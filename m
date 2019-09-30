Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF8AC388F3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2333A21855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 09:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ENKDUxj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbfI3Jf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 05:35:57 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44631 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbfI3Jf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:35:57 -0400
Received: by mail-ua1-f66.google.com with SMTP id n2so3920226ual.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 02:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gzD2qGvL3VizkE9nQvu95DK0V9ar1WcYyRCEdbmgd/s=;
        b=ENKDUxj2S/PL76NTuZ0LtDt8Xp1Qggith5LsiWQ1vVZE86Qa0ly016ttBl1QI6INFA
         BIGRhlxIJzDpY38IboaFgI4jFzR0GGBsoPYCWeEyoCNOvhOb4OZ1VsFSEN+dsHt/LcE0
         QFanGtNHxC8kL9yMg0gmoLHkIz6c2u4tUG4MyElYibFOJw2SlT+Z2lf7RknOjUZXAvaS
         gCFO/YGYKX29t/zhpJATFktFYBI5MDaPbL1eN6PHRS9wNUmLzIOYopZiy/gAfqQ6E54D
         lQT1KLjBXc7GtGAkYyUCcFHVDZCAUlF3v4WinAc9LgL0e+DwE1i4A+7hLPWE3HJLvdJn
         gV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gzD2qGvL3VizkE9nQvu95DK0V9ar1WcYyRCEdbmgd/s=;
        b=YP6YtCfA/5wyMzTxj6l/tfGFxBZpz6ZqyF5lHHsWljhISTh56cJxaa08eRjC1X845Z
         xNbolyrZqskOH84/t0L6A/qTWIlbIixbQmCsP4DuFrq1m6/NRF4YUe4AXf/4muCqyLAe
         6I9NFTL2h3ZBs9QfgKyrdAv0hclbRrgQvHpieVfD55R9X6AUUJ/Ht78qsivPpcPeyOHm
         Mp4KRYcELAMFJ7ees/CKCnga+wI2NoB7bXGb3ZoQUVW7yyCMjHt4WKWaCfbNxOpYc4Uj
         O/ggj38i4l/vD0utjmIIxmH8zenhx0lKnwVxMOMyiU6G6DJS+/rZlwJywAwmNCsgjoXc
         znTg==
X-Gm-Message-State: APjAAAXKdSwDCFY5q8e790sYXCccQ/vGbR06CoTbZyehbOOtG2m24z5l
        nQV8hUNEzIYNSR6Cz2rz0KaXWnWC/UI9rGIFrbEG1g==
X-Google-Smtp-Source: APXvYqwOPzgEcdOwEVKUjzTC90Fkp81Mt7170e3s+ZrPHeKlCkhi0dtBcyVb9k3LPsI52iJjSoPVhKu5BeDpUuzi5Dg=
X-Received: by 2002:ab0:ed:: with SMTP id 100mr4570681uaj.48.1569836156110;
 Mon, 30 Sep 2019 02:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190927184352.28759-1-glaroque@baylibre.com> <20190927184352.28759-2-glaroque@baylibre.com>
In-Reply-To: <20190927184352.28759-2-glaroque@baylibre.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 30 Sep 2019 15:05:44 +0530
Message-ID: <CAHLCerMDyuLW-XJ6XxnDq5Th42g_970e_Scqtuxo0r0=pbSWdA@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] dt-bindings: thermal: Add DT bindings
 documentation for Amlogic Thermal
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-amlogic@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 12:14 AM Guillaume La Roque
<glaroque@baylibre.com> wrote:
>
> Adding the devicetree binding documentation for the Amlogic temperature
> sensor found in the Amlogic Meson G12A and G12B SoCs.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  .../bindings/thermal/amlogic,thermal.yaml     | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
>
> diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> new file mode 100644
> index 000000000000..f761681e4c0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/amlogic,thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Thermal
> +
> +maintainers:
> +  - Guillaume La Roque <glaroque@baylibre.com>
> +
> +description: Binding for Amlogic Thermal
> +
> +properties:
> +  compatible:
> +      items:
> +        - enum:
> +            - amlogic,g12a-cpu-thermal
> +            - amlogic,g12a-ddr-thermal
> +        - const: amlogic,g12a-thermal
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  amlogic,ao-secure:
> +    description: phandle to the ao-secure syscon
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - amlogic,ao-secure
> +
> +examples:
> +  - |
> +        cpu_temp: temperature-sensor@ff634800 {
> +                compatible = "amlogic,g12a-cpu-thermal",
> +                             "amlogic,g12a-thermal";
> +                reg = <0xff634800 0x50>;
> +                interrupts = <0x0 0x24 0x0>;
> +                clocks = <&clk 164>;
> +                #thermal-sensor-cells = <0>;
> +                amlogic,ao-secure = <&sec_AO>;
> +        };
> +...
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
