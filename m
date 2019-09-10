Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB85C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2955D2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394154AbfIJQRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 12:17:53 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:36970 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394139AbfIJQRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 12:17:53 -0400
Received: from sapphire.tkos.co.il (unknown [192.168.100.188])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 619F14402AC;
        Tue, 10 Sep 2019 19:17:49 +0300 (IDT)
Date:   Tue, 10 Sep 2019 19:17:48 +0300
From:   Baruch Siach <baruch@tkos.co.il>
To:     tinywrkb <tinywrkb@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: imx6dl: SolidRun: add phy node with 100Mb/s
 max-speed
Message-ID: <20190910161748.dbvudrkx6i2avoha@sapphire.tkos.co.il>
References: <20190910155507.491230-1-tinywrkb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910155507.491230-1-tinywrkb@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi tinywrkb,

On Tue, Sep 10, 2019 at 06:55:07PM +0300, tinywrkb wrote:
> Cubox-i Solo/DualLite carrier board has 100Mb/s magnetics while the
> Atheros AR8035 PHY on the MicroSoM v1.3 CPU module is a 1GbE PHY device.

According to the hardware designer, Rabeeh Khoury, there is not such 
limitation in the Cubox-i carrier magnetics.

> Since commit 5502b218e001 ("net: phy: use phy_resolve_aneg_linkmode in
> genphy_read_status") ethernet is broken on Cubox-i Solo/DualLite devices.

Does revert of 5502b218e001 fixes your issue?

> This adds a phy node to the MicroSoM DTS and a 100Mb/s max-speed limit
> to the Cubox-i Solo/DualLite carrier DTS.
> 
> Signed-off-by: tinywrkb <tinywrkb@gmail.com>

You must use your real name in sign-off.

> ---
> This patch fixes ethernet on my Cubox-i2-300-D which is limited to 100Mb/s,
> afaik due to the carrier board  magnetics, and was since commit 5502b218e001
> ("net: phy: use phy_resolve_aneg_linkmode in genphy_read_status")
> 
> The AR8035 PHY on the CPU module reports to the driver as 1GbE capable
> via MII_BSMR's BMSR_ESTATEN status bit, the auto-negotiation sets the
> speed at 1GbE while the carrier board can't support it.
> Same behavior with the generic phy_device and the at803x drivers.
> 
> While the PHY is on the CPU module board I added the max-speed limit to
> the cubox-i carrier DTS as I suspect that if the Solo or DualLite v1.3
> MicroSoM will be connected to a 1GbE capable carrier board then it would
> work correctly with 1GbE.
> 
> I can confirm that this commit doesn't break networking on the my
> Cubox-i4Pro Quad (i4P-300-D) with it's 1GbE capable carrier board, and
> was tested separately with the generic phy_device and at803x drivers.
> 
>  arch/arm/boot/dts/imx6dl-cubox-i.dts  | 4 ++++
>  arch/arm/boot/dts/imx6qdl-sr-som.dtsi | 9 +++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-cubox-i.dts b/arch/arm/boot/dts/imx6dl-cubox-i.dts
> index 2b1b3e193f53..cfc82513c78c 100644
> --- a/arch/arm/boot/dts/imx6dl-cubox-i.dts
> +++ b/arch/arm/boot/dts/imx6dl-cubox-i.dts
> @@ -49,3 +49,7 @@
>  	model = "SolidRun Cubox-i Solo/DualLite";
>  	compatible = "solidrun,cubox-i/dl", "fsl,imx6dl";
>  };
> +
> +&ethphy {
> +	max-speed = <100>;
> +};

Where is the ethphy lable defined? Have you build tested this patch?

> diff --git a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
> index 6d7f6b9035bc..969bc96c3f99 100644
> --- a/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sr-som.dtsi
> @@ -57,6 +57,15 @@
>  	phy-reset-duration = <2>;
>  	phy-reset-gpios = <&gpio4 15 GPIO_ACTIVE_LOW>;
>  	status = "okay";
> +	phy-handle = <&ethphy>;
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		ethphy: ethernet-phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +		};
> +	};
>  };
>  
>  &iomuxc {

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
