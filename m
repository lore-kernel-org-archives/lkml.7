Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F47C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8832080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfD3HQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:16:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7711 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725769AbfD3HQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 03:16:13 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C21A5762FFF8842A5C5D;
        Tue, 30 Apr 2019 15:16:10 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 30 Apr 2019
 15:15:59 +0800
CC:     "Liuyu (R)" <liuyu712@hisilicon.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.stultz@linaro.org>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <wanghu17@hisilicon.com>,
        <butao@hisilicon.com>, <chenyao11@huawei.com>,
        <fangshengzhou@hisilicon.com>, <lipengcheng8@huawei.com>,
        <songxiaowei@hisilicon.com>, <xuyiping@hisilicon.com>,
        <xuyoujun4@huawei.com>, <yudongbin@hisilicon.com>,
        <zangleigang@hisilicon.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        =?UTF-8?B?c2h1ZmFuX2xlZSjmnY7mm7jluIYp?= <shufan_lee@richtek.com>
Subject: Re: [PATCH v6 13/13] dts: hi3660: Add support for usb on Hikey960
To:     Rob Herring <robh@kernel.org>
References: <20190420064019.57522-1-chenyu56@huawei.com>
 <20190420064019.57522-14-chenyu56@huawei.com> <20190425220016.GC32028@bogus>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <6b5c219c-3941-5add-5e91-5efbd9b9d85c@huawei.com>
Date:   Tue, 30 Apr 2019 15:15:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190425220016.GC32028@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2019/4/26 6:00, Rob Herring wrote:
> On Sat, Apr 20, 2019 at 02:40:19PM +0800, Yu Chen wrote:
>> This patch adds support for usb on Hikey960.
>>
>> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
>> Cc: Wei Xu <xuwei5@hisilicon.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Binghui Wang <wangbinghui@hisilicon.com>
>> Signed-off-by: Yu Chen <chenyu56@huawei.com>
>> ---
>> v2:
>> * Remove device_type property.
>> * Add property "usb-role-switch".
>> v3:
>> * Make node "usb_phy" a subnode of usb3_otg_bc register.
>> * Remove property "typec-vbus-enable-val" of hisi_hikey_usb.
>> v4:
>> * Remove property "hisilicon,usb3-otg-bc-syscon" of usb-phy.
>> ---
>> ---
>>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 53 ++++++++++++++++
>>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 73 +++++++++++++++++++++++
>>  2 files changed, 126 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
>> index e035cf195b19..d4e11c56b250 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
>> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
>> @@ -13,6 +13,7 @@
>>  #include <dt-bindings/gpio/gpio.h>
>>  #include <dt-bindings/input/input.h>
>>  #include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/usb/pd.h>
>>  
>>  / {
>>  	model = "HiKey960";
>> @@ -196,6 +197,26 @@
>>  			method = "smc";
>>  		};
>>  	};
>> +
>> +	hisi_hikey_usb: hisi_hikey_usb {
>> +		compatible = "hisilicon,hikey960_usb";
>> +		typec-vbus-gpios = <&gpio25 2 GPIO_ACTIVE_HIGH>;
>> +		otg-switch-gpios = <&gpio25 6 GPIO_ACTIVE_HIGH>;
>> +		hub-vdd33-en-gpios = <&gpio5 6 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&usbhub5734_pmx_func>;
>> +
>> +		port {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			hikey_usb_ep: endpoint@0 {
>> +				reg = <0>;
>> +				remote-endpoint = <&dwc3_role_switch_notify>;
>> +			};
>> +		};
>> +	};
>> +
>>  };
>>  
>>  /*
>> @@ -526,6 +547,38 @@
>>  &i2c1 {
>>  	status = "okay";
>>  
>> +	rt1711h: rt1711h@4e {
>> +		compatible = "richtek,rt1711h";
> 
> The binding doc for this should state it should have a 'connector' node.
> 
Hi shufan,
Is the 'connector' node an essential node of rt1711h?
Currently it is missing in Documentation/devicetree/bindings/usb/richtek,rt1711h.txt.
Do you think the 'connector' node should add as this patch in the binding doc?

>> +		reg = <0x4e>;
>> +		status = "ok";
> 
> Can drop this, it is the default.
> 
OK.

>> +		interrupt-parent = <&gpio27>;
>> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&usb_cfg_func>;
>> +
>> +		usb_con: connector {
>> +			compatible = "usb-c-connector";
>> +			label = "USB-C";
>> +			data-role = "dual";
>> +			power-role = "dual";
>> +			try-power-role = "sink";
>> +			source-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)>;
>> +			sink-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)
>> +				PDO_VAR(5000, 5000, 1000)>;
>> +			op-sink-microwatt = <10000000>;
>> +		};
>> +
>> +		port {
> 
> The connector node should have a 'ports' child with 'port@0' being the 
> HS connection.
> 
This port and endpoint of the port are used for role_switch matching by
fwnode_graph_devcon_match. I'm not too sure the 'ports' under connector is used in
rt1711h driver？
Hi shufan_lee,
    Can you confirm this?

>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			rt1711h_ep: endpoint@0 {
>> +				reg = <0>;
>> +				remote-endpoint = <&dwc3_role_switch>;
>> +			};
>> +		};
>> +	};
>> +
>>  	adv7533: adv7533@39 {
>>  		status = "ok";
>>  		compatible = "adi,adv7533";
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> index 2f19e0e5b7cf..173467505ada 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
>> @@ -355,6 +355,12 @@
>>  			#clock-cells = <1>;
>>  		};
>>  
>> +		pmctrl: pmctrl@fff31000 {
>> +			compatible = "hisilicon,hi3660-pmctrl", "syscon";
>> +			reg = <0x0 0xfff31000 0x0 0x1000>;
>> +			#clock-cells = <1>;
>> +		};
>> +
>>  		pmuctrl: crg_ctrl@fff34000 {
>>  			compatible = "hisilicon,hi3660-pmuctrl", "syscon";
>>  			reg = <0x0 0xfff34000 0x0 0x1000>;
>> @@ -1134,5 +1140,72 @@
>>  				};
>>  			};
>>  		};
>> +
>> +		usb3_otg_bc: usb3_otg_bc@ff200000 {
>> +			compatible = "syscon", "simple-mfd";
>> +			reg = <0x0 0xff200000 0x0 0x1000>;
>> +
>> +			usb_phy: usb-phy {
>> +				compatible = "hisilicon,hi3660-usb-phy";
>> +				#phy-cells = <0>;
>> +				hisilicon,pericrg-syscon = <&crg_ctrl>;
>> +				hisilicon,pctrl-syscon = <&pctrl>;
>> +				hisilicon,eye-diagram-param = <0x22466e4>;
>> +			};
>> +		};
>> +
>> +		usb3: hisi_dwc3 {
>> +			compatible = "hisilicon,hi3660-dwc3";
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
> 
> If there are not any wrapper registers, then get rid of the hisi_dwc3 
> node. For just clocks and resets we just put everything in one node.
> 
I will try to fix this.
>> +
>> +			clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
>> +				 <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
>> +			clock-names = "clk_usb3phy_ref", "aclk_usb3otg";
>> +
>> +			assigned-clocks = <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
>> +			assigned-clock-rates = <229000000>;
>> +			resets = <&crg_rst 0x90 8>,
>> +				 <&crg_rst 0x90 7>,
>> +				 <&crg_rst 0x90 6>,
>> +				 <&crg_rst 0x90 5>;
>> +
>> +			dwc3: dwc3@ff100000 {
>> +				compatible = "snps,dwc3";
>> +				reg = <0x0 0xff100000 0x0 0x100000>;
>> +				interrupts = <0 159 4>, <0 161 4>;
>> +				phys = <&usb_phy>;
>> +				phy-names = "usb3-phy";
>> +				dr_mode = "otg";
>> +				maximum-speed = "super-speed";
>> +				phy_type = "utmi";
>> +				snps,dis-del-phy-power-chg-quirk;
> 
>> +				snps,lfps_filter_quirk;
>> +				snps,dis_u2_susphy_quirk;
>> +				snps,dis_u3_susphy_quirk;
>> +				snps,tx_de_emphasis_quirk;
>> +				snps,tx_de_emphasis = <1>;
>> +				snps,dis_enblslpm_quirk;
> 
> Pretty sure these aren't documented because we don't use '_' in property 
> names.
> 
Do you mean property as "snps,dis_enblslpm_quirk"? These properties are
documented in Documentation/devicetree/bindings/usb/dwc3.txt.

>> +				snps,gctl-reset-quirk;
>> +				usb-role-switch;
>> +				role-switch-default-host;
>> +
>> +				port {
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					dwc3_role_switch: endpoint@0 {
>> +						reg = <0>;
>> +						remote-endpoint = <&rt1711h_ep>;
>> +					};
>> +
>> +					dwc3_role_switch_notify: endpoint@1 {
>> +						reg = <1>;
>> +						remote-endpoint = <&hikey_usb_ep>;
>> +					};
>> +				};
>> +			};
>> +		};
>>  	};
>>  };
>> -- 
>> 2.15.0-rc2
>>
> 
> .
> 

Thanks
- Yu Chen

