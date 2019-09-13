Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FE3C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334F920830
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfIMMtK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 08:49:10 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:58073 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbfIMMtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:49:10 -0400
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D2E30240016;
        Fri, 13 Sep 2019 12:49:04 +0000 (UTC)
Date:   Fri, 13 Sep 2019 14:49:03 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Piotr Sroka <piotrs@cadence.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>,
        BrianNorris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>
Subject: Re: [v5 2/2] dt-bindings: mtd: Add Cadence NAND controller driver
Message-ID: <20190913144903.0323a23a@xps13>
In-Reply-To: <20190911150422.GA4973@global.cadence.com>
References: <20190725145804.8886-1-piotrs@cadence.com>
        <20190725145955.13951-1-piotrs@cadence.com>
        <20190830114638.33dc4eb2@xps13>
        <20190911150422.GA4973@global.cadence.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Piotr,

Piotr Sroka <piotrs@cadence.com> wrote on Wed, 11 Sep 2019 16:04:24
+0100:

> Hi Miquel
> 
> The 08/30/2019 11:46, Miquel Raynal wrote:
> >EXTERNAL MAIL
> >
> >
> >Hi Piotr,
> >
> >Piotr Sroka <piotrs@cadence.com> wrote on Thu, 25 Jul 2019 15:59:55
> >+0100:
> >  
> >> Document the bindings used by Cadence NAND controller driver
> >>
> >> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> >> ---
> >> Changes for v5:
> >> - replace "_" by "-" in all properties
> >> - change compatible name from cdns,hpnfc to cdns,hp-nfc
> >> Changes for v4:
> >> - add commit message
> >> Changes for v3:
> >> - add unit suffix for board_delay
> >> - move child description to proper place
> >> - remove prefix cadence_ for reg and sdma fields
> >> Changes for v2:
> >> - remove chip dependends parameters from dts bindings
> >> - add names for register ranges in dts bindings
> >> - add generic bindings to describe NAND chip representation
> >> ---
> >>  .../bindings/mtd/cadence-nand-controller.txt       | 50 ++++++++++++++++++++++
> >>  1 file changed, 50 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
> >> new file mode 100644
> >> index 000000000000..423547a3f993
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
> >> @@ -0,0 +1,50 @@
> >> +* Cadence NAND controller
> >> +
> >> +Required properties:
> >> +  - compatible : "cdns,hp-nfc"
> >> +  - reg : Contains two entries, each of which is a tuple consisting of a
> >> +	  physical address and length. The first entry is the address and
> >> +	  length of the controller register set. The second entry is the
> >> +	  address and length of the Slave DMA data port.
> >> +  - reg-names: should contain "reg" and "sdma"
> >> +  - interrupts : The interrupt number.
> >> +  - clocks: phandle of the controller core clock (nf_clk).
> >> +
> >> +Optional properties:
> >> +  - dmas: shall reference DMA channel associated to the NAND controller
> >> +  - cdns,board-delay-ps : Estimated Board delay. The value includes the total
> >> +    round trip delay for the signals and is used for deciding on values
> >> +    associated with data read capture. The example formula for SDR mode is
> >> +    the following:
> >> +    board delay = RE#PAD delay + PCB trace to device + PCB trace from device
> >> +    + DQ PAD delay
> >> +
> >> +Child nodes represent the available NAND chips.
> >> +
> >> +Required properties of NAND chips:
> >> +  - reg: shall contain the native Chip Select ids from 0 to max supported by
> >> +    the cadence nand flash controller
> >> +
> >> +
> >> +See Documentation/devicetree/bindings/mtd/nand.txt for more details on
> >> +generic bindings.
> >> +
> >> +Example:
> >> +
> >> +nand_controller: nand-controller @60000000 {
> >> +	  compatible = "cdns,hp-nfc";
> >> +	  reg = <0x60000000 0x10000>, <0x80000000 0x10000>;
> >> +	  reg-names = "reg", "sdma";
> >> +	  clocks = <&nf_clk>;
> >> +	  cdns,board-delay-ps = <4830>;  
> >
> >Are you sure you want to export this to the user? Not sure it is easily
> >understandable and tunable... I'm not against but I would have troubles
> >tuning it myself, unless using the documented value. Maybe you should
> >explain more how to derive it?  
> I need to export this parameter somehow. The default value may not be
> valid for other platforms. This value depends on platform, and may be different on different SoCs. So I think the DTS is the best place to put such configuration
> parameter.

What about a different compatible if it depends on the SoC?

This way you can retrieve a different driver data structure and avoid
the pain for the user.


Thanks,
Miquèl
