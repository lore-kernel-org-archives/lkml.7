Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EB2C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE9520675
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556228136;
	bh=pyn+pstkXrYnKrxdU29+PbKwd1AyoPZdSjAOHtomPd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H/u2e/x/Jcj7sPhWMmO8LV49N2CveS11zZaXPcJIJ4MPhQUR59zvKg8Zgg83SzeD+
	 1sJSovMk7b6KM5eVUCpsrqcn0hxB2Ld+JGmVzU4MZJ6HVfd6mwVyNV4FCqSNou2ZLy
	 4UAr/X5rRn8Dl7s3eI5Z+KQwC39sKmnWMxgH13Ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbfDYVff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:35:35 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44075 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfDYVff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:35:35 -0400
Received: by mail-oi1-f193.google.com with SMTP id l7so1263877oil.11;
        Thu, 25 Apr 2019 14:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=83boPgIPT34libWzNARLDjvIg1pZbDlCd/DXPurJI3U=;
        b=k7v4ZCOcUCx4pGTQQ0t4sTN5CIEmcJ0ux0Pw/65aiLB8/QX+3CgLkdGaTiJNbajK8z
         ba6YddbFHP9lA2jJM0NXdunt7g7t+NTojPyd1ZgZLBGKYeMo07p7l2zRXrb9aZ7iT0FS
         bFXLapW4eLAGNG1KoDYdTnLF8lJx6yjJwnElD0CdnTyd4SR9CUzz9wV+PbeOaAYOZde/
         cQipPb7zkkB6uc4Qh1EjQ0wVnzQrG3QyDW/D/fSf4IXa3+vu68bku4S6XsMJtrf0Axyz
         EreSVNlBHLMfaqdbJnobpJAnt7RMMbIUwhCihwSKChyevoAapwoQMq1/WgV/ExbJhtuw
         QmUw==
X-Gm-Message-State: APjAAAVtDvxVLxmHSWTYBUpSyc5+ffQw2JRq8b78yFApzlDQk1RfoANG
        /8al6oZ+uz8PUuW9vDHy7w==
X-Google-Smtp-Source: APXvYqzxVjMrIaO5KDrnlQVI/GkkTrKkJ2myqDXcrOOWAK3wwAMSbZEA2d7QicQ5QpjoOG33dV62zg==
X-Received: by 2002:aca:6086:: with SMTP id u128mr4453169oib.79.1556228133472;
        Thu, 25 Apr 2019 14:35:33 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p189sm733424oih.7.2019.04.25.14.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 14:35:32 -0700 (PDT)
Date:   Thu, 25 Apr 2019 16:35:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yu Chen <chenyu56@huawei.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        liuyu712@hisilicon.com, wanghu17@hisilicon.com,
        butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei@hisilicon.com, xuyiping@hisilicon.com,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        zangleigang@hisilicon.com, Kishon Vijay Abraham I <kishon@ti.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Subject: Re: [PATCH v6 02/13] dt-bindings: misc: Add bindings for HiSilicon
 usb hub and data role switch functionality on HiKey960
Message-ID: <20190425213532.GA32028@bogus>
References: <20190420064019.57522-1-chenyu56@huawei.com>
 <20190420064019.57522-3-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420064019.57522-3-chenyu56@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 02:40:08PM +0800, Yu Chen wrote:
> This patch adds binding documentation to support usb hub and usb
> data role switch of Hisilicon HiKey960 Board.

Sorry I've been slow to really review this, but I needed to look at the 
schematics to see what exactly is going on here.

I think this needs some changes to better reflect the h/w and utilize 
existing bindings. It should really be designed ignoring the muxing to 
start with. Define the binding for the TypeC connector and then the host 
hub and make sure they can coexist. Then overlay what you need to switch 
between the 2 modes which AFAICT is just a single GPIO. 

> 
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> ---
> v1:
> * Fix some format errors as suggested by Sergei.
> * Modify gpio description to use gpiod API.
> v2:
> * Remove information about Hikey.
> * Fix gpio description.
> * Remove device_type of endpoint.
> v3:
> * Remove property typec-vbus-enable-val.
> * Add description of pinctrl-names.
> * Add example for "hisilicon,gpio-hubv1"
> * Add flag in gpiod properties.
> ---
> ---
>  .../bindings/misc/hisilicon-hikey-usb.txt          | 52 ++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
> new file mode 100644
> index 000000000000..422e844df719
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
> @@ -0,0 +1,52 @@
> +Support usb hub and usb data role switch of Hisilicon HiKey960 Board.
> +
> +-----------------------------
> +
> +Required properties:
> +- compatible: "hisilicon,gpio-hubv1","hisilicon,hikey960-usb"
> +- typec-vbus-gpios: gpio to control the vbus of typeC port

This should be a gpio regulator and then connected to 'vbus-supply' in a 
usb-connector node (see .../bindings/connectors/usb-connector.txt). 

Then you also need the RT1711HWSC TypeC controller in DT. That is 
typically the parent device of the connector node. 

> +- otg-switch-gpios: gpio to switch DP & DM between the hub and typeC port

This probably belongs in USB controller node.

> +- hub-vdd33-en-gpios: gpio to enable the power of hub

This too should be a gpio regulator and then in a hub node. We have 2 
ways to represent hubs. Either as an I2C device or as a child of the 
host controller. The latter is preferred, but I'm not too sure how the 
OF graph connection linking the controller to the TypeC connector will 
work with the usb bus binding.

> +- pinctrl-names: pin configuration state name ("default")
> +- pinctrl-0: pinctrl config
> +
> +Example
> +-----
> +
> +	hisi_hikey_usb: hisi_hikey_usb {
> +		compatible = "hisilicon,hikey960-usb";
> +		typec-vbus-gpios = <&gpio25 2 GPIO_ACTIVE_HIGH>;
> +		otg-switch-gpios = <&gpio25 6 GPIO_ACTIVE_HIGH>;
> +		hub-vdd33-en-gpios = <&gpio5 6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usbhub5734_pmx_func>;
> +
> +		port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			hikey_usb_ep: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&dwc3_role_switch_notify>;
> +			};
> +		};
> +	};
> +
> +	hisi_hikey_usb: hisi_hikey_usb {

Perhaps doesn't matter with my above feedback, but I don't understand 
the point of this 2nd example.

> +		compatible = "hisilicon,gpio-hubv1";
> +		typec-vbus-gpios = <&gpio25 2 GPIO_ACTIVE_LOW>;
> +		otg-switch-gpios = <&gpio25 6 GPIO_ACTIVE_HIGH>;
> +		hub-vdd33-en-gpios = <&gpio5 6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usbhub5734_pmx_func>;
> +
> +		port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			hikey_usb_ep: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&dwc3_role_switch_notify>;
> +			};
> +		};
> +	};
> -- 
> 2.15.0-rc2
> 
