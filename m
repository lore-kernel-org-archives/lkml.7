Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61729C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374A52064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfD3RRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 13:17:01 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:48971 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3RRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:17:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 66E3CFB03;
        Tue, 30 Apr 2019 19:16:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mwgHcBd5cvLL; Tue, 30 Apr 2019 19:16:57 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 1B80D4027E; Tue, 30 Apr 2019 19:16:57 +0200 (CEST)
Date:   Tue, 30 Apr 2019 19:16:57 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq: Add a node for irqsteer
Message-ID: <20190430171657.GA1513@bogon.m.sigxcpu.org>
References: <a08a0a2fdd2090f4f42fe50d8ed70ee08b2fbcaf.1556631673.git.agx@sigxcpu.org>
 <1556632204.2560.20.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556632204.2560.20.camel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,
On Tue, Apr 30, 2019 at 03:50:04PM +0200, Lucas Stach wrote:
> Am Dienstag, den 30.04.2019, 15:41 +0200 schrieb Guido Günther:
> > Add a node for the irqsteer interrupt controller found on the iMX8MQ
> > SoC.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > index 2cc939cfbd75..ce0e137ec8ee 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -798,6 +798,27 @@
> >  			};
> >  		};
> >  
> > +		bus@32c00000 { /* AIPS4 */
> > +			compatible = "fsl,imx8mq-aips-bus", "simple-bus";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges = <0x32c00000 0x32c00000 0x400000>;
> > +
> > +			irqsteer: interrupt-controller@32e2d000 {
> > +				compatible = "fsl,imx8m-irqsteer",
> > +					     "fsl,imx-irqsteer";
> 
> This fits on a single line, right?

It went past the 80 char limit but it seems the dts is not super picky
about that so I changed that in v2.

> 
> > +				reg = <0x32e2d000 0x1000>;
> > +				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
> > +				clock-names = "ipg";
> > +				fsl,channel = <0>;
> > +				fsl,num-irqs = <64>;
> > +				interrupt-controller;
> > +				interrupt-parent = <&gic>;
> 
> This is wrong, the irqsteer upstream IRQ is routed through the GPC like
> all the other peripheral interrupts. You can just drop this property.

Fixed in v2. Thanks,
 -- Guido

> 
> With this fixed:
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> 
> Regards,
> Lucas
> 
> > +				#interrupt-cells = <1>;
> > +			};
> > +		};
> > +
> >  		gpu: gpu@38000000 {
> >  			compatible = "vivante,gc";
> >  			reg = <0x38000000 0x40000>;
> 
