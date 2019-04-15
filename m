Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F80C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00882073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfDOM3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:29:17 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35307 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfDOM3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:29:17 -0400
Received: by mail-qt1-f194.google.com with SMTP id h39so18825018qte.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 05:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WlFJ2a0Gegd+f+5u8gC2fdwSw0IBQnT8ATkMdXPZXJU=;
        b=fEyHN/dF4/1e8rx3j/hot7lyuMs/pcfeF1jSd6k+01PHISxSuB/66qQw0p17EBGcg2
         WGCXb/4+958NiZj2UJSm5klSfIN6KiYE8zXSH94VYJ/3poyPafIlUjebqHNM06SAMY6Z
         DuCrZiaA0wTLVASzS0gA1PP0FnvS4PWgI4aomjjpJQptS2bhGLFOt5yCFsKPqAAwIGlR
         gB6U5carCYod1UZHzuZ4lONIrilpJaVVhqF2h3SGAhfFv4BDow44OJ874Cvh55QC3EKu
         YZSRb24cGd7JZ39pZfRVBBjPXVGKvGMU32Ta3fwzXk7UUltxQLDU/VcvZWx3nw66XoaQ
         E8mw==
X-Gm-Message-State: APjAAAVWymIppGwIgvsf32uHGmXEiRlsFXb3iRnvnQXACKMXbk6bs5gY
        U6s6Rgh/8QVH+IfONLbJhxQ+Ey68KjFgF0Y6AWU=
X-Google-Smtp-Source: APXvYqy62EKdoa8lroEe3OKmo1MpQUH0mQbWzQwZ9WWH5VghFXYCClje3nRf/dg3x0sDiod6qnRhXm9RqNC0ThhBgAw=
X-Received: by 2002:ac8:1a0b:: with SMTP id v11mr62319215qtj.171.1555331355533;
 Mon, 15 Apr 2019 05:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190414194705.2e10802aca2df36c8f27f349@kernel.org> <20190414133458.zxdekgx6qwd562qa@shell.armlinux.org.uk>
In-Reply-To: <20190414133458.zxdekgx6qwd562qa@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Apr 2019 14:28:59 +0200
Message-ID: <CAK8P3a2xf9Lp=apuAE5zo+4GHQHjDTeJUh8gkCOWeotsQXRaNA@mail.gmail.com>
Subject: Re: Kconfig dependency issue on function-graph tracer and frame
 pointer on arm
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 3:35 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:

> The subsequent hunks remove the defaulting of the choice according to
> the function graph tracer - this is not a "hint" where the user can
> still choose either option irrespective of the state of the function
> graph tracer.  They should only be able to select the frame pointer
> option in that case.
>
> Another way forward would be for someone to put the work in to making
> the function graph tracer work without frame pointers.

I think Stefan was already looking into making CONFIG_FUNCTION_TRACER
work with clang. I don't know what the status of that work is, but I
think getting
FUNCTION_GRAPH_TRACER working at the same time would be best.

I never noticed the Kconfig issue here, because I was using a patch to
turn off FUNCTION_TRACER on ARM with clang to make it build, and that
turns off FUNCTION_GRAPH_TRACER in the process.

> So, how about this:
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 850b4805e2d1..9aed25a6019b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -73,7 +73,7 @@ config ARM
>         select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
>         select HAVE_EXIT_THREAD
>         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> -       select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL
> +       select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
>         select HAVE_FUNCTION_TRACER if !XIP_KERNEL
>         select HAVE_GCC_PLUGINS
>         select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 6d6e0330930b..e388af4594a6 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -47,8 +47,8 @@ config DEBUG_WX
>
>  choice
>         prompt "Choose kernel unwinder"
> -       default UNWINDER_ARM if AEABI && !FUNCTION_GRAPH_TRACER
> -       default UNWINDER_FRAME_POINTER if !AEABI || FUNCTION_GRAPH_TRACER
> +       default UNWINDER_ARM if AEABI
> +       default UNWINDER_FRAME_POINTER if !AEABI
>         help
>           This determines which method will be used for unwinding kernel stack
>           traces for panics, oopses, bugs, warnings, perf, /proc/<pid>/stack,
> @@ -65,7 +65,7 @@ config UNWINDER_FRAME_POINTER
>
>  config UNWINDER_ARM
>         bool "ARM EABI stack unwinder"
> -       depends on AEABI
> +       depends on AEABI && !FUNCTION_GRAPH_TRACER
>         select ARM_UNWIND
>         help
>           This option enables stack unwinding support in the kernel

This looks good to me in the meantime, at least if there is any
way to get the non-graph FUNCTION_TRACER to build with clang.

       Arnd
