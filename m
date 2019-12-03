Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E5FC43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F0D206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcOLLSM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfLCPG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:06:58 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42250 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfLCPG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:06:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id x13so1799706plr.9;
        Tue, 03 Dec 2019 07:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vuBgxT+Qbk3ubYCJQymif0bEiJiXCbEoz1v3OhqyqTo=;
        b=OcOLLSM21Dry/Jx7rBKSDi7fbfayCR6F2Sw71nKmjXhnewkuGLaC0KJrTWbvJE+Qgn
         LoM5gF9ZC9LoP2bKmW7ZZo2XqW+NAHswxmzSSNJC2SFez7Z5Xyy1Kr3OApohGUgSo+jH
         99JfMsHOXyx8V/Ki5WAX2TUTlJAUb1IG5vMllxIE7HlDTe/LWz7C3WgDDJgFyhDeE8Si
         3rEM1WdOamqJ3J2k/PkcIhAPqnCqE+CEYipSHaPpQaIEx1R0DOg5gRHQqrRyHVK2Hvdd
         7TTv/fekDOShV9LqmOYQfVVOckKdbfcub4iPGqO2WT3HGeHu+rC+EyB+gMLDfaVjkZJX
         lvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vuBgxT+Qbk3ubYCJQymif0bEiJiXCbEoz1v3OhqyqTo=;
        b=m5rGHEZUClpizcaq+UiP7ayhIBGDy+l2HUKjW+uEAx/IFCTfIYZzS8zBXNLXKo2Cmd
         Srt/mWjJJQ9nLq3pBRjkVhuEXoetSLy5T0zf+2aZzvx26eKGOld1tDaVGO0uzwr9Mrg7
         gugcRPyCiX1iXQ5dhs2QdHh470WmcDUIfeKSStvQ+Qug4MwZFEgpPztmrRaYY1Qr7R9Q
         eRdi/tNI0V270K4rdO6x2yfWt/43LS2lldMbpaU5klgzoJRpZghtjPN0O1BAJT8L/8FJ
         wXcVuklm69Lix+YHHPedtyek7E7/Glv8XIwAznWg3cagg9P4QWEwH4/DlOw9E7RAbRct
         78+Q==
X-Gm-Message-State: APjAAAXG0hjClAsjUGZxnXBRRwa6XWMoTM1ieOQa5TdR96n50tArtI0r
        3jbixgbMQp4DEPQPp6bzrd4=
X-Google-Smtp-Source: APXvYqwVUWuvtmoCjjOpXTlhawPaCTM77lQIg8WunkiWSQ50Jtsh07rKO8SxbQZFvar0S/rIQmrtMw==
X-Received: by 2002:a17:902:8498:: with SMTP id c24mr5227759plo.223.1575385616912;
        Tue, 03 Dec 2019 07:06:56 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r6sm1925649pfh.91.2019.12.03.07.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 07:06:55 -0800 (PST)
Subject: Re: [PATCH 2/3] dt-binding: iio: Add documentation for ADM1177
To:     Beniamin Bia <beniamin.bia@analog.com>, linux-hwmon@vger.kernel.org
Cc:     Michael.Hennerich@analog.com, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, mark.rutland@arm.com, lgirdwood@gmail.com,
        broonie@kernel.org, devicetree@vger.kernel.org,
        biabeniamin@outlook.com
References: <20191203135711.13972-1-beniamin.bia@analog.com>
 <20191203135711.13972-2-beniamin.bia@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b7402a4f-1918-1922-a779-c9914be27f1b@roeck-us.net>
Date:   Tue, 3 Dec 2019 07:06:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191203135711.13972-2-beniamin.bia@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/19 5:57 AM, Beniamin Bia wrote:
> Documentation for ADM1177 was added.
> 

Subject still points to iio.

> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
>   .../bindings/hwmon/adi,adm1177.yaml           | 65 +++++++++++++++++++
>   1 file changed, 65 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml b/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
> new file mode 100644
> index 000000000000..abd9354217ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/adi,adm1177.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADM1177 Hot Swap Controller and Digital Power Monitor
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +  - Beniamin Bia <beniamin.bia@analog.com>
> +
> +description: |
> +  Analog Devices ADM1177 Hot Swap Controller and Digital Power Monitor
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1177.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adm1177
> +
> +  reg:
> +    maxItems: 1
> +
> +  avcc-supply:
> +    description:
> +      Phandle to the Avcc power supply
> +
> +  adi,r-sense-micro-ohms:
> +    description:
> +      The value of curent sense resistor in microohms.

There is a standard property for that (shunt-resistor-micro-ohms).

> +
> +  adi,shutdown-threshold-microamp:
> +    description:
> +      Specifies the current level at which an over current alert occurs.
> +
> +  adi,vrange-high-enable:
> +    description:
> +      Specifies which internal voltage divider to be used. A 1 selects
> +      a 7:2 voltage divider while a 0 selects a 14:1 voltage divider.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - adi,r-sense-micro-ohms
> +  - adi,shutdown-threshold-microamp
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pwmon@5a {
> +                compatible = "adi,adm1177";
> +                reg = <0x5a>;
> +                adi,r-sense-micro-ohms = <50000>; /* 50 mOhm */
> +                adi,shutdown-threshold-microamp = <1059000>; /* 1.059 A */
> +                adi,vrange-high-enable;
> +        };
> +    };
> +...
> 

