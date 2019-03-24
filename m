Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54158C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9DE2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553445698;
	bh=Kv3TDuW80B8AVSdOkjAs1pOmjBnZIjLUbrZAG19GBqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=esU1h96ybftYvfbwEEM98u9wee1tLxvkW8rIBirWrEsAc3U3qo+6NGhrMxTKnZ5Ca
	 z1mj1CWRjFClYLEQQPGtT1u9GxwpEA0l10h9hhZnqrylb6uBROxj73FgK2kAvgPLqo
	 NCqplCEa7WJhv49ZPsMDVN/3NzhBx038ZwUwogpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfCXQlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:41:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfCXQlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:41:36 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6792C20823;
        Sun, 24 Mar 2019 16:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553445694;
        bh=Kv3TDuW80B8AVSdOkjAs1pOmjBnZIjLUbrZAG19GBqo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MkcIj+tA2fUQWmo+xVVBd91U20HuKFFG8MyIBo3XYus+QiEam1sKH0P5AR1YQg8tb
         HHgDuVStn6j5H/zGcMa65Orce6byjBg2YQYSIVGbR+oY2nFwhnO7AUyM+DvO20HOYs
         BEb8+rrVWecJyxLkpmsTu+i+9CJOcdlRuabQ8hM0=
Date:   Sun, 24 Mar 2019 16:41:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>, <olivier.moysan@st.com>
Subject: Re: [PATCH v2 1/8] iio: adc: stm32-dfsdm: make spi_master_freq more
 accurate
Message-ID: <20190324164129.620bf216@archlinux>
In-Reply-To: <1553186849-6261-2-git-send-email-fabrice.gasnier@st.com>
References: <1553186849-6261-1-git-send-email-fabrice.gasnier@st.com>
        <1553186849-6261-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 17:47:22 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Current ckout divider may be set to a value that makes ckout to exceed
> spi-max-frequency. Rather use lower value (e.g. round up divider when
> ckout isn't accurate).
> 
> Also when the SPI clock isn't accurate, 'spi_master_freq' is filled in
> with expected frequency. Use computed value instead to be more accurate:
> - e.g. source clock / (CKOUTDIV + 1)
> 
> Enforce checks on the divider: ckoutdiv range can be from 1-255 to provide
> divider of 2-256.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
> - rework the way to determine ckoutdiv bitfield: deal with divider directly
>   to explicitly handle the rounding, the range constraints of 2-256 and the
>   divider = ckoutdiv + 1.
> ---
>  drivers/iio/adc/stm32-dfsdm-core.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index bf089f5..472b809 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -199,7 +199,7 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
>  {
>  	struct device_node *node = pdev->dev.of_node;
>  	struct resource *res;
> -	unsigned long clk_freq;
> +	unsigned long clk_freq, divider;
>  	unsigned int spi_freq, rem;
>  	int ret;
>  
> @@ -243,13 +243,20 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
>  		return 0;
>  	}
>  
> -	priv->spi_clk_out_div = div_u64_rem(clk_freq, spi_freq, &rem) - 1;
> -	if (!priv->spi_clk_out_div) {
> -		/* spi_clk_out_div == 0 means ckout is OFF */
> +	divider = div_u64_rem(clk_freq, spi_freq, &rem);
> +	/* Round up divider when ckout isn't precise, not to exceed spi_freq */
> +	if (rem)
> +		divider++;
> +
> +	/* programmable divider is in range of [2:256] */
> +	if (divider < 2 || divider > 256) {
>  		dev_err(&pdev->dev, "spi-max-frequency not achievable\n");
>  		return -EINVAL;
>  	}
> -	priv->dfsdm.spi_master_freq = spi_freq;
> +
> +	/* SPI clock output divider is: divider = CKOUTDIV + 1 */
> +	priv->spi_clk_out_div = divider - 1;
> +	priv->dfsdm.spi_master_freq = clk_freq / (priv->spi_clk_out_div + 1);
>  
>  	if (rem) {
>  		dev_warn(&pdev->dev, "SPI clock not accurate\n");

