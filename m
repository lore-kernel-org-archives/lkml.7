Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9277C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE025206EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uY58BuYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfKMV3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:29:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45686 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMV3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:29:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id k1so857780pgg.12;
        Wed, 13 Nov 2019 13:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AVqWPleKaz31XmHuM5Ar+WLW3xPppIUP+VoAlnFtLBw=;
        b=uY58BuYHB8vwpNFQzLSanEitfWdr1sIaJEBa/ZXgEaCMCR0/3DKmOvMRfQsyzmihsX
         zZz40DxW/ddhUtb/HBbeBAJYAo76JfnZFs9RYhC70nS8EPxvsJ5hDWRyin8MiNeb4zpm
         CojDvqLC5OAcBUFlepvACs7RRLbJopc+6cp6LW93+YyquBehtxfcVF4F9CCJjEIBbaV0
         pmgu6m/9du0C+uIHqW4LUs8TYM/tvVenFp//abs9ORws8Cu+D81AlGQ7glmA2iUMzoZW
         +UgL/36jDRb3kGLRMg54m5p+8ghrBjeDW7eBENqfxBZ+foBUi3PLtH0BGdp/SUf7Of+Z
         UxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AVqWPleKaz31XmHuM5Ar+WLW3xPppIUP+VoAlnFtLBw=;
        b=fxeHx37EzeRgRD4bEuiVGey8X+/2O2XNFwmXEiHK6M8ZsFyq1trycL5u+WbYxKqvxm
         8DyD7DEbR5+Ze2xEezUnKfgYNmnUuThkc8Xu0TrOGH3stflIoxM4piFqz8BihqRIVwb8
         RiCfreNh54Q61svQMvoukMVEPnEf1TiwVn0cQhcBuCDku/zCg034mFJKKrGU/lotUJm+
         FVesnfk8A9/eFsykOPVi/VQrfBACvIlLmw/d6G2kapiwZVv2S5llNQtdyT/qnbkl3zxW
         g0G4/gimDFBajgoyQ57SjmPE5yWcvmo7iZ3t71561R0F7imbm134ePrLcm6ZzmLMbEnF
         u0XQ==
X-Gm-Message-State: APjAAAXIazJXpZ5yJFoIbDX11Wjzv8P56a+kpWGarrcJEqh6fXmnYYsD
        wmN2lpfE3ofmYav/0O4vtWU=
X-Google-Smtp-Source: APXvYqy9XSFSBUmcN5u6GCN8pPVS5+DCHCUev3ISERx87mJ8d3APZRegPuspjAPxngMAq5PvUtPRHg==
X-Received: by 2002:a63:535c:: with SMTP id t28mr6226419pgl.173.1573680588338;
        Wed, 13 Nov 2019 13:29:48 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id t12sm3519512pgv.45.2019.11.13.13.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Nov 2019 13:29:46 -0800 (PST)
Date:   Wed, 13 Nov 2019 13:27:44 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V3 2/2] ASoC: fsl_asrc: Add support for imx8qm
Message-ID: <20191113212743.GA2844@Asurada-Nvidia.nvidia.com>
References: <b1c922b3496020f611ecd6ea27d262369646d830.1573462647.git.shengjiu.wang@nxp.com>
 <3c3e59ae7adde852f133a5d7c2cbb2730362fc53.1573462647.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c3e59ae7adde852f133a5d7c2cbb2730362fc53.1573462647.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 05:18:23PM +0800, Shengjiu Wang wrote:
> There are two asrc module in imx8qm, each module has different
> clock configuration, and the DMA type is EDMA.
> 
> So in this patch, we define the new clocks, refine the clock map,
> and include struct fsl_asrc_soc_data for different soc usage.
> 
> The EDMA channel is fixed with each dma request, one dma request
> corresponding to one dma channel. So we need to request dma
> channel with dma request of asrc module.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Two small comments inline. Once they are addressed,

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
> changes in v2
> - use !use_edma to wrap code in fsl_asrc_dma
> - add Acked-by: Nicolin Chen
> 
> changes in v3
> - remove the acked-by for commit is updated
> - read "fsl,asrc-clk-map" property, and update table
>   clk_map_imx8qm.
> 
>  sound/soc/fsl/fsl_asrc.c     | 112 ++++++++++++++++++++++++++++-------
>  sound/soc/fsl/fsl_asrc.h     |  64 +++++++++++++++++++-
>  sound/soc/fsl/fsl_asrc_dma.c |  42 +++++++++----
>  3 files changed, 183 insertions(+), 35 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index a3cfceea7d2f..03de33de8633 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -964,14 +1001,33 @@ static int fsl_asrc_probe(struct platform_device *pdev)

> +	} else if (of_device_is_compatible(np, "fsl,imx8qm-asrc")) {

> +		ret = of_property_read_u32(np, "fsl,asrc-clk-map",
> +					   &map_idx);

This seems to fit a single line?

> diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> index d6146de9acd2..f871fdb9d1c6 100644
> --- a/sound/soc/fsl/fsl_asrc_dma.c
> +++ b/sound/soc/fsl/fsl_asrc_dma.c
> @@ -197,21 +197,37 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,

> +	/*
> +	 * For EDMA DEV_TO_DEV channel, we don't need to configure
> +	 * dma_request and dma_request2, we can get dma channel through
> +	 * dma_request_slave_channel directly.
> +	 * Compare with SDMA channel, EDMA channel is bound with dma
> +	 * request event of each peripheral, and it is fixed. Not like SDMA,
> +	 * the channel is allocated dynamically. So when DMA is EDMA, we
> +	 * can only get EDMA channel through dma-names of Front-End device.
> +	 */

Just trying to make it concise :)

+	/*
+	 * An EDMA DEV_TO_DEV channel is fixed and bound with DMA event of each
+	 * peripheral, unlike SDMA channel that is allocated dynamically. So no
+	 * need to configure dma_request and dma_request2, but get dma_chan via
+	 * dma_request_slave_channel directly with dma name of Front-End device
+	 */
