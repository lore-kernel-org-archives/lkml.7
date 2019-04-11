Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328B0C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF03D217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhxxXH4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfDKKn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:43:28 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40156 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfDKKn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:43:28 -0400
Received: by mail-ua1-f66.google.com with SMTP id b8so1845504uaq.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/GOt53/+wDHfpgnpT8grotgDQli96x/+uDMiECu7lo=;
        b=JhxxXH4XebXphnXH5p0S6kdRrIB/VfaOnvQd/t1tpaq9+MooKHstrNTPGEG2A+n1oj
         SLNU0kVNYhg7W7JZBeumZdyYP23lNuyvopeww9OkIHqXIak5KgJWxr9oZE2btkuVmv+b
         3+YTQcmaMZK+GnoxIyS5ldSu4AweyTd8YsfWWbHpsYNvBHkiVGkGIh99u7zJV1Zq+Kwe
         NM/OdZ1uf0+9uFs/5i70OTfB7I1higLUcWB6SjBUAwH9wdG5sN2nE3AJYEaM8Nvpa/Zq
         rgu+kRdGiW4f8At948k2nTWS2jpmyQ4HrWQc3yw2ZsOExSnnYOP2wdEzerVy7nmGQoH4
         LYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/GOt53/+wDHfpgnpT8grotgDQli96x/+uDMiECu7lo=;
        b=pixFlBEi/CFI2XpIzmXb2ry3alQ7Upo1645r7ZBpnuE4/xNnYPW/HdEpl86SNmRhmK
         4blGxX4ckLTJ1dJIxIBmTZR4PskoPL1pVK6KQJMTES0+trAR/ne8vuBLsBkiPLV7kzgf
         +K6A9lcxZjeB//oGS3Cd+1TsGAf0cPzPJwfViQV4hYIGTSsuQnM5TYakXepympMBRTzP
         0Bx+qTX3kiMwZYqAzlHtMcBZ22hsK8WOtQVa2arRauIsnNxZeLlL+kMLAVy5mLzNm7zz
         p2a3lal1YATLAk8Wk39GkszXfx+ofP+96FoVXotswadTTTTjLK3oweor6oe+xBS8HSTk
         fSew==
X-Gm-Message-State: APjAAAVPvo6+sp569xcMBEanIZb3oTz/t3Yt7uaX38SK/aqXh/lwZqsk
        lHEqqsDBo9ukBepZscYcUz9YFS1s3qeBwW/z6zvYXQ==
X-Google-Smtp-Source: APXvYqxI1PzG3yy/bEp5uAMoIdnxkHc5s2GiSSgeHHKKtoEmEuUvPlab0FrGMhaX9/Z72JHCupRY6iTOczLzc7oc/d8=
X-Received: by 2002:ab0:340a:: with SMTP id z10mr16616980uap.10.1554979407639;
 Thu, 11 Apr 2019 03:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190401125804.5665-1-faiz_abbas@ti.com>
In-Reply-To: <20190401125804.5665-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Apr 2019 12:42:51 +0200
Message-ID: <CAPDyKFpTc-RTQtbV+Q1_ebPoYa-3phmGpjvvCNRnG8-tSiCm=w@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci_am654: Clear HISPD_ENA in some lower speed modes
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2019 at 14:58, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> According to the AM654x Data Manual[1], the setup timing in lower speed
> modes can only be met if the controller uses a falling edge data launch.
>
> To ensure this, the HIGH_SPEED_ENA (HOST_CONTROL[2]) bit should be
> cleared in default speed, SD high speed, MMC high speed, SDR12 and SDR25
> speed modes.
>
> Use the sdhci writeb callback to implement this condition.
>
> [1] http://www.ti.com/lit/gpn/am6546 Section 5.10.5.16.1
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v2: Dropped QUIRK in favour of writeb callback
>
>  drivers/mmc/host/Kconfig       |  1 +
>  drivers/mmc/host/sdhci_am654.c | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 28fcd8f580a1..6379fba8b122 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -993,6 +993,7 @@ config MMC_SDHCI_OMAP
>  config MMC_SDHCI_AM654
>         tristate "Support for the SDHCI Controller in TI's AM654 SOCs"
>         depends on MMC_SDHCI_PLTFM && OF
> +       select MMC_SDHCI_IO_ACCESSORS
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
>           support present in TI's AM654 SOCs. The controller supports
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index eea183e90f1b..a91c0b45c48d 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -158,6 +158,27 @@ static void sdhci_am654_set_power(struct sdhci_host *host, unsigned char mode,
>         sdhci_set_power_noreg(host, mode, vdd);
>  }
>
> +static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
> +{
> +       unsigned char timing = host->mmc->ios.timing;
> +
> +       if (reg == SDHCI_HOST_CONTROL) {
> +               switch (timing) {
> +               /*
> +                * According to the data manual, HISPD bit
> +                * should not be set in these speed modes.
> +                */
> +               case MMC_TIMING_SD_HS:
> +               case MMC_TIMING_MMC_HS:
> +               case MMC_TIMING_UHS_SDR12:
> +               case MMC_TIMING_UHS_SDR25:
> +                       val &= ~SDHCI_CTRL_HISPD;
> +               }
> +       }
> +
> +       writeb(val, host->ioaddr + reg);
> +}
> +
>  static struct sdhci_ops sdhci_am654_ops = {
>         .get_max_clock = sdhci_pltfm_clk_get_max_clock,
>         .get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -165,6 +186,7 @@ static struct sdhci_ops sdhci_am654_ops = {
>         .set_bus_width = sdhci_set_bus_width,
>         .set_power = sdhci_am654_set_power,
>         .set_clock = sdhci_am654_set_clock,
> +       .write_b = sdhci_am654_write_b,
>         .reset = sdhci_reset,
>  };
>
> --
> 2.19.2
>
