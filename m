Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B61C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E1220675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f9fO3VP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfCFNcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:32:19 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38294 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfCFNcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 08:32:19 -0500
Received: by mail-vs1-f67.google.com with SMTP id h132so2191978vsd.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 05:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icS4CXrHorSX6h7XZWIhVC5ZyqED36hLDEh9f7uHtAg=;
        b=f9fO3VP5Nof0ILA6Xe2ez/JjICO2mQvOsdv4Z6U77Bn98ixtzup+j3XBnq9S0HoD8x
         RWX4GW8iBcofO87kz0hj54gFQdUKABBVu3qwnLSUnYO7h9L2N85RWeWhcW+XGzxocfhr
         5lfzfzI2pnfgHgTPhbzY/4sMvfgS2pAZUmLyp3kZxMmdvfNsDXlFwx+853TNzNbCOrRr
         yleG3N5+zZ/uS+CjH77uOEO5sbi3LJvasIE0fNonzWkDQrLOcc05koQj2PoTUpc7G1Nc
         44rdaglqJbRPd8arLYGKKP5x3+vzjjKY4YToV6A5M2GSPo+A8kzCJ7YVjJDLy8TLyrLX
         W5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icS4CXrHorSX6h7XZWIhVC5ZyqED36hLDEh9f7uHtAg=;
        b=VhnzhIDd/3aDBmaNL+wgyRcFttUF656vQAmmdKR4nXcaCAVG2PJzfifiE+KEHtU7/s
         MBx7DiWFGyEsr3bLbnz1lamQVmJ3+gvErcHyL+J5PQm+VZdUoV4hGq3AXrqvVLPNLqnG
         jiH2OEpJ6bI8hu+jswPr3noF8VdM/xuGLNo0DKVbdXaSl6AO4m/BOj0qKoFK3qt/9XxK
         dhVzbfPJIivC/lOztNHd9ZPpZ33cbjYi1r0dI2A6KOkJ5rlx02nV7JjHy5xjMk9i7sLN
         UnU2/ZuyALBnO7b6vbZdMluPKcpaXwpSljlv0uZ3ZtF2aym9TeIZx/BX+oUOF2fN6Rx+
         KXzA==
X-Gm-Message-State: APjAAAWBAQ1iKMnipGbfJJXKkF3Kmi+Rga0oCp0b18F6epw7gLe2KXqR
        D6McTHA6b/RlW/NEseAKLREqR1BblMhyVRVpi7VdkA==
X-Google-Smtp-Source: APXvYqzDpZrMmjjpcPYt6O6aqAGQzh2oSWFfILvj5ebSfUMjlkxmm+7TTx/MT+652k7mpMm6/I2aT9eCYD4eTw0GL6g=
X-Received: by 2002:a67:c902:: with SMTP id w2mr3889431vsk.191.1551879137902;
 Wed, 06 Mar 2019 05:32:17 -0800 (PST)
MIME-Version: 1.0
References: <1551694625-6414-1-git-send-email-ludovic.Barre@st.com> <1551694625-6414-4-git-send-email-ludovic.Barre@st.com>
In-Reply-To: <1551694625-6414-4-git-send-email-ludovic.Barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Mar 2019 14:31:42 +0100
Message-ID: <CAPDyKFqVssTzjQYQq1n+CVEFODzjUdSiv=OUPkhycWYcxMoHGQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] mmc: mmci: qcom: define get_dctrl_cfg
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
> This patch defines get_dctrl_cfg callback for qcom variant.
> qcom variant has a specific block size definition.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci_qcom_dml.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
> index 25d0a75..d7b083d 100644
> --- a/drivers/mmc/host/mmci_qcom_dml.c
> +++ b/drivers/mmc/host/mmci_qcom_dml.c
> @@ -183,9 +183,17 @@ static int qcom_dma_setup(struct mmci_host *host)
>         return 0;
>  }
>
> +u32 qcom_get_dctrl_cfg(struct mmci_host *host)

This can be static.

> +{
> +       struct variant_data *variant = host->variant;
> +
> +       return variant->datactrl_dpsm_enable | (host->data->blksz << 4);
> +}
> +
>  static struct mmci_host_ops qcom_variant_ops = {
>         .prep_data = mmci_dmae_prep_data,
>         .unprep_data = mmci_dmae_unprep_data,
> +       .get_datactrl_cfg = qcom_get_dctrl_cfg,
>         .get_next_data = mmci_dmae_get_next_data,
>         .dma_setup = qcom_dma_setup,
>         .dma_release = mmci_dmae_release,
> --
> 2.7.4
>

Kind regards
Uffe
