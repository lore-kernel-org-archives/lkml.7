Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A17FC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E285A2199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cXznW2fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbfGVNnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:43:47 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46594 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbfGVNnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:43:46 -0400
Received: by mail-vs1-f66.google.com with SMTP id r3so26081640vsr.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGmqG4ptpoLIjXtcAYy8btzZvJKDKHMEImKjNaUWrIw=;
        b=cXznW2faB3D/zdq8swGVmyFl8k+9mAGF+PgWbMSfNGiTYAg646sq3YBoAbRbi9gTv7
         1MjSWnUxAD3qZGkTFy9ERBAOA1/OqdzaDngC73lRQRVFjw4yANKrr7ksdw68RfR2u3f1
         k4Xx6OL6BAVjai3eJBIl0Phg3dUszMgfYzZJDqkr63ZcUzA9t17Bgw31+mCMCgN86FPN
         T7zxWbbDUhAg+mfGUFjJLvlGSU4eq33rw4UCFosTKHZZ/R/E7HwhdeTrxcOZxHFoQWQ/
         vdmvtJgN6mHpn7QEtxBHfwSrysZTZClVtNYUvxqiTQuGIrxQt6Y8vsReWrs8Ow8AWgR8
         z61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGmqG4ptpoLIjXtcAYy8btzZvJKDKHMEImKjNaUWrIw=;
        b=WSVIvDypabonlz8/GTPwUcWbiGD90Aeey5PLOIF2+czsCAm+1mmNReqv0iRPv4UHix
         ldiXyPjGMMElwVNOkPrFepC5ySlI25ss2DzFPV1yYNTB+f8kiOL5yAcpEGjcC5jCbVs+
         kEnBaWPV2Db5C97660U6XnvuwAmZD6rkMjt4ulIbdd+Fl4R6AfQjdej0y008lNqQ7hTg
         EfhyrZKVFFTuMUCPJajUEYXRXfYpO5T2MyrvC6aw39lW8hnNmbOQRAZk34vgtaTc6h7P
         yaefv4JfuVv8CigGxuEycHOpOSYuZH3/VulyC1QAk7cx9vVeARS4mbe9Gbm2GUE5gasa
         4E8Q==
X-Gm-Message-State: APjAAAW7xbV8ffxkYyioePoLi3aZNBkW6yktovfMzbA1xFSaxZ3o+95q
        +OgdBMwyKbxRLDN4O32EdCh37Y9LPIrggvXkV05I6A==
X-Google-Smtp-Source: APXvYqzkfGZ1DKRRQAo+4IRI8owf3oXR3DF9EBGvHNO5tTE1l1JMNbpTfmAk+9D6uiCqKpvCr7b42xz1Nh+0fNXXddQ=
X-Received: by 2002:a67:ee16:: with SMTP id f22mr41692590vsp.191.1563803025344;
 Mon, 22 Jul 2019 06:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190717085259.31235-1-Anson.Huang@nxp.com>
In-Reply-To: <20190717085259.31235-1-Anson.Huang@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Jul 2019 15:43:09 +0200
Message-ID: <CAPDyKFqfhk6S0gN-eN5ozYKZPBWb8+gC2A_vy55gYOx7dOKQ-w@mail.gmail.com>
Subject: Re: [PATCH] mmc: mxs: use devm_platform_ioremap_resource() to
 simplify code
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2019 at 11:02, <Anson.Huang@nxp.com> wrote:
>
> From: Anson Huang <Anson.Huang@nxp.com>
>
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mxs-mmc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index b334e81..78e7e35 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -571,7 +571,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>         struct device_node *np = pdev->dev.of_node;
>         struct mxs_mmc_host *host;
>         struct mmc_host *mmc;
> -       struct resource *iores;
>         int ret = 0, irq_err;
>         struct regulator *reg_vmmc;
>         struct mxs_ssp *ssp;
> @@ -587,8 +586,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>         host = mmc_priv(mmc);
>         ssp = &host->ssp;
>         ssp->dev = &pdev->dev;
> -       iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       ssp->base = devm_ioremap_resource(&pdev->dev, iores);
> +       ssp->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(ssp->base)) {
>                 ret = PTR_ERR(ssp->base);
>                 goto out_mmc_free;
> --
> 2.7.4
>
