Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E87EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4866C20685
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfCSMr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:47:56 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:50093 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfCSMr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:47:56 -0400
X-Originating-IP: 90.88.33.153
Received: from aptenodytes (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 76F0320006;
        Tue, 19 Mar 2019 12:47:52 +0000 (UTC)
Message-ID: <580ae1b1053aeaae7a1ee126d406b84ef3681394.camel@bootlin.com>
Subject: Re: [PATCH 1/3] dt-bindings: phy: Add bindings for the SMSC USB333x
 ULPI USB PHY
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        =?ISO-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Tue, 19 Mar 2019 13:47:51 +0100
In-Reply-To: <20190225164139.GA10291@bogus>
References: <20190130155023.4495-1-paul.kocialkowski@bootlin.com>
         <20190130155023.4495-2-paul.kocialkowski@bootlin.com>
         <20190225164139.GA10291@bogus>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi and sorry for the late response,

Le lundi 25 février 2019 à 10:41 -0600, Rob Herring a écrit :
> On Wed, Jan 30, 2019 at 04:50:21PM +0100, Paul Kocialkowski wrote:
> > Introduce the device-tree bindings for this ULPI USB PHY.
> > Optional bindings that are not prefixed with the vendor may be
> > relevant to other ULPI USB PHYs since they match generic ULPI
> > registers.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  .../devicetree/bindings/phy/smsc-usb333x.txt  | 50 +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/smsc-usb333x.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/smsc-usb333x.txt b/Documentation/devicetree/bindings/phy/smsc-usb333x.txt
> > new file mode 100644
> > index 000000000000..50d500d67b2f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/smsc-usb333x.txt
> > @@ -0,0 +1,50 @@
> > +Device tree bindings for SMSC USB333x ULPI USB PHY
> > +
> > +Required properties:
> > +- compatible: Should be "smsc,usb333x".
> > +
> > +Optional properties:
> > +- reset-gpios: GPIO to reset the PHY.
> > +- clocks: Reference clock that feeds the PHY's PLL.
> > +- clock-names: Should be "refclk" for the reference clock.
> > +- extvbus-passthru: Enable EXTVBUS signal pass-through to assert the VbusValid
> > +  signal internally. This is useful when no VBUS line is connected to the PHY.
> > +- auto-resume: Enable automatic transmission resume (in host mode).
> > +- chrg-vbus: Enable internal VBUS pull-up to 3.3 V during OTG SRP.
> > +- dischrg-vbus: Enable internal VBUS pull-down during OTG SRP.
> > +- id-pull-up: Enable internal ID pull-up tp 3.3 V.
> 
> These all need smsc prefix.

Note that these features are not specific to this PHY but reflect the
use of fields from the standardized ULPI register set, so they could
just as well apply to other ULPI USB PHYs.

With that in mind, do these props still qualify to get a smsc prefix?
Perhaps they should be added to bindings/usb/generic.txt instead.

> > +- smsc,varisense: Squelch detector threshold register field value, as described
> > +  in the datasheet.
> > +- smsc,phyboost: Output voltage change register field value, as described in the
> > +  datasheet.
> 
> Please give a range of values at least so we can write constraints.

Yes, I'll definitely do that in the next revision.

Thanks for the review!

Cheers,

Paul

> > +
> > +Refer to phy/phy-bindings.txt for the generic PHY binding properties.
> > +Refer to usb/ulpi.txt for the parent ULPI bus binding required for this PHY.
> > +
> > +Example:
> > +
> > +&usb0 {
> > +	compatible = "xlnx,zynq-usb-2.20a", "chipidea,usb2";
> > +	clocks = <&clkc 28>;
> > +	interrupt-parent = <&intc>;
> > +	interrupts = <0 21 4>;
> > +	reg = <0xe0002000 0x1000>;
> > +	dr_mode = "peripheral";
> > +	phys = <&usb_phy0>;
> > +	phy-names = "usb-phy";
> > +	phy_type = "ulpi";
> > +
> > +	ulpi {
> > +		usb_phy0: usb-phy0 {
> > +			#phy-cells = <0>;
> > +			compatible = "smsc,usb333x";
> > +			reset-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> > +			clocks = <&usb_phy_clk>;
> > +			clock-names = "refclk";
> > +			smsc,varisense = <1>;
> > +			smsc,phyboost = <5>;
> > +			extvbus-passthru;
> > +			chrg-vbus;
> > +		};
> > +	};
> > +};
> > -- 
> > 2.20.1
> > 
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

