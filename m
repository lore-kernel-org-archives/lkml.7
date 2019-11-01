Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F114CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810D9208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfKAIGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 04:06:42 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44466 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729852AbfKAIGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 04:06:42 -0400
Received: from [46.218.74.72] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iQRx7-0001Qk-C2; Fri, 01 Nov 2019 09:06:37 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add PCIe node on rk3399-roc-pc
Date:   Fri, 01 Nov 2019 09:06:36 +0100
Message-ID: <2490852.kIovObk3uj@phil>
In-Reply-To: <f66fe5c3-6760-20b0-54cc-8f0c1a754bab@fivetechno.de>
References: <09300c2d-4298-1b01-ac41-d1b2610589d4@fivetechno.de> <1719506.vT9a8mQdzu@phil> <f66fe5c3-6760-20b0-54cc-8f0c1a754bab@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

Am Donnerstag, 31. Oktober 2019, 19:12:10 CET schrieb Markus Reichl:
> Am 31.10.19 um 17:57 schrieb Heiko Stuebner:
> > Am Montag, 28. Oktober 2019, 15:47:27 CET schrieb Markus Reichl:
> >> rk3399-roc-pc has a PCIe interface. Enable it for use with
> >> the M.2 NGFF M_KEY slot on roc-rk3399-mezzanine board.
> >> Tested with Samsung 970 evo plus SSD.
> >> 
> >> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> >> ---
> >>  .../arm64/boot/dts/rockchip/rk3399-roc-pc.dts | 38 +++++++++++++++++++
> >>  1 file changed, 38 insertions(+)
> >> 
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> >> index 9313251765c7..2d637d54994b 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
> >> @@ -158,6 +158,21 @@
> >>  		regulator-max-microvolt = <1400000>;
> >>  		vin-supply = <&vcc_sys>;
> >>  	};
> >> +
> >> +	/* on roc-rk3399-mezzanine board */
> > 
> > I'm undecided on this. From what I've seen that mezzanine board is some
> > sort of addon, like a raspberry pi hat. Therefore it's not always present,
> > so probably should not be part of the base board dts.
> > 
> > I'm thinking a dt-overlay that can then be activated might be the solution
> > of choice, but I've reached out to arm-soc poeple on irc to determine the
> > correct course.
> > 
> I have seen some board.dtsi with board_only.dts respective board_extension.dts
> in the arch/arm64/boot/dts/rockchip directory. Would that be ok?

The answer is twofold I guess ;-)

(1) The 100% correct way would probably be to use a devicetree overlay
together with capemgr [0] to load the overlay from userspace, but

(2a) The distinction between system-on-module + baseboard and
board+cape is somewhat foggy I think and it really doesn't look like there
will be a big plethora of capes for the roc-rk3399-pc

(2b) People may actually want to boot of that nvme pcie drive attached
to the mezzanine, so it will be somewhat permanent connection anyway
and also the system then cannot wait for userspace to come up first, if
the userspace is sitting on that drive ;-) .

So I think, going the dts+dts-extension is the best way to go.

Heiko


[0] https://elinux.org/Capemgr



> >> +	vcc3v3_pcie: vcc3v3-pcie {
> >> +		compatible = "regulator-fixed";
> >> +		regulator-name = "vcc3v3_pcie";
> >> +		enable-active-high;
> >> +		gpio = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
> >> +		pinctrl-names = "default";
> >> +		pinctrl-0 = <&vcc3v3_pcie_en>;
> >> +		regulator-always-on;
> >> +		regulator-boot-on;
> >> +		regulator-min-microvolt = <3300000>;
> >> +		regulator-max-microvolt = <3300000>;
> >> +		vin-supply = <&dc_12v>;
> >> +	};
> >>  };
> >>  
> >>  &cpu_l0 {
> >> @@ -514,6 +529,19 @@
> >>  	status = "okay";
> >>  };
> >>  
> >> +&pcie_phy {
> >> +	status = "okay";
> >> +};
> >> +
> >> +&pcie0 {
> >> +	ep-gpios = <&gpio4 RK_PD1 GPIO_ACTIVE_HIGH>;
> >> +	num-lanes = <4>;
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&pcie_perst>;
> >> +	vpcie3v3-supply = <&vcc3v3_pcie>;
> >> +	status = "okay";
> >> +};
> >> +
> >>  &pinctrl {
> >>  	lcd-panel {
> >>  		lcd_panel_reset: lcd-panel-reset {
> >> @@ -535,6 +563,16 @@
> >>  		};
> >>  	};
> >>  
> >> +	pcie {
> >> +		vcc3v3_pcie_en: vcc3v3-pcie-en {
> >> +			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
> >> +		};
> >> +
> >> +		pcie_perst: pcie-perst {
> >> +			rockchip,pins = <4 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
> >> +		};
> >> +	};
> >> +
> >>  	pmic {
> >>  		vsel1_gpio: vsel1-gpio {
> >>  			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
> >> 
> > 
> > 
> > 
> > 
> > 
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> > 
> 




