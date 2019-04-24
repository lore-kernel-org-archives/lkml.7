Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9B5C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAAD21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556070786;
	bh=x3TVKicgp13gQiB/D6y+092OpLcNHyBRyvRzFXik6N8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OBWc51q6ZSNmOWsUgwuAJ+EFOWHH2/7+q7/G6vbd6C16gF/a3VCHrwZZ+zZ4t1Gmj
	 kYhKeznpihXpD6LAsvMo/OKYsxH59jrVc83hkRmbhaK3hbmJKIe98i+TkGgRJ1oUIM
	 Ocj9ulS+EMd8cH/a32HXsE5HMo747zPoZNMkUlM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfDXBxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729009AbfDXBxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:53:05 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFBE121903;
        Wed, 24 Apr 2019 01:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556070783;
        bh=x3TVKicgp13gQiB/D6y+092OpLcNHyBRyvRzFXik6N8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pgw89Y1+BoZW/S8InwiAALyS8gHflLETLjFG/kniB6pE2is4XtX5r0RgEW1TyrqWY
         SJRx1DN6az5wOiii05mv5i43U/u4OxGW8upCFl+cubojbViej6eTlU2UV6RhgVXz8I
         oi87cFyrJNsFhQE0Xtc75uKN15J4duyo3n692lhY=
Received: by mail-qk1-f170.google.com with SMTP id f125so5076273qke.6;
        Tue, 23 Apr 2019 18:53:03 -0700 (PDT)
X-Gm-Message-State: APjAAAWPcS3xjO6NwF/Ked54c8nLIhlVtyJQNckgGrE+Hrt/ONDkHEUw
        uacZ2KELExNcx7eYJycBAXVyzKA7e+CnuKc7FA==
X-Google-Smtp-Source: APXvYqyxLrc36Z3BNbK/A4HHfW8n24e0BsUnfv77DepAjECikieODygbDT0rEz+lcRWC2TL9pOa/Vo1Z2ougaeWC4LI=
X-Received: by 2002:a37:4b92:: with SMTP id y140mr22918682qka.79.1556070782893;
 Tue, 23 Apr 2019 18:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190418151143.26068-1-masneyb@onstation.org> <20190418151143.26068-3-masneyb@onstation.org>
In-Reply-To: <20190418151143.26068-3-masneyb@onstation.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 23 Apr 2019 20:52:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLZqA=cKLo3Jw7fizt06ytADL8YbhhRKS=mLo05hAaf2A@mail.gmail.com>
Message-ID: <CAL_JsqLZqA=cKLo3Jw7fizt06ytADL8YbhhRKS=mLo05hAaf2A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: backlight: add lm3630a bindings
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

On Thu, Apr 18, 2019 at 10:12 AM Brian Masney <masneyb@onstation.org> wrote:
>
> Add new backlight bindings for the TI LM3630A dual-string white LED.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Changes since v4:
> - Drop $ref from led-sources
> - Drop description from reg of i2c address
> - Expand description of reg for the control bank
> - Drop status from examples
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
>  .../leds/backlight/lm3630a-backlight.yaml     | 129 ++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> new file mode 100644
> index 000000000000..e754df569365
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> @@ -0,0 +1,129 @@
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
> +        description: |
> +          The control bank that is used to program the two current sinks. The
> +          LM3630A has two control banks (A and B) and are represented as 0 or 1
> +          in this property. The two current sinks can be controlled
> +          independently with both banks, or bank A can be configured to control
> +          both sinks with the led-sources property.
> +        maxItems: 1
> +        minimum: 0
> +        maximum: 1
> +
> +      label:
> +        maxItems: 1
> +
> +      led-sources:
> +        allOf:
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

Still needs:

led-controller@38

> +                compatible = "ti,lm3630a";
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

And here.

With those fixed:

Reviewed-by: Rob Herring <robh@kernel.org>
