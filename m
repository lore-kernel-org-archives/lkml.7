Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764C4C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A00D214AE
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556311542;
	bh=x2XdKAd1H93NAjKt4Tl9HnwFXNFxfU+kgGfTEV6HCSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oyE1UkIYz4CWFPj5ejldzt5qJLagBRgh1Qf5qGYvsdpLYjg/kAL7qeI0JwLuJzITw
	 RN/VgXpkbyOyFG9tM8EgcL+ALijBqsfgVupzw68QNK9wi7+mX57FnrnQ2xFRh5pWR6
	 8vMT/FZAkFnDaTn/h83urejSGDEcT7ZH5jZ+mfnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfDZUpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:45:40 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40180 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfDZUpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:45:40 -0400
Received: by mail-oi1-f196.google.com with SMTP id k10so3991220oik.7;
        Fri, 26 Apr 2019 13:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LBK1qQiinkVtppuUn/MtZMeDjsphed7rjwWQBzqodsA=;
        b=bYnSbOcrh/k/NazPWGZyO4X70BcpqESvk4V/dhcETCFfqMBweTWbNLxpWM1bBpCF83
         1gsZHO4GuveK62LV/OzJfQX/sWiWyjHJxLmtVWZIdLsNJ2SxXxc1seQeovZTHRddhptn
         qJoppeuiG+09wqGTX2IlCfuhZxGJM5ku8MEolnpMkVXMBN7WskaM/Kk3yAApoDFJpmWV
         dleCCxEDK1MhyKhv7gJ5A08BjHWyOyjGdwkoPUM1WPBbosh1OzcbDt8+NAQq5744VCbg
         E67GYKPw96EttRPUG2c0xfcpK7kbg5/LgueOk8cYq/9GOXyYmHEOUDCWoIx1hOkiFZf3
         ICRA==
X-Gm-Message-State: APjAAAVfQknz33TFcrs0rXIbFBVPwy2GBighvhFlplxPKbyUDbU3KtzB
        PscJsrudr2hsgcWdQRs/BA==
X-Google-Smtp-Source: APXvYqwawrECtPMKTCABj3IlM0ZD7s9DWDSE3GhnWkMdq0k8EUUCPGoxJ5SO8c8xOA/qIxjgtMhKvA==
X-Received: by 2002:aca:d9c4:: with SMTP id q187mr8377682oig.91.1556311539434;
        Fri, 26 Apr 2019 13:45:39 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f5sm1249855otp.16.2019.04.26.13.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 13:45:38 -0700 (PDT)
Date:   Fri, 26 Apr 2019 15:45:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 2/6] dt-bindings: usb: add binding for Type-B GPIO
 connector driver
Message-ID: <20190426204537.GA15074@bogus>
References: <1556261237-13823-1-git-send-email-chunfeng.yun@mediatek.com>
 <1556261237-13823-3-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556261237-13823-3-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 02:47:13PM +0800, Chunfeng Yun wrote:
> It's used to support dual role switch via GPIO when use Type-B
> receptacle, typically the USB ID pin is connected to an input
> GPIO pin
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v4 no changes
> 
> v3 changes:
>  1. treat type-B connector as a virtual device, but not child device of
>     USB controller's
> 
> v2 changes:
>   1. new patch to make binding clear suggested by Hans
> ---
>  .../bindings/usb/typeb-conn-gpio.txt          | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt b/Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt
> new file mode 100644
> index 000000000000..d2e1c4e01b6d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt
> @@ -0,0 +1,49 @@
> +USB Type-B GPIO Connector
> +
> +This is a virtual device used to switch dual role mode from the USB ID pin
> +connected to an input GPIO pin.
> +
> +Required properties:
> +- compatible : Should be "linux,typeb-conn-gpio"

There's no need for this virtual node. The USB host or device driver can 
instantiate a connector driver by walking the OF graph to the connector 
and creating a device.

> +
> +Sub-nodes:
> +- connector : should be present.
> +	- compatible : should be "usb-b-connector".
> +	- id-gpios, vbus-gpios : either one of them must be present,
> +		and both can be present as well.
> +	- vbus-supply : can be present if needed when supports dual role mode.
> +	see connector/usb-connector.txt
> +
> +- port : should be present.
> +	see graph.txt
> +
> +Example:
> +
> +rsw_iddig: role_sw_iddig {
> +	compatible = "linux,typeb-conn-gpio";
> +	status = "okay";
> +
> +	connector {
> +		compatible = "usb-b-connector";
> +		label = "micro-USB";
> +		type = "micro";
> +		id-gpios = <&pio 12 GPIO_ACTIVE_HIGH>;
> +		vbus-supply = <&usb_p0_vbus>;
> +	};
> +
> +	port {

Humm, same mistake as Hikey patches...

This goes under the connector node as defined in the connector binding.

> +		bconn_ep: endpoint@0 {
> +			remote-endpoint = <&usb_role_sw>;
> +		};
> +	};
> +};
> +
> +&mtu3 {
> +	status = "okay";
> +
> +	port {
> +		usb_role_sw: endpoint@0 {
> +			remote-endpoint = <&bconn_ep>;
> +		};
> +	};
> +};
> -- 
> 2.21.0
> 
