Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EB3C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EDB20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i8rP3w8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407427AbfIWRZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 13:25:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39231 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389167AbfIWRZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:25:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so4905525pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 10:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L3+53+4tDqcisH8nEn571hrd9nXBXU/wwqjTnECUQJw=;
        b=i8rP3w8H7XdRZzQC+vEtNbIOw2PeTLnH4pc4n+PfWkBuD6VjnLKHotKRieESI8WjSm
         JjZwAvWJhfKceU+qeK6fooGbCYweulh8jCh64Yz5EGZ1jzK8AozeErEi4H3XF4eEXBPh
         uCGqhTWoQMKGi9U0WOrIXVYcs5bNWMxlrTVs/He24GaBoNyTc9mSMmH/4A175a3IaX27
         Ib0jnP4AFA6g/nkI2nu+ZO9C5qjYMZOKSD3G0da4lcjdVTa17aGrH1lzHRqH02mAkVI1
         4ghF493+SAr863MhjVdpGXL2IhkO1ycALDeTCLWCb6jUt1cW3S1jINQnz14FGfI3EvZ7
         0g+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L3+53+4tDqcisH8nEn571hrd9nXBXU/wwqjTnECUQJw=;
        b=Ii/1yiFttzD1HUM8Ry+C2+56qQawOb0dvsmvNaJG99P9m8DzNI2rBYoa07l0f6YqNs
         HpbHnZPqkHIRWezOwWp6+jErg6hxQ7RIrJa2xRsLrQ2Gr9jzPxzP64TqcRNNGETG21fu
         ilXwVLxgVFDcpN8xuhg16r9y/kFnPwAIO4JoNgnP8cX41XSVLtPl5EMlfJs9EIFZq4K7
         ObcTRK9bzFEEihToxlfxvM2ABcJaMWe0FCwijK/dzXLkIv0v4KM5ZYhwZ+dvnfo+h3LL
         FMYjVByN6LIZ4CxofTc7idPOxPPu+ct9HGfwkmkIbBvqMLljfWgD2PJUbSkYd6cDcvEq
         WXtw==
X-Gm-Message-State: APjAAAUnDFnyJdSyRbnkJwICbfBJa2ogQlB5O4mV6Fxzl05tHPAC9YfU
        FLGb/XR/klmWoDK64CPpD3ymGibhdjzS05ZNWWy9sw==
X-Google-Smtp-Source: APXvYqzPebvl4GooiI4/1Ommn9k5fln0V+QYnrzWrMivCXE4C96/PAtt1lM1qELnrjqrWt506wH4mQ/oJ0m2QGgjYtA=
X-Received: by 2002:a17:90a:154f:: with SMTP id y15mr597914pja.73.1569259533361;
 Mon, 23 Sep 2019 10:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190922173241.GA44503@rani.riverdale.lan> <CAKwvOd=X9+uxQSzKad8B-Lw=ZarBT+SfNpBm_TE0k+DeJZmrsw@mail.gmail.com>
 <20190923171753.GA2252517@rani.riverdale.lan>
In-Reply-To: <20190923171753.GA2252517@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 23 Sep 2019 10:25:22 -0700
Message-ID: <CAKwvOdk86AdyiuM1iHPCYQ8CAhg9Y68e=ELzNCgTaOaUjNO0JQ@mail.gmail.com>
Subject: Re: [PATCH] x86/purgatory: Add $(DISABLE_STACKLEAK_PLUGIN)
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 10:17 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Since commit b059f801a937 ("x86/purgatory: Use CFLAGS_REMOVE rather than
> reset KBUILD_CFLAGS") kexec breaks is GCC_PLUGIN_STACKLEAK is enabled, as
> the purgatory contains undefined references to stackleak_track_stack.
> Attempting to load a kexec kernel results in:
>         kexec: Undefined symbol: stackleak_track_stack
>         kexec-bzImage64: Loading purgatory failed
>
> Fix this by disabling the stackleak plugin for purgatory.
>
> Fixes: b059f801a937 ("x86/purgatory: Use CFLAGS_REMOVE rather than reset KBUILD_CFLAGS")
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
(Sorry for the fallout from b059f801a937, but this is giving us a
pretty good idea about what "runtime" requirements certain configs
have.  It would be cool to eventually have some kind of kexec test
case that folks could run in QEMU).

> ---
>  arch/x86/purgatory/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 527749066d31..fb4ee5444379 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -25,6 +25,7 @@ KCOV_INSTRUMENT := n
>
>  PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
>  PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
> +PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN)
>
>  # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
>  # in turn leaves some undefined symbols like __fentry__ in purgatory and not
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers
