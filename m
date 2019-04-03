Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9557CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D211206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvaVhol5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfDCLv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:51:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43425 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfDCLv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:51:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so8201177pgu.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 04:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LeBuh7e0xo0Yd76B7jQlnsPL/L3qs0Zl4qYNPHHmMOY=;
        b=TvaVhol5+sQ1aSflJzOOq+xJBpNK4vL+0aZsFrWXQhiaku4thAPRZ750FooRgTTomI
         fwGdLV3IF0YwZgrqbcunIikUPTnbaz+ODFkjSi1Co3Y9f2aBM1vcwmRrTR5wRch7bUK7
         I45Uu6IPhu7Nqi1mUi5nbnhUk9SrefEvqesMvz2dinE9iIEYAt2Ve0cVbL8ZvFV/G0RS
         X1Rj3/PzL+dANftAfkhcLQHm+Y86I9qvIDifhOD66nrJOQTdMnCldkK+bc/e6OSFDQFl
         MssqAHt2QPQFzh4gQLgfykIYAqVYQYDNNkRHU6v7Z+e9btnrlkhIIcTwL3uRiaYLEgx5
         TRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LeBuh7e0xo0Yd76B7jQlnsPL/L3qs0Zl4qYNPHHmMOY=;
        b=C1JwNIfKF/stZDSkzhKtSP8etzcAJdl5A+aj6iqGVzEr/KaxvgHjE/7HIFfIEAwtSB
         /1//ew5gEE19ZO3L0yY8l0r5B0J1vSSrIksIsOZHfWVKe8ll4yvyovrx8N6Tq3ufUZyY
         vcfD3K4FHWii3gLuxCsqRFkj8fhr9kdeDOtP0/Hdmk+XJWMbnXwu5CoaCJdrfw3I8PAm
         dusgogh2hDN+43Yvnmrgoojd8Ifr9h+eyWBlxNje7EcWSkY5N+LjIzxtikNqwZZZg5Jn
         Y9h6A6CDIoctS+YsOszXLq03AHpCLmg5EHVX7Kz8A3vb2jAIzFWSqcKVK9QIOv88FMvG
         CG7g==
X-Gm-Message-State: APjAAAVWR+1rAuCWLQFDTF6ygRt/3LtTDjtSa+zmEYkc1pQKJArH5MvY
        5U81HEeoRODXndR3PHFrCKgKljsApA0a6w==
X-Google-Smtp-Source: APXvYqz+wHNR2Ljkw4ZN04tKY+ztQWajg9tEPZPt4FUK6kzoI/oO+I4WV8uEqlsgXgaZIob8WBJoKg==
X-Received: by 2002:a63:4819:: with SMTP id v25mr2464895pga.412.1554292316602;
        Wed, 03 Apr 2019 04:51:56 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id s15sm19137510pga.71.2019.04.03.04.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 04:51:55 -0700 (PDT)
Date:   Wed, 3 Apr 2019 12:51:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, dwmw2@infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, computersforpeace@gmal.com,
        paul.burton@mips.com, stefan@agner.ch, christophe.kerello@st.com,
        liang.yang@amlogic.com, geert@linux-m68k.org,
        devicetree@vger.kernel.org, marcel.ziswiler@toradex.com,
        linux-mtd@lists.infradead.org, richard@nod.at,
        miquel.raynal@bootlin.com, juliensu@mxic.com.tw,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH 4/7] dt-bindings: mfd: Document Macronix MX25F0A
 controller bindings
Message-ID: <20190403115146.GR11301@dell>
References: <1553768318-23149-1-git-send-email-masonccyang@mxic.com.tw>
 <1553768318-23149-5-git-send-email-masonccyang@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1553768318-23149-5-git-send-email-masonccyang@mxic.com.tw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2019, Mason Yang wrote:

> Document the bindings used by the Macronix MX25F0A MFD controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/mfd/mxic-mx25f0a.txt       | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt b/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
> new file mode 100644
> index 0000000..53b4839
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
> @@ -0,0 +1,66 @@
> +Macronix MX25F0A Multi-Function Device Tree Bindings
> +----------------------------------------------------
> +
> +MX25F0A is a MultiFunction Device with SPI and raw NAND, which
> +supports either spi host controller or raw nand controller.
> +
> +Required properties:
> +- compatible: should be "mxic,mx25f0a-mfd"
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +- reg: should contain 2 entries, one for the registers and one for the direct
> +       mapping area in SPI mode.
> +- reg-names: should contain "regs" and "dirmap"
> +- interrupts: interrupt line connected to this MFD controller
> +
> +Required nodes:
> + - spi :
> +	Node for configuring the SPI controller driver.
> +	Required properties:
> +		- compatible = "mxicy,mx25f0a-spi";
> +		- clock-names: should contain "ps_clk", "send_clk" and
> +			       "send_dly_clk"
> +		- clocks: should contain 3 entries for the "ps_clk", "send_clk"
> +			  and "send_dly_clk" clocks
> +
> +- nand :
> +	Node for configuring the raw nand controller driver.
> +	Required properties:
> +		- compatible = "mxicy,mx25f0a-nand-ctlr";
> +		- nand-ecc-mode = "soft";
> +		- nand-ecc-algo = "bch";
> +
> +Example:
> +
> +	mxic: mx25f0a-mfd@43c30000 {

I'm not sure I understand why you are using an MFD for this.

> +		compatible = "mxic,mx25f0a-mfd";
> +		reg = <0x43c30000 0x10000>, <0xa0000000 0x4000000>;
> +		reg-names = "regs", "dirmap";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* either spi or nand */
> +		spi {
> +			compatible = "mxicy,mx25f0a-spi";
> +			clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
> +			clock-names = "send_clk", "send_dly_clk", "ps_clk";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			flash@0 {
> +				compatible = "jedec,spi-nor";
> +				reg = <0>;
> +				spi-max-frequency = <25000000>;
> +				spi-tx-bus-width = <4>;
> +				spi-rx-bus-width = <4>;
> +			};
> +		};
> +
> +		nand {
> +			compatible = "mxicy,mx25f0a-nand-ctlr";
> +			nand-ecc-mode = "soft";
> +			nand-ecc-algo = "bch";
> +			nand-ecc-step-size = <512>;
> +			nand-ecc-strength = <8>;
> +		};
> +	};

Why not just select one using device tree alone, by:

	spi@43c30000 {
		compatible = "mxicy,mx25f0a-spi";
		reg = <0x43c30000 0x10000>, <0xa0000000 0x4000000>;
		reg-names = "regs", "dirmap";
		#address-cells = <1>;
		#size-cells = <0>;
		clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
		clock-names = "send_clk", "send_dly_clk", "ps_clk";
		#address-cells = <1>;
		#size-cells = <0>;

		flash@0 {
			compatible = "jedec,spi-nor";
			reg = <0>;
			spi-max-frequency = <25000000>;
			spi-tx-bus-width = <4>;
			spi-rx-bus-width = <4>;
		};
	};

OR ...

	nand@43c30000 {
		compatible = "mxicy,mx25f0a-nand-ctlr";
		reg = <0x43c30000 0x10000>, <0xa0000000 0x4000000>;
		reg-names = "regs", "dirmap";
		#address-cells = <1>;
		#size-cells = <0>;
		nand-ecc-mode = "soft";
		nand-ecc-algo = "bch";
		nand-ecc-step-size = <512>;
		nand-ecc-strength = <8>;
	};

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
