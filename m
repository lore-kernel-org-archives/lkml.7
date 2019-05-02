Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAA8C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD7920652
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YPzwpyb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfEBKJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:09:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41419 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEBKJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:09:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id c12so2495266wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 03:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I7JrE3ge5OwnOiOnVlC2RZbWUmNCT1JzFNMIC7yOYmw=;
        b=YPzwpyb2xZ4bsMxRYFwplk7CCfxYwnyHCJNfIwn1vproql2OIZuBsflIO4fA42RTYG
         lduSHc2hAm5BiyAinvioxbNVpBkpXzK/4D4si/tVEgv4CJGS2xL6MaiMZSmgLRTxdEY+
         +zBdFB4JEKMOBnviNe7ValNsje/PLjT7nw1TsXDos9ZhVRoDB1+gDrZ5NmSqeB/V1n19
         1mp0Hqpozop2g+pQ65m1uLT+J57yBEFF6GuNP8Ne/azlX8n35eLKANBTeZNDSXH5bFuB
         PrDJmrgn2IxQGZQDPpD3f8iXDq1aZPRLeiNHYM24DfA+ZC4KMjGZu9T4McTKEDetVNer
         vzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I7JrE3ge5OwnOiOnVlC2RZbWUmNCT1JzFNMIC7yOYmw=;
        b=d4hutV8av7fGbWe/QWlyr6bnsgF1aVkSb7JKMgy7cYxRaCm6FFi6jrFribYc+zwdj9
         9ht37Bs7YYdd4AQ/G6Pj8D5/pLL/y2qdEWDe+HWY5c4rWnpnXVhYOOGKNVo/HBzfa9Lb
         gGAfb/tqiQetu/YWUJvudeaF+y3BivyDStMZfbUfqIjRtxvkDz/g2bH3jTlZEAkMXwZB
         eQIardExNjBj7qjdJvq4BtpmZcKv0KBfhEq1p26Lp/37PWBpSjMfsjF0ox2HG+WZkhre
         Z+PD4CZ5EuZUNht+X0H3xDE+OtgLSrorrE+ye3xZW9bae2ekoLQ9Cw21+qKLohuXvnc/
         aRqg==
X-Gm-Message-State: APjAAAUaChbzbUio9nixwpIBkVoP5uqrsmypwOvJ2R/kNniPYdf3fdqK
        guaaEmJAEGEeuowFp2nvGJbsXg==
X-Google-Smtp-Source: APXvYqxdMhBumIHHoJYpIja2McKFC1BEmf6wYmSiGfKGDP5d+Rza9ajEKe7MSVL+UMPr1OGLIDnWJg==
X-Received: by 2002:adf:cc8a:: with SMTP id p10mr2237729wrj.34.1556791777014;
        Thu, 02 May 2019 03:09:37 -0700 (PDT)
Received: from holly.lan (static-84-9-17-116.vodafonexdsl.co.uk. [84.9.17.116])
        by smtp.googlemail.com with ESMTPSA id j13sm45973524wrd.88.2019.05.02.03.09.35
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 03:09:36 -0700 (PDT)
Subject: Re: [PATCH v6 2/3] dt-bindings: backlight: add lm3630a bindings
To:     Brian Masney <masneyb@onstation.org>, lee.jones@linaro.org,
        jingoohan1@gmail.com, robh+dt@kernel.org
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dmurphy@ti.com, jonathan@marek.ca, Rob Herring <robh@kernel.org>,
        Daniel Thompson <daniel@redfelineninja.org.uk>
References: <20190424092505.6578-1-masneyb@onstation.org>
 <20190424092505.6578-3-masneyb@onstation.org>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <6af80a58-b3e2-bf67-cbfc-284df7ec52c1@linaro.org>
Date:   Thu, 2 May 2019 11:09:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424092505.6578-3-masneyb@onstation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2019 10:25, Brian Masney wrote:
> Add new backlight bindings for the TI LM3630A dual-string white LED.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
> Changes since v5:
> - Change 'lm3630a_bl@38' in examples to 'led-controller@38'
> 
> Changes since v4:
> - Drop $ref from led-sources
> - Drop description from reg of i2c address
> - Expand description of reg for the control bank
> - Drop status from examples
> 
> Changes since v3:
> - Add label. I didn't add a description for it since that'll come from
>    the common properties once its converted.
> 
> Changes since v2:
> - Update description of max-brightness
> - Add description for reg
> - Correct typo: s/tranisiton/transition
> - add reg to control banks
> - add additionalProperties
> 
>   .../leds/backlight/lm3630a-backlight.yaml     | 129 ++++++++++++++++++
>   1 file changed, 129 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> new file mode 100644
> index 000000000000..4d61fe0a98a4
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
> +        led-controller@38 {
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
> +        led-controller@38 {
> +                compatible = "ti,lm3630a";
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
> 

