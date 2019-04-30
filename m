Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE6CC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B4B2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfD3GIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 02:08:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58102 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725554AbfD3GIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 02:08:09 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0394B9A3133819C6DFC7;
        Tue, 30 Apr 2019 14:08:06 +0800 (CST)
Received: from [127.0.0.1] (10.142.63.192) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 30 Apr 2019
 14:07:57 +0800
CC:     <liuyu712@hisilicon.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.stultz@linaro.org>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <wanghu17@hisilicon.com>,
        <butao@hisilicon.com>, <chenyao11@huawei.com>,
        <fangshengzhou@hisilicon.com>, <lipengcheng8@huawei.com>,
        <songxiaowei@hisilicon.com>, <xuyiping@hisilicon.com>,
        <xuyoujun4@huawei.com>, <yudongbin@hisilicon.com>,
        <zangleigang@hisilicon.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v6 02/13] dt-bindings: misc: Add bindings for HiSilicon
 usb hub and data role switch functionality on HiKey960
To:     Rob Herring <robh@kernel.org>
References: <20190420064019.57522-1-chenyu56@huawei.com>
 <20190420064019.57522-3-chenyu56@huawei.com> <20190425213532.GA32028@bogus>
From:   Chen Yu <chenyu56@huawei.com>
Message-ID: <f925304a-17ef-1574-b671-77d4ad0331d8@huawei.com>
Date:   Tue, 30 Apr 2019 14:07:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190425213532.GA32028@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.63.192]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2019/4/26 5:35, Rob Herring wrote:
> On Sat, Apr 20, 2019 at 02:40:08PM +0800, Yu Chen wrote:
>> This patch adds binding documentation to support usb hub and usb
>> data role switch of Hisilicon HiKey960 Board.
> 
> Sorry I've been slow to really review this, but I needed to look at the 
> schematics to see what exactly is going on here.
> 
> I think this needs some changes to better reflect the h/w and utilize 
> existing bindings. It should really be designed ignoring the muxing to 
> start with. Define the binding for the TypeC connector and then the host 
> hub and make sure they can coexist. Then overlay what you need to switch 
> between the 2 modes which AFAICT is just a single GPIO. 
> 
>>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Binghui Wang <wangbinghui@hisilicon.com>
>> Signed-off-by: Yu Chen <chenyu56@huawei.com>
>> ---
>> v1:
>> * Fix some format errors as suggested by Sergei.
>> * Modify gpio description to use gpiod API.
>> v2:
>> * Remove information about Hikey.
>> * Fix gpio description.
>> * Remove device_type of endpoint.
>> v3:
>> * Remove property typec-vbus-enable-val.
>> * Add description of pinctrl-names.
>> * Add example for "hisilicon,gpio-hubv1"
>> * Add flag in gpiod properties.
>> ---
>> ---
>>  .../bindings/misc/hisilicon-hikey-usb.txt          | 52 ++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
>>
>> diff --git a/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
>> new file mode 100644
>> index 000000000000..422e844df719
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
>> @@ -0,0 +1,52 @@
>> +Support usb hub and usb data role switch of Hisilicon HiKey960 Board.
>> +
>> +-----------------------------
>> +
>> +Required properties:
>> +- compatible: "hisilicon,gpio-hubv1","hisilicon,hikey960-usb"
>> +- typec-vbus-gpios: gpio to control the vbus of typeC port
> 
> This should be a gpio regulator and then connected to 'vbus-supply' in a 
> usb-connector node (see .../bindings/connectors/usb-connector.txt). 
Currently usb-connector node has no "vbus-supply" property and
I do not find process that handles vbus-supply in RT1711H TypeC driver.

> 
> Then you also need the RT1711HWSC TypeC controller in DT. That is 
> typically the parent device of the connector node. 
> 
>> +- otg-switch-gpios: gpio to switch DP & DM between the hub and typeC port
> 
> This probably belongs in USB controller node.
> 
The otg-switch-gpios controls a mux like fsusb30mux. It is related to
the board design of HiKey960. And the state of the mux is decided by
the typeC port state. So I think it is not so good to make it belongs
in USB controller node.

>> +- hub-vdd33-en-gpios: gpio to enable the power of hub
> 
> This too should be a gpio regulator and then in a hub node. We have 2 
> ways to represent hubs. Either as an I2C device or as a child of the 
> host controller. The latter is preferred, but I'm not too sure how the 
> OF graph connection linking the controller to the TypeC connector will 
> work with the usb bus binding.
> 
There is no particular code except the power control for the hub.
The i2c on the hub is not used. So it can not be an I2C device.
Is there such an example that make the hub as a child of the host controller
and control its power?

>> +- pinctrl-names: pin configuration state name ("default")
>> +- pinctrl-0: pinctrl config
>> +
>> +Example
>> +-----
>> +
>> +	hisi_hikey_usb: hisi_hikey_usb {
>> +		compatible = "hisilicon,hikey960-usb";
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
>> +	hisi_hikey_usb: hisi_hikey_usb {
> 
> Perhaps doesn't matter with my above feedback, but I don't understand 
> the point of this 2nd example.
> 
OK. I will remove it.
>> +		compatible = "hisilicon,gpio-hubv1";
>> +		typec-vbus-gpios = <&gpio25 2 GPIO_ACTIVE_LOW>;
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
>> -- 
>> 2.15.0-rc2
>>
> 
> .
> 

Thanks
- Yu Chen

