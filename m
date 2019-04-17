Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BDEC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43EC21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555508088;
	bh=GPsZXYlgzmujoIoxRBTkTeI3SuyxrV3tSUcHjMl7vWY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k9CuU0BSIQFbItheHsmIZNpWnZpAxjku+d/DAP5w3RbMktA3suHgCL2nDqvXCzDO+
	 9eSejLjfHTijE7k67a9RmI+Yyi5N4sZgfUTe4bZZL/gqdOI3uyC2NwtkFPpBE7xyuv
	 KB8u4wDUG6i0B+p1DAdn97pk1gEilf7Pnqty+rR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbfDQNer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:34:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729633AbfDQNer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:34:47 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 909952183F;
        Wed, 17 Apr 2019 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555508085;
        bh=GPsZXYlgzmujoIoxRBTkTeI3SuyxrV3tSUcHjMl7vWY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AYoMClAzSK1GwyruDYZBPG/lrSEm7S6dq0to9bkzf6Fu+FPz3O8eEFAren2aa7Jp6
         oG8YAotOKiXCUpokHq07SuOJmZPBfrgModikEXC2giyMJ7ga/WnqKmdjgHysFvB/TN
         cMSliottN7FGbEGsYFtnx9J/x6LvXVyHkk539Fyw=
Received: by mail-qt1-f180.google.com with SMTP id x12so27295696qts.7;
        Wed, 17 Apr 2019 06:34:45 -0700 (PDT)
X-Gm-Message-State: APjAAAX4ZFX7+6CiMTHTMUyPGRKKzvLuEgEfp7FCuVFw871rmYY3oYAw
        AKLthljOj6BPL6UdHYgOgWzIwRPJe18ncsPVhA==
X-Google-Smtp-Source: APXvYqwI6Zm/iZpnFq71F/HfOZ3BSzn1vnas4aB3IqxduQg1AmdntSscvGFyUkCBSaqY0IsjZRT7KdxNcXo9tPF6XBY=
X-Received: by 2002:ac8:2cef:: with SMTP id 44mr55726906qtx.178.1555508084691;
 Wed, 17 Apr 2019 06:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190416235350.13742-1-masneyb@onstation.org> <20190416235350.13742-3-masneyb@onstation.org>
In-Reply-To: <20190416235350.13742-3-masneyb@onstation.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 17 Apr 2019 08:34:33 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+YnjDGmLODXy6M1GpixMV=spfc809atGkrighvy=QPHg@mail.gmail.com>
Message-ID: <CAL_Jsq+YnjDGmLODXy6M1GpixMV=spfc809atGkrighvy=QPHg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: backlight: add lm3630a bindings
To:     Brian Masney <masneyb@onstation.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>, Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 6:54 PM Brian Masney <masneyb@onstation.org> wrote:
>
> Add new backlight bindings for the TI LM3630A dual-string white LED.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Rob: Since the common bindings aren't converted to the new JSON schema
> yet, I'm not sure how to do led-sources here. I would expect that we'd
> have the uint32-array on the common binding once it exists. I had to
> add it here to keep 'make dt_binding_check' happy. I left the
> description off though for that property since that'll come from common
> once its converted.

What was the error? '$ref' shouldn't be needed for this. The tooling
has no knowledge whether there's common schema or not. So you probably
have some pattern the meta-schema doesn't like and we need to fix.

>
> Changes since v3:
> - Add label. I didn't add a description for it since that'll come from
>   the common properties once its converted.
>
> Changes since v2:
> - Update description of max-brightness
> - Add description for reg
> - Correct typo: s/tranisiton/transition
> - add reg to control banks
> - add additionalProperties
>
>  .../leds/backlight/lm3630a-backlight.yaml     | 128 ++++++++++++++++++
>  1 file changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> new file mode 100644
> index 000000000000..5067038ca637
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> @@ -0,0 +1,128 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/lm3630a-backlight.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI LM3630A High-Efficiency Dual-String White LED
> +
> +maintainers:
> +  - Lee Jones <lee.jones@linaro.org>
> +  - Daniel Thompson <daniel.thompson@linaro.org>
> +  - Jingoo Han <jingoohan1@gmail.com>
> +
> +description: |
> +  The LM3630A is a current-mode boost converter which supplies the power and
> +  controls the current in up to two strings of 10 LEDs per string.
> +  https://www.ti.com/product/LM3630A
> +
> +properties:
> +  compatible:
> +    const: ti,lm3630a
> +
> +  reg:
> +    description: The I2C address of the device

No need to describe a common property if there's nothing specific for
this device.

> +    maxItems: 1
> +
> +  ti,linear-mapping-mode:
> +    description: |
> +      Enable linear mapping mode. If disabled, then it will use exponential
> +      mapping mode in which the ramp up/down appears to have a more uniform
> +      transition to the human eye.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +patternProperties:
> +  "^led@[01]$":
> +    type: object
> +    description: |
> +      Properties for a string of connected LEDs.
> +
> +    properties:
> +      reg:
> +        description: Control Bank

Probably makes sense to have description here since this isn't a
standard type of address.

> +        maxItems: 1
> +        minimum: 0
> +        maximum: 1
> +
> +      label:
> +        maxItems: 1
> +
> +      led-sources:
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32-array
> +          - minItems: 1
> +            maxItems: 2
> +            items:
> +              minimum: 0
> +              maximum: 1
> +
> +      default-brightness:
> +        description: Default brightness level on boot.
> +        minimum: 0
> +        maximum: 255
> +
> +      max-brightness:
> +        description: Maximum brightness that is allowed during runtime.
> +        minimum: 0
> +        maximum: 255
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        lm3630a_bl@38 {

led-controller@38

> +                compatible = "ti,lm3630a";
> +                status = "ok";

Don't show status in examples.

> +                reg = <0x38>;
> +
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                led@0 {
> +                        reg = <0>;
> +                        led-sources = <0 1>;
> +                        label = "lcd-backlight";
> +                        default-brightness = <200>;
> +                        max-brightness = <255>;
> +                };
> +        };
> +    };
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        lm3630a_bl@38 {
> +                compatible = "ti,lm3630a";
> +                status = "ok";
> +                reg = <0x38>;
> +
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                led@0 {
> +                        reg = <0>;
> +                        default-brightness = <150>;
> +                        ti,linear-mapping-mode;
> +                };
> +
> +                led@1 {
> +                        reg = <1>;
> +                        default-brightness = <225>;
> +                        ti,linear-mapping-mode;
> +                };
> +        };
> +    };
> --
> 2.20.1
>
