Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5FDC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C75D20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p8CFtX9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfCFNc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:32:29 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44046 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfCFNc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 08:32:29 -0500
Received: by mail-vs1-f65.google.com with SMTP id r201so2188893vsc.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 05:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqeJmwiVJ3THo/zk+FitT7vSw+iu9lg/E46M2S5sS38=;
        b=p8CFtX9P7DoqMlFOXApz/Lj6Tm6Tt/WGn7mQ8UgOTUG+sS/jX+ttU+qVURFI7KdZ6E
         z9mCDYyBAjIZrIIhXOEjXkCqG9eRHA0NcLfEnMSBUydsmpGBEwU5xBfZmAf0tY+v75bw
         2BEx4LIQkWtsncLjtXpi4DzYhQJOlsorQiOz5PVuOKED07UpT8/LtJpDBY3RtlNgK5Ka
         5Q7jHW69k4irEhGfVeBwziacgxdgOdQzSvwHofOMR2waBiUem2GojIq1QsfcWMhThW0h
         0gZkXwocssYlZjPCevY8gmwaZW78lq5rrbq9U3zoOvVzj/UWriWtpoPjn3FBHURbiY52
         uCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqeJmwiVJ3THo/zk+FitT7vSw+iu9lg/E46M2S5sS38=;
        b=kGZgCmBz/IYwXi86qLdxdhZ3Hgn6N+1Ud3g/mKfMN+dvBzKg8ZopggsAoF8h3sdabD
         lQvwa37OslOgigYpSugTkv/xz9l7WvG+Tr0MekoB7EQtMGt6d7ZppOS0LMrCi9zRa9sR
         0K0c3+BwQaT3kgp3Pd33g/OMD2KPsBh8KQfi6YwU3lhX17uvK242IlyjyoAGtMAn/F58
         fBxybXtq3hQTFpV9jmY/n/yFOsfqsOfdSEjM42tcN6UguGRoRoZPP6Y1VGhivvXzHNx5
         iHjJfpuzNIF6pvCLFnoh4L851QO1avv4HdLApjh6M4yVFZGIeSWCUJwTcXnMuZcAuUVt
         LKVw==
X-Gm-Message-State: APjAAAVzwfOJ8X+itgPN0O6u2ihwPbLrMSMgValpvBlnb4qh5gJCua9P
        AWGXe15CHWLhluuFCscGkN7xc8EKMTbXZZfIR5Om+Q==
X-Google-Smtp-Source: APXvYqxEaLeX/AfsQp1oeUKjYtxDtSFUcwaPffJIGv2AZWAWRX5i5QIs9oKrHHXv8QC709Cs0mZcpcMQBp3tyNnHgHk=
X-Received: by 2002:a67:7e84:: with SMTP id z126mr3826766vsc.165.1551879148263;
 Wed, 06 Mar 2019 05:32:28 -0800 (PST)
MIME-Version: 1.0
References: <1551694625-6414-1-git-send-email-ludovic.Barre@st.com> <1551694625-6414-5-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1551694625-6414-5-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Mar 2019 14:31:52 +0100
Message-ID: <CAPDyKFr3PLOdozCmfE7Lin0FhzgLnN120RZmMwk=K8RzGvveow@mail.gmail.com>
Subject: Re: [PATCH 4/5] mmc: mmci: stm32: define get_dctrl_cfg
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

On Mon, 4 Mar 2019 at 11:17, Ludovic Barre <ludovic.Barre@st.com> wrote:
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
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 21 +++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 6f28f71..eb5d99af 100644
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
> index cfbfc6f..e7bf744 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -265,10 +265,31 @@ static void mmci_sdmmc_set_pwrreg(struct mmci_host *host, unsigned int pwr)
>         }
>  }
>
> +u32 sdmmc_get_dctrl_cfg(struct mmci_host *host)
> +{
> +       struct variant_data *variant = host->variant;
> +       int blksz_bits;
> +       u32 datactrl;
> +
> +       blksz_bits = ffs(host->data->blksz) - 1;
> +       datactrl = variant->datactrl_dpsm_enable | blksz_bits << 4;
> +
> +       if (host->mmc->card && mmc_card_sdio(host->mmc->card) &&
> +           host->data->blocks == 1)

These settings are not limited to deal with the block size bits.

Don't get me wrong, it seems reasonable to include them, but the
generic code in mmci_start_data() also have code to cope with SDIO. I
think we should start by splitting that up into a couple of
helper/library functions, and make the legacy variant to use them.
This should probably be done as a preparation to your series, so you
can build on top of that.

Does it make sense? If not, please tell and I can try to provide some
patch to show you what I mean.


> +               datactrl |= MCI_DPSM_STM32_MODE_SDIO;
> +       else if (host->data->stop && !host->mrq->sbc)
> +               datactrl |= MCI_DPSM_STM32_MODE_BLOCK_STOP;
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
