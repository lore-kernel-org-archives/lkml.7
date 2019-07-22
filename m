Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E535C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D3B2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 12:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfGVM4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 08:56:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60877 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfGVM4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:56:41 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hpXr7-0005EL-1U; Mon, 22 Jul 2019 14:55:53 +0200
Message-ID: <1563800148.2311.9.camel@pengutronix.de>
Subject: Re: [PATCH 05/10] ASoC: fsl_sai: Add support to enable multiple
 data lines
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Daniel Baluta <daniel.baluta@nxp.com>, broonie@kernel.org
Cc:     festevam@gmail.com, perex@perex.cz, tiwai@suse.com,
        Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, timur@kernel.org,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        shengjiu.wang@nxp.com, angus@akkea.ca, kernel@pengutronix.de,
        viorel.suman@nxp.com
Date:   Mon, 22 Jul 2019 14:55:48 +0200
In-Reply-To: <20190722124833.28757-6-daniel.baluta@nxp.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
         <20190722124833.28757-6-daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 22.07.2019, 15:48 +0300 schrieb Daniel Baluta:
> SAI supports up to 8 Rx/Tx data lines which can be enabled
> using TCE/RCE bits of TCR3/RCR3 registers.
> 
> Data lines to be enabled are read from DT fsl,dl_mask property.
> By default (if no DT entry is provided) only data line 0 is enabled.
> 
> Note:
> We can only enable consecutive data lines starting with data line #0.

Why is the property a bitmask then? To me this sounds like we want to
have the number of lanes in the DT and convert to the bitmask inside
the driver.

> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 10 +++++++++-
>  sound/soc/fsl/fsl_sai.h |  6 ++++--
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 768341608695..d0fa02188b7c 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -601,7 +601,7 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
>  
> >  	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx),
> >  			   FSL_SAI_CR3_TRCE_MASK,
> > -			   FSL_SAI_CR3_TRCE);
> > +			   FSL_SAI_CR3_TRCE(sai->soc_data->dl_mask[tx]);
>  
> >  	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
> >  			SNDRV_PCM_HW_PARAM_RATE, &fsl_sai_rate_constraints);
> @@ -887,6 +887,14 @@ static int fsl_sai_probe(struct platform_device *pdev)
> >  		}
> >  	}
>  
> > +	/* active data lines mask for TX/RX, defaults to 1 (only the first
> > +	 * data line is enabled
> +	 */

Comment style not in line with Linux coding style.

Regards,
Lucas

> +	sai->dl_mask[RX] = 1;
> > +	sai->dl_mask[TX] = 1;
> > +	of_property_read_u32_index(np, "fsl,dl_mask", RX, &sai->dl_mask[RX]);
> > +	of_property_read_u32_index(np, "fsl,dl_mask", TX, &sai->dl_mask[TX]);
> +
> >  	irq = platform_get_irq(pdev, 0);
> >  	if (irq < 0) {
> >  		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index b1abeed2f78e..6d32f0950ec5 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -109,8 +109,8 @@
> >  #define FSL_SAI_CR2_DIV_MASK	0xff
>  
>  /* SAI Transmit and Receive Configuration 3 Register */
> > -#define FSL_SAI_CR3_TRCE	BIT(16)
> > -#define FSL_SAI_CR3_TRCE_MASK	GENMASK(16, 23)
> > +#define FSL_SAI_CR3_TRCE(x)	((x) << 16)
> > +#define FSL_SAI_CR3_TRCE_MASK	GENMASK(23, 16)
> >  #define FSL_SAI_CR3_WDFL(x)	(x)
> >  #define FSL_SAI_CR3_WDFL_MASK	0x1f
>  
> @@ -176,6 +176,8 @@ struct fsl_sai {
> >  	unsigned int slots;
> >  	unsigned int slot_width;
>  
> > +	unsigned int dl_mask[2];
> +
> >  	const struct fsl_sai_soc_data *soc_data;
> >  	struct snd_dmaengine_dai_dma_data dma_params_rx;
> >  	struct snd_dmaengine_dai_dma_data dma_params_tx;
