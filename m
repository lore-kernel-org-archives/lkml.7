Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79342C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498F0218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DcXy2uvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfCUQoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:44:07 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37691 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbfCUQoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:44:06 -0400
Received: by mail-ua1-f65.google.com with SMTP id x1so2146531uaj.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sM1yGQ5v2jOeD65+zu8wzi19KfsaD9MhkY+UP+i8rUg=;
        b=DcXy2uvAP5zTVSjJEnNlf1I8WYMJrxPsdqUpdW4xxu64U4Wv0pQapyS0YxEILKEQVZ
         rSQAoUEYOIeCfqdE2qch5aNCzP5Xjcfot3QHPkfNE5XAqAz4fqAFKytZrjc8gH+Qf2u2
         VKtXF8takDN6Ac92irH2y4liYu3NhGCTpqXnGiWQsLrsHJtDoA67cExjypDyQxV9WobV
         n26E4P+adiZTIQiCC9Z9nNgIvo4wJ3phrIlqWCtXEf+dqkPGDC9dYR5MBObAda9zPwLd
         mRTtEWNoS3ESpTOBtEDSqf/NFmFUEYyqE/Op7OpElbFX5BV15mPEo/QVVbjiFxnX0xGt
         B83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sM1yGQ5v2jOeD65+zu8wzi19KfsaD9MhkY+UP+i8rUg=;
        b=K3kxsQ+SnmxEZAjjPxxXqB1pzetXOVgAN66ySDrqVPPx/5w08mTs5jUiTOYelzfG7t
         axJ62jd4RAFGsk+ghDSp1hCpCX+Jsq6QfmNsrZZZiq+8ArZQt19neK5ER+v8+Jz1770C
         4/QAtaWjtgF7yhDCGgOytM/NYDDa2gFsj7zWRd7jR9uTpvmFCzre73L4XARmvk7Eo2ma
         AGRfxLSzHAKdUxf+tCuR69K+DMolJ/X528qZrjSDoJs0+9HL3+nFqZu+XxLhVzyasJEv
         FAG1kAn9AKGU5IAHHQXV/09QAvijtjMlhKPNQl+v99MwYbymKzyzzrA/nliQziCoxPnf
         6McQ==
X-Gm-Message-State: APjAAAWWHjwQvr/0cMOFfUpCxyEx0jUVLdoIUEK4iXxG/uS1aZN69mY8
        oNjXnPUdWfejkWJy8WZpv8wtLW5HZ+XR6cck5GVqRg==
X-Google-Smtp-Source: APXvYqwKDeU6f51kzOyQfHEEdj7pgJ4eEy6SAn5iX3PI1Tu7l0K630Rk1yPyYFWe7Z9+sbSRfpXikTTytqcOapt4XTY=
X-Received: by 2002:ab0:719a:: with SMTP id l26mr2465922uao.24.1553186645083;
 Thu, 21 Mar 2019 09:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <1551976742-4358-1-git-send-email-ludovic.Barre@st.com> <1551976742-4358-3-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1551976742-4358-3-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Mar 2019 17:43:28 +0100
Message-ID: <CAPDyKFoq-pvw=KNPK4XzNu=0Jeu_OPDB0KZrhWVQ88LjNAu5nw@mail.gmail.com>
Subject: Re: [PATCH V2 2/6] mmc: mmci: add helper functions to define datactrl
 value for variants
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

On Thu, 7 Mar 2019 at 17:39, Ludovic Barre <ludovic.Barre@st.com> wrote:
>
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch adds default helper functions to define datactrl value.
> Each variant could use these helpers to define datactrl and adds
> their specific field.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 25 +++++++++++++++++++++++++
>  drivers/mmc/host/mmci.h |  5 +++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 9e6a2c1..28b76c5 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -983,6 +983,31 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
>         mmci_unprep_data(host, data, err);
>  }
>
> +u32 mmci_dctrl_blksz(struct mmci_host *host)
> +{
> +       return (ffs(host->data->blksz) - 1) << 4;
> +}

Overall, this function and the other helpers added here, could be made
static inline functions, implemented in mmci.h.

If I understood Russell's point correctly, that's also we he suggested.

> +
> +u32 mmci_dctrl_dir(struct mmci_host *host)
> +{
> +       return host->data->flags & MMC_DATA_READ ? MCI_DPSM_DIRECTION : 0;

As pointed out by Russell, drop this and keep this in the common
mmci_start_data().

Or you need this for the stm32_sdmmc later? Then perhaps make that a
separate change on top.

> +}
> +
> +u32 mmci_dctrl_ddr(struct mmci_host *host)
> +{
> +       if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50 ||
> +           host->mmc->ios.timing == MMC_TIMING_MMC_DDR52)
> +               return host->variant->datactrl_mask_ddrmode;

This seems a bit like an unnecessary helper. How about moving this
into the ux500v2 and qcom variants ->datactrl() callbacks instead,
thus we can also remove ->datactrl_mask_ddrmode from the variant
struct.

Does that make sense?

> +       return 0;
> +}
> +
> +u32 mmci_dctrl_sdio(struct mmci_host *host)
> +{
> +       if (host->mmc->card && mmc_card_sdio(host->mmc->card))
> +               return host->variant->datactrl_mask_sdio;
> +       return 0;
> +}
> +
>  static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
>  {
>         struct variant_data *variant = host->variant;
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index a59049b..32ae41d 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -430,6 +430,11 @@ struct mmci_host {
>  void mmci_write_clkreg(struct mmci_host *host, u32 clk);
>  void mmci_write_pwrreg(struct mmci_host *host, u32 pwr);
>
> +u32 mmci_dctrl_blksz(struct mmci_host *host);
> +u32 mmci_dctrl_dir(struct mmci_host *host);
> +u32 mmci_dctrl_ddr(struct mmci_host *host);
> +u32 mmci_dctrl_sdio(struct mmci_host *host);
> +
>  #ifdef CONFIG_DMA_ENGINE
>  int mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
>                         bool next);
> --
> 2.7.4
>

Overall, I have to admit that it's tricky to fine a decent balance of
callbacks/helpers/variant-data. I guess we simply have to continue
evolve this, along the lines of what suggest here and just see how it
turns out. We can always patch the code on top if we find other/better
solutions along the road.

Kind regards
Uffe
