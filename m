Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA56AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3DC2080A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393171AbfFMQ46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:56:58 -0400
Received: from foss.arm.com ([217.140.110.172]:47186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730001AbfFMQ4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:56:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C32D367;
        Thu, 13 Jun 2019 09:56:52 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A1293F694;
        Thu, 13 Jun 2019 09:56:49 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: rockchip: Update DWC3 modules on RK3399 SoCs
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-rockchip@lists.infradead.org,
        Tony Xie <tony.xie@rock-chips.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Randy Li <ayaka@soulik.info>, linux-kernel@vger.kernel.org,
        Vicente Bergas <vicencb@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
References: <20190613162745.12195-1-enric.balletbo@collabora.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <40d2260f-3925-acdc-eb02-8abb972f1056@arm.com>
Date:   Thu, 13 Jun 2019 17:56:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190613162745.12195-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2019 17:27, Enric Balletbo i Serra wrote:
> As per binding documentation [1], the DWC3 core should have the "ref",
> "bus_early" and "suspend" clocks. As explained in the binding, those
> clocks are required for new platforms but not for existing platforms
> before commit fe8abf332b8f ("usb: dwc3: support clocks and resets for
> DWC3 core").
> 
> However, as those clocks are really treated as required, this ends with
> having some annoying messages when the "rockchip,rk3399-dwc3" is used:
> 
> [    1.724107] dwc3 fe800000.dwc3: Failed to get clk 'ref': -2
> [    1.731893] dwc3 fe900000.dwc3: Failed to get clk 'ref': -2
> [    2.495937] dwc3 fe800000.dwc3: Failed to get clk 'ref': -2
> [    2.647239] dwc3 fe900000.dwc3: Failed to get clk 'ref': -2
> 
> In order to remove those annoying messages, update the DWC3 hardware
> module node and add all the required clocks. With this change, both, the
> glue node and the DWC3 core node, have the clocks defined, but that's
> not really a problem and there isn't a side effect on do this. So, we
> can get rid of the annoying get clk error messages.

Can we not just move these clocks entirely from the glue layer to the 
core layer? That didn't seem to break when I tried it, although I'll 
admit my 'testing' was no more than booting and mounting a USB 3.0 flash 
drive, no suspend or anything fancy.

My own attempt to shut up these errors got sidetracked into c0c61471ef86 
("usb: dwc3: of-simple: Convert to bulk clk API"), then apparently 
stalled :)

Robin.

> 
> [1] Documentation/devicetree/bindings/usb/dwc3.txt
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 196ac9b78076..a15348d185ce 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -414,6 +414,9 @@
>   			compatible = "snps,dwc3";
>   			reg = <0x0 0xfe800000 0x0 0x100000>;
>   			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&cru SCLK_USB3OTG0_REF>, <&cru ACLK_USB3OTG0>,
> +				 <&cru SCLK_USB3OTG0_SUSPEND>;
> +			clock-names = "ref", "bus_early", "suspend";
>   			dr_mode = "otg";
>   			phys = <&u2phy0_otg>, <&tcphy0_usb3>;
>   			phy-names = "usb2-phy", "usb3-phy";
> @@ -447,6 +450,9 @@
>   			compatible = "snps,dwc3";
>   			reg = <0x0 0xfe900000 0x0 0x100000>;
>   			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&cru SCLK_USB3OTG1_REF>, <&cru ACLK_USB3OTG1>,
> +				 <&cru SCLK_USB3OTG1_SUSPEND>;
> +			clock-names = "ref", "bus_early", "suspend";
>   			dr_mode = "otg";
>   			phys = <&u2phy1_otg>, <&tcphy1_usb3>;
>   			phy-names = "usb2-phy", "usb3-phy";
> 
