Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD039C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A401E21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfCOHxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:53:06 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:26469 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727557AbfCOHxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:53:06 -0400
X-UUID: 74200d71c15b4ddb9fc49abef31b0c0a-20190315
X-UUID: 74200d71c15b4ddb9fc49abef31b0c0a-20190315
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1407047240; Fri, 15 Mar 2019 15:52:56 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 15 Mar
 2019 15:52:55 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 15 Mar 2019 15:52:54 +0800
Message-ID: <1552636374.10179.121.camel@mhfsdcap03>
Subject: Re: [PATCH v2 2/6] dt-bindings: usb: add binding for Type-B dual
 role switch by GPIO
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        "Badhri Jagan Sridharan" <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 15 Mar 2019 15:52:54 +0800
In-Reply-To: <1552635513-2378-3-git-send-email-chunfeng.yun@mediatek.com>
References: <1552635513-2378-1-git-send-email-chunfeng.yun@mediatek.com>
         <1552635513-2378-3-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

There are two ways that I think out to support type-B GPIO based dual
role switch.

The first one, as the series used:

&mtu3 {
    status = "okay";

    connector@0 {
        compatible = "usb-b-connector", "linux,typeb-switch-gpio";
        label = "micro-USB";
        type = "micro";
        id-gpio = <&pio 12 GPIO_ACTIVE_HIGH>;
        vbus-supply = <&usb_p0_vbus>;
    };
};

but there are some shortcomings:
1. It's not transparent, USB controller driver should be modified, and
call of_platform_populate() to create platform device for connector,
this is not friendly when the controller driver hasn't child node
before, and also not compatible with other cases, such as Type-C

2. It doesn't keep format consistent with the case using Type-C, or
using PMIC to detect ID pin.

3. vbus-supply will be got by USB controller driver if it aready
supports it


another way as following:

role_sw_iddig {
    compatible = "linux,typeb-switch-gpio";
    status = "okay";

    connector {
        compatible = "usb-b-connector";
        label = "micro-USB";
        type = "micro";
        id-gpios = <&pio 12 GPIO_ACTIVE_HIGH>;
        vbus-supply = <&usb_p0_vbus>;
    };

    port {
        bsw_ep: endpoint@0 {
            remote-endpoint = <&usb_role_sw>;
        };
    };
};

&mtu3 {
    status = "okay";

    port {
        usb_role_sw: endpoint@0 {
            remote-endpoint = <&bsw_ep>;
        };
    };
};

strength:
avoid the shortcomings of the first way
shortcoming:
it's a virtual device and seems not following graph.txt binding,

Do you have any suggestion?

Thanks


On Fri, 2019-03-15 at 15:38 +0800, Chunfeng Yun wrote:
> It's used to support dual role switch via GPIO when use Type-B
> receptacle
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2 changes:
>   1. new patch to make binding clear suggested by Hans
> ---
>  .../bindings/usb/typeb-switch-gpio.txt        | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/typeb-switch-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/typeb-switch-gpio.txt b/Documentation/devicetree/bindings/usb/typeb-switch-gpio.txt
> new file mode 100644
> index 000000000000..d46d83bc6500
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/typeb-switch-gpio.txt
> @@ -0,0 +1,26 @@
> +USB Type-B dual role switch via a GPIO
> +
> +This is a virtual device used to switch dual role mode from the USB ID pin
> +connected to a GPIO pin.
> +
> +Required properties:
> +- compatible: Should be "linux,typeb-switch-gpio"
> +
> +Either one of id-gpios or vbus-gpios must be present, and both can be present
> +as well.
> +vbus-supply could be present if needed when support dual role mode.
> +	see connector/usb-connector.txt
> +
> +Example:
> +
> +&mtu3 {
> +	status = "okay";
> +
> +	connector@0 {
> +		compatible = "usb-b-connector", "linux,typeb-switch-gpio";
> +		label = "micro-USB";
> +		type = "micro";
> +		id-gpio = <&pio 12 GPIO_ACTIVE_HIGH>;
> +		vbus-supply = <&usb_p0_vbus>;
> +	};
> +};


