Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB480C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D31D20856
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 19:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfH1TvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 15:51:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbfH1TvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 15:51:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 371FA8B5FF0;
        Wed, 28 Aug 2019 19:51:03 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A06C25DC18;
        Wed, 28 Aug 2019 19:51:02 +0000 (UTC)
Date:   Wed, 28 Aug 2019 14:51:00 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: next-20190826 - objtool fails to build.
Message-ID: <20190828195100.tbkvphzhjtflrp66@treble>
References: <133250.1566965715@turing-police>
 <20190828151003.3px5plk4tp2s5s5c@treble>
 <23345.1567020600@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23345.1567020600@turing-police>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Wed, 28 Aug 2019 19:51:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 03:30:00PM -0400, Valdis Klētnieks wrote:
> On Wed, 28 Aug 2019 10:10:04 -0500, Josh Poimboeuf said:
> 
> > But I don't see how those warnings could get enabled: -Wsign-compare
> > -Wunused-parameter.
> >
> > Can you "make clean" and do "make V=1 tools/objtool" to show the actual
> > flags?
> 
> And that tells me those warnings in fact don't get specifically enabled.
> (I've added some line breaks for sanity)
> 
>   gcc -Wp,-MD,/usr/src/linux-next/tools/objtool/.special.o.d -Wp,-MT,/usr/src/linux-next/tools/objtool/special.o -O2 -D_FORTIFY_SOURCE=2 -Wall -Wextra -Wbad-function-cast
> 
> Found the cause of the mystery - I changed something in a bash profile, and
> as a result...
> 
> export CFLAGS="-O2 -D_FORTIFY_SOURCE=2 -Wall -Wextra"
> 
> And -Wextra pulls in the things that cause problems. So this is mostly
> self-inflicted.
> 
> The real question then becomes - should the Makefile sanitize CFLAGS or just
> append to whatever the user supplied as it does currently? The rest of the tree
> sanitizes CFLAG, because I don't get deluged in -Wsign-compare warnings all
> over the place...

Agreed.  I assume this fixes it?

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 88158239622b..20f67fcf378d 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -35,7 +35,7 @@ INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
 	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
-CFLAGS   += -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
+CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
 
 # Allow old libelf to be used:
