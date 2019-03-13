Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E463CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764D22070D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1VITww2V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfCMR3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:29:05 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:17768 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfCMR3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:29:04 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x2DHSwJp008442
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 02:28:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x2DHSwJp008442
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552498139;
        bh=/zYcsdLek5tATBwadZ/g+VOLsE/N+1DOzRxU1B07Zvk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1VITww2VvWho3TY7hw1lSTvlcutyYLpMgos4l3VDwIGfF6RlF1erC48EJfgieyiZN
         /G5huCa2bNtOR3S4VWY5mWOr4S/k2JT0WjgnH0p5i3w1lolKWmfADceDZahsOXWLPw
         RRCRZR8bPkXt/CSj4sUe1T3np9EGYDNNMz/RL7sD54qnWjr4BIR5SUbJoQAxnrGV5A
         HqLHkeG2OYS45HxLm0VT1yC+VCZGZxVmkZ1dUrIh8RWcfnfZTs5jWoQdJ1E8YkDORe
         y9hnC6h6KJ5t0Ys0AwPbkutDLkPR49AY0VkImquBlgruJe6Oi1quYHnkmzVFTYEE5E
         1B3Rk9URUaB4A==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id j12so1520933vsd.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 10:28:58 -0700 (PDT)
X-Gm-Message-State: APjAAAVaVHx46B9h+q2w+u6fvuNFZM92ZR5FwlIyWlPPiOFX6cm7IEOF
        6LoibQiSkZmIg8LYPWnRw9LMOfbhV7LwQE7uDRY=
X-Google-Smtp-Source: APXvYqytqUamuL9qApt1+nvPfH1j15S65p+ztcotTWZif8TtEZypFOnd70y1xvfBdb91pJy1lKs8sAEKNvyGkb8jR9w=
X-Received: by 2002:a67:ea05:: with SMTP id g5mr5999124vso.179.1552498137759;
 Wed, 13 Mar 2019 10:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <1550203466-13984-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1550203466-13984-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 14 Mar 2019 02:28:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNASmkPHWWk+WDn9ZK0gPvaB2ksmo8GY_F6d-ouH6s_AY-w@mail.gmail.com>
Message-ID: <CAK7LNASmkPHWWk+WDn9ZK0gPvaB2ksmo8GY_F6d-ouH6s_AY-w@mail.gmail.com>
Subject: Re: [PATCH] h8300: use cc-cross-prefix instead of hardcoding h8300-unknown-linux-
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 11:53 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> It believe it is a bad idea to hardcode a specific compiler prefix
> that may or may not be installed on a user's system. It is annoying
> when testing features that should not require compilers at all.
>
> For example, mrproper, headers_install, etc. should work without
> any compiler.
>
> They look like follows on my machine.
>
> $ make ARCH=h8300 mrproper
> ./scripts/gcc-version.sh: line 26: h8300-unknown-linux-gcc: command not found
> ./scripts/gcc-version.sh: line 27: h8300-unknown-linux-gcc: command not found
> make: h8300-unknown-linux-gcc: Command not found
> make: h8300-unknown-linux-gcc: Command not found
>   [ a bunch of the same error messages continue ]
>
> $ make ARCH=h8300 headers_install
> ./scripts/gcc-version.sh: line 26: h8300-unknown-linux-gcc: command not found
> ./scripts/gcc-version.sh: line 27: h8300-unknown-linux-gcc: command not found
> make: h8300-unknown-linux-gcc: Command not found
>   HOSTCC  scripts/basic/fixdep
> make: h8300-unknown-linux-gcc: Command not found
>   WRAP    arch/h8300/include/generated/uapi/asm/kvm_para.h
>   [ snip ]
>
> The solution is to delete this line, or to use cc-cross-prefix like
> some architectures do. I chose the latter as a moderate fixup.
>
> I added an alternative 'h8300-linux-' because it is available at:
>
> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

This is more related to build system.
So, I applied to linux-kbuild now.





>  arch/h8300/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/h8300/Makefile b/arch/h8300/Makefile
> index f801f37..ba0f26c 100644
> --- a/arch/h8300/Makefile
> +++ b/arch/h8300/Makefile
> @@ -27,7 +27,7 @@ KBUILD_LDFLAGS += $(ldflags-y)
>  CHECKFLAGS += -msize-long
>
>  ifeq ($(CROSS_COMPILE),)
> -CROSS_COMPILE := h8300-unknown-linux-
> +CROSS_COMPILE := $(call cc-cross-prefix, h8300-unknown-linux- h8300-linux-)
>  endif
>
>  core-y += arch/$(ARCH)/kernel/ arch/$(ARCH)/mm/
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
