Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1BFC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04A02063F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVlWniVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfF0HaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:30:17 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42464 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfF0HaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:30:17 -0400
Received: by mail-io1-f66.google.com with SMTP id u19so2551980ior.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 00:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m9mecs4e5Wsida9t8S/le8lj8VgFqltg0rd2WgLjRdc=;
        b=QVlWniVzQr9Py3FoYfYhI3tAE9t1jqAW8O721fa4F7WDZGwC1Q8r7YhYQgHkTOG8ML
         YRjz2cBsi+H22F0DlDJZWhozSgiGJc6WDy3roWiQW11NRN/x0io2PXng3GThqpASfpCr
         VZBD8l2LiaOg4uCFdC91k+D0lK8EQnDNhSfDpqSBOM2R+BHlX0+9YIu4TeFCXE8nEKla
         1vYLaVrjhi5DJ73S3Y/X+tW6YEhyGK/WTdqHhmgDq7VyvKp2neTdkiL0zBPoQcpgkoeJ
         naicjOUlw6R2sBfF8e+JuIzo8Vf8JRCqzrapuDLfLlQHgid6kDxS/5MqV2N8uXpZQ9hN
         CdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m9mecs4e5Wsida9t8S/le8lj8VgFqltg0rd2WgLjRdc=;
        b=DglOPsZKUIt4cUnMbk8bcUelSYnwdL+Syx3D8y28sBMg+kxU6gyXO9CmF7nGT6axTB
         y710izIEc9Mtq4qjQtdmifTvSqreu7PLFO9FMkPOK8kBOuvr+O2rOCrs6u8AKLwJVitj
         AZvu6cVlCnjBH88e8g8X3XlbI4mjdhwUrcLHVRNxOjARIkmygmpz9879YJcGeO6jsIIx
         wEiVAOoMnbj/pCCLRgdRjtgxymC50HYo222PPfNKVgJrE8m09fyFlGH8jPDUO2/DxVXM
         764jfu4foqJaH8j/ziQONLKK0iWUP+bxN+CYWNGIWLNBt5Hqt7EZqnGtDeA2pFeofgWx
         uosw==
X-Gm-Message-State: APjAAAWvFsUnATQO2VgQPmoUe94N3xZMm53cyaFpbSxWYLIj9Hegs2gP
        qndO8c++RgCXS1zbScMYcshSZYg7Jw2HLQv7iekFAg==
X-Google-Smtp-Source: APXvYqzuqK2wYgvAi4gnFHr8y8d8JWXs8r4UGoduhVCUJRqklO+uoYhGS+229c8Zigv0u4UFt5yV7DpkpAgbyQvg8z4=
X-Received: by 2002:a05:6602:98:: with SMTP id h24mr2966317iob.49.1561620615992;
 Thu, 27 Jun 2019 00:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <201906261343.5F26328@keescook>
In-Reply-To: <201906261343.5F26328@keescook>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 27 Jun 2019 09:30:03 +0200
Message-ID: <CAKv+Gu9Tnrw3BpDNBDvo5bc4Zi4EzbF3w7JdkwAsbX_d2Ty_eA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Move jump_label_init() before parse_early_param()
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019 at 22:51, Kees Cook <keescook@chromium.org> wrote:
>
> While jump_label_init() was moved earlier in the boot process in commit
> efd9e03facd0 ("arm64: Use static keys for CPU features"), it wasn't
> early enough for early params to use it. The old state of things was as
> described here...
>
> init/main.c calls out to arch-specific things before general jump
> label and early param handling:
>
> asmlinkage __visible void __init start_kernel(void)
> {
>         ...
>         setup_arch(&command_line);
>         ...
>         smp_prepare_boot_cpu();
>         ...
>         /* parameters may set static keys */
>         jump_label_init();
>         parse_early_param();
>         ...
> }
>
> x86 setup_arch() wants those earlier, so it handles jump label and
> early param:
>
> void __init setup_arch(char **cmdline_p)
> {
>         ...
>         jump_label_init();
>         ...
>         parse_early_param();
>         ...
> }
>
> arm64 setup_arch() only had early param:
>
> void __init setup_arch(char **cmdline_p)
> {
>         ...
>         parse_early_param();
>         ...
> }
>
> with jump label later in smp_prepare_boot_cpu():
>
> void __init smp_prepare_boot_cpu(void)
> {
>         ...
>         jump_label_init();
>         ...
> }
>
> This moves arm64 jump_label_init() from smp_prepare_boot_cpu() to
> setup_arch(), as done already on x86, in preparation from early param
> usage in the init_on_alloc/free() series:
> https://lkml.kernel.org/r/1561572949.5154.81.camel@lca.pw
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/kernel/setup.c | 5 +++++
>  arch/arm64/kernel/smp.c   | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 7e541f947b4c..9c4bad7d7131 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -283,6 +283,11 @@ void __init setup_arch(char **cmdline_p)
>
>         setup_machine_fdt(__fdt_pointer);
>
> +       /*
> +        * Initialise the static keys early as they may be enabled by the
> +        * cpufeature code and early parameters.
> +        */
> +       jump_label_init();
>         parse_early_param();
>
>         /*
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 6dcf9607d770..20c456b3862c 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -424,11 +424,6 @@ void __init smp_cpus_done(unsigned int max_cpus)
>  void __init smp_prepare_boot_cpu(void)
>  {
>         set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
> -       /*
> -        * Initialise the static keys early as they may be enabled by the
> -        * cpufeature code.
> -        */
> -       jump_label_init();
>         cpuinfo_store_boot_cpu();
>
>         /*
> --
> 2.17.1
>
>
> --
> Kees Cook
