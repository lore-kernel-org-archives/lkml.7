Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFABC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D6E22CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfIDJrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:47:25 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:47229 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725840AbfIDJrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:47:25 -0400
X-UUID: 20d97f0ab7ab4b9487fb870f7a985cba-20190904
X-UUID: 20d97f0ab7ab4b9487fb870f7a985cba-20190904
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 782800987; Wed, 04 Sep 2019 17:47:18 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 Sep
 2019 17:47:15 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Sep 2019 17:47:15 +0800
Message-ID: <1567590435.7317.55.camel@mhfsdcap03>
Subject: Re: [Patch V8 6/8] arm64: tegra: Enable xudc on Jetson TX1
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date:   Wed, 4 Sep 2019 17:47:15 +0800
In-Reply-To: <1567585440-13751-7-git-send-email-nkristam@nvidia.com>
References: <1567585440-13751-1-git-send-email-nkristam@nvidia.com>
         <1567585440-13751-7-git-send-email-nkristam@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: D87928C5A73737F4FDAFFCF7D19F9B4E08A5B9C99695FB703669287E41A94F292000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-04 at 13:53 +0530, Nagarjuna Kristam wrote:
> Enable XUSB device mode driver for USB0 slot on Jetson TX1.
> 
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> Reviewed-by: JC Kuo <jckuo@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi | 31 +++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
> index a7dc319..6aba1ba 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
> @@ -1362,7 +1362,7 @@
>  				status = "okay";
>  
>  				lanes {
> -					usb2-0 {
> +					micro_b: usb2-0 {
>  						nvidia,function = "xusb";
>  						status = "okay";
>  					};
> @@ -1483,6 +1483,21 @@
>  		vmmc-supply = <&vdd_3v3_sd>;
>  	};
>  
> +	usb@700d0000 {
> +		status = "okay";
> +		phys = <&micro_b>;
> +		phy-names = "usb2";
> +		avddio-usb-supply = <&vdd_3v3_sys>;
> +		hvdd-usb-supply = <&vdd_1v8>;
> +		usb-role-switch;
> +
> +		port {
> +			usb_role_switch: endpoint {
> +				remote-endpoint = <&usb_b_conn_ep>;
> +			};
> +		};
> +	};
> +
>  	regulators {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> @@ -1641,4 +1656,18 @@
>  			linux,code = <KEY_VOLUMEUP>;
>  		};
>  	};
> +
> +	usb_type_b: connector {
> +		compatible = "linux,usb-conn-gpio", "gpio-usb-b-connector";
please use "gpio-usb-b-connector" and "usb-b-connector", due to
"linux,usb-conn-gpio" is not supported now


> +		label = "micro-USB";
> +		type = "micro";
> +		vbus-gpio = <&gpio TEGRA_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
> +
> +		port {
> +			usb_b_conn_ep: endpoint {
> +				remote-endpoint = <&usb_role_switch>;
> +			};
> +		};
> +	};
> +
>  };


