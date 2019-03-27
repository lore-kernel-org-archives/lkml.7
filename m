Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EA8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9444E20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJfLc2na"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbfC0Kz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:55:26 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:33853 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732159AbfC0KzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:55:25 -0400
Received: by mail-vk1-f194.google.com with SMTP id k64so3536090vke.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 03:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8D93uEpQIWR9bU2gewfVnHMOexOYmOATDsj8KMhWmzs=;
        b=OJfLc2naHRECuIF3I6IPiVv3URfyr0S5zFIHOxztLXtFE+fNJpuKp5VeuFIcalhURz
         QO7/lX9t4W7YdD3Jar2htHmgTbycM8t3zsZFPlXY5I5CufqVunX0sahaEfNd5wewGFUH
         s34LQrwoNdoO29c1r6aTY1wyBRXZEpPFfAkoPiwmqBEeY6NKNZqD+gX1Qn+x+7zIZPYv
         7ojUUCy4i60atzMpZGmgcUp99HmD0X6YXqUs+cppvi4G1E9miPUMA/dAsKYTUqBPWgFl
         wlLfYCpIpJkzgUKYvO+bECtRKkQR7v72C83vb2Lqqn4Nerdsr6ErVD/FxOILMTDBFcEH
         UGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8D93uEpQIWR9bU2gewfVnHMOexOYmOATDsj8KMhWmzs=;
        b=Cl0g4rVM7pvaF+D+Le/bkEjFZ2cd+r2Ysj8DiFt9ytpiYyrebwyCfGlmfFg/9J/fnz
         lWH2qsTsaedStKzK2K/0otlI9Oc48ukvBgTtdhOpTFzD0tkb0yk8T7mP/wsp+yASb9AW
         +TgYZFTei45m+lWTlglZ7r7ZiYQBY1PHFI0AbWRsuhGP285K7JADLU8UgCrLmyRBak2J
         3Ql+VDPrQszsqPJOL2yJjhfGR3WfP23Ect2Ig33iJOwD8BKls7FxHZhErf/YWPvsxYhU
         EFOLjlv+vqo/Dyai2dyLHDDjKgvcVcGgrfXu1Cb6f3KBJmcy9dn72Gy8aSuGJYq3GTK7
         bJhw==
X-Gm-Message-State: APjAAAWF4vlB2cQ00woUDFf8PcCl7wU7z7pPUpM85AmP6mpEmqD3+M+j
        VjQ9S4P4KLxtWmengCgBc2cuDjAejA92mKwJqcBRtw==
X-Google-Smtp-Source: APXvYqyJVNLMJUg1HOBmLfdxHIBC094HJD7Mc71tky+a7mqgXb90y0f5DRsmFajAKM3Ikci960C5FcY1JjrxHcV+MDc=
X-Received: by 2002:a1f:28d7:: with SMTP id o206mr3699484vko.36.1553684124211;
 Wed, 27 Mar 2019 03:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <1553677532-3539-1-git-send-email-ludovic.Barre@st.com> <1553677532-3539-5-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1553677532-3539-5-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Mar 2019 11:54:45 +0100
Message-ID: <CAPDyKFrGRojw5jmGZ_J-nmP4bHqd0BnKwyKweAr6aLD4C4NMPQ@mail.gmail.com>
Subject: Re: [PATCH V4 4/5] mmc: mmci: stm32: define get_dctrl_cfg
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 at 10:05, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch defines get_dctrl_cfg callback for sdmmc variant.
> sdmmc variant has specific stm32 transfer modes.
> sdmmc data transfer mode selection could be:
> -Block data transfer ending on block count.
> -SDIO multibyte data transfer.
> -MMC Stream data transfer (not used).
> -Block data transfer ending with STOP_TRANSMISSION command.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.h             |  5 +++++
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 18 ++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 35c91d0..82e9f94 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -131,6 +131,11 @@
>  /* Control register extensions in the Qualcomm versions */
>  #define MCI_DPSM_QCOM_DATA_PEND        BIT(17)
>  #define MCI_DPSM_QCOM_RX_DATA_PEND BIT(20)
> +/* Control register extensions in STM32 versions */
> +#define MCI_DPSM_STM32_MODE_BLOCK      (0 << 2)
> +#define MCI_DPSM_STM32_MODE_SDIO       (1 << 2)
> +#define MCI_DPSM_STM32_MODE_STREAM     (2 << 2)
> +#define MCI_DPSM_STM32_MODE_BLOCK_STOP (3 << 2)
>
>  #define MMCIDATACNT            0x030
>  #define MMCISTATUS             0x034
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index cfbfc6f..8e83ae6 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -265,10 +265,28 @@ static void mmci_sdmmc_set_pwrreg(struct mmci_host *host, unsigned int pwr)
>         }
>  }
>
> +static u32 sdmmc_get_dctrl_cfg(struct mmci_host *host)
> +{
> +       u32 datactrl;
> +
> +       datactrl = mmci_dctrl_blksz(host);
> +
> +       if (host->mmc->card && mmc_card_sdio(host->mmc->card) &&
> +           host->data->blocks == 1)
> +               datactrl |= MCI_DPSM_STM32_MODE_SDIO;
> +       else if (host->data->stop && !host->mrq->sbc)
> +               datactrl |= MCI_DPSM_STM32_MODE_BLOCK_STOP;

Just a question here. Does this mean that the controller sends the
stop command automatically when a transfer has finished successfully?

> +       else
> +               datactrl |= MCI_DPSM_STM32_MODE_BLOCK;
> +
> +       return datactrl;
> +}
> +
>  static struct mmci_host_ops sdmmc_variant_ops = {
>         .validate_data = sdmmc_idma_validate_data,
>         .prep_data = sdmmc_idma_prep_data,
>         .unprep_data = sdmmc_idma_unprep_data,
> +       .get_datactrl_cfg = sdmmc_get_dctrl_cfg,
>         .dma_setup = sdmmc_idma_setup,
>         .dma_start = sdmmc_idma_start,
>         .dma_finalize = sdmmc_idma_finalize,
> --
> 2.7.4
>

Kind regards
Uffe
