Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C0EC48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B2B2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfF0R0Y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:26:24 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:47667 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0R0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:26:24 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id A5B4D200004;
        Thu, 27 Jun 2019 17:26:12 +0000 (UTC)
Date:   Thu, 27 Jun 2019 19:26:09 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, bbrezillon@kernel.org,
        dwmw2@infradead.org, computersforpeace@gmail.com, vigneshr@ti.com,
        paul.burton@mips.com, liang.yang@amlogic.com, richard@nod.at,
        anders.roxell@linaro.org, christophe.kerello@st.com,
        paul@crapouillou.net, jianxin.pan@amlogic.com, stefan@agner.ch,
        devicetree@vger.kernel.org, juliensu@mxic.com.tw,
        lee.jones@linaro.org, broonie@kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: mtd: Document Macronix raw NAND
 controller bindings
Message-ID: <20190627192609.0965f6d5@xps13>
In-Reply-To: <1561443056-13766-3-git-send-email-masonccyang@mxic.com.tw>
References: <1561443056-13766-1-git-send-email-masonccyang@mxic.com.tw>
        <1561443056-13766-3-git-send-email-masonccyang@mxic.com.tw>
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

Mason Yang <masonccyang@mxic.com.tw> wrote on Tue, 25 Jun 2019 14:10:56
+0800:

> Document the bindings used by the Macronix raw NAND controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/mtd/mxic-nand.txt          | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/mxic-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mxic-nand.txt b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
> new file mode 100644
> index 0000000..3d198e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/mxic-nand.txt
> @@ -0,0 +1,26 @@
> +Macronix Raw NAND Controller Device Tree Bindings
> +-------------------------------------------------
> +
> +Required properties:
> +- compatible: should be "mxic,raw-nand-ctlr"

I would prefer "macronix,nand-controller"

> +- reg: should contain 1 entrie for the registers

                           entry

> +- reg-names: should contain "regs"

Not sure you need that?

> +- interrupts: interrupt line connected to this NAND controller
> +- clock-names: should contain "ps_clk", "send_clk" and "send_dly_clk"
> +- clocks: should contain 3 entries for the "ps_clk", "send_clk" and
> +	 "send_dly_clk" clocks

s/entries/phandles/ ?

> +
> +Example:
> +
> +	nand: mxic-nfc@43c30000 {
> +		compatible = "mxic,raw-nand-ctlr";
> +		reg = <0x43c30000 0x10000>;
> +		reg-names = "regs";
> +		clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
> +		clock-names = "send_clk", "send_dly_clk", "ps_clk";
> +
> +		nand-ecc-mode = "soft";
> +		nand-ecc-algo = "bch";
> +		nand-ecc-step-size = <512>;
> +		nand-ecc-strength = <8>;

The last 4 lines are probably not needed.

> +	};

Thanks,
Miquèl
