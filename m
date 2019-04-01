Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28725C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E032086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554099239;
	bh=LCqdFB722rt9ET0SZqdXzeglVUMGIIAgBansj7hQHq4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DHMB5svjeZ89utsjUb5yrq++aUGO04fBHgqW4/P38ZDAsPzA26KhLrROQSdnVMoaU
	 67Phr+nZ8QD6Nn3Ziy+0I1a1nbGHmrVkohADOuSh1c+ObYB1e0gN6COfvn1qVm9JFL
	 RQLxm2FMD0pjO3fSEStF5UXXRu/IK+/HmJ+aP/zA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbfDAGN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 02:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfDAGN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 02:13:57 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B00B21841;
        Mon,  1 Apr 2019 06:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554099236;
        bh=LCqdFB722rt9ET0SZqdXzeglVUMGIIAgBansj7hQHq4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Uyq1dgPELcGqLbNFjKDDZmPh6eGjhgNt6scuO8cM/ONyvAI0Fw6Z+DKrqdXsBoopc
         b+jeGuB4ltJM0R+KURrdkPIm1KJsFYKsn7TGPLChk6yi9qZ6AIbQJD38RbzB5YWnX5
         bidzuPZd2m5aRoEBOoECWk0XLCZBbm4fIP4iqkfk=
Received: by mail-qk1-f181.google.com with SMTP id c20so4896023qkc.10;
        Sun, 31 Mar 2019 23:13:56 -0700 (PDT)
X-Gm-Message-State: APjAAAWfSBcCWBUC9I4TgM9IR6NZlrAnTFVretX0f3oBV03ZyBlUFnLv
        CfmFG0KJUAix4EP0m54x0IZkNLzH/7JWn83R5A==
X-Google-Smtp-Source: APXvYqy9OcArgA5LYVM2Q3OwfhGdghCywxRy13DUvQHPfRw1Xx97eTBOfLxSz8hip1m1xRHd6x72O4H1bIE/I+Xk+QE=
X-Received: by 2002:a37:d285:: with SMTP id f127mr49230127qkj.147.1554099235271;
 Sun, 31 Mar 2019 23:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190331152717.j3b3aggx674zrcko@arbad>
In-Reply-To: <20190331152717.j3b3aggx674zrcko@arbad>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 1 Apr 2019 01:13:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLvXu3rmeekZ+rXUMB6Mw8yBSi8B3mdjga5N0GwrM7n+Q@mail.gmail.com>
Message-ID: <CAL_JsqLvXu3rmeekZ+rXUMB6Mw8yBSi8B3mdjga5N0GwrM7n+Q@mail.gmail.com>
Subject: Re: [PATCH] avia-hx711.yaml: transform DT binding to YAML
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 10:27 AM Andreas Klinger <ak@it-klinger.de> wrote:
>
> replace avia-hx711.txt by avia-hx711.yaml as yaml devicetree documentation
> for avia hx711 iio adc sensor
>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../devicetree/bindings/iio/adc/avia-hx711.txt     | 24 --------
>  .../devicetree/bindings/iio/adc/avia-hx711.yaml    | 67 ++++++++++++++++++++++
>  2 files changed, 67 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt b/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> deleted file mode 100644
> index 7222328a3d0d..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -* AVIA HX711 ADC chip for weight cells
> -  Bit-banging driver
> -
> -Required properties:
> - - compatible: Should be "avia,hx711"
> - - sck-gpios:  Definition of the GPIO for the clock
> - - dout-gpios: Definition of the GPIO for data-out
> -               See Documentation/devicetree/bindings/gpio/gpio.txt
> - - avdd-supply:        Definition of the regulator used as analog supply
> -
> -Optional properties:
> - - clock-frequency:    Frequency of PD_SCK in Hz
> -                       Minimum value allowed is 10 kHz because of maximum
> -                       high time of 50 microseconds.
> -
> -Example:
> -weight {
> -       compatible = "avia,hx711";
> -       sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
> -       dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> -       avdd-suppy = <&avdd>;
> -       clock-frequency = <100000>;
> -};
> -
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> new file mode 100644
> index 000000000000..e4fee0f877ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/iio/adc/avia-hx711.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: AVIA HX711 ADC chip for weight cells
> +
> +maintainers:
> +  - Andreas Klinger <ak@it-klinger.de>
> +
> +description: |
> +  Bit-banging driver using two GPIOs:
> +  - sck-gpio gives a clock to the sensor with 24 cycles for data retrieval
> +    and up to 3 cycles for selection of the input channel and gain for the
> +    next measurement
> +  - dout-gpio is the sensor data the sensor responds to the clock
> +
> +  Specifications about the driver can be found at:
> +  http://www.aviaic.com/ENProducts.aspx
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - const: avia,hx711

You don't need oneOf here unless you expect to have compatible with a
variable number of compatible strings. If there are other similar
chips which could be added, then using enum will be more future proof
(So is 'oneOf' arguably, but it makes for more cryptic error
messages).

> +
> +  sck-gpios:
> +    description:
> +      Definition of the GPIO for the clock (output). In the datasheet it is
> +      named PD_SCK
> +    maxItems: 1
> +
> +  dout-gpios:
> +    description:
> +      Definition of the GPIO for the data-out sent by the sensor in
> +      response to the clock (input).
> +      See Documentation/devicetree/bindings/gpio/gpio.txt for information
> +      on how to specify a consumer gpio.
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description:
> +      Definition of the regulator used as analog supply
> +    maxItems: 1
> +
> +  clock-frequency:
> +    minimum: 20000
> +    maximum: 2500000
> +    default: 400000
> +
> +required:
> +  - compatible
> +  - sck-gpios
> +  - dout-gpios
> +  - avdd-supply
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    weight {
> +        compatible = "avia,hx711";
> +        sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
> +        dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> +        avdd-suppy = <&avdd>;
> +        clock-frequency = <100000>;
> +    };
> --
> 2.11.0
