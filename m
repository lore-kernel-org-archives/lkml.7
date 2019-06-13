Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42D3C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965C52173C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 20:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560457998;
	bh=4ORjBm9h1PVzfT1T37ZB0z9YsICQkKnBW1Bwmyrjpzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xVHx79THizVQIJVCbzUxqVl7qXTyT/g7TKIjGWSe4jnehxSyQ/H4VcdaDA+vwj1df
	 p3XRhkkVf7JnHMkbrpdFqbRFKHaGgzAgRL0kxovIJk2chtwxYvpIQ6r0kZEvVRkugC
	 E8yDsh2XE+a7y6lGfV9CmA5s+cyrf6EpR1GwKgzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbfFMUdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 16:33:17 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36268 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfFMUdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 16:33:16 -0400
Received: by mail-qt1-f194.google.com with SMTP id p15so4792006qtl.3;
        Thu, 13 Jun 2019 13:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R2FstjYRqQg59DXy+7LjAPTotoewKiLMGMYZxUsswDg=;
        b=slXjkj1j5Jm7zPn/DBlhDdXtqvGdl5k2k1Vc9O+nBLlxdfjSRYODAuHyOVgKkFYzxh
         vp7TBDYBmQV/SF7e4gpa52WkRlEqvCtkxyzPBnLYNNHCQc5ISp7MrCHqhKlQySTkRS+D
         cK+xlSOasWhT+qWKPcUHD3lDddzb0JLK7QIAlVwSrNyGxHbE8wdNHXL1zcfR/mPZ6hVe
         SyV+fPQBNAiWSmIEocUb8DSLtvEu7n3wbVBIEpTIUjWym1LHsDXWjcz1+XKyLTdM2kUL
         iVZxl70Ah7J1S1g8YonLd1bwB2t7p/O725vgTxX2DJ42kLwjAF30ualKT/NyVDqyQyOk
         Z4qg==
X-Gm-Message-State: APjAAAXdy2T2hFZC0+J4w2mc3Ls4aE1x7WIyvxeyj1oq1DsA05PQax3Y
        vDaF/ADNTLo2Kwb2QwmlVw==
X-Google-Smtp-Source: APXvYqz/AjvzkvNZlLu61SiHZDfFw95Oeihx85WNdMpZRhlJlbJo2We6Ewob7bP6MREJhRmhkvqgzQ==
X-Received: by 2002:a0c:887c:: with SMTP id 57mr4994570qvm.192.1560457995500;
        Thu, 13 Jun 2019 13:33:15 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id l88sm423749qte.33.2019.06.13.13.33.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 13:33:14 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:33:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add DT bindings for TI
 ads1000/ads1100 ADCs
Message-ID: <20190613203313.GA23102@bogus>
References: <20190514225810.12591-1-fancer.lancer@gmail.com>
 <20190514225810.12591-2-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514225810.12591-2-fancer.lancer@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 01:58:08AM +0300, Serge Semin wrote:
> Add dt-binding documentation for the Texas Instruments ads1000/ads1100 ADCs
> driver.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  .../devicetree/bindings/hwmon/ads1000.txt     | 61 ++++++++++++++++

Bindings should be separate patch.

>  Documentation/hwmon/ads1000.rst               | 72 +++++++++++++++++++
>  2 files changed, 133 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ads1000.txt
>  create mode 100644 Documentation/hwmon/ads1000.rst
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ads1000.txt b/Documentation/devicetree/bindings/hwmon/ads1000.txt
> new file mode 100644
> index 000000000000..3907b7da9b33
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ads1000.txt
> @@ -0,0 +1,61 @@
> +ADS1000/ADS1100 (I2C)
> +
> +This device is a 12-16 bit A-D converter with 1 input.

ADC's should be in bindings/iio/adc/

> +
> +The inputs can be used either as a differential pair of Vin+ Vin- or as a single
> +ended sensor for Vin+ GND. The inputs mode is platform-dependent and isn't
> +configured by software in any case.
> +
> +Device A-D converter sensitivity can be configured using two parameters:
> + - pga is the programmable gain amplifier
> +    0: x1 (default) 
> +    1: x2
> +    2: x4
> +    3: x8
> + - data_rate in samples per second also affecting the output code accuracy
> +    0: 128SPS - +/- Vdd*0.488mV (default, ads1000 accepts this rate only)
> +    1: 32SPS  - +/- Vdd*0.122mV
> +    2: 16SPS  - +/- Vdd*0.061mV
> +    3: 8SPS   - +/- Vdd*0.030mV
> +   Since this parameter also affects the output accuracy, be aware the greater
> +   SPS the worse accuracy.
> +
> +As a result the output value is calculated by the next formulae:
> +dVin = Cod * Vdd / (PGA * max(|Cod|)), where
> +max(|Cod|) - maximum possible value of the output code, which depends on the SPS
> +setting from the table above.
> +
> +The ADS1000/ADS1100 dts-node:
> +
> +  Required properties:
> +   - compatible : must be "ti,ads1000" or "ti,ads1100"
> +   - reg : I2C bus address of the device
> +   - #address-cells : must be <1>
> +   - #size-cells : must be <0>
> +   - vdd-supply : regulator for reference supply voltage (usually fixed)
> +
> +  Optional properties:
> +   - ti,gain : the programmable gain amplifier setting
> +   - ti,datarate : the converter data rate

IIRC, we have standard properties for these.

> +   - ti,voltage-divider : <R1 R2> Ohms inbound voltage dividers,
> +     so dVin = (R1 + R2)/R2 * dVin
> +
> +Example:
> +
> +vdd_5v0: fixedregulator@0 {
> +	compatible = "regulator-fixed";
> +	regulator-name = "vdd-ref";
> +	regulator-min-microvolt = <5000000>;
> +	regulator-max-microvolt = <5000000>;
> +	regulator-always-on;
> +};
> +
> +tiadc: ads1000@48 {

adc@48

> +	compatible = "ti,ads1000";
> +	reg = <0x48>;
> +
> +	vdd-supply = <&vdd_5v0>;
> +	ti,gain = <0>;
> +	ti,voltage-divider = <31600 3600>;
> +};
> +
