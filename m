Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4080C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BA120862
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tPx7dShK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbfJCUS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:18:29 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35632 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728503AbfJCUS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 16:18:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id p30so328273pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 13:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+sLqpxQwn5IKAm1aZLON2pNwFcFKrH4kS1PpKV5io00=;
        b=tPx7dShK1fKz58midm5HFeKBUk9GrBo/Eg96g1VKDwJcr++u7xtVdw1qfs9lgGNkCf
         Gm3XpKa7FGISJdruBKtKBISHqkeXT9dvzY0uufVpkbUc0glzae6lcQvMVhvJaEvAq5jq
         fqZFNBCIAyp/Q2SDDs4IphqnH5invfbNJQSBuoZoi5CRS5GKHZAogCn6hV1OCf582/Cw
         FDY/G2bNiohgOVui/vaT2YycHrm4NNW1fVP/HEsPrScdt964iwQmOCraoDgUd0O+fXSL
         tvwaUkXXZPVXRI+78KM29C3E8UQ5XU8JozY4itSVuf0iRfs2jUnbanKc5XIB1IR7/ubh
         lWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sLqpxQwn5IKAm1aZLON2pNwFcFKrH4kS1PpKV5io00=;
        b=fMUqbyB+3U/RIJHgBN+mpJYu7nxjYKLr4Zx98MTDj/QFsA4sPtIPxK+g6uEkenrhIv
         f9+pp/AwXPDw1Ot7Gr8wTgTQNQm3fD5/gFSCBL1BofbkXWm8ULvEtYSEUZXOI5nt/VAP
         TxGeyS/RvC6TSYuQqDTFhuF183klxDR5bv2XgpJtQhNm1V9shMRvLCKlfYM9q28Edgfc
         6Xygc1Q9aYKDPx7hflKlTn6znZydwpKolAYZ895lxx6+26zw79UCPvkZYUS9NHdOVyTW
         nHZ1NI+XdSOEsvYNZ+/R7Tt2at6qhj2pMeNisoqr8RdH68WjMrfLK6/DnMBFgSQjyzAo
         dYFA==
X-Gm-Message-State: APjAAAW0zmKIjs5IuNsutRXL7C1ZoR+lZz/zYOfMgCKDOMmMd6nC9N5A
        JlRRPONd/EazUJCEBB0N/r8XHdWJa3A4Uj3Ycf0X2w==
X-Google-Smtp-Source: APXvYqyD6BEnO4ZUoyiVVPkVY2fJjAirNyrjFZR5lstV7VlmlMPIqQuSaIj15lBFzeUrnMAnBoa05ZyW7Q0kii+jR8g=
X-Received: by 2002:a17:90a:178d:: with SMTP id q13mr12760931pja.134.1570133907317;
 Thu, 03 Oct 2019 13:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191003174838.8872-1-vincenzo.frascino@arm.com> <20191003174838.8872-3-vincenzo.frascino@arm.com>
In-Reply-To: <20191003174838.8872-3-vincenzo.frascino@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Oct 2019 13:18:16 -0700
Message-ID: <CAKwvOdmhyVHREHvyB0wL2GfMsE8GcJ1Ouj_8ifrR4hU8kBYukQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] arm64: vdso32: Detect binutils support for dmb ishld
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 10:48 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Older versions of binutils that do not support certain types of memory
> barriers can cause build failure of the vdso32 library.

Do you know specific version numbers of binutils that are affected?
May be helpful to have in the commit message just for future
travelers.

>
> Add a compilation time mechanism that detects if binutils supports those
> instructions and configure the kernel accordingly.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Tested-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/vdso/compat_barrier.h | 2 +-
>  arch/arm64/kernel/vdso32/Makefile            | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/vdso/compat_barrier.h b/arch/arm64/include/asm/vdso/compat_barrier.h
> index fb60a88b5ed4..3fd8fd6d8fc2 100644
> --- a/arch/arm64/include/asm/vdso/compat_barrier.h
> +++ b/arch/arm64/include/asm/vdso/compat_barrier.h
> @@ -20,7 +20,7 @@
>
>  #define dmb(option) __asm__ __volatile__ ("dmb " #option : : : "memory")
>
> -#if __LINUX_ARM_ARCH__ >= 8
> +#if __LINUX_ARM_ARCH__ >= 8 && defined(CONFIG_AS_DMB_ISHLD)
>  #define aarch32_smp_mb()       dmb(ish)
>  #define aarch32_smp_rmb()      dmb(ishld)
>  #define aarch32_smp_wmb()      dmb(ishst)
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 19e0d3115ffe..77aa61340374 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -15,6 +15,8 @@ cc32-disable-warning = $(call try-run,\
>         $(COMPATCC) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
>  cc32-ldoption = $(call try-run,\
>          $(COMPATCC) $(1) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
> +cc32-as-instr = $(call try-run,\
> +       printf "%b\n" "$(1)" | $(COMPATCC) $(VDSO_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
>
>  # We cannot use the global flags to compile the vDSO files, the main reason
>  # being that the 32-bit compiler may be older than the main (64-bit) compiler
> @@ -53,6 +55,7 @@ endif
>  VDSO_CAFLAGS += -fPIC -fno-builtin -fno-stack-protector
>  VDSO_CAFLAGS += -DDISABLE_BRANCH_PROFILING
>
> +
>  # Try to compile for ARMv8. If the compiler is too old and doesn't support it,
>  # fall back to v7. There is no easy way to check for what architecture the code
>  # is being compiled, so define a macro specifying that (see arch/arm/Makefile).
> @@ -89,6 +92,12 @@ VDSO_CFLAGS += -Wno-int-to-pointer-cast
>  VDSO_AFLAGS := $(VDSO_CAFLAGS)
>  VDSO_AFLAGS += -D__ASSEMBLY__
>
> +# Check for binutils support for dmb ishld
> +dmbinstr := $(call cc32-as-instr,dmb ishld,-DCONFIG_AS_DMB_ISHLD=1)
> +
> +VDSO_CFLAGS += $(dmbinstr)
> +VDSO_AFLAGS += $(dmbinstr)
> +
>  VDSO_LDFLAGS := $(VDSO_CPPFLAGS)
>  # From arm vDSO Makefile
>  VDSO_LDFLAGS += -Wl,-Bsymbolic -Wl,--no-undefined -Wl,-soname=linux-vdso.so.1
> --
> 2.23.0
>


-- 
Thanks,
~Nick Desaulniers
