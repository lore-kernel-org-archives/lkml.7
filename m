Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D068CC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4DB2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfFMRUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:20:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55188 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfFMRUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 13:20:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E7AB52838FC
Subject: Re: [PATCH] arm64: dts: rockchip: Update DWC3 modules on RK3399 SoCs
To:     Robin Murphy <robin.murphy@arm.com>, devicetree@vger.kernel.org
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
 <40d2260f-3925-acdc-eb02-8abb972f1056@arm.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <a685fef9-8f45-700c-17d6-59d792fca092@collabora.com>
Date:   Thu, 13 Jun 2019 19:20:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <40d2260f-3925-acdc-eb02-8abb972f1056@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 13/6/19 18:56, Robin Murphy wrote:
> On 13/06/2019 17:27, Enric Balletbo i Serra wrote:
>> As per binding documentation [1], the DWC3 core should have the "ref",
>> "bus_early" and "suspend" clocks. As explained in the binding, those
>> clocks are required for new platforms but not for existing platforms
>> before commit fe8abf332b8f ("usb: dwc3: support clocks and resets for
>> DWC3 core").
>>
>> However, as those clocks are really treated as required, this ends with
>> having some annoying messages when the "rockchip,rk3399-dwc3" is used:
>>
>> [    1.724107] dwc3 fe800000.dwc3: Failed to get clk 'ref': -2
>> [    1.731893] dwc3 fe900000.dwc3: Failed to get clk 'ref': -2
>> [    2.495937] dwc3 fe800000.dwc3: Failed to get clk 'ref': -2
>> [    2.647239] dwc3 fe900000.dwc3: Failed to get clk 'ref': -2
>>
>> In order to remove those annoying messages, update the DWC3 hardware
>> module node and add all the required clocks. With this change, both, the
>> glue node and the DWC3 core node, have the clocks defined, but that's
>> not really a problem and there isn't a side effect on do this. So, we
>> can get rid of the annoying get clk error messages.
> 
> Can we not just move these clocks entirely from the glue layer to the core
> layer? That didn't seem to break when I tried it, although I'll admit my
> 'testing' was no more than booting and mounting a USB 3.0 flash drive, no
> suspend or anything fancy.
> 

AFAICT usb doesn't break, but we won't break backward compability then? (/me
still doesn't know when backward compability is really important or not)

> My own attempt to shut up these errors got sidetracked into c0c61471ef86 ("usb:
> dwc3: of-simple: Convert to bulk clk API"), then apparently stalled :)
> 

There was any off the record discussion and stalled or simply you didn't get
feedback?

I'll take a look.

Thanks,
~ Enric

> Robin.
> 
>>
>> [1] Documentation/devicetree/bindings/usb/dwc3.txt
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> index 196ac9b78076..a15348d185ce 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -414,6 +414,9 @@
>>               compatible = "snps,dwc3";
>>               reg = <0x0 0xfe800000 0x0 0x100000>;
>>               interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&cru SCLK_USB3OTG0_REF>, <&cru ACLK_USB3OTG0>,
>> +                 <&cru SCLK_USB3OTG0_SUSPEND>;
>> +            clock-names = "ref", "bus_early", "suspend";
>>               dr_mode = "otg";
>>               phys = <&u2phy0_otg>, <&tcphy0_usb3>;
>>               phy-names = "usb2-phy", "usb3-phy";
>> @@ -447,6 +450,9 @@
>>               compatible = "snps,dwc3";
>>               reg = <0x0 0xfe900000 0x0 0x100000>;
>>               interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>;
>> +            clocks = <&cru SCLK_USB3OTG1_REF>, <&cru ACLK_USB3OTG1>,
>> +                 <&cru SCLK_USB3OTG1_SUSPEND>;
>> +            clock-names = "ref", "bus_early", "suspend";
>>               dr_mode = "otg";
>>               phys = <&u2phy1_otg>, <&tcphy1_usb3>;
>>               phy-names = "usb2-phy", "usb3-phy";
>>
