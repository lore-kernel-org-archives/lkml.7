Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554BCC00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 23:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9F624649
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 23:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578093619;
	bh=vROKDr8ou9KC9ShWiJhEJm1fxvNK1FpW7pX42/uvUGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cy1gtJrFOQ88ihRvCi002gj29Qb/WMBzD9Xn5p7Ao7mV9M+OTsg7q+Ihn2UdLf60n
	 iDJsAQUwuOhhf0goFcQWPP8hC1zHkLmE5kFiELTwSVQT0WNjHu/WiIvAebFUI3OLVY
	 RCgDRtGlYV6K0m8cS9Q0UJsrYLGyGNQRXE9YZioY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgACXUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 18:20:18 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41912 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgACXUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 18:20:17 -0500
Received: by mail-il1-f195.google.com with SMTP id f10so37909466ils.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 15:20:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YCaxbEJ1CW2jND/UvSNmsdGdR3TnCMQc7c+abO1Ak4E=;
        b=Z5RriGCp3HuE3oD2lPykgNoniGatMs398pftH2xNswDpd8+2sCPToFYfSmRw1ajEiL
         Guc+G8hqi+WYFbq2Fz6KIOo2JJDXfUSXkxuqTg25TriDeoXrC03pp4QyQg1+oHHZaTK0
         uja7iR+O+dN7bRBvXt2u/VGVwra1kNAOliBL25rfueZ0bDZ3fbCDE+TNELEQ4Q9BbwgI
         tgjahoTo40/+iJEP7yLrujJ/c2qUMjMTEJnMK4/otD5z5/yaQdykrU0FxrzEBLSNJAUm
         choA0FgYmeiO2PClRs2GRNEy08+CXOq/2SRNCF4FqlroDIygbKFNI2hgiNFppIdhuTWU
         Bwww==
X-Gm-Message-State: APjAAAXos1TwI8qDIGPct/TNxUdLFkFdcTfxjq2Z/+Lau96iJd14oVzn
        LXtJgLT8oH4ivS+9UqtTAlCJJUA=
X-Google-Smtp-Source: APXvYqy9LJdSSMjrUzot5blVQMQW9Xq0/Au6yF56Hr6kz7zAfocKY6tFjndaV1K3JbJIJ5jmx0yELQ==
X-Received: by 2002:a92:481d:: with SMTP id v29mr78290878ila.271.1578093616766;
        Fri, 03 Jan 2020 15:20:16 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id f125sm11583850ilh.88.2020.01.03.15.20.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 15:20:16 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a5
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 16:18:42 -0700
Date:   Fri, 3 Jan 2020 16:18:42 -0700
From:   Rob Herring <robh@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com,
        mripard@kernel.org, shawnguo@kernel.org, heiko@sntech.de,
        sam@ravnborg.org, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: regulator: add document bindings for
 mpq7920
Message-ID: <20200103231842.GA25920@bogus>
References: <20191226222930.8882-1-sravanhome@gmail.com>
 <20191226222930.8882-3-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226222930.8882-3-sravanhome@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 11:29:28PM +0100, Saravanan Sekar wrote:
> Add device tree binding information for mpq7920 regulator driver.
> Example bindings for mpq7920 are added.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  .../bindings/regulator/mpq7920.yaml           | 143 ++++++++++++++++++

Convention is use the compatible string: mps,mpq7920.yaml

>  1 file changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mpq7920.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mpq7920.yaml
> new file mode 100644
> index 000000000000..54e9177dfd1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mpq7920.yaml
> @@ -0,0 +1,143 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mpq7920.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Monolithic Power System MPQ7920 PMIC
> +
> +maintainers:
> +  - Saravanan Sekar <sravanhome@gmail.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "pmic@[0-9a-f]{1,2}"
> +  compatible:
> +    enum:
> +      - mps,mpq7920
> +
> +  reg:
> +    maxItems: 1
> +
> +  mps,time-slot:
> +    description:
> +      each regulator output shall be delayed during power on/off sequence which
> +      based on configurable time slot value, must be one of following corresponding
> +      value 0.5ms, 2ms, 8ms, 16ms

These values map to 0-3?

This value is how long each time slot is?

> +    allOf:
> +      - $ref: "/schemas/types.yaml#/definitions/uint8"
> +      - enum: [ 0, 1, 2, 3 ]
> +      - default: 0

Only $ref needs to be under the allOf, so move enum and default to same 
level as allOf.

> +
> +  mps,fixed-on-time:
> +     description:
> +       select power on sequence with fixed time output delay mentioned in
> +       time-slot reg for all the regulators.
> +     type: boolean
> +
> +  mps,fixed-off-time:
> +     description:
> +        select power off sequence with fixed time output delay mentioned in
> +        time-slot reg for all the regulators.
> +     type: boolean
> +
> +  mps,inc-off-time:
> +     description: |
> +        mutually exclusive to mps,fixed-off-time an array of 8, linearly increase
> +        output delay during power off sequence based on factor of time slot/interval
> +        for each regulator.
> +     allOf:
> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +       - minimum: 0
> +       - maximum: 15
> +       - default: [ 0, 6, 0, 6, 7, 7, 7, 9 ]

Each value corresponds to a regulator? Why not a per regulator property?

> +
> +  mps,inc-on-time:
> +     description: |
> +        mutually exclusive to mps,fixed-on-time an array of 8, linearly increase
> +        output delay during power on sequence based on factor of time slot/interval
> +        for each regulator.
> +     allOf:
> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +       - minimum: 0
> +       - maximum: 15
> +       - default: [ 0, 6, 0, 6, 7, 7, 7, 9 ]
> +
> +  mps,switch-freq:
> +     description: |
> +        switching frequency must be one of following corresponding value
> +        1.1MHz, 1.65MHz, 2.2MHz, 2.75MHz

Seems like this should be a common property.

> +     allOf:
> +       - $ref: "/schemas/types.yaml#/definitions/uint8"
> +       - enum: [ 0, 1, 2, 3 ]
> +       - default: 2
> +
> +  mps,buck-softstart:
> +     description: |
> +        An array of 4 contains soft start time of each buck, must be one of
> +        following corresponding values 150us, 300us, 610us, 920us
> +     allOf:
> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +       - enum: [ 0, 1, 2, 3 ]

As this is an array, should be:

items:
  enum: ...

Constraints on the size of the array?

Though again, why not a per regulator property? Also, a fairly common 
thing for buck regulators?

> +       - default: [ 1, 1, 1, 1 ]
> +
> +  mps,buck-ovp:
> +     description: |
> +        An array of 4 contains over voltage protection of each buck, must be
> +        one of above values
> +     allOf:
> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +       - enum: [ 0, 1 ]
> +       - default: [ 1, 1, 1, 1 ]
> +
> +  mps,buck-phase-delay:
> +     description: |
> +        An array of 4 contains phase delay of each buck must be one of above values
> +        corresponding to 0deg, 90deg, 180deg, 270deg
> +     allOf:
> +       - $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +       - enum: [ 0, 1, 2, 3 ]
> +       - default: [ 0, 0, 1, 1 ]
> +
> +  regulators:
> +    type: object
> +    description:
> +      list of regulators provided by this controller, must be named
> +      after their hardware counterparts BUCK[1-4], one LDORTC, and LDO[2-5]
> +      The valid names for regulators are
> +      buck1, buck2, buck3, buck4, ldortc, ldo2, ldo3, ldo4, ldo5

You need buck[1-4] and ldo(rtc|[2-5]) child nodes defined here which 
reference regulators.yaml.

> +
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@69 {
> +          compatible = "mps,mpq7920";
> +          reg = <0x69>;
> +
> +          mps,switch-freq = <1>;
> +          mps,buck-softstart = /bits/ 8 <1 2 1 3>;
> +          mps,buck-ovp = /bits/ 8 <1 0 1 1>;
> +
> +          regulators {
> +            buck1 {
> +             regulator-name = "buck1";
> +             regulator-min-microvolt = <400000>;
> +             regulator-max-microvolt = <3587500>;
> +             regulator-min-microamp  = <460000>;
> +             regulator-max-microamp  = <7600000>;
> +             regulator-boot-on;
> +            };
> +
> +            ldo2 {
> +             regulator-name = "ldo2";
> +             regulator-min-microvolt = <650000>;
> +             regulator-max-microvolt = <3587500>;
> +            };
> +         };
> +       };
> +     };
> +...
> -- 
> 2.17.1
> 
