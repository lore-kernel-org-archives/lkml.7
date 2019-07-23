Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B5BC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB5B227C1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eelFDO4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403836AbfGWScH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:32:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45526 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfGWScH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:32:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so20936232plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6Z296Ww2u/bmu3pYPAARMC4DrDQxa2anOwOIWqwEVs=;
        b=eelFDO4qRHcOF8UxYjEYnL3lYVbQMJZHxikjazCXLj2qEtDNjUpuE1v/311FJyC8we
         SNSis0uVdCxQ7Uf2v+t0+0mGcdLaViREKZfLMosFRIVGR6Chk1+dFtZLoiQ8eKkmiUNh
         B2yDPCv5P/MXgOhh6JZwq/2h3ziG2zOwKUPuxyqtUX0gOPxrEoDrvzCSRPEfrZlm1CxV
         4NaIfqGCfmnS4daYZNDct9HxaSC/Nq29wT589N37TQ4ZpLW6RCnQLTBcxl+15IoTh8si
         4Ot9kNxggOyAXGRQLYmchtkTuGUCcyMqKiAoSKNuovm3GAHKJyQTLLtHJqAfFQKmok9C
         XyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6Z296Ww2u/bmu3pYPAARMC4DrDQxa2anOwOIWqwEVs=;
        b=KgWRBFhb5j2UOFESB+4DDfPjztUY4QL7J0IsQeHRcAxFRswIQkarnwjvL81F1VAWg2
         GQr6WqbWNn7oW5yWm3y1XQFze6/E0t+cvr/DHegGmjI5/1jcYhU3X5uXUCSCKu57ya7P
         N/OKz5ztbW8/ZBaWCyDMMMvpFNzDEfSo1VskbRXWfLvnUyWUaenehLgChQSwDIOFgrZ6
         zm9WOWP9wMZk678L9SF/v0Ka/CwXEdMrhS99HQI2A6/QwgEWEQfXfHwO7cHnI5b9sLiL
         geut24OXn0eFOLN/RgsXjBSJqL34nUcULekFwaDq/2HzrD5BD6Ic/6FraoyvREPRABbJ
         2kvw==
X-Gm-Message-State: APjAAAWPVYyQYIsz0N9TwYZluS7YEkVzrV6jP/lb7Cdh5zsJxHbeL3Sw
        7liTmj0SFthSawqUR6Ox+VUpFmwbWnk5hJEBmho=
X-Google-Smtp-Source: APXvYqwySaMOFEwyvnfdNbD6ux2WzrhNRIdYpGOvpHhuYRTaAmodVcb7vQXCAVcvYhIjYbDru78fk0/btutwIRHhSAs=
X-Received: by 2002:a17:902:694a:: with SMTP id k10mr81183804plt.255.1563906725912;
 Tue, 23 Jul 2019 11:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190723181624.203864-1-swboyd@chromium.org> <20190723181624.203864-3-swboyd@chromium.org>
In-Reply-To: <20190723181624.203864-3-swboyd@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 23 Jul 2019 21:31:54 +0300
Message-ID: <CAHp75Vf8EUKLSWoEshU_VogBDym_oco_kj3AhfT=9KqtaGba3Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] treewide: Remove dev_err() usage after platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 9:16 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
>
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
>
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
>
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
>

Can you teach it to remove curly braces when it's appropriate? (see
below for examples)

>  drivers/i2c/busses/i2c-cht-wc.c               |  1 -

>  drivers/mfd/intel_soc_pmic_bxtwc.c            |  1 -

>  drivers/pinctrl/intel/pinctrl-cherryview.c    |  1 -
>  drivers/pinctrl/intel/pinctrl-intel.c         |  1 -

>  drivers/platform/x86/intel_bxtwc_tmu.c        |  1 -
>  drivers/platform/x86/intel_int0002_vgpio.c    |  1 -
>  drivers/platform/x86/intel_pmc_ipc.c          |  1 -

Can you split this on per subsystem level?

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
after addressing above.

> diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
> index 66af44bfa67d..02f9f3eccbed 100644
> --- a/drivers/i2c/busses/i2c-cht-wc.c
> +++ b/drivers/i2c/busses/i2c-cht-wc.c
> @@ -270,7 +270,6 @@ static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
>
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0) {
> -               dev_err(&pdev->dev, "Error missing irq resource\n");
>                 return -EINVAL;
>         }

No need for curly braces.

> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
> index 6310c3bdb991..3bbd16628581 100644
> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
> @@ -451,7 +451,6 @@ static int bxtwc_probe(struct platform_device *pdev)
>
>         ret = platform_get_irq(pdev, 0);
>         if (ret < 0) {
> -               dev_err(&pdev->dev, "Invalid IRQ\n");
>                 return ret;
>         }
>         pmic->irq = ret;

Ditto.

> diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
> index 03ec7a5d9d0b..98f8b276db51 100644
> --- a/drivers/pinctrl/intel/pinctrl-cherryview.c
> +++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
> @@ -1704,7 +1704,6 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
>
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0) {
> -               dev_err(&pdev->dev, "failed to get interrupt number\n");
>                 return irq;
>         }
>
> diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
> index a18d6eefe672..f37c4a7ff313 100644
> --- a/drivers/pinctrl/intel/pinctrl-intel.c
> +++ b/drivers/pinctrl/intel/pinctrl-intel.c
> @@ -1355,7 +1355,6 @@ static int intel_pinctrl_probe(struct platform_device *pdev,
>
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0) {
> -               dev_err(&pdev->dev, "failed to get interrupt number\n");
>                 return irq;
>         }
>

Ditto.

> diff --git a/drivers/platform/x86/intel_bxtwc_tmu.c b/drivers/platform/x86/intel_bxtwc_tmu.c
> index 951c105bafc1..fe609b937def 100644
> --- a/drivers/platform/x86/intel_bxtwc_tmu.c
> +++ b/drivers/platform/x86/intel_bxtwc_tmu.c
> @@ -62,7 +62,6 @@ static int bxt_wcove_tmu_probe(struct platform_device *pdev)
>         irq = platform_get_irq(pdev, 0);
>
>         if (irq < 0) {
> -               dev_err(&pdev->dev, "invalid irq %d\n", irq);
>                 return irq;
>         }
>
> diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
> index d9542c661ddc..cca021e42baa 100644
> --- a/drivers/platform/x86/intel_int0002_vgpio.c
> +++ b/drivers/platform/x86/intel_int0002_vgpio.c
> @@ -167,7 +167,6 @@ static int int0002_probe(struct platform_device *pdev)
>
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0) {
> -               dev_err(dev, "Error getting IRQ: %d\n", irq);
>                 return irq;
>         }
>
> diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
> index 55037ff258f8..b5b9baf3e898 100644
> --- a/drivers/platform/x86/intel_pmc_ipc.c
> +++ b/drivers/platform/x86/intel_pmc_ipc.c
> @@ -937,7 +937,6 @@ static int ipc_plat_probe(struct platform_device *pdev)
>
>         ipcdev.irq = platform_get_irq(pdev, 0);
>         if (ipcdev.irq < 0) {
> -               dev_err(&pdev->dev, "Failed to get irq\n");
>                 return -EINVAL;
>         }
>

Ditto.

-- 
With Best Regards,
Andy Shevchenko
