Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67976CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF9020700
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="txob3QU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442493AbfJRK6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:58:53 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34160 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbfJRK6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:58:51 -0400
Received: by mail-ua1-f68.google.com with SMTP id q11so1598010uao.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 03:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ca95FDLqVIwTMxVi4C0ayivApjVlDjhZW98VO/akMgw=;
        b=txob3QU1ZZTBr0fz4z1FAnmHKFKvTJ+uRKGQjWfv+3JhC2sJ1lflA9qM3Kst2lbjmb
         UU2KSKOk2eLmzH1mxykoepji9eYZNIvnZa72C/jt4hcAlBVJleXvYm9YDNZMxvoQWBNO
         VF4Bxr9D8QmRL2D8MZ9EWW+I3n3etbUrDnpYt/ZC+o0Wj+c+ix3TSf8+Suhyeh115NUC
         tStpPj7Ror60+sjVEEZQa7O0LtgYRjv0BjsUKjv5uA4fe1Z1Q5ouuTwEVwfx0V85FIZa
         zWBehNZCpxNuuobsMOgM96pxaT527zwyBf2bM638+HGqDRPGYtoj++kskg67e+ENTC7Y
         gLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ca95FDLqVIwTMxVi4C0ayivApjVlDjhZW98VO/akMgw=;
        b=YVyXOLMVLPgTgg83+Ut7cBs4CXT5GydhdH6iq0DlA+PIdOgHR371T8ZmO+v7GlfPb5
         0hkms+6YNI31DJPiubT3ZNZx87JyViW/8V+xTB5mjIUby07vilXw7D6xqr1cYhhXMnzj
         X2r653z283H+4fe2wdShtInpwdszvvMGb2FiDuFULp+3jW9Fe4wMjKdRtXnRV36gLlFO
         7kpg2AsjSLdD4WHRtyXv4kDH4YNSwM3ArF3OqGKsq72T3wkoI7mL544RoEDgzV4Hvxjf
         +V9FP3PdqCjBdEjWcjToGvni5K4za1l+3761BBo1/fs8IteTXFOnOvAqbdxRDKTdYMoe
         h61g==
X-Gm-Message-State: APjAAAV2sGPPYF0lzqwOQoSV0gzLlg7lhnFUm0HX7/VODzkt8Ph1MBsh
        5Cbg6QqKyStARMPbsjtaA/WRvImsytIHiGz/mT/e0g==
X-Google-Smtp-Source: APXvYqziBvPUdA/pLLnCkQCMGiBKL9xGlNYI+FQR3EGKYfmEWMjStiFUlTUn4Sou39IKFohPDlanYzU+rI6rRKbtiJo=
X-Received: by 2002:ab0:348c:: with SMTP id c12mr534722uar.100.1571396330137;
 Fri, 18 Oct 2019 03:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <4d269f30b1122487a2b5c8b48e24f78f2b75a509.1570537903.git.nicolas.ferre@microchip.com>
 <d25c8f909d039938a5696e8de32396cf2aaf54b7.1570537903.git.nicolas.ferre@microchip.com>
In-Reply-To: <d25c8f909d039938a5696e8de32396cf2aaf54b7.1570537903.git.nicolas.ferre@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Oct 2019 12:58:14 +0200
Message-ID: <CAPDyKFrR810Yb+CqrhvJpSPW0yDEuWsNBysnbEq=3YHcOsVLhw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-at91: add DT property to enable
 calibration on full reset
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019 at 14:34, Nicolas Ferre <nicolas.ferre@microchip.com> wrote:
>
> Add a property to keep the analog calibration cell powered.
> This feature is specific to the Microchip SDHCI IP and outside
> of the standard SDHCI register map.
>
> By always keeping it on, after a full reset sequence, we make sure
> that this feature is activated and not disabled.
>
> We expose a hardware property to the DT as this feature can be used
> to adapt SDHCI behavior vs. how the SDCAL SoC pin is connected
> on the board.
>
> Note that managing properly this property would reduce
> power consumption on some SAMA5D2 SiP revisions.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-at91.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index e7d1920729fb..9571c4a882a9 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -27,6 +27,9 @@
>  #define SDMMC_CACR     0x230
>  #define                SDMMC_CACR_CAPWREN      BIT(0)
>  #define                SDMMC_CACR_KEY          (0x46 << 8)
> +#define SDMMC_CALCR    0x240
> +#define                SDMMC_CALCR_EN          BIT(0)
> +#define                SDMMC_CALCR_ALWYSON     BIT(4)
>
>  #define SDHCI_AT91_PRESET_COMMON_CONF  0x400 /* drv type B, programmable clock mode */
>
> @@ -35,6 +38,7 @@ struct sdhci_at91_priv {
>         struct clk *gck;
>         struct clk *mainck;
>         bool restore_needed;
> +       bool cal_always_on;
>  };
>
>  static void sdhci_at91_set_force_card_detect(struct sdhci_host *host)
> @@ -116,10 +120,17 @@ static void sdhci_at91_set_uhs_signaling(struct sdhci_host *host,
>
>  static void sdhci_at91_reset(struct sdhci_host *host, u8 mask)
>  {
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
>         sdhci_reset(host, mask);
>
>         if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
>                 sdhci_at91_set_force_card_detect(host);
> +
> +       if (priv->cal_always_on && (mask & SDHCI_RESET_ALL))
> +               sdhci_writel(host, SDMMC_CALCR_ALWYSON | SDMMC_CALCR_EN,
> +                            SDMMC_CALCR);
>  }
>
>  static const struct sdhci_ops sdhci_at91_sama5d2_ops = {
> @@ -345,6 +356,14 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>
>         priv->restore_needed = false;
>
> +       /*
> +        * if SDCAL pin is wrongly connected, we must enable
> +        * the analog calibration cell permanently.
> +        */
> +       priv->cal_always_on =
> +               device_property_read_bool(&pdev->dev,
> +                                         "microchip,sdcal-inverted");
> +
>         ret = mmc_of_parse(host->mmc);
>         if (ret)
>                 goto clocks_disable_unprepare;
> --
> 2.17.1
>
