Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1396DC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52DF21902
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556120883;
	bh=Lz8P2pOdqkylqA6PefAVJPK5SZUmgNH17yrLVKVRv4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DsHRaG+lxS3sjJkPMSQDCOAYpkOiPkt1CnsLtgTiXotyDmLBLqtoD/fQm9BE2xRS3
	 ZKVyHuPPDjQXAu/JC7Zrjss1QcBTYVPlijrN5ICaepUT/7J4F0dM8MRqZ/UxiUoRXo
	 BTxDEpSC865zzmYyUlwYxEe8H8v7K3RWjkAeFx98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbfDXPsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:48:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731094AbfDXPsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:48:02 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC28421902;
        Wed, 24 Apr 2019 15:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556120880;
        bh=Lz8P2pOdqkylqA6PefAVJPK5SZUmgNH17yrLVKVRv4s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SpxLD8y7LfGADw2qFaeTZJlvIWl04jms/EgL8YSO9nriV1l7pM/IiqXwjCEolIaUv
         Ah8v1insv0ndMGfuMPY8otbW0+mwBkAS++aoXvu1edu3DtRkhClI4LA48WxCYB3nG9
         ZYEePK+1lDYTAba2rNDjgpp+KjBOEWlEG8LpGBXw=
Received: by mail-qt1-f173.google.com with SMTP id l17so1652231qtp.2;
        Wed, 24 Apr 2019 08:48:00 -0700 (PDT)
X-Gm-Message-State: APjAAAVHJYL8eE6N8gF+SWgh0WtBGBTbM5D7k/BLMq6HNdwPN6qNXBKx
        BtcgiWhdDFpsppNCV+C3d8jxbMffCY3YX5+MjQ==
X-Google-Smtp-Source: APXvYqwyw2dMBpFg6SQGL7P4wLUP2TancdL4tLXyNwq+6Gqo5zzsg8q4JerHnMhzTFinJ7WBgbLqi9Jnjt3W5JuVPek=
X-Received: by 2002:ac8:74d6:: with SMTP id j22mr6572824qtr.144.1556120880023;
 Wed, 24 Apr 2019 08:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190424092238.6381-1-masneyb@onstation.org>
In-Reply-To: <20190424092238.6381-1-masneyb@onstation.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 24 Apr 2019 10:47:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKKQd-pMuHwh3ckhqy5Ohf4sGMZVZfcMPSjD+rOWdX3qA@mail.gmail.com>
Message-ID: <CAL_JsqKKQd-pMuHwh3ckhqy5Ohf4sGMZVZfcMPSjD+rOWdX3qA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: tsl2772: convert bindings to
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
> Convert the tsl2772 device tree bindings to the new YAML format.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Changes since v1:
> - Dropped description from reg and interrupts properties.
> - Dropped $ref from led-max-microamp, vdd-supply, and vddio-supply.
> - Changed 'tsl2772@39' in example to 'proximity-sensor@39'
>
>  .../devicetree/bindings/iio/light/tsl2772.txt | 42 ----------
>  .../bindings/iio/light/tsl2772.yaml           | 80 +++++++++++++++++++
>  2 files changed, 80 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.txt b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> deleted file mode 100644
> index 1c5e6f17a1df..000000000000
> --- a/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -* AMS/TAOS ALS and proximity sensor
> -
> -Required properties:
> -
> -  - compatible: Should be one of
> -               "amstaos,tsl2571"
> -               "amstaos,tsl2671"
> -               "amstaos,tmd2671"
> -               "amstaos,tsl2771"
> -               "amstaos,tmd2771"
> -               "amstaos,tsl2572"
> -               "amstaos,tsl2672"
> -               "amstaos,tmd2672"
> -               "amstaos,tsl2772"
> -               "amstaos,tmd2772"
> -               "avago,apds9930"
> -  - reg: the I2C address of the device
> -
> -Optional properties:
> -
> -  - amstaos,proximity-diodes - proximity diodes to enable. <0>, <1>, or <0 1>
> -                               are the only valid values.
> -  - led-max-microamp - current for the proximity LED. Must be 100000, 50000,
> -                       25000, or 13000.
> -  - vdd-supply: phandle to the regulator that provides power to the sensor.
> -  - vddio-supply: phandle to the regulator that provides power to the bus.
> -  - interrupts: the sole interrupt generated by the device
> -
> -  Refer to interrupt-controller/interrupts.txt for generic interrupt client
> -  node bindings.
> -
> -Example:
> -
> -tsl2772@39 {
> -       compatible = "amstaos,tsl2772";
> -       reg = <0x39>;
> -       interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
> -       vdd-supply = <&pm8941_l17>;
> -       vddio-supply = <&pm8941_lvs1>;
> -       amstaos,proximity-diodes = <0>;
> -       led-max-microamp = <100000>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.yaml b/Documentation/devicetree/bindings/iio/light/tsl2772.yaml
> new file mode 100644
> index 000000000000..2ebc8d727f09
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/tsl2772.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/tsl2772.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMS/TAOS Ambient Light Sensor (ALS) and Proximity Detector
> +
> +maintainers:
> +  - Brian Masney <masneyb@onstation.org>
> +
> +description: |
> +  Ambient light sensing and proximity detection with an i2c interface.
> +  https://ams.com/documents/20143/36005/TSL2772_DS000181_2-00.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amstaos,tsl2571
> +      - amstaos,tsl2671
> +      - amstaos,tmd2671
> +      - amstaos,tsl2771
> +      - amstaos,tmd2771
> +      - amstaos,tsl2572
> +      - amstaos,tsl2672
> +      - amstaos,tmd2672
> +      - amstaos,tsl2772
> +      - amstaos,tmd2772
> +      - avago,apds9930
> +
> +  reg:
> +    maxItems: 1
> +
> +  amstaos,proximity-diodes:
> +    description: Proximity diodes to enable
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - minItems: 1
> +        maxItems: 2
> +        items:
> +          minimum: 0
> +          maximum: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  led-max-microamp:
> +    description: Current for the proximity LED
> +    allOf:

No need for the allOf here with only one entry.

> +      - enum: [13000, 25000, 50000, 100000]
