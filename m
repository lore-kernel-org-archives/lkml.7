Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5D7C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34432084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yH0eacdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfDCHeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:34:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35888 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfDCHeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:34:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id 85so7875977pgc.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 00:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=E5hSr5XPWVDtOTprJ4M+OB6en/qp/jTyjg6TZvE9zg4=;
        b=yH0eacdy6kCpUX2likU+32mgIFIrhnxidQVxfNF8Rbt4wu6b+PwGEs5fd/sijch1A9
         TBDLq+O/cNn+j1/g8NsQvriPGyRry9fI+XMsuahVOX7bhUFYOiSJCJb6oRmjxxSLDYYv
         UTW4MuVaXbdPHQWazHzYch8aCjw2R1n9SSxTQkGvBotJ+EHM3jI40wdTTHTO+j7GLbWL
         Jfrhp2i0AhD8twIqBwYgeULWS6z2UHGfv4MQGmg949ZDAa2YsoGMEsCpCLIZo9C4GO6x
         vJGDhuTUHDgv5X5g+z4emvKWIHnv6dNZfwbvxUFdqzEC6pcmp7TAJeOZC9JBn94kDVx0
         i3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E5hSr5XPWVDtOTprJ4M+OB6en/qp/jTyjg6TZvE9zg4=;
        b=qUy/1YRW6QEMDAJRJpaNNER88rnGja8a9uEA67qdyq2bZltIsTGFX5zn/vrdUdZRFC
         WZ74bZgoHFGt50G33Ljc2POfr+i4Wk01uSQAqQAV3W/7i3kZ7t/Ve3FiukS6jqNoY69g
         WsxOxBfKxNC6s1qvWvbALhExawFf0Xhq0V+KyzyVYGl0cL3LxjGImlckfdI9bPmXjstU
         DtvVHGUq3YFNrZEbJ2GoRtIDAjB/O4nc0THzbLhbph2HtkTW12RCjulQtbldYG1uz0qZ
         pmMkSJzk87mIBS6NxR8KOIi+/GoqilYpDb0PpIhX0ACzDBvQ8DbiXq0l0PFmWbPjvFR0
         DAqQ==
X-Gm-Message-State: APjAAAW83KYc5mQJsuyKY4bgy+qsA8c4xsqVJr1GO2NmJhIux9a/CG/k
        muZHGpD1jFMmaqnzNQWDitoVeQ==
X-Google-Smtp-Source: APXvYqzgZ7k7CHBY8R+R+XUF+ikzugGh7vzulZfRf3CW0lJZHzUDD/csCIb+ev+UHlS92td8fXEs5w==
X-Received: by 2002:a62:183:: with SMTP id 125mr74801840pfb.146.1554276876149;
        Wed, 03 Apr 2019 00:34:36 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id a129sm45307462pfa.152.2019.04.03.00.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 00:34:35 -0700 (PDT)
Date:   Wed, 3 Apr 2019 08:34:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH v11 4/8] dt-bindings: mfd: Document first ROHM BD70528
 bindings
Message-ID: <20190403073426.GN4187@dell>
References: <cover.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <c674ef76ca0a3298e6b13ade4ab29775edf36a76.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c674ef76ca0a3298e6b13ade4ab29775edf36a76.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019, Matti Vaittinen wrote:

> Document bindings for regulators (3 bucks, 3 LDOs and 2 LED
> drivers) and 4 GPIO pins which can be configured for I/O or
> as interrupt sources withe configurable trigger levels.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/mfd/rohm,bd70528-pmic.txt        | 102 ++++++++++++++++++
>  1 file changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> new file mode 100644
> index 000000000000..120462c17904
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> @@ -0,0 +1,102 @@
> +* ROHM BD70528 Power Management Integrated Circuit bindings
> +
> +BD70528MWV is an ultra-low quiescet current general purpose single-chip

What does 'quiescet' mean?

"general purpose, single-chip,"

> +power management IC for battery-powered portable devices. The IC
> +integrates 3 ultra-low current consumption buck converters, 3 LDOs and 2
> +LED Drivers. Also included are 4 GPIOs, a real-time clock (RTC), a 32kHz
> +clock gate, high-accuracy VREF for use with an external ADC, flexible
> +dual-input power path, 10 bit SAR ADC for battery temperature monitor and
> +1S battery charger with scalable charge currents.
> +
> +Required properties:
> + - compatible		: Should be "rohm,bd70528"
> + - reg			: I2C slave address.
> + - interrupts		: The interrupt line the device is connected to.
> + - interrupt-controller	: To indicate BD70528 acts as an interrupt controller.
> + - #interrupt-cells	: Should be 2. Usage is compliant to the 2 cells
> +			  variant of ../interrupt-controller/interrupts.txt
> + - gpio-controller	: To indicate BD70528 acts as a GPIO controller.
> + - #gpio-cells		: Should be 2. The first cell is the pin number and
> +			  the second cell is used to specify flags. See
> +			  ../gpio/gpio.txt for more information.
> + - #clock-cells		: Should be 0.
> + - regulators:		: List of child nodes that specify the regulators.
> +			  Please see ../regulator/rohm,bd70528-regulator.txt
> +
> +Optional properties:
> + - clock-output-names	: Should contain name for output clock.
> +
> +Example:
> +/* external oscillator */

"External"

> +osc: oscillator {
> +	compatible = "fixed-clock";
> +	#clock-cells = <1>;
> +	clock-frequency  = <32768>;
> +	clock-output-names = "osc";
> +};
> +
> +pmic: pmic@4b {
> +	compatible = "rohm,bd70528";
> +	reg = <0x4b>;
> +	interrupt-parent = <&gpio1>;
> +	interrupts = <29 GPIO_ACTIVE_LOW>;
> +	clocks = <&osc 0>;
> +	#clock-cells = <0>;
> +	clock-output-names = "bd70528-32k-out";
> +	#gpio-cells = <2>;
> +	gpio-controller;
> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +
> +	regulators {
> +		buck1: BUCK1 {
> +			regulator-name = "buck1";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <3400000>;
> +			regulator-boot-on;
> +			regulator-ramp-delay = <125>;
> +		};
> +		buck2: BUCK2 {
> +			regulator-name = "buck2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-boot-on;
> +			regulator-ramp-delay = <125>;
> +		};
> +		buck3: BUCK3 {
> +			regulator-name = "buck3";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-boot-on;
> +			regulator-ramp-delay = <250>;
> +		};
> +		ldo1: LDO1 {
> +			regulator-name = "ldo1";
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-boot-on;
> +		};
> +		ldo2: LDO2 {
> +			regulator-name = "ldo2";
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-boot-on;
> +		};
> +
> +		ldo3: LDO3 {
> +			regulator-name = "ldo3";
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +		led_ldo1: LED_LDO1 {
> +			regulator-name = "led_ldo1";
> +			regulator-min-microvolt = <200000>;
> +			regulator-max-microvolt = <300000>;
> +		};
> +		led_ldo2: LED_LDO2 {
> +			regulator-name = "led_ldo2";
> +			regulator-min-microvolt = <200000>;
> +			regulator-max-microvolt = <300000>;
> +		};
> +	};
> +};

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
