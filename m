Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB363C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B275021874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DwowMSYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfCUQ40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:56:26 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46177 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUQ4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:56:25 -0400
Received: by mail-vs1-f67.google.com with SMTP id w26so4051331vsk.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EeVvaul/ghG8cZ88OaKM9xzNDvHUVRjw3QiM9cFRDuk=;
        b=DwowMSYppIsZGNYnWrX9dSAy2Emh3sCPzm9r7roJa6uLF4wsBch7PXWw1LQ7qvLYK0
         C/5ybh8QkwW/0sfBmCuVluOlh0Rwpc2ZHAuLqCyJau51pi5O/fBJA5aFHDe1tHBFx4Bc
         r1MCmu8Kl1MH4ecBX3TjCIcNfKKrXwP99zt3xldqchbMRGTVN2ebftfZjJLel0CxLxy4
         plMxsquRvVRIAZ/bj7Rccj4KE+jsOmDDeLpGPC38AKFaCLNH495lqbWTL8vqHZhTqsGL
         i1Xyl+dZN5R8YFMFsgfUSOj7fN7DE0jmRp0s2xNBaMapEOLLDolsBtqsMnj8DFOGxhjV
         y3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EeVvaul/ghG8cZ88OaKM9xzNDvHUVRjw3QiM9cFRDuk=;
        b=BRWQFCArqSS02n3hS2+mByZouet9+BE6me3tbdKySBG/mixCg0LxMMNskzAllYAKFG
         YaeTELMQpl00hq4Cd3EdwIV9pGmvZc2Z6kkseJvpQ0zeCNZHAA/lx/o/hMubnsgZgvu/
         n5SNcT7TCy4r99y0kPpzQs76FtlcKppD8fOl6rMTDDuaDQHaSpFLPbynMviI2UcjAPas
         Q54GyTyEG5oJYuIswcIJCVfe8qAqhhn1kDqp2+6GSWNSwCnXL1hi+VLzs7g/xZty2r/1
         TI43JHct0AG+dTMhlcgGRjk+1LFvBgsu8MTBGhZs8ZGQszp3UWOKWXtr8dZ21l30iCWP
         kAOQ==
X-Gm-Message-State: APjAAAWfk40o6xaNiloqaGyHz7wbJ24ZFifvskYD1q2k5o5HsVyo2wpW
        WJTOMSVop12ZMw2RB1o1KMOfxllJURZYO1fIjjOMag==
X-Google-Smtp-Source: APXvYqwqzQSNFkDflJNzParD7ATWhxktAsFQrgHY4C8+1iIRThGFNhX0uqm0gpii01OnXWrVvjs0rBDU32JFJ2WthAo=
X-Received: by 2002:a67:e451:: with SMTP id n17mr2680387vsm.35.1553187384212;
 Thu, 21 Mar 2019 09:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <1551976742-4358-1-git-send-email-ludovic.Barre@st.com> <1551976742-4358-4-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1551976742-4358-4-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Mar 2019 17:55:48 +0100
Message-ID: <CAPDyKFrkdQf1yq2YKaNMr8vgpd5fH4BAXgO7Qkj-aaw0AB9wRw@mail.gmail.com>
Subject: Re: [PATCH V2 3/6] mmc: mmci: define get_dctrl_cfg for legacy variant
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
> This patch defines get_dctrl_cfg callback for legacy variants
> whatever DMA_ENGINE configuration.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 44 ++++++++++++++++++++++++++++++++++++--------
>  drivers/mmc/host/mmci.h |  3 +++
>  2 files changed, 39 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 28b76c5..52f9dbf 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -46,12 +46,6 @@
>
>  #define DRIVER_NAME "mmci-pl18x"
>
> -#ifdef CONFIG_DMA_ENGINE
> -static void mmci_variant_init(struct mmci_host *host);
> -#else
> -static inline void mmci_variant_init(struct mmci_host *host) {}
> -#endif
> -
>  static unsigned int fmax = 515633;
>
>  static struct variant_data variant_arm = {
> @@ -231,7 +225,7 @@ static struct variant_data variant_ux500v2 = {
>         .irq_pio_mask           = MCI_IRQ_PIO_MASK,
>         .start_err              = MCI_STARTBITERR,
>         .opendrain              = MCI_OD,
> -       .init                   = mmci_variant_init,
> +       .init                   = mmci_ux500v2_variant_init,
>  };
>
>  static struct variant_data variant_stm32 = {
> @@ -617,6 +611,29 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
>         sg_miter_start(&host->sg_miter, data->sg, data->sg_len, flags);
>  }
>
> +u32 mmci_get_dctrl_cfg(struct mmci_host *host)
> +{
> +       u32 datactrl;
> +
> +       datactrl = MCI_DPSM_ENABLE;
> +       datactrl |= mmci_dctrl_blksz(host) | mmci_dctrl_dir(host);
> +       datactrl |= mmci_dctrl_sdio(host) | mmci_dctrl_ddr(host);
> +
> +       return datactrl;
> +}
> +
> +u32 mmci_ux500v2_get_dctrl_cfg(struct mmci_host *host)

To be consistent with other variant function names, let's drop the
"mmci_"* prefix.

> +{
> +       u32 datactrl;
> +
> +       datactrl = MCI_DPSM_ENABLE;
> +       datactrl |= (host->data->blksz << 16);
> +       datactrl |= mmci_dctrl_dir(host);
> +       datactrl |= mmci_dctrl_sdio(host) | mmci_dctrl_ddr(host);
> +
> +       return datactrl;
> +}
> +
>  /*
>   * All the DMA operation mode stuff goes inside this ifdef.
>   * This assumes that you have a generic DMA device interface,
> @@ -941,6 +958,7 @@ void mmci_dmae_unprep_data(struct mmci_host *host,
>  static struct mmci_host_ops mmci_variant_ops = {
>         .prep_data = mmci_dmae_prep_data,
>         .unprep_data = mmci_dmae_unprep_data,
> +       .get_datactrl_cfg = mmci_get_dctrl_cfg,
>         .get_next_data = mmci_dmae_get_next_data,
>         .dma_setup = mmci_dmae_setup,
>         .dma_release = mmci_dmae_release,
> @@ -948,12 +966,22 @@ static struct mmci_host_ops mmci_variant_ops = {
>         .dma_finalize = mmci_dmae_finalize,
>         .dma_error = mmci_dmae_error,
>  };
> +#else
> +static struct mmci_host_ops mmci_variant_ops = {
> +       .get_datactrl_cfg = mmci_get_dctrl_cfg,
> +}
> +#endif
>
>  void mmci_variant_init(struct mmci_host *host)
>  {
>         host->ops = &mmci_variant_ops;
>  }
> -#endif
> +
> +void mmci_ux500v2_variant_init(struct mmci_host *host)
> +{
> +       host->ops = &mmci_variant_ops;
> +       host->ops->get_datactrl_cfg = mmci_ux500v2_get_dctrl_cfg;
> +}
>
>  static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 32ae41d..bfc6e54 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -448,6 +448,9 @@ void mmci_dmae_finalize(struct mmci_host *host, struct mmc_data *data);
>  void mmci_dmae_error(struct mmci_host *host);
>  #endif
>
> +void mmci_variant_init(struct mmci_host *host);
> +void mmci_ux500v2_variant_init(struct mmci_host *host);

Drop the "mmci_" prefix.

> +
>  #ifdef CONFIG_MMC_QCOM_DML
>  void qcom_variant_init(struct mmci_host *host);
>  #else
> --
> 2.7.4
>

Kind regards
Uffe
