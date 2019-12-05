Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A415FC2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADB321835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575557904;
	bh=AuxIhNzVenY1YORsvEg+wFXj6r70v48oXJ1iiIrdDFA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ku9EytjYWCMWoxEv9VQ0J1iVQEKhYJrAqJCdYMlzdhhwZGDT/Fp3I0aaeCHiHuLsp
	 jKK2d+SbMNBvr1Yi5aRW/j1JtIJzo3FWYG7+gC3Wa/891FRnnQjaBcU5leLnRFSqFH
	 24Lkp7wHan8qtN7mz+ORUd9t9hQ52WD/rDhEEVMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfLEO6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:58:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:53192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbfLEO6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:58:23 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D181B2464F;
        Thu,  5 Dec 2019 14:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575557902;
        bh=AuxIhNzVenY1YORsvEg+wFXj6r70v48oXJ1iiIrdDFA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pXVarShPWA1HkuNKryg4YeaoV53ibXTtwYDPHUfdv+ET3MXVauHJJenM6X4SNL8vU
         wB4/Nyaq8Ri/tLoAs0p9NTyaCSHmAazwJ/d0oqvoMTO88+dX1B6NGF4N1OL/Z0kUS8
         sor0Wy2wU8tM/inVIX3LopV2IyAvHmviAXXFJhws=
Received: by mail-qk1-f170.google.com with SMTP id a10so3535922qko.9;
        Thu, 05 Dec 2019 06:58:21 -0800 (PST)
X-Gm-Message-State: APjAAAWIVPWDpU9pHKBLE+by3d6JJXUXunNrJ4rqMt8Qs+FgpyNd1Ugn
        i2aZgjupmLBFoD1hSoTYZaj/Rk/wpmBPOLtW2g==
X-Google-Smtp-Source: APXvYqwYaD7EYo6dbc77Xi0Q+9jY+nRYZTjhkmZUBgpjkyBCK7tDH4AyGL94U374y0Sk+qHHMLrnQoCPStJBctuP+qo=
X-Received: by 2002:a05:620a:1eb:: with SMTP id x11mr9028132qkn.254.1575557900890;
 Thu, 05 Dec 2019 06:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20191205140809.19413-1-p.paillet@st.com>
In-Reply-To: <20191205140809.19413-1-p.paillet@st.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 5 Dec 2019 08:58:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKzRj_SDUJH60gUpOqUE_cBbT7bwdo5OgK=iUwh_7xo+g@mail.gmail.com>
Message-ID: <CAL_JsqKzRj_SDUJH60gUpOqUE_cBbT7bwdo5OgK=iUwh_7xo+g@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: Convert stm32-pwr regulator to json-schema
To:     Pascal Paillet <p.paillet@st.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 8:08 AM Pascal Paillet <p.paillet@st.com> wrote:
>
> Convert the stm32-pwr regulator binding to DT schema format using
> json-schema.
>
> Signed-off-by: Pascal Paillet <p.paillet@st.com>
> ---
> Changes since v1:
> - remove a regulator.yaml reference
> - add /schemas/types.yaml#/definitions/phandle-array for supply

Why? That's wrong as *-supply already has a type definition.

> - fix indent below required
>
>  .../regulator/st,stm32mp1-pwr-reg.txt         | 43 ------------
>  .../regulator/st,stm32mp1-pwr-reg.yaml        | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
>
> diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt
> deleted file mode 100644
> index e372dd3f0c8a..000000000000
> --- a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.txt
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -STM32MP1 PWR Regulators
> ------------------------
> -
> -Available Regulators in STM32MP1 PWR block are:
> -  - reg11 for regulator 1V1
> -  - reg18 for regulator 1V8
> -  - usb33 for the swtich USB3V3
> -
> -Required properties:
> -- compatible: Must be "st,stm32mp1,pwr-reg"
> -- list of child nodes that specify the regulator reg11, reg18 or usb33
> -  initialization data for defined regulators. The definition for each of
> -  these nodes is defined using the standard binding for regulators found at
> -  Documentation/devicetree/bindings/regulator/regulator.txt.
> -- vdd-supply: phandle to the parent supply/regulator node for vdd input
> -- vdd_3v3_usbfs-supply: phandle to the parent supply/regulator node for usb33
> -
> -Example:
> -
> -pwr_regulators: pwr@50001000 {
> -       compatible = "st,stm32mp1,pwr-reg";
> -       reg = <0x50001000 0x10>;
> -       vdd-supply = <&vdd>;
> -       vdd_3v3_usbfs-supply = <&vdd_usb>;
> -
> -       reg11: reg11 {
> -               regulator-name = "reg11";
> -               regulator-min-microvolt = <1100000>;
> -               regulator-max-microvolt = <1100000>;
> -       };
> -
> -       reg18: reg18 {
> -               regulator-name = "reg18";
> -               regulator-min-microvolt = <1800000>;
> -               regulator-max-microvolt = <1800000>;
> -       };
> -
> -       usb33: usb33 {
> -               regulator-name = "usb33";
> -               regulator-min-microvolt = <3300000>;
> -               regulator-max-microvolt = <3300000>;
> -       };
> -};
> diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
> new file mode 100644
> index 000000000000..cc66a7c91260
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/st,stm32mp1-pwr-reg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STM32MP1 PWR voltage regulators
> +
> +maintainers:
> +  - Pascal Paillet <p.paillet@st.com>
> +
> +properties:
> +  compatible:
> +    const: st,stm32mp1,pwr-reg
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Input supply phandle(s) for vdd input
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +  vdd_3v3_usbfs-supply:
> +    description: Input supply phandle(s) for vdd_3v3_usbfs input
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +patternProperties:
> +  "^(reg11|reg18|usb33)$":
> +    type: object
> +
> +    allOf:
> +      - $ref: "regulator.yaml#"
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwr@50001000 {
> +      compatible = "st,stm32mp1,pwr-reg";
> +      reg = <0x50001000 0x10>;
> +      vdd-supply = <&vdd>;
> +      vdd_3v3_usbfs-supply = <&vdd_usb>;
> +
> +      reg11 {
> +        regulator-name = "reg11";
> +        regulator-min-microvolt = <1100000>;
> +        regulator-max-microvolt = <1100000>;
> +      };
> +
> +      reg18 {
> +        regulator-name = "reg18";
> +        regulator-min-microvolt = <1800000>;
> +        regulator-max-microvolt = <1800000>;
> +      };
> +
> +      usb33 {
> +        regulator-name = "usb33";
> +        regulator-min-microvolt = <3300000>;
> +        regulator-max-microvolt = <3300000>;
> +      };
> +    };
> +...
> --
> 2.17.1
>
