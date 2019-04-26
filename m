Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBAAC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98753206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556318500;
	bh=TSlLR0SoV4yY+s+9Jlsb3CLGNH37LofNhjQxRe0j7ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ACA6QfVYKG0CzMlUkAdoTXFz3Zlyg5DrGUXg8v7g65UJ5jaH11HicspXaHudqi0uh
	 tc3n3g/jxD1nb4dKfRbQsbi0GjD3ZPlb1eDfEwXCkQr7G7bLNW3inNph7/Gu6CLvW9
	 7/8YunGj25KIhAuSBTqiXqYQXqpAkfvKZNZS/Rs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfDZWlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:41:39 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36482 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfDZWlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 18:41:39 -0400
Received: by mail-oi1-f193.google.com with SMTP id l203so4213854oia.3;
        Fri, 26 Apr 2019 15:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PsdEdDTbsz+N7C5OSHpzo5ojKTZZOZ+w3y29AXWU3a0=;
        b=USj0sm7W3Oj2QGmVQHsqAVsPc701QX+koKUEer5eMGldKvz6fgqxWQGWnFzNcMB5fc
         woVAKmWXsZP6TZckUSzNhg83yFY/5K8iH0Q3S/ImIvchEA2ot9loM4DyCp/q8RnZoNht
         ngf4+tvn+ELlnSHXOWgjdd+FSYKemvBMnW7uezke75Tn8goKo6A9KV8m/eyn556YW0g+
         QBPERH1aebhBLsb3dUo529WmvUHR3TX3Ac3OuTpa2LqKpp/x122VDba2L0lT8raPh1iv
         g3oaMZw7sgNeMcXLeYUI0ZOfn4YqX9LoijjsV9Vzh4vBrsPKdqW9+JremfjnUO+FYJzz
         HZLQ==
X-Gm-Message-State: APjAAAVAT5QcKRaG0ey1tzqTCZH6miFlQHkeI7ZPBJYWaS3UPDtE+maS
        saZ1VXSVjLrboCeBGK225A==
X-Google-Smtp-Source: APXvYqzzmEbC/NuD5L8a9Vj0ZUk4s85sFCjNd6YoWDJUPGt8PPb+Skw3FBdVQPhaSCv3ksmJRDcfww==
X-Received: by 2002:aca:f1d4:: with SMTP id p203mr9098222oih.154.1556318497952;
        Fri, 26 Apr 2019 15:41:37 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f16sm3915279otq.15.2019.04.26.15.41.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 15:41:36 -0700 (PDT)
Date:   Fri, 26 Apr 2019 17:41:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, dwmw2@infradead.org, lee.jones@linaro.org,
        mark.rutland@arm.com, computersforpeace@gmal.com,
        paul.burton@mips.com, stefan@agner.ch, christophe.kerello@st.com,
        liang.yang@amlogic.com, geert@linux-m68k.org,
        devicetree@vger.kernel.org, marcel.ziswiler@toradex.com,
        linux-mtd@lists.infradead.org, richard@nod.at,
        miquel.raynal@bootlin.com, juliensu@mxic.com.tw,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH v3 4/4] dt-bindings: mfd: Document Macronix MX25F0A
 controller bindings
Message-ID: <20190426224136.GA636@bogus>
References: <1555320234-15802-1-git-send-email-masonccyang@mxic.com.tw>
 <1555320234-15802-5-git-send-email-masonccyang@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555320234-15802-5-git-send-email-masonccyang@mxic.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 05:23:54PM +0800, Mason Yang wrote:
> Document the bindings used by the Macronix MX25F0A MFD controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/mfd/mxic-mx25f0a.txt       | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt b/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
> new file mode 100644
> index 0000000..7f3e0f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
> @@ -0,0 +1,51 @@
> +Macronix MX25F0A MultiFunction Device Tree Bindings
> +----------------------------------------------------
> +
> +MX25F0A is a MultiFunction Device with SPI and raw NAND, which
> +supports either spi host controller or raw nand controller.
> +
> +Required properties:
> +- compatible: should be "mxic,mx25f0a"
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain 2 entries, one for the registers and one for the direct
> +       mapping area in SPI mode.
> +- reg-names: should contain "regs" and "dirmap"
> +- interrupts: interrupt line connected to this MFD controller
> +- SPI controller driver:
> +		- clock-names: should contain "ps_clk", "send_clk" and
> +			       "send_dly_clk"
> +		- clocks: should contain 3 entries for the "ps_clk", "send_clk"
> +			  and "send_dly_clk" clocks
> +
> +- Raw nand controller driver.
> +		- nand-ecc-mode = "soft";
> +		- nand-ecc-algo = "bch";
> +
> +Example:
> +
> +	mxic: mx25f0a@43c30000 {
> +		compatible = "mxic,mx25f0a";
> +		reg = <0x43c30000 0x10000>, <0xa0000000 0x4000000>;
> +		reg-names = "regs", "dirmap";
> +
> +		/* spi */
> +		clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
> +		clock-names = "send_clk", "send_dly_clk", "ps_clk";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		flash@0 {
> +			compatible = "jedec,spi-nor";
> +			reg = <0>;
> +			spi-max-frequency = <25000000>;
> +			spi-tx-bus-width = <4>;
> +			spi-rx-bus-width = <4>;
> +		};
> +
> +		/* nand */

Don't you need a nand child node? I'm not sure how that's going to work 
as you are already using the number space (i.e. reg) for SPI CS number 
and you can't really mix number spaces within a node level.

> +		nand-ecc-mode = "soft";
> +		nand-ecc-algo = "bch";
> +		nand-ecc-step-size = <512>;
> +		nand-ecc-strength = <8>;
> +	};
> -- 
> 1.9.1
> 
