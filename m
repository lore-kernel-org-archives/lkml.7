Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D3AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781A72173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lRFCIPmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfH0Nu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:50:29 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45055 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbfH0Nu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:50:28 -0400
Received: by mail-vs1-f67.google.com with SMTP id c7so13465525vse.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 06:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9nTdAXMkkDWuizv1tysprjOJ2R0IJRbo/lx0RTYg+gg=;
        b=lRFCIPmx30bbAcvZ3ja1zoN/Q3+vSqfaVYAcaCKhScS9+a4YuFNPLRxB9y5OIZW+Iu
         6pa5Iu/6QsGXgoEY5AB8deRH2GTZgetkr0vkJL6dpQ4V0cl0AHjU48W6ayhzWNXsgMuL
         /3GYi+XhaOw8Wi5LXWnKjn6WgGak6tZhmxOIZWPfBop/ZWYefWw46yN0SAPYQCBO7WMN
         zMJvjGTPUCviMFP2pVUsoXeG//iGiUMhfuVu2czaHGlLoJAO/pbzLBl48LxnmKEsmfZk
         bmfQvPvgwX4m9OyGWFQNO5nK+jZ2umhflxqFk4orYXIMuiKov8bBIoNu34lHmvkenMS2
         lx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9nTdAXMkkDWuizv1tysprjOJ2R0IJRbo/lx0RTYg+gg=;
        b=OFptCXX5yhp1+CqnVy+/kg4BI+6jBPD8GILHeJgNIXSpDDxs9Ul9fZaLbpX0IWmTXS
         f8+oEtPkL8I8fj4zac0XY1z25/6nEXRvOz5eCVME9AgZ6HSkWPLhptRTFGHEELzdn7Xe
         ajiQSv2MokjZ/A7NO50gV304+pFk3hMOsyVBu0Un/1o/V742mnjCpZEWX1d4Uqj++bIQ
         igjNvLCmL7sTSji4qFfTwsDt2OMVkDatP7Toi+2j5+xSmIKnMZNGaOIACRjhl4gX9nQu
         /E+9NJX/ryOZRnswCzzB2SVmcrdgXaNxat9IwT28VKvG3/jSY3f9lcCYssfxZbzjunbK
         10Zg==
X-Gm-Message-State: APjAAAVGvFYLaV98OIbXNITFg8t6v8wY5MUXvqYTEKBUtY/oHlvXgeci
        XrgF9XOBYty5LQUatsiErDUl1UJLeggbWkxwYPqtxw==
X-Google-Smtp-Source: APXvYqxuL5QLvtpihYjZI5CsVwD6jsXto4QZa31USkmsbOyid71SgorLhwLsMkfjsVyq/LxIIJYnJj5VAXPG3DJ54S8=
X-Received: by 2002:a67:32c5:: with SMTP id y188mr13651472vsy.191.1566913827420;
 Tue, 27 Aug 2019 06:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190826072800.38413-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190826072800.38413-2-vadivel.muruganx.ramuthevar@linux.intel.com>
In-Reply-To: <20190826072800.38413-2-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Aug 2019 15:49:49 +0200
Message-ID: <CAPDyKFrPoPqnh3_23P=wGO+QrUE9ogJzC6xgzy+0QeyuyeO=HQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: sdhci-of-arasan: Add Support for Intel LGM eMMC
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Aug 2019 at 09:28, Ramuthevar,Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> From: Ramuthevar Vadivel Muruganx <vadivel.muruganx.ramuthevar@linux.intel.com>
>
> The current arasan sdhci PHY configuration isn't compatible
> with the PHY on Intel's LGM(Lightning Mountain) SoC devices.
>
> Therefore, add a new compatible, to adapt the Intel's LGM
> eMMC PHY with arasan-sdhc controller to configure the PHY.
>
> Signed-off-by: Ramuthevar Vadivel Muruganx <vadivel.muruganx.ramuthevar@linux.intel.com>


Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index b12abf9b15f2..7023cbec4017 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -114,6 +114,12 @@ static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map = {
>         .hiword_update = true,
>  };
>
> +static const struct sdhci_arasan_soc_ctl_map intel_lgm_emmc_soc_ctl_map = {
> +       .baseclkfreq = { .reg = 0xa0, .width = 8, .shift = 2 },
> +       .clockmultiplier = { .reg = 0, .width = -1, .shift = -1 },
> +       .hiword_update = false,
> +};
> +
>  /**
>   * sdhci_arasan_syscon_write - Write to a field in soc_ctl registers
>   *
> @@ -373,6 +379,11 @@ static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
>         .pdata = &sdhci_arasan_cqe_pdata,
>  };
>
> +static struct sdhci_arasan_of_data intel_lgm_emmc_data = {
> +       .soc_ctl_map = &intel_lgm_emmc_soc_ctl_map,
> +       .pdata = &sdhci_arasan_cqe_pdata,
> +};
> +
>  #ifdef CONFIG_PM_SLEEP
>  /**
>   * sdhci_arasan_suspend - Suspend method for the driver
> @@ -474,6 +485,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
>                 .compatible = "rockchip,rk3399-sdhci-5.1",
>                 .data = &sdhci_arasan_rk3399_data,
>         },
> +       {
> +               .compatible = "intel,lgm-sdhci-5.1-emmc",
> +               .data = &intel_lgm_emmc_data,
> +       },
>         /* Generic compatible below here */
>         {
>                 .compatible = "arasan,sdhci-8.9a",
> --
> 2.11.0
>
