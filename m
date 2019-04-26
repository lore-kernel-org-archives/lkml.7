Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F309FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA60220656
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfDZTS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:18:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfDZTS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:18:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C8AE713AC13;
        Fri, 26 Apr 2019 19:18:57 +0000 (UTC)
Received: from treble (ovpn-123-99.rdu2.redhat.com [10.10.123.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3209E5D9C9;
        Fri, 26 Apr 2019 19:18:53 +0000 (UTC)
Date:   Fri, 26 Apr 2019 14:18:51 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     live-patching@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, mliska@suse.cz, hubicka@ucw.cz
Subject: Re: Livepatch vs LTO
Message-ID: <20190426191851.5oodjy2m2bobqoio@treble>
References: <20190425152628.ogk4woi3omeocwly@treble>
 <alpine.LSU.2.21.1904261054240.27157@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1904261054240.27157@pobox.suse.cz>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 26 Apr 2019 19:18:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 11:00:48AM +0200, Miroslav Benes wrote:
> > - For binary-based patch generation (kpatch-build), we currently diff
> >   objects at a per-compilation-unit level.  That would have to be
> >   changed to work on vmlinux.o instead.
> > 
> > - Objtool would also have to be changed to work on vmlinux.o.  It's
> >   currently not optimized for large files, and the per-.o whitelisting
> >   would need to be fixed.  And there may be other issues lurking.
> > 
> > Also, thinking about objtool in this context has given me another idea,
> > which might allow us to get rid of the use of -flive-patching and
> > -fdump-ipa-clones altogether (which are both nasty and way too
> > compiler-dependent):
> > 
> > Since objtool is already reading every function in the kernel, it could
> > create a checksum associated with each function, based on all the
> > instructions (both within the function and any alternatives or other
> > special sections it relies on).  The function checksums could be written
> > to a file.
> > 
> > Then, when a patch file is applied and the kernel rebuilt, the checksum
> > files could be compared to determine exactly which functions have
> > changed at a binary level.
> > 
> > Thoughts?  Any reasons why that wouldn't work?
> 
> I think it could work. If nothing else, it would give us the information 
> we look for.

I'm gone next week but after that I'll start looking at implementing
this.

> > And, if we wanted to take the idea even further, objtool could have the
> > ability to write the changed functions to a new object file.  Voila, we
> > now pretty much have kpatch-build :-)  (Though whether this is better
> > than source-based patch generation is certainly an open question.)
> 
> ...worth of discussion.

When I get some free time I might prototype something to see what it
would look like.

-- 
Josh
