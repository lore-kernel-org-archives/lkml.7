Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D126C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF8920870
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552212581;
	bh=eCdM6jdCcVcbvvmuBC3cUHjyHNsrk1CsMDk6B8cH+m4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Qbp6EBp+6EQ2vRen/gxFkmleggk4kLhmNYzZ/+i819/eNK132RmlNGk7Bq1yi+ppU
	 vXTz1fhRGXXrWEuz60Wbnan7sVXxNOtlRdYu3NEYbxKSo3hjjxNCa3Ur7H2kjZsw7S
	 HWeDhZiNmfeo7e7qvsBr7ikxy5KAI8EhkV/BeIS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfCJKJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 06:09:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfCJKJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 06:09:39 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C1E0207E0;
        Sun, 10 Mar 2019 10:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552212578;
        bh=eCdM6jdCcVcbvvmuBC3cUHjyHNsrk1CsMDk6B8cH+m4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bUjZyLI9/UjPtzh7AJlzyoKnDouerg8cohIY9E9kDufMJcxWFARPpDUDXkI5QY6JG
         otKFVId4TFjkDdjoMARVU5AFGb57h32MSrRwoUcEYCoY32aH5Kc9I6kdFLwi3JSVJT
         o2MD56vhZZOwhhtKyGksK3/1qW0qiJeTsLMXBpcg=
Date:   Sun, 10 Mar 2019 10:09:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: Re: [PATCH 1/8] iio: adc: stm32-dfsdm: make spi_master_freq more
 accurate
Message-ID: <20190310100932.71fd1af1@archlinux>
In-Reply-To: <1551862524-25098-2-git-send-email-fabrice.gasnier@st.com>
References: <1551862524-25098-1-git-send-email-fabrice.gasnier@st.com>
        <1551862524-25098-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2019 09:55:17 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> When SPI clock isn't accurate, 'spi_master_freq' is filled in with
> expected frequency. Use computed value instead:
> - e.g. source clock / (CKOUTDIV + 1)
> Also, current divider may be set to value that makes CKOUT to exceed
> spi-max-frequency. Rather use lower value (e.g. round up divider when
> ckout isn't accurate).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/iio/adc/stm32-dfsdm-core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index bf089f5..65b7556 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -243,13 +243,18 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
>  		return 0;
>  	}
>  
> -	priv->spi_clk_out_div = div_u64_rem(clk_freq, spi_freq, &rem) - 1;
> +	priv->spi_clk_out_div = div_u64_rem(clk_freq, spi_freq, &rem);
> +
> +	/* round up divider when clkout isn't accurate (e.g. !rem) */
> +	if (priv->spi_clk_out_div && !rem)
> +		priv->spi_clk_out_div--;
> +
This comment perhaps needs adjusting because at the moment it looks
like it decrements when it is accurate.   With the old code in place
in the patch it's obvious that's because you actually want one less.

Might even be worth the dance of

/* round up if not precise */
if (priv->spi_clk_out_div && rem)
	priv->spi_clk_out_div++;

/* subtract one because....  */
priv->spi_clk_out_div--;

>  	if (!priv->spi_clk_out_div) {
>  		/* spi_clk_out_div == 0 means ckout is OFF */
>  		dev_err(&pdev->dev, "spi-max-frequency not achievable\n");
>  		return -EINVAL;
>  	}
> -	priv->dfsdm.spi_master_freq = spi_freq;
> +	priv->dfsdm.spi_master_freq = clk_freq / (priv->spi_clk_out_div + 1);
And we increment it again here? That needs an explanation as well.
>  
>  	if (rem) {
>  		dev_warn(&pdev->dev, "SPI clock not accurate\n");

