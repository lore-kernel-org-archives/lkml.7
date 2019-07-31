Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F241C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B140206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbfGaQqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:46:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43495 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfGaQqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:46:32 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hsrkA-0005jG-Fj; Wed, 31 Jul 2019 18:46:26 +0200
Message-ID: <1564591585.7267.22.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] reset: imx7: Fix IMX8MQ_RESET_MIPI_DSI_ defines
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Wed, 31 Jul 2019 18:46:25 +0200
In-Reply-To: <bd1504122f6797536a253a37f3604f5c46f02ab2.1564591352.git.agx@sigxcpu.org>
References: <cover.1564591352.git.agx@sigxcpu.org>
         <bd1504122f6797536a253a37f3604f5c46f02ab2.1564591352.git.agx@sigxcpu.org>
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

Am Mittwoch, den 31.07.2019, 18:43 +0200 schrieb Guido Günther:
> Some of the mipi dsi resets were called
> 
>   IMX8MQ_RESET_MIPI_DIS_
> 
> instead of
> 
>   IMX8MQ_RESET_MIPI_DSI_
> 
> Since they're DSI related this looks like a typo.
> 
> I wasn't sure if this should be a single patch since it otherwise breaks
> bisectability. I couldn't find any device trees using this yet.

Yes, I think this should be squashed into a single commit. Other than
that, the change looks correct.

Regards,
Lucas

> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  drivers/reset/reset-imx7.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> index 3ecd770f910b..1443a55a0c29 100644
> --- a/drivers/reset/reset-imx7.c
> +++ b/drivers/reset/reset-imx7.c
> @@ -169,9 +169,9 @@ static const struct imx7_src_signal imx8mq_src_signals[IMX8MQ_RESET_NUM] = {
> > >  	[IMX8MQ_RESET_OTG2_PHY_RESET]		= { SRC_USBOPHY2_RCR, BIT(0) },
> > >  	[IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N]	= { SRC_MIPIPHY_RCR, BIT(1) },
> > >  	[IMX8MQ_RESET_MIPI_DSI_RESET_N]		= { SRC_MIPIPHY_RCR, BIT(2) },
> > > -	[IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(3) },
> > > -	[IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(4) },
> > > -	[IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(5) },
> > > +	[IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(3) },
> > > +	[IMX8MQ_RESET_MIPI_DSI_ESC_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(4) },
> > > +	[IMX8MQ_RESET_MIPI_DSI_PCLK_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(5) },
> > >  	[IMX8MQ_RESET_PCIEPHY]			= { SRC_PCIEPHY_RCR,
> >  						    BIT(2) | BIT(1) },
> > >  	[IMX8MQ_RESET_PCIEPHY_PERST]		= { SRC_PCIEPHY_RCR, BIT(3) },
> @@ -220,9 +220,9 @@ static int imx8mq_reset_set(struct reset_controller_dev *rcdev,
>  
> >  	case IMX8MQ_RESET_PCIE_CTRL_APPS_EN:
> > >  	case IMX8MQ_RESET_PCIE2_CTRL_APPS_EN:	/* fallthrough */
> > > -	case IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N:	/* fallthrough */
> > > -	case IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N:	/* fallthrough */
> > > -	case IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N:	/* fallthrough */
> > > +	case IMX8MQ_RESET_MIPI_DSI_PCLK_RESET_N:	/* fallthrough */
> > > +	case IMX8MQ_RESET_MIPI_DSI_ESC_RESET_N:	/* fallthrough */
> > > +	case IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N:	/* fallthrough */
> > >  	case IMX8MQ_RESET_MIPI_DSI_RESET_N:	/* fallthrough */
> > >  	case IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N:	/* fallthrough */
> >  		value = assert ? 0 : bit;
