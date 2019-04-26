Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44A6C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5CD20675
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfDZJHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:07:25 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38081 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfDZJHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:07:24 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hJwp9-0000Bx-TF; Fri, 26 Apr 2019 11:07:15 +0200
Message-ID: <1556269635.2584.23.camel@pengutronix.de>
Subject: Re: [PATCH v2 06/15] spi: imx: fix ERR009165
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 26 Apr 2019 11:07:15 +0200
In-Reply-To: <1556265512-9130-7-git-send-email-yibin.gong@nxp.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
         <1556265512-9130-7-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
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

Am Freitag, den 26.04.2019, 08:05 +0000 schrieb Robin Gong:
> Change to XCH  mode even in dma mode, please refer to the below
> errata:
> https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/spi/spi-imx.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 09c9a1e..eb56eac 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -585,8 +585,9 @@ static int mx51_ecspi_prepare_transfer(struct
> spi_imx_data *spi_imx,
>  	ctrl |= mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
>  	spi_imx->spi_bus_clk = clk;
>  
> +	/* ERR009165: work in XHC mode as PIO */
>  	if (spi_imx->usedma)
> -		ctrl |= MX51_ECSPI_CTRL_SMC;
> +		ctrl &= ~MX51_ECSPI_CTRL_SMC;
>  
>  	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
>  
> @@ -612,12 +613,14 @@ static int mx51_ecspi_prepare_transfer(struct
> spi_imx_data *spi_imx,
>  
>  static void mx51_setup_wml(struct spi_imx_data *spi_imx)
>  {
> +	u32 tx_wml = 0;
> +

With a wml of 0 you might set the maxburst of the TX dma channel to
fifosize to minimize the performance impact of this workaround.

Regards,
Lucas

>  	/*
>  	 * Configure the DMA register: setup the watermark
>  	 * and enable DMA request.
>  	 */
>  	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
> -		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
> +		MX51_ECSPI_DMA_TX_WML(tx_wml) |
>  		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
>  		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
>  		MX51_ECSPI_DMA_RXTDEN, spi_imx->base +
> MX51_ECSPI_DMA);
> @@ -1265,10 +1268,6 @@ static int spi_imx_sdma_init(struct device
> *dev, struct spi_imx_data *spi_imx,
>  {
>  	int ret;
>  
> -	/* use pio mode for i.mx6dl chip TKT238285 */
> -	if (of_machine_is_compatible("fsl,imx6dl"))
> -		return 0;
> -
>  	spi_imx->wml = spi_imx->devtype_data->fifo_size / 2;
>  
>  	/* Prepare for TX DMA: */
> -- 
> 2.7.4
> 
