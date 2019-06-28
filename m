Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D63BC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DAF206A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfF1AAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:00:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfF1AAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:00:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D94AC04BD4A;
        Fri, 28 Jun 2019 00:00:36 +0000 (UTC)
Received: from treble (ovpn-126-66.rdu2.redhat.com [10.10.126.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BA9360BE0;
        Fri, 28 Jun 2019 00:00:35 +0000 (UTC)
Date:   Thu, 27 Jun 2019 19:00:34 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Olof Johansson <olof@lixom.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Be lenient about -Wundef
Message-ID: <20190628000033.ipcypg4kny2whfz7@treble>
References: <20190619120337.78624-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190619120337.78624-1-olof@lixom.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 28 Jun 2019 00:00:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 05:03:37AM -0700, Olof Johansson wrote:
> Some libelf versions use undefined macros, which combined with newer GCC
> makes for errors from system headers. This isn't overly useful to fail
> compiling objtool for.
> 
> Error as seen:
> 
> cc1: all warnings being treated as errors
> In file included from arch/x86/../../elf.h:10,
>                  from arch/x86/decode.c:14:
> /usr/include/libelf/gelf.h:25:5: error: "__LIBELF_INTERNAL__" is not defined, evaluates to 0 [-Werror=undef]
>  #if __LIBELF_INTERNAL__
>      ^~~~~~~~~~~~~~~~~~~
> 
> For this reason, skip -Wundef on objtool.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Sorry for the delay, I was out last week and I'm still getting caught
up.

Which libelf was this?  I'm guessing it's the old non-elfutils version
which has been unmaintained for 10 years (and which doesn't work with
objtool anyway).

It would be nice if we could figure out a way to detect that libelf and
report a more useful error for it.

-- 
Josh
