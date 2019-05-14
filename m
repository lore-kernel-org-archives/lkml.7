Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAB2C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0324420850
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557857545;
	bh=1u+0RIP502cOVMKpSszyvWip+tJgxs7ndfhRdjVwHHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BOErzMeLADmT97LlhWGpctE2pqWWPo+nnC9hxrG7euSRZksQm1EGrJnObSwq3KszN
	 tcyi8Q7aVAjNAPFZEZRysD4/lmpdLYiQsI1aY18POs+InsfJ2E8lIGDpH/FBhINvyO
	 B8EcDTp0OERK9FWGLbZzxGZ8Ryh5mXNO2AyI3ZOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfENSMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:12:24 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35891 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfENSMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:12:24 -0400
Received: by mail-oi1-f195.google.com with SMTP id l203so12878795oia.3;
        Tue, 14 May 2019 11:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7MKXOx72GnJK4OThTbg/Yq9n8A27D1pwO48w3mZxGik=;
        b=TfDtCCNmcVJ7WXWPI4ZxFdlwO0Mhu9x3wjKHn1IdQCdY9mHw24ZvvuEItFjyHyZpu2
         VVaz36e+vJPBfZPmbsEm41Coi/JjA4va/p9o0kvrggHc2zBWGDWLX/HBSSPbeqVTEGDU
         mmMoH/38v1RUoxJGrxyn7NPQKxi+XI6brkd5mAVEiudZ6sx/eplCH0Uf5wFpUPHxv1bx
         0hk6ZGy5qnlOI19/ytIrXV3KXZfKZQxz62xmm+92AAPdqeizcpWBMw39O6+iGuHjYqbf
         jo5CP/qANtYYfvhexUdugkb9gbz68cThPWwAvxcQuEDgJ9O0HwqtCxFtu9cRngMYQIEY
         ERgw==
X-Gm-Message-State: APjAAAUOd5gcSGnSDvtXoXis3wg37CD0iZXveg3378RV4K81JXWuIj8M
        eFNwkcTNwxB2d8YJL7Tiww==
X-Google-Smtp-Source: APXvYqy19Xjq9sGP3TMfrsYa+PbNh1BafjhPi5bE6IL4JiP7WIz0dF4SnI69FmgshwGuUtHZQI4Byg==
X-Received: by 2002:aca:5d86:: with SMTP id r128mr3690918oib.135.1557857542852;
        Tue, 14 May 2019 11:12:22 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q25sm6355192otl.60.2019.05.14.11.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 11:12:22 -0700 (PDT)
Date:   Tue, 14 May 2019 13:12:04 -0500
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
Subject: Re: [PATCH v5 2/6] dt-bindings: usb: add binding for Type-B GPIO
 connector driver
Message-ID: <20190514181204.GA13949@bogus>
References: <1557823643-8616-1-git-send-email-chunfeng.yun@mediatek.com>
 <1557823643-8616-3-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557823643-8616-3-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 04:47:19PM +0800, Chunfeng Yun wrote:
> It's used to support dual role switch via GPIO when use Type-B
> receptacle, typically the USB ID pin is connected to an input
> GPIO pin
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v5 changes:
>  1. treat type-B connector as child device of USB controller's, but not
>     as a separate virtual device, suggested by Rob
>  2. put connector's port node under connector node, suggested by Rob
> 
> v4 no changes
> 
> v3 changes:
>  1. treat type-B connector as a virtual device, but not child device of
>     USB controller's
> 
> v2 changes:
>   1. new patch to make binding clear suggested by Hans
> ---
>  .../bindings/usb/typeb-conn-gpio.txt          | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt b/Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt
> new file mode 100644
> index 000000000000..20dd3499a348
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/typeb-conn-gpio.txt
> @@ -0,0 +1,42 @@
> +USB Type-B GPIO Connector
> +
> +This is used to switch dual role mode from the USB ID pin connected to
> +an input GPIO pin.
> +
> +Required properties:
> +- compatible : should include "linux,typeb-conn-gpio" and "usb-b-connector".

I don't think we need "linux,typeb-conn-gpio". A driver can decide to 
handle GPIO lines if they present or we assume the parent device handles 
ID and/or Vbus if they are not present.

> +- id-gpios, vbus-gpios : either one of them must be present, and both
> +	can be present as well.

Please clarify that vbus-gpios is an input to sense Vbus presence as an 
output it should be modelled as a regulator only.

These should be added to usb-connector.txt.

The result of all this is you don't need this file. Just additions to 
usb-connector.txt.

> +- vbus-supply : can be present if needed when supports dual role mode or
> +	host mode.
> +	see connector/usb-connector.txt
> +
> +Sub-nodes:
> +- port : should be present.
> +	see graph.txt
> +
> +Example:
> +
> +&mtu3 {
> +	status = "okay";

Don't show status in examples.

> +
> +	connector {
> +		compatible = "linux,typeb-conn-gpio", "usb-b-connector";
> +		label = "micro-USB";
> +		type = "micro";
> +		id-gpios = <&pio 12 GPIO_ACTIVE_HIGH>;
> +		vbus-supply = <&usb_p0_vbus>;
> +
> +		port {
> +			bconn_ep: endpoint@0 {
> +				remote-endpoint = <&usb_role_sw>;
> +			};
> +		};
> +	};
> +
> +	port {
> +		usb_role_sw: endpoint@0 {
> +			remote-endpoint = <&bconn_ep>;
> +		};
> +	};

When the host controller is the parent of the connector, you don't need 
the graph unless you're describing the alternate modes in Type-C.

> +};
> -- 
> 2.21.0
> 
