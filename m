Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1847EC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 16:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BB221D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 16:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AWRrGdXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfIZQYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 12:24:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45900 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbfIZQYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 12:24:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id q7so1807466pgi.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 09:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o1tbaMq7T/ukWk3mtjnMcOjC8Q34znuuWkXOuJc+ANU=;
        b=AWRrGdXHoLy0Riqb0073AS7eedCai2Vnf+L0NuZ5iUtSvW8Ll3ne2bpW8y1u4ICN+X
         s3VLuNyuv9ndPU4+1ae57GO1aBwlS3nn7m9Jbm3ya9iIhG9cNmSIHrzg0nJlFr1ag9wS
         uJkGkEdyJqhM045BLt4HcFR8hsI4s2aiZMFJGFgvMa09Yb+2VKIPl1F3lCJjmtvWlMsr
         vN9VlYiGjx4O8QnB7QbzdIWHyqmry0R4eO2Ucyt+VWxVs1/8blxniD9L9blmDUttJNe4
         2gtKDqHFrmuH61sDeKi34kA0nIIfxe623LuGsOyH/TuQb9GPQljJNHVR7p5pN3d0Z2QZ
         rLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o1tbaMq7T/ukWk3mtjnMcOjC8Q34znuuWkXOuJc+ANU=;
        b=H4YMsDmajgqoJ8kLZ1RdFZgU7hPv93oQymMFIf+DjiW7j6xdcxAOMX88hzvavl5y+I
         LrVX4kKcJVd/xiKBSGgDFmWXGot7fCLNYxA3TLGP4hrpubZ81p5R59IoVlNm0BgcFWSb
         WAIeB4dASmroXOQd1HyYlGbN78WE2zII52CwCERXKlfdnRrcTVyt7Ojl4nM/wBl4MQbp
         jjY2kdnrhXYziRNB4fpRwwWaqzxny9GCLBJalfsZxIMeghFEAmz6vht262qb/f7iNDE6
         opTKOvdCANQhpU3a7cLsXPQdmGbhRkbdIyXPUAjx4W0C1i4HpM2ZI23HxJcYO2DJCDUd
         u9mA==
X-Gm-Message-State: APjAAAUPeV5yql681rBAuAD09bdGQdZPoQMCcANJXG/tTyHjjfql37UT
        5QTpkWVG9SP1STMdG9k8omHTk0WZ73TlA/ilgJNF/g==
X-Google-Smtp-Source: APXvYqyBhJTcbx4Xt1FhYrPpeBs0GWYkzqvVM6fIDAS309M5Y+7Qirq8NKvhlgW2LRzB9wDxw7sc9ZgsUvCOO8QhaXg=
X-Received: by 2002:a63:d909:: with SMTP id r9mr4150357pgg.381.1569515042255;
 Thu, 26 Sep 2019 09:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190920142738.qlsjwguc6bpnez63@willie-the-truck>
 <20190926133805.52348-1-vincenzo.frascino@arm.com> <20190926133805.52348-3-vincenzo.frascino@arm.com>
In-Reply-To: <20190926133805.52348-3-vincenzo.frascino@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 26 Sep 2019 09:23:51 -0700
Message-ID: <CAKwvOdmbbwrAvh1f7ctkg-GoqsfXLWFd2VehLVX39N2qM9LJJg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] arm64: vdso32: Detect binutils support for dmb ishld
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 6:38 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> As reported by Will Deacon, older versions of binutils that do not
> support certain types of memory barriers can cause build failure of the
> vdso32 library.

Do we know which specific version of binutils has this problem?
Documentation/process/changes.rst lists 2.21+ as the supported
versions.  If it's older than that, it's unsupported.

I triple checked android's 2.27 seems ok.

$ cat bar.s
.text
.globl foo
  dmb ish
  dmb ishld
  dmb ishst
$ aarch64-linux-gnu-as bar.s
$ echo $?
0
$ llvm-objdump -d a.out

a.out: file format ELF64-aarch64-little


Disassembly of section .text:

0000000000000000 $x:
       0: bf 3b 03 d5                  dmb ish
       4: bf 39 03 d5                  dmb ishld
       8: bf 3a 03 d5                  dmb ishst

>
> Add a compilation time mechanism that detects if binutils supports those
> instructions and configure the kernel accordingly.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/Kbuild                            | 6 ++++++
>  arch/arm64/include/asm/vdso/compat_barrier.h | 2 +-
>  arch/arm64/kernel/vdso32/Makefile            | 9 +++++++++
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
> index d6465823b281..75cf8c796d0e 100644
> --- a/arch/arm64/Kbuild
> +++ b/arch/arm64/Kbuild
> @@ -4,3 +4,9 @@ obj-$(CONFIG_NET)       += net/
>  obj-$(CONFIG_KVM)      += kvm/
>  obj-$(CONFIG_XEN)      += xen/
>  obj-$(CONFIG_CRYPTO)   += crypto/
> +
> +# as-instr-compat
> +# Usage: cflags-y += $(call as-instr-compat,instr,option1,option2)
> +
> +as-instr-compat = $(call try-run,\
> +       printf "%b\n" "$(1)" | $(COMPATCC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
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
> index 1fba0776ed40..22f0d31ea528 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -17,6 +17,8 @@ cc32-disable-warning = $(call try-run,\
>         $(COMPATCC) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
>  cc32-ldoption = $(call try-run,\
>          $(COMPATCC) $(1) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
> +cc32-as-instr = $(call try-run,\
> +       printf "%b\n" "$(1)" | $(COMPATCC) $(VDSO_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
>
>  # We cannot use the global flags to compile the vDSO files, the main reason
>  # being that the 32-bit compiler may be older than the main (64-bit) compiler
> @@ -55,6 +57,7 @@ endif
>  VDSO_CAFLAGS += -fPIC -fno-builtin -fno-stack-protector
>  VDSO_CAFLAGS += -DDISABLE_BRANCH_PROFILING
>
> +
>  # Try to compile for ARMv8. If the compiler is too old and doesn't support it,
>  # fall back to v7. There is no easy way to check for what architecture the code
>  # is being compiled, so define a macro specifying that (see arch/arm/Makefile).
> @@ -91,6 +94,12 @@ VDSO_CFLAGS += -Wno-int-to-pointer-cast
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
