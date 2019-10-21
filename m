Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AA5CA9EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3404D20873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfJUJLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:11:54 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:57260 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfJUJLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:11:53 -0400
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id 2C41047C0C;
        Mon, 21 Oct 2019 17:09:27 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.67] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P14676T139991093077760S1571648966711348_;
        Mon, 21 Oct 2019 17:09:27 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <dcec87c863f149527207a6b7e5b402df>
X-RL-SENDER: andy.yan@rock-chips.com
X-SENDER: yxj@rock-chips.com
X-LOGIN-NAME: andy.yan@rock-chips.com
X-FST-TO: huangtao@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Add core dts for RK3308 SOC
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     kever.yang@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        tony.xie@rock-chips.com, huangtao@rock-chips.com
References: <20191017030242.32219-1-andy.yan@rock-chips.com>
 <20191017030449.32289-1-andy.yan@rock-chips.com> <5242916.cCMrPAA6xQ@phil>
From:   Andy Yan <andy.yan@rock-chips.com>
Message-ID: <35a37c31-0e28-1900-1e50-d6b7dc78266b@rock-chips.com>
Date:   Mon, 21 Oct 2019 17:09:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5242916.cCMrPAA6xQ@phil>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko:

Thanks for your kindly review.

On 10/18/19 7:30 AM, Heiko Stuebner wrote:
> Hi Andy,
>
> Am Donnerstag, 17. Oktober 2019, 05:04:49 CEST schrieb Andy Yan:
>
>> +	psci {
>> +		compatible = "arm,psci-1.0";
>> +		method = "smc";
>> +	};
> Please also provide a ATF implementation for the rk3308 :-)
> [Not a requirement for getting this merged, but it would be
> really cool to have sources for the full stack]


Tony's team has the plan to do it.

>> +
>> +	ramoops_mem: ramoops_mem {
>> +		reg = <0x0 0x110000 0x0 0xf0000>;
>> +		reg-names = "ramoops_mem";
>> +	};
>> +
>> +	ramoops: ramoops {
>> +		compatible = "ramoops";
>> +		record-size = <0x0 0x30000>;
>> +		console-size = <0x0 0xc0000>;
>> +		ftrace-size = <0x0 0x00000>;
>> +		pmsg-size = <0x0 0x00000>;
>> +		memory-region = <&ramoops_mem>;
>> +	};
> I think ramoops are more a per-board thing, like for the evb.
> As they'll require cooperation with bootloaders to not mangle that
> memory area. For this please also coordinate with Kever because
> I somehow remember we have u-boot sometimes at 0x100000.
>
I removed it in V2.
>> +	grf: grf@ff000000 {
>> +		compatible = "rockchip,rk3308-grf", "syscon", "simple-mfd";
> Please add a patch adding the rockchip,rk3308-grf compatible to
> Documentation/devicetree/bindings/soc/rockchip/grf.txt


Done

>
>> +		reg = <0x0 0xff000000 0x0 0x10000>;
>> +
>> +		reboot-mode {
>> +			compatible = "syscon-reboot-mode";
>> +			offset = <0x500>;
>> +			mode-bootloader = <BOOT_BL_DOWNLOAD>;
>> +			mode-loader = <BOOT_BL_DOWNLOAD>;
>> +			mode-normal = <BOOT_NORMAL>;
>> +			mode-recovery = <BOOT_RECOVERY>;
>> +			mode-fastboot = <BOOT_FASTBOOT>;
>> +		};
>> +	};
>> +
>> +	detect_grf: syscon@ff00b000 {
>> +		compatible = "syscon", "simple-mfd";
> 	compatible = "rockchip,rk3308-detect-grf", "syscon"
> + add the rk3308-detect-grf to the binding
Done
>> +		reg = <0x0 0xff00b000 0x0 0x1000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +	};
>> +
>> +	core_grf: syscon@ff00c000 {
>> +		compatible = "syscon", "simple-mfd";
> same as detect_grf
Done
>
>> +		reg = <0x0 0xff00c000 0x0 0x1000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +
>> +	};
>> +
>> +	i2c0: i2c@ff040000 {
>> +		compatible = "rockchip,rk3399-i2c";
> 	compatible = "rockchip,rk3308-i2c", "rockchip,rk3399-i2c";
> Same for all i2c controllers.
Done
>
>> +		reg = <0x0 0xff040000 0x0 0x1000>;
>> +		clocks = <&cru SCLK_I2C0>, <&cru PCLK_I2C0>;
>> +		clock-names = "i2c", "pclk";
>> +		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&i2c0_xfer>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		status = "disabled";
>> +	};
>
>> +	spi0: spi@ff120000 {
>> +		compatible = "rockchip,rk3308-spi", "rockchip,rk3066-spi";
>> +		reg = <0x0 0xff120000 0x0 0x1000>;
>> +		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
>> +		clock-names = "spiclk", "apb_pclk";
>> +		dmas = <&dmac0 0>, <&dmac0 1>;
>> +		dma-names = "tx", "rx";
>> +		pinctrl-names = "default", "high_speed";
> there is no high_speed pinctrl defined for the Rockchip spi driver
> in mainline, so this part should go away in a first step.
> Same for the other spi controllers.
>
Removed
>> +		pinctrl-0 = <&spi0_clk &spi0_csn0 &spi0_miso &spi0_mosi>;
>> +		pinctrl-1 = <&spi0_clk_hs &spi0_csn0 &spi0_miso_hs &spi0_mosi_hs>;
>> +		status = "disabled";
>> +	};
>
>> +	rktimer: rktimer@ff1a0000 {
>> +		compatible = "rockchip,rk3288-timer";
> 	compatible = "rockchip,rk3308-timer", "rockchip,rk3288-timer";
Done
>
>> +		reg = <0x0 0xff1a0000 0x0 0x20>;
>> +		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&cru PCLK_TIMER>, <&cru SCLK_TIMER0>;
>> +		clock-names = "pclk", "timer";
>> +	};
>
>
>> +	amba {
>> +		compatible = "arm,amba-bus";
> compatible = "simple-bus";

Done
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		dmac0: dma-controller@ff2c0000 {
>> +			compatible = "arm,pl330", "arm,primecell";
>> +			reg = <0x0 0xff2c0000 0x0 0x4000>;
>> +			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
>> +			#dma-cells = <1>;
>> +			clocks = <&cru ACLK_DMAC0>;
>> +			clock-names = "apb_pclk";
>> +			peripherals-req-type-burst;
> peripherals-req-type-burst is undocumented so likely some change to the
> dma driver not yet upstream?


  not upstream， so i remove it.

>> +		};
>> +
>> +		dmac1: dma-controller@ff2d0000 {
>> +			compatible = "arm,pl330", "arm,primecell";
>> +			reg = <0x0 0xff2d0000 0x0 0x4000>;
>> +			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
>> +			#dma-cells = <1>;
>> +			clocks = <&cru ACLK_DMAC1>;
>> +			clock-names = "apb_pclk";
>> +			peripherals-req-type-burst;
>> +		};
>> +	};
>> +
>> +	i2s_2ch_0: i2s@ff350000 {
>> +		compatible = "rockchip,rk3308-i2s", "rockchip,rk3066-i2s";
>> +		reg = <0x0 0xff350000 0x0 0x1000>;
>> +		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&cru SCLK_I2S0_2CH>, <&cru HCLK_I2S0_2CH>;
>> +		clock-names = "i2s_clk", "i2s_hclk";
>> +		dmas = <&dmac1 8>, <&dmac1 9>;
>> +		dma-names = "tx", "rx";
>> +		resets = <&cru SRST_I2S0_2CH_M>, <&cru SRST_I2S0_2CH_H>;
>> +		reset-names = "reset-m", "reset-h";
> These resets don't seem to be defined in driver or binding?
> Same for other i2s


Remove in v2

>
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&i2s_2ch_0_sclk
>> +			     &i2s_2ch_0_lrck
>> +			     &i2s_2ch_0_sdi
>> +			     &i2s_2ch_0_sdo>;
>> +		status = "disabled";
>> +	};
>
>> +
>> +	mac: ethernet@ff4e0000 {
>> +		compatible = "rockchip,rk3308-mac";
> Was this support to the network driver already submitted?
> Because I wasn't able to find it in the gmac driver.


I remove mac in v2.

>
>> +		reg = <0x0 0xff4e0000 0x0 0x10000>;
>> +		rockchip,grf = <&grf>;
>> +		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-names = "macirq";
>> +		clocks = <&cru SCLK_MAC>, <&cru SCLK_MAC_RX_TX>,
>> +			 <&cru SCLK_MAC_RX_TX>, <&cru SCLK_MAC_REF>,
>> +			 <&cru SCLK_MAC>, <&cru ACLK_MAC>,
>> +			 <&cru PCLK_MAC>, <&cru SCLK_MAC_RMII>;
>> +		clock-names = "stmmaceth", "mac_clk_rx",
>> +			      "mac_clk_tx", "clk_mac_ref",
>> +			      "clk_mac_refout", "aclk_mac",
>> +			      "pclk_mac", "clk_mac_speed";
>> +		phy-mode = "rmii";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&rmii_pins &mac_refclk_12ma>;
>> +		resets = <&cru SRST_MAC_A>;
>> +		reset-names = "stmmaceth";
>> +		status = "disabled";
>> +	};
>
> Heiko
>
>
>
>


