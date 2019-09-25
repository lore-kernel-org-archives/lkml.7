Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D8DC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D79214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qWcsG6xY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440011AbfIYQx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 12:53:29 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41710 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437678AbfIYQx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 12:53:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7so3870861pfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 09:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/sojhQaKNfMwCzwlmCta8VLr7dMJZiKlxmvoLeV0xI=;
        b=qWcsG6xYj8I2u4Z0FOvpRJNmoINmp4oKlfBLVJlJ+3y1cXOTmV26RTzmv1TyjCwR4h
         eSVMBEcQ5GTnB42JC8NI47DTM62W5HYUDWGFkA8O/6wkOmn/ABJ179sISNie/gTCB67g
         G59Fvn01qNJiBJStmIyr2B3fHwAzDpeAjOlwluiZL/UjWxt0cvVTykQqWP/k+Wa5m6FH
         6upOHc69RCH6rdsvdDpAIxZTZXM7AJ5Am+zuiZ/upqPmRTsQTgGUzdXeE1sqepZ0Xaru
         uD5CM3d4iHHoHKNhcjvU6Uc+6A1FLRxqjMKwcibKO2dob8tM7p83FTxxsdQh3sXYhJNX
         9Fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/sojhQaKNfMwCzwlmCta8VLr7dMJZiKlxmvoLeV0xI=;
        b=SX6DeIeTOMVn7hcxsSiNcfUDsmod+sg2C9B9e/YE074JOy0unTkRjFQc3mmV7ff8J5
         cGN3TIfM66BrO+K5jbchdu5StwIrM/5aZFEKa+TenTwSE7WWoSgrNVs/fIvZEeNFeDkV
         YP6iXtsMai/4KFEpAZy1I8G9P7VxdAjQMviOvns+b+Z19CwPj+NyiY9B5i2n7Z2KYf1U
         H979SnFI1PUMgo4z0nCpAPkiOOYFwxdwJhSohdd6++i5y5bzg9CcwOvhI7kBV27LOwuQ
         uTRv2exmwxO+8y3/WbglyWkYAZHSZJiOuAoa1fy0Om3oU1qJ6nknQUAsUkN9va6bL//f
         tPUw==
X-Gm-Message-State: APjAAAVfkR38e8XM78igW2FBsuDDH0A/LF7T940GTRwfRkvRGV5axeuc
        Egqe7zafEpZoOjBwdwda4U1UT9vkKtLDhKXH3jMPvA==
X-Google-Smtp-Source: APXvYqyGOrPmmtsw3QaNO3jNzRvgBnclwKeaJ8rYvix6Eqms6giQGJOoDgBUTsFg1jBCdVquRwzJhHZ/p2YowQNYnYk=
X-Received: by 2002:a17:90a:ff18:: with SMTP id ce24mr7402764pjb.123.1569430407847;
 Wed, 25 Sep 2019 09:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190925130926.50674-1-catalin.marinas@arm.com>
In-Reply-To: <20190925130926.50674-1-catalin.marinas@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Sep 2019 09:53:16 -0700
Message-ID: <CAKwvOdn2Sf7aAt0zqUUqGY6nXg-C3be7An9amy4tfiNr_8ERJw@mail.gmail.com>
Subject: Re: [PATCH] arm64: Allow disabling of the compat vDSO
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 6:09 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> The compat vDSO building requires a cross-compiler than produces AArch32
> binaries, defined via CONFIG_CROSS_COMPILE_COMPAT_VDSO or the
> CROSS_COMPILE_COMPAT environment variable. If none of these is defined,
> building the kernel always prints a warning as there is no way to
> deselect the compat vDSO.
>
> Add an arm64 Kconfig entry to allow the deselection of the compat vDSO.
> In addition, make it an EXPERT option, default n, until other issues
> with the compat vDSO are solved (64-bit only kernel headers included in
> user-space vDSO code, CC_IS_CLANG irrelevant to CROSS_COMPILE_COMPAT).

CC_IS_CLANG might be because then CC can be reused with different
flags, rather than providing a different cross compiler binary via
config option.

>
> Fixes: bfe801ebe84f ("arm64: vdso: Enable vDSO compat support")
> Cc: Will Deacon <will@kernel.org>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/595
Overall, this work is important to Android; the ARMv8-A series of
mobile SoCs we see today have to support 32b and 64b (A32+A64?) for at
least a few more years; we would like gettimeofday() and friends to be
fast for 32b and 64b applications.

> ---
>
> It looks like you can't really win with the current compat vDSO logic.
> You either don't have a compat cross-compiler and you get a Makefile
> warning or you have one and a get a compiler warning (or failure)
> because of the 64-bit kernel headers included in 32-bit user-space code.
>
> "depends on BROKEN" for ARM64_COMPAT_VDSO also work for me instead of
> EXPERT. I'll leave it up to Will to decide but I'd like at least this
> patch in -rc2 (even better if everything else is fixed before the final
> 5.4).
>
> Suggestions for future improvements of the compat vDSO handling:
>
> - replace the CROSS_COMPILE_COMPAT prefix with a full COMPATCC; maybe
>   check that it indeed produces 32-bit code
>
> - check whether COMPATCC is clang or not rather than CC_IS_CLANG, which
>   only checks the native compiler

When cross compiling, IIUC CC_IS_CLANG is referring to CC which is the
cross compiler, which is different than HOSTCC which is the host
compiler.  HOSTCC is used mostly for things in scripts/ while CC is
used to compile a majority of the kernel in a cross compile.

>
> - clean up the headers includes; vDSO should not include kernel-only
>   headers that may even contain code patched at run-time

This is a big one; Clang validates the inline asm constraints for
extended inline assembly, GCC does not for dead code.  So Clang chokes
on the inclusion of arm64 headers using extended inline assembly when
being compiled for arm-linux-gnueabi.

>
>  arch/arm64/Kconfig | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 866e05882799..83a9a78085c6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -110,7 +110,6 @@ config ARM64
>         select GENERIC_STRNLEN_USER
>         select GENERIC_TIME_VSYSCALL
>         select GENERIC_GETTIMEOFDAY
> -       select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT)
>         select HANDLE_DOMAIN_IRQ
>         select HARDIRQS_SW_RESEND
>         select HAVE_PCI
> @@ -1185,6 +1184,15 @@ config KUSER_HELPERS
>           Say N here only if you are absolutely certain that you do not
>           need these helpers; otherwise, the safe option is to say Y.
>
> +config ARM64_COMPAT_VDSO
> +       bool "Enable the 32-bit vDSO" if EXPERT
> +       depends on !CPU_BIG_ENDIAN
> +       select GENERIC_COMPAT_VDSO
> +       help
> +         Enable the vDSO support for 32-bit applications. You would
> +         need to set the 32-bit cross-compiler prefix in
> +         CONFIG_CROSS_COMPILE_COMPAT_VDSO or the CROSS_COMPILE_COMPAT
> +         environment variable.
>
>  menuconfig ARMV8_DEPRECATED
>         bool "Emulate deprecated/obsolete ARMv8 instructions"



-- 
Thanks,
~Nick Desaulniers
