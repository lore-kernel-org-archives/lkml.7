Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A5FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4B321773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556141039;
	bh=hByUOmFD/7n4kP2jFclwLcVDU4I9226OptgSLkI1uts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PaGI7y7KMu+7HREStZxqTN8BcQyydwattmhdIGLRH8wZIeHq5SgB2HImBJB+g/fcu
	 05sabUqPoWQtP8vCXj/U0Ly6d+9Wum2uCiRE3600VBmxU60d5RwWTSXLgsimh9p176
	 CizbvDoqbhSfx/X3YMT3Fjs75AXyhGS6HbOS8JkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbfDXVX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:23:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44100 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730662AbfDXVX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:23:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id l7so5948977oil.11;
        Wed, 24 Apr 2019 14:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=04EpxJXw4mXPYtYB891cYmt+jQome5FdL9anudXX+Wk=;
        b=RATiYGg1ZPpI6BieYEyLxqlHjbfnY5Ypo2nKLQ1TkLUlfwpVkwWGlXAh1IH+Zia08G
         i2o2+IS930JWyQsUwBfWrV3meFNwYBJJ/0yOSfUxjGAYknUNrb6anJJF7q6fZz4n+QIX
         EC3UE/gH9KjF9zBQJxKPyrxJYCbLbXvOSck0V3JlhT2404CBvNEpldT5oo27pECjEUXN
         Xz19jazaNEQvQ2aQ6iryOWxPXOrVy8TM1+hu8Pyg13pD5F8SpZPRckcA0bQR0TaexdCt
         SV2i/0d5z3az8fxz64tp8ATmW/rAsMXj0iUjusO1YlZg95a+PZohkneS8elOMHxIp8J3
         y3/A==
X-Gm-Message-State: APjAAAVSsvimgdLxXQ1il2PvS0669s5lw5ugxux1dIJ55RoREV3NCZDJ
        QOpUO6QRfhUZh8kvePaY6g==
X-Google-Smtp-Source: APXvYqxJLIPYPIgKdnMk/AhR9COB8voqiSRnX+mBrNU76MhHRXYi2+B+KcybO/oAmDDkl2H5wrENtg==
X-Received: by 2002:aca:3556:: with SMTP id c83mr897704oia.89.1556141037435;
        Wed, 24 Apr 2019 14:23:57 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k73sm9950382otk.14.2019.04.24.14.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 14:23:56 -0700 (PDT)
Date:   Wed, 24 Apr 2019 16:23:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        lee.jones@linaro.org, sergei.shtylyov@cogentembedded.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
Message-ID: <20190424212356.GA27103@bogus>
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <1556092536-17095-4-git-send-email-masonccyang@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556092536-17095-4-git-send-email-masonccyang@mxic.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 03:55:36PM +0800, Mason Yang wrote:
> Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt    | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> new file mode 100644
> index 0000000..668b822
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> @@ -0,0 +1,40 @@
> +Renesas R-Car Gen3 RPC-IF MFD Device Tree Bindings
> +--------------------------------------------------

Looks like a SPI flash controller from the example. What makes it an 
MFD?

> +
> +Required properties:
> +- compatible: should be an SoC-specific compatible value, followed by
> +		"renesas,rcar-gen3-rpc" as a fallback.
> +		supported SoC-specific values are:
> +		"renesas,r8a77995-rpc"	(R-Car D3)
> +- reg: should contain three register areas:
> +	first for the base address of RPC-IF registers,
> +	second for the direct mapping read mode and
> +	third for the write buffer area.
> +- reg-names: should contain "regs", "dirmap" and "wbuf"
> +- clocks: should contain 1 entries for the module's clock
> +- clock-names: should contain "rpc"
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +
> +Example:
> +
> +	rpc: rpc-if@ee200000 {
> +		compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
> +		reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
> +		      <0 0xee208000 0 0x100>;
> +		reg-names = "regs", "dirmap", "wbuf";
> +		clocks = <&cpg CPG_MOD 917>;
> +		clock-names = "rpc";
> +		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +		resets = <&cpg 917>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		flash@0 {
> +			compatible = "jedec,spi-nor";
> +			reg = <0>;
> +			spi-max-frequency = <40000000>;
> +			spi-tx-bus-width = <1>;
> +			spi-rx-bus-width = <1>;
> +		};
> +	};
> -- 
> 1.9.1
> 
