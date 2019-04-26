Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0769DC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59D520675
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfDZJKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:10:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38629 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfDZJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:10:07 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hJwrm-0000LO-0y; Fri, 26 Apr 2019 11:09:58 +0200
Message-ID: <1556269796.2584.25.camel@pengutronix.de>
Subject: Re: [PATCH v2 07/15] spi: imx: remove ERR009165 workaround on
 i.mx6ul
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
Date:   Fri, 26 Apr 2019 11:09:56 +0200
In-Reply-To: <1556265512-9130-8-git-send-email-yibin.gong@nxp.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
         <1556265512-9130-8-git-send-email-yibin.gong@nxp.com>
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
>    ERR009165 fix on i.mx6ul and next chip, such as i.mx6ull/i.mx8mq/i.mx8mm.
> Remove workaround on those chips. Add new i.mx6ul type for that.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/spi/spi-imx.c | 39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index eb56eac..2e5e978 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -57,6 +57,7 @@ enum spi_imx_devtype {
>  	IMX35_CSPI,	/* CSPI on all i.mx except above */
>  	IMX51_ECSPI,	/* ECSPI on i.mx51 */
>  	IMX53_ECSPI,	/* ECSPI on i.mx53 and later */
> +	IMX6UL_ECSPI,	/* ERR009165 fix from i.mx6ul */
>  };
>  
>  struct spi_imx_data;
> @@ -128,7 +129,8 @@ static inline int is_imx35_cspi(struct spi_imx_data *d)
>  
>  static inline int is_imx51_ecspi(struct spi_imx_data *d)
>  {
> -	return d->devtype_data->devtype == IMX51_ECSPI;
> +	return d->devtype_data->devtype == IMX51_ECSPI ||
> +	       d->devtype_data->devtype == IMX6UL_ECSPI;
>  }
>  
>  static inline int is_imx53_ecspi(struct spi_imx_data *d)
> @@ -585,9 +587,16 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
>  	ctrl |= mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
>  	spi_imx->spi_bus_clk = clk;
>  
> -	/* ERR009165: work in XHC mode as PIO */
> -	if (spi_imx->usedma)
> -		ctrl &= ~MX51_ECSPI_CTRL_SMC;
> +	/*
> +	 * ERR009165: work in XHC mode instead of SMC as PIO on the chips
> +	 * before i.mx6ul.
> +	 */
> +	if (spi_imx->usedma) {
> +		if (spi_imx->devtype_data->devtype == IMX6UL_ECSPI)

>=, otherwise the workaround might be applied to later generations of
the core if more are added later.

Regards,
Lucas
