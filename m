Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866C8C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FD220989
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 07:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfDFHYx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 03:24:53 -0400
Received: from hermes.aosc.io ([199.195.250.187]:56795 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfDFHYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 03:24:52 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 9436AA5E0F;
        Sat,  6 Apr 2019 07:24:45 +0000 (UTC)
Date:   Sat, 06 Apr 2019 15:24:14 +0800
In-Reply-To: <20190406071402.GA6006@bogus>
References: <20190405205736.55177-1-icenowy@aosc.io> <20190405205736.55177-3-icenowy@aosc.io> <20190406071402.GA6006@bogus>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v5 2/5] dt-bindings: phy: add binding for Allwinner USB3 PHY
To:     linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
CC:     devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chen-Yu Tsai <wens@csie.org>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <B954438A-73B2-4156-81CD-197C08D0E3F5@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2019年4月6日 GMT+08:00 下午3:14:02, Rob Herring <robh@kernel.org> 写到:
>On Sat, Apr 06, 2019 at 04:57:33AM +0800, Icenowy Zheng wrote:
>> The new Allwinner H6 SoC contains a USB3 PHY that is wired to the
>> external USB3 pins of the SoC.
>> 
>> Add a device tree binding for the PHY.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>> Changes in v5:
>> - Dropped Vbus regulator and added connector subnode.
>> 
>> Changes in v4:
>> - Changed Vbus regulator property to vbus-supply.
>> 
>> Changes in v3:
>> - Added Chen-Yu's Review tag.
>> 
>> No changes in v2, v1.
>> 
>>  .../bindings/phy/sun50i-usb3-phy.txt          | 28
>+++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>  create mode 100644
>Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
>> 
>> diff --git
>a/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
>b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
>> new file mode 100644
>> index 000000000000..eeedc53e6360
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
>> @@ -0,0 +1,28 @@
>> +Allwinner sun50i USB3 PHY
>> +-----------------------
>> +
>> +Required properties:
>> +- compatible : should be one of
>> +  * allwinner,sun60i-h6-usb3-phy
>> +- reg : a list of offset + length pairs
>> +- #phy-cells : from the generic phy bindings, must be 0
>> +- clocks : phandle + clock specifier for the phy clock
>> +- resets : phandle + reset specifier for the phy reset
>> +
>> +Optional nodes:
>> +- connector : A sub-node required for representing the connector
>connected
>> +	      to the USB PHY. See ../connector/usb-connector.txt for
>details.
>> +
>> +Example:
>> +	usb3phy: phy@5210000 {
>> +		compatible = "allwinner,sun50i-h6-usb3-phy";
>> +		reg = <0x5210000 0x10000>;
>> +		clocks = <&ccu CLK_USB_PHY1>;
>> +		resets = <&ccu RST_USB_PHY1>;
>> +		#phy-cells = <0>;
>> +
>> +		connector {
>> +			compatible = "usb-a-connector";
>> +			label = "USB3";
>
>The binding defines that a connector is a child of USB controller or 

Please note that the word used is not "USB controller", but "USB interface
controller".

A USB controller is something that deal with USB protocol, and connect to a USB
PHY with ULPI/UTMI/PIPE interface. It's not connected to the connector
directly at all. Then the PHY is connected to the interface controller (if present), or
the connector, with D+, D- and SS pins.

>some port controller (such as USB-C ctrlr) with OF graph to USB 
>controller. So either way, this is wrong unless this is more than just
>a 
>phy.
>
>Rob
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
使用 K-9 Mail 发送自我的Android设备。
