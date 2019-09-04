Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB0DC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEC62087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aXZuvHa1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbfIDQEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:04:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44112 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387668AbfIDQD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:03:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id k1so2411359pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 09:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUu7jEYknwWvPxSIww3cGcFcBMCEyjRD/qWIx9TD3dM=;
        b=aXZuvHa1hI0zECNodigCdK/AztketBGpB5KRo99bRJAegKGh23AkFftnjVgCaQaYDV
         r/MAFpjbZKtw9yEBG0/c5KTGKhI4RAykuTQl84poX4lM48t1KTqUSsYBOFHljnO4qmam
         XteiWsbMMNyhozK6Rdt5paMH9GLgojCUbIjRKbMfNQDmCPIzw3DlVI6wSKYqYvkOWA/A
         ag8XUqXeofKviz4dFZpvsV3nGBLYTvOOv38pvtGLJaUEx173EZABiusTJYLp92JpW39J
         OQn62QVMk4ShDqUgPZZArtPwKtwpydm0NbYHM+MHTzTZuELA9GfQ5RFLZWipxWu7w4Yy
         Tltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUu7jEYknwWvPxSIww3cGcFcBMCEyjRD/qWIx9TD3dM=;
        b=BX/wQpwfhBid4vraza3Mjqm1Ir9uD/bc/zX2/gcxWzG9dnAvxXiDRxVINySxi3pbTW
         YN5m82XUdOwyyUHaJKhBCi2obI9Ow6biVGR8ns58HxfNQReKzjzzSTd7BtaZzBy+UOOH
         Ccuq7qXnWnN3fbvpiEj72pZMRfR8ok8ENl2yjDuV613EIjo7SO7rDLVapHMpZbfn0XfY
         FWOQCaOSVx7jSdF8AnmAgrwxtmQQhSz7ug9tvmp6w8Uzr+clVOh+59mpp7NYfriRT8MY
         T2y6AjqWFxvi7SyMEqOelpXyXnu/cWtNUd33PO16zizUg9FI5G2pX1pTx3tmWzS++HCA
         7Pew==
X-Gm-Message-State: APjAAAV2fC2EGTZuMedKk7KW0OvAbu9XfzHLnKd8ysNhXVMo2ZzEaxr6
        FF8qDRLumyQxer6E7Dh8muioY7p8hw6vS3toxVzIkQ==
X-Google-Smtp-Source: APXvYqyh8FzyyXaEHkm20wLHSSAh7U+934bzlwlLUUm/+rv9EcqnfWWn+NUpe56pQBjtLrshWi/RV1TYMuNAiJdPfH0=
X-Received: by 2002:a17:902:8484:: with SMTP id c4mr41196596plo.223.1567613005847;
 Wed, 04 Sep 2019 09:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190904160039.3350229-1-arnd@arndb.de>
In-Reply-To: <20190904160039.3350229-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 4 Sep 2019 09:03:13 -0700
Message-ID: <CAKwvOd=udH0NLaz_+PbJ4ANyoJ3gGKZ-gsfTJ3xDJOqpsO1y0g@mail.gmail.com>
Subject: Re: [PATCH] bus: imx-weim: remove incorrect __init annotations
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ilie Halip <ilie.halip@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 9:00 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The probe function is no longer __init, so anything it calls now
> must also be available at runtime, as Kbuild points out when building
> with clang-9:

Thanks for the patch, this has already been addressed in:
https://patchwork.kernel.org/patch/11114307/
https://github.com/ClangBuiltLinux/linux/issues/645

>
> WARNING: vmlinux.o(.text+0x6e7040): Section mismatch in reference from the function weim_probe() to the function .init.text:imx_weim_gpr_setup()
> The function weim_probe() references
> the function __init imx_weim_gpr_setup().
> This is often because weim_probe lacks a __init
> annotation or the annotation of imx_weim_gpr_setup is wrong.
>
> WARNING: vmlinux.o(.text+0x6e70f0): Section mismatch in reference from the function weim_probe() to the function .init.text:weim_timing_setup()
> The function weim_probe() references
> the function __init weim_timing_setup().
> This is often because weim_probe lacks a __init
> annotation or the annotation of weim_timing_setup is wrong.
>
> Remove the remaining __init markings that are now wrong.
>
> Fixes: 4a92f07816ba ("bus: imx-weim: use module_platform_driver()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I applied this on top of the patch taht introduced the build error
>
>  drivers/bus/imx-weim.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 79af0c27f5a3..28bb65a5613f 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -76,7 +76,7 @@ static const struct of_device_id weim_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(of, weim_id_table);
>
> -static int __init imx_weim_gpr_setup(struct platform_device *pdev)
> +static int imx_weim_gpr_setup(struct platform_device *pdev)
>  {
>         struct device_node *np = pdev->dev.of_node;
>         struct property *prop;
> @@ -126,10 +126,10 @@ static int __init imx_weim_gpr_setup(struct platform_device *pdev)
>  }
>
>  /* Parse and set the timing for this device. */
> -static int __init weim_timing_setup(struct device *dev,
> -                                   struct device_node *np, void __iomem *base,
> -                                   const struct imx_weim_devtype *devtype,
> -                                   struct cs_timing_state *ts)
> +static int weim_timing_setup(struct device *dev,
> +                            struct device_node *np, void __iomem *base,
> +                            const struct imx_weim_devtype *devtype,
> +                            struct cs_timing_state *ts)
>  {
>         u32 cs_idx, value[MAX_CS_REGS_COUNT];
>         int i, ret;
> --
> 2.20.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190904160039.3350229-1-arnd%40arndb.de.



-- 
Thanks,
~Nick Desaulniers
