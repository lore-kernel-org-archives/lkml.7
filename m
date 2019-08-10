Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A89BC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783BF2085B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfHJTcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 15:32:08 -0400
Received: from smtprelay0176.hostedemail.com ([216.40.44.176]:41133 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726055AbfHJTcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 15:32:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 40B2E18029128;
        Sat, 10 Aug 2019 19:32:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spark10_4c70ab692da2a
X-Filterd-Recvd-Size: 3006
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 10 Aug 2019 19:32:05 +0000 (UTC)
Message-ID: <9c7a79b4d21aea52464d00c8fa4e4b92638560b6.camel@perches.com>
Subject: Re: [PATCH] Makefile: Convert -Wimplicit-fallthrough=3 to just
 -Wimplicit-fallthrough for clang
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Date:   Sat, 10 Aug 2019 12:32:03 -0700
In-Reply-To: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
References: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-05 at 15:11 -0700, Joe Perches wrote:
> A compilation -Wimplicit-fallthrough warning was enabled by
> commit a035d552a93b ("Makefile: Globally enable fall-through warning")
> 
> Even though clang 10.0.0 does not currently support this warning
> without a patch, clang currently does not support a value for this
> option.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=39382
> 
> The gcc default for this warning is 3 so removing the =3 has no
> effect for gcc and enables the warning for patched versions of clang.
> 
> Also remove the =3 from an existing use in a parisc Makefile:
> arch/parisc/math-emu/Makefile

Hey Linus,

What does it take for this sort of patch to be applied by you?

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  Makefile                      | 2 +-
>  arch/parisc/math-emu/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 5ee6f6889869..a3985421fd29 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -845,7 +845,7 @@ NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>  KBUILD_CFLAGS += -Wdeclaration-after-statement
>  
>  # Warn about unmarked fall-throughs in switch statement.
> -KBUILD_CFLAGS += $(call cc-option,-Wimplicit-fallthrough=3,)
> +KBUILD_CFLAGS += $(call cc-option,-Wimplicit-fallthrough,)
>  
>  # Variable Length Arrays (VLAs) should not be used anywhere in the kernel
>  KBUILD_CFLAGS += -Wvla
> diff --git a/arch/parisc/math-emu/Makefile b/arch/parisc/math-emu/Makefile
> index 55c1396580a4..3747a0cbd3b8 100644
> --- a/arch/parisc/math-emu/Makefile
> +++ b/arch/parisc/math-emu/Makefile
> @@ -18,4 +18,4 @@ obj-y	 := frnd.o driver.o decode_exc.o fpudispatch.o denormal.o \
>  # other very old or stripped-down PA-RISC CPUs -- not currently supported
>  
>  obj-$(CONFIG_MATH_EMULATION)	+= unimplemented-math-emulation.o
> -CFLAGS_REMOVE_fpudispatch.o	= -Wimplicit-fallthrough=3
> +CFLAGS_REMOVE_fpudispatch.o	= -Wimplicit-fallthrough
> 

