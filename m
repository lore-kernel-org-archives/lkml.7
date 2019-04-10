Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF13C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FC62082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OoZ98ClQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732844AbfDJQ0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:26:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38270 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732370AbfDJQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:26:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id f36so1744243plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 09:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9UbDO978zumdTH0GKIWnRhVTeRX13IbwklWJ8oTD7A=;
        b=OoZ98ClQUQ5wbLtVGaHgYjLq5iluJjlyC23cS7+lAvkHdV8p664IXk7LmeEjj313pP
         5B4p9wsKXKbKngXoX3mn7Kan6ndWhWZeJquOtp4VeVshNZV+OZd5/Z/d1WuljZvLHUH1
         pZ509RuHt2NoI6vtHzQirWKVZ+KBkMjDkJNbkYiT3mg3VqjlNtSXU8oPjf2rPA1svznk
         6sWs4uGef4RvJe1Kz95iByXytBG/HbFdHHKz6KKieXzX5+t9IeJKltm3Wlupb77M84tW
         2FPY72lgGgLp8tuNAwi18SZfQqvEprTggCqdTShZI0GoFb/Vu4k8KDnT3MjC9shLNC6e
         oSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9UbDO978zumdTH0GKIWnRhVTeRX13IbwklWJ8oTD7A=;
        b=T5a7Rn45SX6nGzGOzA9dJmTD6QgCJNdjHL1gsz+/ex/GqLa/H/eZOt93wL+qW5wxQS
         R2XE4iSxxJI441t6a0cMH6ezja20IdHAHpm2g6KnJQczZxRBVY36+cvxPLfCwjBGSOF1
         G6d8wN6bJMVzS5d77pprSz0K6KVsiCugEam7eOpx1rPf2f/6a251iVpYeNhMQYHcxNe6
         VPA3ZX01ib+zrtoj1umvFJMkn5jGBUugLo3Si2r5rExnklr3jtYoN4yMoPSABHbAZHE/
         wJPXQQkhcYI7EkyoEbrSsVtMw2B/FfRQ+NNgMqHVjfBSxZbZudFF+4UqsLz9NqN7mw/k
         iy2A==
X-Gm-Message-State: APjAAAUJl5bbz8YewiC78UZuSfESS27WoHoQ+tNvKHIFclOaRBhC6RL7
        Lo/AQc4jb0carHHLluflxkEYAw8mSwEbMOWrXLjfyg==
X-Google-Smtp-Source: APXvYqw0rpEKRS9jPgft8rFPq/hZ0/e/Bef/bdr+Z5oPUv68G9+FEmuGFw8cDk6sccLez3d2os5k3gw2IG8fU/Aw3W0=
X-Received: by 2002:a17:902:7044:: with SMTP id h4mr1010553plt.274.1554913602274;
 Wed, 10 Apr 2019 09:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190408212648.2407234-1-arnd@arndb.de> <20190408212648.2407234-2-arnd@arndb.de>
In-Reply-To: <20190408212648.2407234-2-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 10 Apr 2019 09:26:30 -0700
Message-ID: <CAKwvOdmRVK8t=CL5h0MXykm00R39e17dy8EkgFrLuhg1Yr0HJQ@mail.gmail.com>
Subject: Re: [PATCH 02/12] s390: don't build vdso32 with clang
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 2:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> clang does not support 31 bit object files on s390, so skip
> the 32-bit vdso here, and only build it when using gcc to compile
> the kernel.

What's the build failure?  Would you mind filing a bug against LLVM's
issue tracker for it, please?

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/Kconfig         |  3 +++
>  arch/s390/kernel/Makefile |  2 +-
>  arch/s390/kernel/vdso.c   | 10 +++++-----
>  3 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index b6e3d0653002..8cd860cba4d1 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -388,6 +388,9 @@ config COMPAT
>           (and some other stuff like libraries and such) is needed for
>           executing 31 bit applications.  It is safe to say "Y".
>
> +config COMPAT_VDSO
> +       def_bool COMPAT && !CC_IS_CLANG
> +
>  config SYSVIPC_COMPAT
>         def_bool y if COMPAT && SYSVIPC
>
> diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
> index 8a62c7f72e1b..1222db6d4ee9 100644
> --- a/arch/s390/kernel/Makefile
> +++ b/arch/s390/kernel/Makefile
> @@ -86,7 +86,7 @@ obj-$(CONFIG_TRACEPOINTS)     += trace.o
>
>  # vdso
>  obj-y                          += vdso64/
> -obj-$(CONFIG_COMPAT)           += vdso32/
> +obj-$(CONFIG_COMPAT_VDSO)      += vdso32/
>
>  chkbss := head64.o early_nobss.o
>  include $(srctree)/arch/s390/scripts/Makefile.chkbss
> diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
> index e7920a68a12e..243d8b1185bf 100644
> --- a/arch/s390/kernel/vdso.c
> +++ b/arch/s390/kernel/vdso.c
> @@ -29,7 +29,7 @@
>  #include <asm/vdso.h>
>  #include <asm/facility.h>
>
> -#ifdef CONFIG_COMPAT
> +#ifdef CONFIG_COMPAT_VDSO
>  extern char vdso32_start, vdso32_end;
>  static void *vdso32_kbase = &vdso32_start;
>  static unsigned int vdso32_pages;
> @@ -55,7 +55,7 @@ static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
>
>         vdso_pagelist = vdso64_pagelist;
>         vdso_pages = vdso64_pages;
> -#ifdef CONFIG_COMPAT
> +#ifdef CONFIG_COMPAT_VDSO
>         if (vma->vm_mm->context.compat_mm) {
>                 vdso_pagelist = vdso32_pagelist;
>                 vdso_pages = vdso32_pages;
> @@ -76,7 +76,7 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
>         unsigned long vdso_pages;
>
>         vdso_pages = vdso64_pages;
> -#ifdef CONFIG_COMPAT
> +#ifdef CONFIG_COMPAT_VDSO
>         if (vma->vm_mm->context.compat_mm)
>                 vdso_pages = vdso32_pages;
>  #endif
> @@ -223,7 +223,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>                 return 0;
>
>         vdso_pages = vdso64_pages;
> -#ifdef CONFIG_COMPAT
> +#ifdef CONFIG_COMPAT_VDSO
>         mm->context.compat_mm = is_compat_task();
>         if (mm->context.compat_mm)
>                 vdso_pages = vdso32_pages;
> @@ -280,7 +280,7 @@ static int __init vdso_init(void)
>         int i;
>
>         vdso_init_data(vdso_data);
> -#ifdef CONFIG_COMPAT
> +#ifdef CONFIG_COMPAT_VDSO
>         /* Calculate the size of the 32 bit vDSO */
>         vdso32_pages = ((&vdso32_end - &vdso32_start
>                          + PAGE_SIZE - 1) >> PAGE_SHIFT) + 1;
> --
> 2.20.0
>


-- 
Thanks,
~Nick Desaulniers
