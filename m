Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBCCC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A42E21901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556121621;
	bh=oji+Wi53ymhYmIKY89XzMnHdg2QBdDr51Mdt9eRMP7U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UrCG/5iL1N8RwVUSM6mSbk75ZslJsnypilw/mFpM7mQYVs1ARkngvRZ5ljToMVdrf
	 MbfpwZUwX18b5Ch8Y+8ZLX6VtQ1qUh0v6LFotDgEWIaR2TriQfB11DJVHbMofOFAuO
	 EvstRnBWJP0hkMGmhKSAB9kbY+5tb7HyLIZjb/Ig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbfDXQAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730620AbfDXQAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:00:20 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8993A21901;
        Wed, 24 Apr 2019 16:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556121618;
        bh=oji+Wi53ymhYmIKY89XzMnHdg2QBdDr51Mdt9eRMP7U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1/GYxoe4iEmHpvXmeu4J05Ia+SqyPoduXCWSWhvMb3H2DvvlYi9aBZVLfmLrc8BMc
         UHwC89RKmeKf+AQGysdw4S5ZHm9jUDAzss9qvstDrS5jnumt8PWxREPHnQiM4yV/yr
         1WgdJRRRrT82ElJHjIh+p3ZnLfFQzrM98xD56Dwo=
Received: by mail-qt1-f180.google.com with SMTP id c35so6133489qtk.3;
        Wed, 24 Apr 2019 09:00:18 -0700 (PDT)
X-Gm-Message-State: APjAAAVGYT34PF5on5pYU1qCjqV8wEsxczVNuJbYncwnUsf7jpMKmxR7
        sHn6fE6XiDrLl4rPL+xZgiE/rF+dFhdH6hYXuQ==
X-Google-Smtp-Source: APXvYqzz3osG5s1bPzRj3FVPlzRNHwzG9Beg4bg28IjqhlgMoKcA/Jl+yBhva+tq30i2MynaQsH9+vHLpJ+npxX8NF4=
X-Received: by 2002:ac8:7647:: with SMTP id i7mr25685276qtr.38.1556121617776;
 Wed, 24 Apr 2019 09:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190424092238.6381-1-masneyb@onstation.org> <20190424092238.6381-2-masneyb@onstation.org>
In-Reply-To: <20190424092238.6381-2-masneyb@onstation.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 24 Apr 2019 11:00:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKHVdL96DVwhTnh_8rwuCGrC3Q33AbKyfT+QwxbgfHtow@mail.gmail.com>
Message-ID: <CAL_JsqKHVdL96DVwhTnh_8rwuCGrC3Q33AbKyfT+QwxbgfHtow@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: tsl2583: convert bindings to
 YAML format
To:     Brian Masney <masneyb@onstation.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 4:22 AM Brian Masney <masneyb@onstation.org> wrote:
>
> Convert the tsl2583 device tree bindings to the new YAML format.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Changes since v1:
> - Dropped description from reg and interrupts properties.
> - Dropped $ref from vcc-supply property.
> - Changed 'tsl2581@29' in example to 'als-sensor@29'
>
> I can no longer find the data sheet for this device linked on AMS's
> site. The datasheet is still on Digikey [1], however I didn't include it
> in the binding document since I assume that we should only link to the
> manufacturer's website.
> https://media.digikey.com/pdf/Data%20Sheets/Austriamicrosystems%20PDFs/TSL2581,83.pdf
>
>  .../devicetree/bindings/iio/light/tsl2583.txt | 25 ----------
>  .../bindings/iio/light/tsl2583.yaml           | 46 +++++++++++++++++++
>  2 files changed, 46 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/light/tsl2583.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2583.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/light/tsl2583.txt b/Documentation/devicetree/bindings/iio/light/tsl2583.txt
> deleted file mode 100644
> index 059dffa1829a..000000000000
> --- a/Documentation/devicetree/bindings/iio/light/tsl2583.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -* TAOS TSL 2580/2581/2583 ALS sensor
> -
> -Required properties:
> -
> -  - compatible: Should be one of
> -               "amstaos,tsl2580"
> -               "amstaos,tsl2581"
> -               "amstaos,tsl2583"
> -  - reg: the I2C address of the device
> -
> -Optional properties:
> -
> -  - interrupts: the sole interrupt generated by the device
> -
> -  Refer to interrupt-controller/interrupts.txt for generic interrupt client
> -  node bindings.
> -
> -  - vcc-supply: phandle to the regulator that provides power to the sensor.
> -
> -Example:
> -
> -tsl2581@29 {
> -       compatible = "amstaos,tsl2581";
> -       reg = <0x29>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/light/tsl2583.yaml b/Documentation/devicetree/bindings/iio/light/tsl2583.yaml
> new file mode 100644
> index 000000000000..6989a8a54c5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/tsl2583.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/tsl2583.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMS/TAOS Ambient Light Sensor (ALS)
> +
> +maintainers:
> +  - Brian Masney <masneyb@onstation.org>
> +
> +description: |
> +  Ambient light sensing with an i2c interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amstaos,tsl2580
> +      - amstaos,tsl2581
> +      - amstaos,tsl2583
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description: Regulator that provides power to the sensor
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        als-sensor@29 {

light-sensor@29

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
