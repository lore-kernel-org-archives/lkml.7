Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E67C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F5420883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbfDARwx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:52:53 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:53315 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732545AbfDARww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:52:52 -0400
X-Originating-IP: 81.185.163.178
Received: from xps13 (178.163.185.81.rev.sfr.net [81.185.163.178])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id BECECC000A;
        Mon,  1 Apr 2019 17:52:40 +0000 (UTC)
Date:   Mon, 1 Apr 2019 19:52:35 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, dwmw2@infradead.org, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        computersforpeace@gmail.com, paul.burton@mips.com, stefan@agner.ch,
        christophe.kerello@st.com, liang.yang@amlogic.com,
        geert@linux-m68k.org, devicetree@vger.kernel.org,
        marcel.ziswiler@toradex.com, linux-mtd@lists.infradead.org,
        richard@nod.at, juliensu@mxic.com.tw, zhengxunli@mxic.com.tw
Subject: Re: [PATCH 4/7] dt-bindings: mfd: Document Macronix MX25F0A
 controller bindings
Message-ID: <20190401193431.3e8788a0@xps13>
In-Reply-To: <1553768318-23149-5-git-send-email-masonccyang@mxic.com.tw>
References: <1553768318-23149-1-git-send-email-masonccyang@mxic.com.tw>
        <1553768318-23149-5-git-send-email-masonccyang@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

Mason Yang <masonccyang@mxic.com.tw> wrote on Thu, 28 Mar 2019 18:18:35
+0800:

> Document the bindings used by the Macronix MX25F0A MFD controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/mfd/mxic-mx25f0a.txt       | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt b/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
> new file mode 100644
> index 0000000..53b4839
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
> @@ -0,0 +1,66 @@
> +Macronix MX25F0A Multi-Function Device Tree Bindings
> +----------------------------------------------------
> +
> +MX25F0A is a MultiFunction Device with SPI and raw NAND, which
> +supports either spi host controller or raw nand controller.
> +
> +Required properties:
> +- compatible: should be "mxic,mx25f0a-mfd"

Should probably be "mxic,mx25f0a"

> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain 2 entries, one for the registers and one for the direct
> +       mapping area in SPI mode.
> +- reg-names: should contain "regs" and "dirmap"
> +- interrupts: interrupt line connected to this MFD controller
> +
> +Required nodes:
> + - spi :
> +	Node for configuring the SPI controller driver.
> +	Required properties:
> +		- compatible = "mxicy,mx25f0a-spi";
> +		- clock-names: should contain "ps_clk", "send_clk" and
> +			       "send_dly_clk"
> +		- clocks: should contain 3 entries for the "ps_clk", "send_clk"
> +			  and "send_dly_clk" clocks
> +
> +- nand :
> +	Node for configuring the raw nand controller driver.
> +	Required properties:
> +		- compatible = "mxicy,mx25f0a-nand-ctlr";
> +		- nand-ecc-mode = "soft";
> +		- nand-ecc-algo = "bch";

You can have only one node at a time. You can add a mxic,mode property
being either "spi-controller" or "nand-controller".

> +
> +Example:
> +
> +	mxic: mx25f0a-mfd@43c30000 {
> +		compatible = "mxic,mx25f0a-mfd";
> +		reg = <0x43c30000 0x10000>, <0xa0000000 0x4000000>;
> +		reg-names = "regs", "dirmap";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* either spi or nand */
> +		spi {
> +			compatible = "mxicy,mx25f0a-spi";
> +			clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
> +			clock-names = "send_clk", "send_dly_clk", "ps_clk";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			flash@0 {
> +				compatible = "jedec,spi-nor";
> +				reg = <0>;
> +				spi-max-frequency = <25000000>;
> +				spi-tx-bus-width = <4>;
> +				spi-rx-bus-width = <4>;
> +			};
> +		};
> +
> +		nand {
> +			compatible = "mxicy,mx25f0a-nand-ctlr";
> +			nand-ecc-mode = "soft";
> +			nand-ecc-algo = "bch";
> +			nand-ecc-step-size = <512>;
> +			nand-ecc-strength = <8>;

Are you sure you want soft correction? (I have not checked the driver
yet). For hw correction, I prefer to drop the two step-size/strength
properties. These values will be derived depending on the chip's
requirements.


Thanks,
Miquèl
