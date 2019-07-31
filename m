Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F550C41514
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070D021855
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564592466;
	bh=y/z8SK50ZpO4nCmvVJnpvHDo1YUj59MbZ52y+l8J5m0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=i8nmJ9FXUostJUJcEV4TrMH11DtUMOyccXEpcfOaJKfA3BMzyyhAJMf5lgt7RkhyE
	 nmQfUbHRlcPYThJYSIvgXMB0Jo94DPmZIiZbxove/OcXNr76d6TW+eTclAthy4RSlO
	 Vv0Mq2ikMZTh4ppyj22qsjJAwpMH0E8NokbDS5Ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfGaRBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 13:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbfGaRBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:01:04 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36D1421855;
        Wed, 31 Jul 2019 17:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564592463;
        bh=y/z8SK50ZpO4nCmvVJnpvHDo1YUj59MbZ52y+l8J5m0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HbwUPQ/TqNvkzRJEcfZ45zRKq9UrnGWvUXJ0/cdlWu/BJVBs2LG/ZZYYUrk4dGsAo
         AjbOYmZU11vX9u5eeQwPrz6tRO6FbPeES2AcQ8GI18tGedmrKCP7LT72FixIM3jwNu
         Aak7Z3x3bzlKlc3NTPWHGAeUTjEWh4pIQALXNY0k=
Received: by mail-qt1-f175.google.com with SMTP id h18so67318021qtm.9;
        Wed, 31 Jul 2019 10:01:03 -0700 (PDT)
X-Gm-Message-State: APjAAAXqChy7pPlRu0B5aU6wkXLxK9WpOTkzfuqNg0N6vHtBX+REdSMn
        36P/e+93kCh1KZ0rjt3J8TdeIMkKpdi66sFzbQ==
X-Google-Smtp-Source: APXvYqyjhn7/hvSOJl+L9+ZR20USCeZlDySkINDz19gr0YGu/PGoSbb4n4RnD39j2VWH+e65HF3uPE1NOiig1AteLQA=
X-Received: by 2002:a0c:b786:: with SMTP id l6mr89053606qve.148.1564592462233;
 Wed, 31 Jul 2019 10:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190731121409.17285-1-glaroque@baylibre.com> <20190731121409.17285-2-glaroque@baylibre.com>
 <f0f0dfe5-0cd3-5275-53ff-cfc4bb44f7e6@baylibre.com>
In-Reply-To: <f0f0dfe5-0cd3-5275-53ff-cfc4bb44f7e6@baylibre.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 31 Jul 2019 11:00:50 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Z1JvvtrDBtqbcuzdy_k5=OSSLQ7ezKvs9-oyvGi=-9A@mail.gmail.com>
Message-ID: <CAL_Jsq+Z1JvvtrDBtqbcuzdy_k5=OSSLQ7ezKvs9-oyvGi=-9A@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: thermal: Add DT bindings documentation
 for Amlogic Thermal
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Guillaume La Roque <glaroque@baylibre.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 6:44 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 31/07/2019 14:14, Guillaume La Roque wrote:
> > Adding the devicetree binding documentation for the Amlogic temperature
> > sensor found in the Amlogic Meson G12 SoCs.
> > the G12A  and G12B SoCs are supported.
> >
> > Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> > ---
> >  .../bindings/thermal/amlogic,thermal.yaml     | 58 +++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> > new file mode 100644
> > index 000000000000..1e2fe84da13d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> > @@ -0,0 +1,58 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/thermal/amlogic,thermal.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Amlogic Thermal Driver
> > +
> > +maintainers:
> > +  - Guillaume La Roque <glaroque@baylibre.com>
> > +
> > +description: Amlogic Thermal driver
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - amlogic,g12-cpu-thermal
> > +              - amlogic,g12-ddr-thermal
> > +          - enum:
> > +              - amlogic,g12-thermal
>
> Shouldn't be :
>     compatible:
>         items:
>           - enum:
>               - amlogic,g12-cpu-thermal
>               - amlogic,g12-ddr-thermal
>           - const:
>               - amlogic,g12-thermal
>
> instead ?

Yes, except 'const' is a string, not list value.

>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  amlogic,ao-secure:
> > +    description: phandle to the ao-secure syscon
> > +    allOf:
> > +     - $ref: /schemas/types.yaml#/definitions/uint32

phandle, not uint32

> > +
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - amlogic,ao-secure
> > +
> > +examples:
> > +  - |
> > +        cpu_temp: temperature-sensor@ff634800 {
> > +                compatible = "amlogic,g12-cpu-thermal",
> > +                             "amlogic,g12-thermal";
> > +                reg = <0x0 0xff634800 0x0 0x50>;
> > +                interrupts = <0x0 0x24 0x0>;
> > +                clocks = <&clk 164>;
> > +                status = "okay";
> > +                #thermal-sensor-cells = <1>;
> > +                amlogic,ao-secure = <&sec_AO>;
> > +        };
> > +...
> > \ No newline at end of file

Fix this.


> >
>
