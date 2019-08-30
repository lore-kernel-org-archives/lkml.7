Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB12C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5519D23439
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 21:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EW99Eqkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfH3VN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:13:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39312 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfH3VN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 17:13:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id a67so2129379pfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 14:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1J0sxNta1Y7TX28deVqyjMgnkCtYfR2j9BgKqBFiKOI=;
        b=EW99Eqkb2zHXK7i7yXBZZtK9zRekFpro7wkDVkT8jfrTEuhsHNSMSJTm1WE0sl8IP1
         O9547obfMg3vuk02KqBj7Td0E5/UZH8fqLopjyWlA5RZyTTGD0MfnMYYWEDioGWlGJPy
         pUJCmlQq4PbW3OK/H46tZgJ2xYaTxHRf/pgWiv+/v+Pw3RRUd1sAr8M5QIuqAutHCSJt
         88UzyhvcAfiu0c0rbJhcawlbu/D3eYbdVfLkmHBplnTh54UCPFZrSRsFb4iaN6yGWAd1
         z2t31TgBWtbuekEgty9l+b+5d3OraQCLjjdNZKx71u8nrvagywgYhV/cpu0TylmduSgq
         3fMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1J0sxNta1Y7TX28deVqyjMgnkCtYfR2j9BgKqBFiKOI=;
        b=XgPiz5m9ywd21sZRPLu1imwDsavFrVNkXBNVH5IdVkuqAO5rD6CJ7DPpPtdcrmnIOp
         bI89gk1wFhZKooN0os80Oei//3IvC+4ygXDSacNcXMC4UrJhnJdAcGvRD7R9BMtUbnOq
         ZgjX+JIglXRhbuHW5ow4teahPQ+nP7I+Z164r4OW6Ea1ATbiZZ5cXU3eZ+GLS9FTs4cE
         /JIyOhfquMxLaQHb/3e1geTckZmaYNrfLRjM2oxhNl8fayevd5neFnGDX0YtKNcnuimc
         +Jebf81WirLrhC4wj0Mo/diUMsEkxX0/tbWAAMLXK5T+pXJ0gqSxIl0rhstYasBC6/kz
         +plA==
X-Gm-Message-State: APjAAAV1sp7WCps54BZuY70RbQYofg8qiSyfushZEGWKTq1KdqAlK6EU
        XhtNjZL2UezZ0QQY6o5lkgPtZ4mZbLF4n68OO9JFcg==
X-Google-Smtp-Source: APXvYqzIPKpHsapC8ENx4jtmvoElcYw4Qq4xMMIWa5Ku+Nm08JDAhrfmSBMwGXNM+736TM9pWfKXY49DMZSTbMKwGBQ=
X-Received: by 2002:a63:6193:: with SMTP id v141mr3690361pgb.263.1567199635468;
 Fri, 30 Aug 2019 14:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190829062635.45609-1-natechancellor@gmail.com>
 <CAKwvOdkXSWE+_JCZsuQdkCSrK5pJSp9n_Cd27asFP0mHBfHg6w@mail.gmail.com>
 <20190829193432.GA10138@archlinux-threadripper> <885bb20c11f0cb004e5eeda7b0ca6d16@agner.ch>
 <CAKwvOdm-9T5Mmys93VMK8HLUgPJa2HOpcmG96SAvH2EGLA=3Nw@mail.gmail.com> <20190830172824.GA119107@archlinux-threadripper>
In-Reply-To: <20190830172824.GA119107@archlinux-threadripper>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 30 Aug 2019 14:13:44 -0700
Message-ID: <CAKwvOdksu_L+e52awkd=ffkaasCZeBjKcFU4nvU7q7reEzF2WA@mail.gmail.com>
Subject: Re: [PATCH] ARM: Emit __gnu_mcount_nc when using Clang 10.0.0 or newer
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Stefan Agner <stefan@agner.ch>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 10:28 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Aug 29, 2019 at 01:57:35PM -0700, Nick Desaulniers wrote:
> > On Thu, Aug 29, 2019 at 1:21 PM Stefan Agner <stefan@agner.ch> wrote:
> > >
> > > On 2019-08-29 21:34, Nathan Chancellor wrote:
> > > > On Thu, Aug 29, 2019 at 10:55:28AM -0700, Nick Desaulniers wrote:
> > > >> On Wed, Aug 28, 2019 at 11:27 PM Nathan Chancellor
> > > > I will test with or without CONFIG_AEABI like Matthias asked and I will
> > > > implement your Kconfig suggestion if it passes all of my tests. The
> > > > reason that I did it this way is because I didn't want a user to end up
> > > > with a non-booting kernel since -meabi gnu works with older versions of
> > > > clang at build time, the issue happens at boot time but the Kconfig
> > > > suggestion + cc-option should fix that.
> Disabling CONFIG_AEABI does not work with clang, I get a ton of failures
> around undefined references to __aeabi_idivmod and __aeabi_uidivmod. I
> don't think this is worth looking into given that CONFIG_AEABI is not
> selectable when CONFIG_CPU_V6 or CONFIG_CPU_V7 is selected, which is
> what we primarily care about.. We currently build and boot
> multi_v5_defconfig but it has CONFIG_AEABI set in it. As a result, I
> don't think we need to care about it with this patch.

The plan of record is to never support !CONFIG_AEBI (ie OABI) w/
Clang. See also my commit currently in linux-next:
ARM: 8875/1: Kconfig: default to AEABI w/ Clang
https://github.com/ClangBuiltLinux/linux/issues/482
so !AEABI is a moot point.  If we ever changed our minds, then yes we
should additionally guard on !CONFIG_AEABI, but I feel like that's a
highly unlikely scenario at this point.

>
> This diff would also solve the issue without the need for the version
> check in the Makefile, as it is the combination of -meabi gnu and -pg
> that causes the boot issue and -pg gets added when
> CONFIG_FUNCTION_TRACER is enabled. Would that be preferred? I do not
> think adding cc-option is necessary given that we know GCC universally
> does not support this flag; there is no point in adding a small penalty
> with cc-option to either compiler.
>
> Cheers,
> Nathan
>
> ================================================
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a98c7af50bf0..440ad41e77e4 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -83,7 +83,7 @@ config ARM
>         select HAVE_FAST_GUP if ARM_LPAE
>         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>         select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
> -       select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> +       select HAVE_FUNCTION_TRACER if !XIP_KERNEL && (CC_IS_GCC || CLANG_VERSION >= 100000)
>         select HAVE_GCC_PLUGINS
>         select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
>         select HAVE_IDE if PCI || ISA || PCMCIA
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index a43fc753aa53..23c2bf0fbd30 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -115,6 +115,10 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
>  CFLAGS_ABI     +=-funwind-tables
>  endif
>
> +ifeq ($(CONFIG_CC_IS_CLANG),y)
> +CFLAGS_ABI     +=-meabi gnu
> +endif

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> +
>  # Accept old syntax despite ".syntax unified"
>  AFLAGS_NOWARN  :=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
>


-- 
Thanks,
~Nick Desaulniers
