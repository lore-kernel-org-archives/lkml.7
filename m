Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C6EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C16A2339D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567532930;
	bh=2uD++TBraCQkPObAZLDBJSUyD8SNOUu4nKap+J4/iFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yU7jwKPIvJ6hC6nhps+QTxPYD1/QGXF6FA4o2S8PpmSlcxHQKzJ/oywfbbaYnfZMz
	 doV2P1IFJH93TJd/x9fFZPE/ECZn0onImasThlvSMZdyaF7SDoGo/dfWpWUqQr8nun
	 60P8CWOd07a3fp1YeaiIp60iV0/A47968rUKZZww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfICRst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 13:48:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38456 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbfICRst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:48:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id o184so454609wme.3;
        Tue, 03 Sep 2019 10:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WxydxVU2CFhWd0QEZ7Dd4XKp/p4c1U4sKS90L0qSlNM=;
        b=fNo9/JTji/ZWhxc4b/MqAsCMKbFZCAXiK+GboO+RfDmR9hWvzXCMWpt30FYPgUMCBf
         x5cNSil1QzKGFENXmDFegZFVOjdxNInsb5u5+NTuQpdbdK2vd+vjyft0Al8YbWUQ+EI7
         H9B1244sWceQSFPZy0O22lhnxudrdhi5g8FyaEgKO472W822uiD1Il3ri8g8Ca6m+ItF
         kmoUPtsr9yFhXVIg95Lb+vLDm2hJsbNidNadFxkr8hbCpEWEh4bT8uiIbKhxFAuCmUsC
         s7rX/ULitc+/GlFMUcgACg1BxzaqNzeOPjmU+VWe0OfSCDhrVqz9fYJbJ9SBfCFlERX5
         N0xA==
X-Gm-Message-State: APjAAAVduPZ7pxX/vO4cl9fNVkpgOGN22uLq6cDL9+QD+bwTtLe0C1bV
        ZkvueHEfKweflD4Bmibl/DadtV/BtQ==
X-Google-Smtp-Source: APXvYqwKKZxGa3P7rOKwJCnEa107FksH8qZoSDy9XKQWNeIR+1mSDDCxud+EJcVbOMGJguXrzvC05Q==
X-Received: by 2002:a1c:1d8d:: with SMTP id d135mr635821wmd.7.1567532926783;
        Tue, 03 Sep 2019 10:48:46 -0700 (PDT)
Received: from localhost ([176.12.107.132])
        by smtp.gmail.com with ESMTPSA id n12sm162415wmc.24.2019.09.03.10.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 10:48:46 -0700 (PDT)
Date:   Tue, 3 Sep 2019 18:48:44 +0100
From:   Rob Herring <robh@kernel.org>
To:     allen <allen.chen@ite.com.tw>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        CK Hu <ck.hu@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: Add binding for IT6505.
Message-ID: <20190903174844.GA4044@bogus>
References: <1567507915-9844-1-git-send-email-allen.chen@ite.com.tw>
 <1567507915-9844-2-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567507915-9844-2-git-send-email-allen.chen@ite.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 06:51:53PM +0800, allen wrote:
> From: Allen Chen <allen.chen@ite.com.tw>
> 
> Add a DT binding documentation for IT6505.
> 
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> 
> ---
> Comments in v1 would be addressed later in v3.
> ---
>  .../bindings/display/bridge/ite,it6505.txt         | 30 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  2 files changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it6505.txt

This won't apply. Base your patches on current (latest -rc) kernels.

We've moved to a DT schema format. Minimally vendor-prefixes.txt will 
have to change. It's also preferred for display bridges.

> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.txt b/Documentation/devicetree/bindings/display/bridge/ite,it6505.txt
> new file mode 100644
> index 0000000..c3506ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.txt
> @@ -0,0 +1,30 @@
> +iTE it6505 DP bridge bindings
> +
> +Required properties:
> +        - compatible: "ite,it6505"
> +        - reg: i2c address of the bridge
> +        - ovdd-supply: I/O voltage
> +        - pwr18-supply: Core voltage
> +        - interrupts: interrupt specifier of INT pin
> +        - reset-gpios: gpio specifier of RESET pin
> +
> +Example:
> +	it6505dptx: it6505dptx@5c {

dp-bridge@5c

> +                compatible = "ite,it6505";
> +                status = "okay";

Don't show status in examples.

> +                interrupt-parent = <&pio>;

And interrupt-parent.

> +                interrupts = <152 IRQ_TYPE_EDGE_RISING 152 0>;
> +                reg = <0x5c>;
> +                pinctrl-names = "default";
> +                pinctrl-0 = <&it6505_pins>;
> +                ovdd-supply = <&mt6358_vsim1_reg>;
> +                pwr18-supply = <&it6505_pp18_reg>;
> +                reset-gpios = <&pio 179 1>;
> +                hpd-gpios = <&pio 9 0>;

This goes in a connector node.

> +                extcon = <&usbc_extcon>;

extcon is deprecated. Drop or use the usb-connector binding.

Plus this is not documented above.

> +                port {

Need to list what each port is. You're going to need an output port too 
for a dp-connector or usb-c connector.

> +                        it6505_in: endpoint {
> +                                remote-endpoint = <&dpi_out>;
> +                        };
> +                };
> +        };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 2c3fc51..c088646 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -184,6 +184,7 @@ iom	Iomega Corporation
>  isee	ISEE 2007 S.L.
>  isil	Intersil
>  issi	Integrated Silicon Solutions Inc.
> +ite	iTE Tech. Inc.
>  itead	ITEAD Intelligent Systems Co.Ltd
>  iwave  iWave Systems Technologies Pvt. Ltd.
>  jdi	Japan Display Inc.
> -- 
> 1.9.1
> 
