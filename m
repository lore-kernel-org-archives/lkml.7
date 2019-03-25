Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D68C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BD0207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbfCYKjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:39:19 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41923 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730535AbfCYKjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:39:18 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1h8N0Z-0000c1-6G; Mon, 25 Mar 2019 11:39:11 +0100
Message-ID: <1553510350.2561.3.camel@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx6qdl: Specify IMX6QDL_CLK_IPG as "ipg"
 clock for SDMA
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Angus Ainslie <angus@akkea.ca>, Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 Mar 2019 11:39:10 +0100
In-Reply-To: <20190325050100.29517-1-andrew.smirnov@gmail.com>
References: <20190325050100.29517-1-andrew.smirnov@gmail.com>
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

Am Sonntag, den 24.03.2019, 22:01 -0700 schrieb Andrey Smirnov:
> Since 25aaa75df1e6 SDMA driver uses clock rates of "ipg" and "ahb"
> clock to determine if it needs to configure the IP block as operating
> at 1:1 or 1:2 clock ratio (ACR bit in SDMAARM_CONFIG). Specifying both
> clocks as IMX6QDL_CLK_SDMA results in driver incorrectly thinking that
> ratio is 1:1 which results in broken SDMA functionality(this at least
> breaks RAVE SP serdev driver on RDU2). Fix the code to specify
> IMX6QDL_CLK_IPG as "ipg" clock for SDMA, to the problem.

As this is breaking DT backward compatibility, I think we need a
blacklist in the driver for SOCs where the DT is known to be broken.

But fixing the broken DT is still a good idea, so:

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> Fixes: 25aaa75df1e6 ("dmaengine: imx-sdma: add clock ratio 1:1 check")
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
> 
> This probably has been fixed already, so please ignore this patch if
> that is the case.
> 
> Thanks,
> Andrey Smirnov
> 
>  arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 9f9aa6e7ed0e..354feba077b2 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -949,7 +949,7 @@
> >  				compatible = "fsl,imx6q-sdma", "fsl,imx35-sdma";
> >  				reg = <0x020ec000 0x4000>;
> >  				interrupts = <0 2 IRQ_TYPE_LEVEL_HIGH>;
> > -				clocks = <&clks IMX6QDL_CLK_SDMA>,
> > +				clocks = <&clks IMX6QDL_CLK_IPG>,
> >  					 <&clks IMX6QDL_CLK_SDMA>;
> >  				clock-names = "ipg", "ahb";
> >  				#dma-cells = <3>;
