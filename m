Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9031C31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802B1214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOgnVbzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfHGBPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 21:15:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42517 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbfHGBPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 21:15:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so38618504plb.9;
        Tue, 06 Aug 2019 18:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S1vZmLL8Ef5YNWjt3PZw2jH5xRYm8FWeVtuvX8SAW6s=;
        b=WOgnVbzOLvto6kl63uaTingJqxs6z2MJ11Pvfz09lDFrLFElnBic1BYGC++U6KbU0N
         N48pChlPBQPT2SICE0pw9oP749sDiT/TtAH/lCCuTFZXeEaUkCEz2yLz67LjwuTgTlxB
         h4JmQV/meCDzGJ3GZ6KObqFVYRIPqWlzlZwIX7Xet3yn57njqKSODU6OceQEO2n/2oJV
         v4GwNw4sNDxEk6LHhtbQzz0AFBZkmzTtwCnfdQSc1+9r1J0UY3akk0EURmGx8dbWvI/X
         IZgJUL0s2FU3BSZDrgfpLTTcI/itVZWPYpXmDFzWmp3ybs+8kzk3cO0mfr1nAv/pizy7
         yngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S1vZmLL8Ef5YNWjt3PZw2jH5xRYm8FWeVtuvX8SAW6s=;
        b=BBuZih1qniwWj77pJX+W1JBT3SmjHq2/E7wwA89fkiGzJkzxJ5RusAQ1EBE4vDgVFi
         74m4HtLADTsqaV/Vw1yRaNmXVejs9UA/8fHxVIGWjmkKRQLMhxvh9zuqD/6t0U56ZrqK
         t2cenf78LalSqCiGQaDu3djxmCmfyhZZxwbspOcwpj9r5KNI+R2Yb8d6KmZOSiXe5Z01
         iHLAC49xWWBuHjG+Azm/qmn522ocp8d/WnosBg6JxJ5L1jQR33O/k0fFROIbsXjNa7Rj
         qCKJJ/hm4o4FC0OfJ8L3nFZmZYKp4Ri5NUdtiJU4W8QOgxWEHsXc0LVVAkQdh8K5pHca
         zQ6w==
X-Gm-Message-State: APjAAAWi3CwO7SpR27S5dVdE2cvNbhZqtLeV5tmJ2/hWFWS576AJTJoZ
        8KNZqrP40303e+iCpeWib18=
X-Google-Smtp-Source: APXvYqzRmu/BJ0/yj8GwkXedsZ8XNkYKCk/UskpJTF2G6+doM8xcHqGpkRbCxm+BAy/mxC0TdB0o8A==
X-Received: by 2002:a17:902:1aa:: with SMTP id b39mr5899371plb.333.1565140516140;
        Tue, 06 Aug 2019 18:15:16 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id p19sm99964465pfn.99.2019.08.06.18.15.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 18:15:15 -0700 (PDT)
Date:   Tue, 6 Aug 2019 18:16:11 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, l.stach@pengutronix.de, mihai.serban@gmail.com,
        alsa-devel@alsa-project.org, timur@kernel.org,
        shengjiu.wang@nxp.com, angus@akkea.ca, tiwai@suse.com,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: Re: [PATCH v3 1/5] ASoC: fsl_sai: Add registers definition for
 multiple datalines
Message-ID: <20190807011611.GD8938@Asurada-Nvidia.nvidia.com>
References: <20190806151214.6783-1-daniel.baluta@nxp.com>
 <20190806151214.6783-2-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806151214.6783-2-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 06:12:10PM +0300, Daniel Baluta wrote:
> SAI IP supports up to 8 data lines. The configuration of
> supported number of data lines is decided at SoC integration
> time.
> 
> This patch adds definitions for all related data TX/RX registers:
> 	* TDR0..7, Transmit data register
> 	* TFR0..7, Transmit FIFO register
> 	* RDR0..7, Receive data register
> 	* RFR0..7, Receive FIFO register
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
>  sound/soc/fsl/fsl_sai.c | 76 +++++++++++++++++++++++++++++++++++------
>  sound/soc/fsl/fsl_sai.h | 36 ++++++++++++++++---
>  2 files changed, 98 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 6d3c6c8d50ce..17b0aff4ee8b 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -685,7 +685,14 @@ static struct reg_default fsl_sai_reg_defaults[] = {
>  	{FSL_SAI_TCR3, 0},
>  	{FSL_SAI_TCR4, 0},
>  	{FSL_SAI_TCR5, 0},
> -	{FSL_SAI_TDR,  0},
> +	{FSL_SAI_TDR0, 0},
> +	{FSL_SAI_TDR1, 0},
> +	{FSL_SAI_TDR2, 0},
> +	{FSL_SAI_TDR3, 0},
> +	{FSL_SAI_TDR4, 0},
> +	{FSL_SAI_TDR5, 0},
> +	{FSL_SAI_TDR6, 0},
> +	{FSL_SAI_TDR7, 0},
>  	{FSL_SAI_TMR,  0},
>  	{FSL_SAI_RCR1, 0},
>  	{FSL_SAI_RCR2, 0},
> @@ -704,7 +711,14 @@ static bool fsl_sai_readable_reg(struct device *dev, unsigned int reg)
>  	case FSL_SAI_TCR3:
>  	case FSL_SAI_TCR4:
>  	case FSL_SAI_TCR5:
> -	case FSL_SAI_TFR:
> +	case FSL_SAI_TFR0:
> +	case FSL_SAI_TFR1:
> +	case FSL_SAI_TFR2:
> +	case FSL_SAI_TFR3:
> +	case FSL_SAI_TFR4:
> +	case FSL_SAI_TFR5:
> +	case FSL_SAI_TFR6:
> +	case FSL_SAI_TFR7:
>  	case FSL_SAI_TMR:
>  	case FSL_SAI_RCSR:
>  	case FSL_SAI_RCR1:
> @@ -712,8 +726,22 @@ static bool fsl_sai_readable_reg(struct device *dev, unsigned int reg)
>  	case FSL_SAI_RCR3:
>  	case FSL_SAI_RCR4:
>  	case FSL_SAI_RCR5:
> -	case FSL_SAI_RDR:
> -	case FSL_SAI_RFR:
> +	case FSL_SAI_RDR0:
> +	case FSL_SAI_RDR1:
> +	case FSL_SAI_RDR2:
> +	case FSL_SAI_RDR3:
> +	case FSL_SAI_RDR4:
> +	case FSL_SAI_RDR5:
> +	case FSL_SAI_RDR6:
> +	case FSL_SAI_RDR7:
> +	case FSL_SAI_RFR0:
> +	case FSL_SAI_RFR1:
> +	case FSL_SAI_RFR2:
> +	case FSL_SAI_RFR3:
> +	case FSL_SAI_RFR4:
> +	case FSL_SAI_RFR5:
> +	case FSL_SAI_RFR6:
> +	case FSL_SAI_RFR7:
>  	case FSL_SAI_RMR:
>  		return true;
>  	default:
> @@ -726,9 +754,30 @@ static bool fsl_sai_volatile_reg(struct device *dev, unsigned int reg)
>  	switch (reg) {
>  	case FSL_SAI_TCSR:
>  	case FSL_SAI_RCSR:
> -	case FSL_SAI_TFR:
> -	case FSL_SAI_RFR:
> -	case FSL_SAI_RDR:
> +	case FSL_SAI_TFR0:
> +	case FSL_SAI_TFR1:
> +	case FSL_SAI_TFR2:
> +	case FSL_SAI_TFR3:
> +	case FSL_SAI_TFR4:
> +	case FSL_SAI_TFR5:
> +	case FSL_SAI_TFR6:
> +	case FSL_SAI_TFR7:
> +	case FSL_SAI_RFR0:
> +	case FSL_SAI_RFR1:
> +	case FSL_SAI_RFR2:
> +	case FSL_SAI_RFR3:
> +	case FSL_SAI_RFR4:
> +	case FSL_SAI_RFR5:
> +	case FSL_SAI_RFR6:
> +	case FSL_SAI_RFR7:
> +	case FSL_SAI_RDR0:
> +	case FSL_SAI_RDR1:
> +	case FSL_SAI_RDR2:
> +	case FSL_SAI_RDR3:
> +	case FSL_SAI_RDR4:
> +	case FSL_SAI_RDR5:
> +	case FSL_SAI_RDR6:
> +	case FSL_SAI_RDR7:
>  		return true;
>  	default:
>  		return false;
> @@ -744,7 +793,14 @@ static bool fsl_sai_writeable_reg(struct device *dev, unsigned int reg)
>  	case FSL_SAI_TCR3:
>  	case FSL_SAI_TCR4:
>  	case FSL_SAI_TCR5:
> -	case FSL_SAI_TDR:
> +	case FSL_SAI_TDR0:
> +	case FSL_SAI_TDR1:
> +	case FSL_SAI_TDR2:
> +	case FSL_SAI_TDR3:
> +	case FSL_SAI_TDR4:
> +	case FSL_SAI_TDR5:
> +	case FSL_SAI_TDR6:
> +	case FSL_SAI_TDR7:
>  	case FSL_SAI_TMR:
>  	case FSL_SAI_RCSR:
>  	case FSL_SAI_RCR1:
> @@ -885,8 +941,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  				   MCLK_DIR(index));
>  	}
>  
> -	sai->dma_params_rx.addr = res->start + FSL_SAI_RDR;
> -	sai->dma_params_tx.addr = res->start + FSL_SAI_TDR;
> +	sai->dma_params_rx.addr = res->start + FSL_SAI_RDR0;
> +	sai->dma_params_tx.addr = res->start + FSL_SAI_TDR0;
>  	sai->dma_params_rx.maxburst = FSL_SAI_MAXBURST_RX;
>  	sai->dma_params_tx.maxburst = FSL_SAI_MAXBURST_TX;
>  
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index 7c1ef671da28..4bb478041d67 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -20,8 +20,22 @@
>  #define FSL_SAI_TCR3	0x0c /* SAI Transmit Configuration 3 */
>  #define FSL_SAI_TCR4	0x10 /* SAI Transmit Configuration 4 */
>  #define FSL_SAI_TCR5	0x14 /* SAI Transmit Configuration 5 */
> -#define FSL_SAI_TDR	0x20 /* SAI Transmit Data */
> -#define FSL_SAI_TFR	0x40 /* SAI Transmit FIFO */
> +#define FSL_SAI_TDR0	0x20 /* SAI Transmit Data 0 */
> +#define FSL_SAI_TDR1	0x24 /* SAI Transmit Data 1 */
> +#define FSL_SAI_TDR2	0x28 /* SAI Transmit Data 2 */
> +#define FSL_SAI_TDR3	0x2C /* SAI Transmit Data 3 */
> +#define FSL_SAI_TDR4	0x30 /* SAI Transmit Data 4 */
> +#define FSL_SAI_TDR5	0x34 /* SAI Transmit Data 5 */
> +#define FSL_SAI_TDR6	0x38 /* SAI Transmit Data 6 */
> +#define FSL_SAI_TDR7	0x3C /* SAI Transmit Data 7 */
> +#define FSL_SAI_TFR0	0x40 /* SAI Transmit FIFO 0 */
> +#define FSL_SAI_TFR1	0x44 /* SAI Transmit FIFO 1 */
> +#define FSL_SAI_TFR2	0x48 /* SAI Transmit FIFO 2 */
> +#define FSL_SAI_TFR3	0x4C /* SAI Transmit FIFO 3 */
> +#define FSL_SAI_TFR4	0x50 /* SAI Transmit FIFO 4 */
> +#define FSL_SAI_TFR5	0x54 /* SAI Transmit FIFO 5 */
> +#define FSL_SAI_TFR6	0x58 /* SAI Transmit FIFO 6 */
> +#define FSL_SAI_TFR7	0x5C /* SAI Transmit FIFO 7 */
>  #define FSL_SAI_TMR	0x60 /* SAI Transmit Mask */
>  #define FSL_SAI_RCSR	0x80 /* SAI Receive Control */
>  #define FSL_SAI_RCR1	0x84 /* SAI Receive Configuration 1 */
> @@ -29,8 +43,22 @@
>  #define FSL_SAI_RCR3	0x8c /* SAI Receive Configuration 3 */
>  #define FSL_SAI_RCR4	0x90 /* SAI Receive Configuration 4 */
>  #define FSL_SAI_RCR5	0x94 /* SAI Receive Configuration 5 */
> -#define FSL_SAI_RDR	0xa0 /* SAI Receive Data */
> -#define FSL_SAI_RFR	0xc0 /* SAI Receive FIFO */
> +#define FSL_SAI_RDR0	0xa0 /* SAI Receive Data 0 */
> +#define FSL_SAI_RDR1	0xa4 /* SAI Receive Data 1 */
> +#define FSL_SAI_RDR2	0xa8 /* SAI Receive Data 2 */
> +#define FSL_SAI_RDR3	0xac /* SAI Receive Data 3 */
> +#define FSL_SAI_RDR4	0xb0 /* SAI Receive Data 4 */
> +#define FSL_SAI_RDR5	0xb4 /* SAI Receive Data 5 */
> +#define FSL_SAI_RDR6	0xb8 /* SAI Receive Data 6 */
> +#define FSL_SAI_RDR7	0xbc /* SAI Receive Data 7 */
> +#define FSL_SAI_RFR0	0xc0 /* SAI Receive FIFO 0 */
> +#define FSL_SAI_RFR1	0xc4 /* SAI Receive FIFO 1 */
> +#define FSL_SAI_RFR2	0xc8 /* SAI Receive FIFO 2 */
> +#define FSL_SAI_RFR3	0xcc /* SAI Receive FIFO 3 */
> +#define FSL_SAI_RFR4	0xd0 /* SAI Receive FIFO 4 */
> +#define FSL_SAI_RFR5	0xd4 /* SAI Receive FIFO 5 */
> +#define FSL_SAI_RFR6	0xd8 /* SAI Receive FIFO 6 */
> +#define FSL_SAI_RFR7	0xdc /* SAI Receive FIFO 7 */
>  #define FSL_SAI_RMR	0xe0 /* SAI Receive Mask */
>  
>  #define FSL_SAI_xCSR(tx)	(tx ? FSL_SAI_TCSR : FSL_SAI_RCSR)
> -- 
> 2.17.1
> 
