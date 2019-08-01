Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DC9C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B622087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfHAIWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 04:22:12 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:43968 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbfHAIWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:22:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 559D4FB03;
        Thu,  1 Aug 2019 10:22:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1Gg7twQCHvA7; Thu,  1 Aug 2019 10:22:09 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 84CBD46DEA; Thu,  1 Aug 2019 10:22:09 +0200 (CEST)
Date:   Thu, 1 Aug 2019 10:22:09 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] reset: imx7: Fix IMX8MQ_RESET_MIPI_DSI_ defines
Message-ID: <20190801082209.GA7524@bogon.m.sigxcpu.org>
References: <cover.1564591352.git.agx@sigxcpu.org>
 <bd1504122f6797536a253a37f3604f5c46f02ab2.1564591352.git.agx@sigxcpu.org>
 <1564591585.7267.22.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1564591585.7267.22.camel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,
On Wed, Jul 31, 2019 at 06:46:25PM +0200, Lucas Stach wrote:
> Am Mittwoch, den 31.07.2019, 18:43 +0200 schrieb Guido Günther:
> > Some of the mipi dsi resets were called
> > 
> >   IMX8MQ_RESET_MIPI_DIS_
> > 
> > instead of
> > 
> >   IMX8MQ_RESET_MIPI_DSI_
> > 
> > Since they're DSI related this looks like a typo.
> > 
> > I wasn't sure if this should be a single patch since it otherwise breaks
> > bisectability. I couldn't find any device trees using this yet.
> 
> Yes, I think this should be squashed into a single commit. Other than
> that, the change looks correct.

Thanks for having a look. Sent out v2 as a single patch.
Cheers,
 -- Guido

> 
> Regards,
> Lucas
> 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> >  drivers/reset/reset-imx7.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
> > index 3ecd770f910b..1443a55a0c29 100644
> > --- a/drivers/reset/reset-imx7.c
> > +++ b/drivers/reset/reset-imx7.c
> > @@ -169,9 +169,9 @@ static const struct imx7_src_signal imx8mq_src_signals[IMX8MQ_RESET_NUM] = {
> > > >  	[IMX8MQ_RESET_OTG2_PHY_RESET]		= { SRC_USBOPHY2_RCR, BIT(0) },
> > > >  	[IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N]	= { SRC_MIPIPHY_RCR, BIT(1) },
> > > >  	[IMX8MQ_RESET_MIPI_DSI_RESET_N]		= { SRC_MIPIPHY_RCR, BIT(2) },
> > > > -	[IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(3) },
> > > > -	[IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(4) },
> > > > -	[IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(5) },
> > > > +	[IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(3) },
> > > > +	[IMX8MQ_RESET_MIPI_DSI_ESC_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(4) },
> > > > +	[IMX8MQ_RESET_MIPI_DSI_PCLK_RESET_N]	= { SRC_MIPIPHY_RCR, BIT(5) },
> > > >  	[IMX8MQ_RESET_PCIEPHY]			= { SRC_PCIEPHY_RCR,
> > >  						    BIT(2) | BIT(1) },
> > > >  	[IMX8MQ_RESET_PCIEPHY_PERST]		= { SRC_PCIEPHY_RCR, BIT(3) },
> > @@ -220,9 +220,9 @@ static int imx8mq_reset_set(struct reset_controller_dev *rcdev,
> >  
> > >  	case IMX8MQ_RESET_PCIE_CTRL_APPS_EN:
> > > >  	case IMX8MQ_RESET_PCIE2_CTRL_APPS_EN:	/* fallthrough */
> > > > -	case IMX8MQ_RESET_MIPI_DIS_PCLK_RESET_N:	/* fallthrough */
> > > > -	case IMX8MQ_RESET_MIPI_DIS_ESC_RESET_N:	/* fallthrough */
> > > > -	case IMX8MQ_RESET_MIPI_DIS_DPI_RESET_N:	/* fallthrough */
> > > > +	case IMX8MQ_RESET_MIPI_DSI_PCLK_RESET_N:	/* fallthrough */
> > > > +	case IMX8MQ_RESET_MIPI_DSI_ESC_RESET_N:	/* fallthrough */
> > > > +	case IMX8MQ_RESET_MIPI_DSI_DPI_RESET_N:	/* fallthrough */
> > > >  	case IMX8MQ_RESET_MIPI_DSI_RESET_N:	/* fallthrough */
> > > >  	case IMX8MQ_RESET_MIPI_DSI_RESET_BYTE_N:	/* fallthrough */
> > >  		value = assert ? 0 : bit;
> 
