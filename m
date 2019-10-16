Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B68ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B637E2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zYuc2eZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391864AbfJPJIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:08:31 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37039 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730579AbfJPJIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:08:30 -0400
Received: by mail-vs1-f68.google.com with SMTP id p13so15114034vsr.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 02:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NdVzA6qPVlAmhSw+AF0RzsUEa7rtQhimXzVFQeLQmeY=;
        b=zYuc2eZ9oGLA1uBehnPVw3qQghPYysUXj+5+wQkhQ8Q0vhUZYyls8WZWwVTpZaz/f0
         xx8XuURCVETsEjW7RrxU1lVytuaF9SDoyRLW/7wZZGtdLI8npkck9Gwy33hWjJsm9t8V
         HNuJYmlMK0sCHnbt1jceoZARW15VMQkafTKURVi4D+6C9YBX2PowbgGNj8IZdSgFQXQy
         /kELXCPaXG+99tz2Wh2H+ep7a8hf4uHc7CHJoWN2CoezsBwtXMFbvWs0xSs7WBraLDdG
         sXnrjlzPIDxhfFwhCBi1hoys4BDH/gpaAv4sVVTUG00b5u/K0RO0PDYFLJ6I94sGrokH
         L3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdVzA6qPVlAmhSw+AF0RzsUEa7rtQhimXzVFQeLQmeY=;
        b=Xzdg8OCmkKq9K3QQW40CeNkEpE6EmBPzg//rrTOjgIO/472yj0U8g9Dd9GhowZ+tXk
         g1SIAmjloZ2ogttMwsOpF35IljimIYBG8W+OFpwR0TJJKheon9c0Fl4sWpCQxNpO4zCW
         QgyuU2SVpMon+oln63kEUzfHqeduw6T6joW206FJVsOQxpL1IECJqyELNeqKEfBxv2Nw
         M/smh4iZ9VWsMYO1Y0u8EkUoxEpr26c3iIsKiPZuAHzVRemMks35/SpJ/065v42mo6Oy
         MsMKlxyaXAUyEjQo+VMzdcgIbxrD/5FsDEUuQPvLFSkuio3LjwrRBTEDAyZwac4Nw5k1
         kzIw==
X-Gm-Message-State: APjAAAVd/MlpuHVlrs9S0LwUfM6ifKonNcfwFD9pA2TSbHKPol5Qq8tq
        KPoxG2mprW7JSCA34nWwI6wkqnoYOMvnckicz1z0Rw==
X-Google-Smtp-Source: APXvYqzUUdjO1L90uCeShcgC6GevLXtyLsvHvDJTSP9JdgM4/IYVfwW7FFgabsmOFF/VTLlGKr6pTf/ZFohS3hAj90I=
X-Received: by 2002:a67:edce:: with SMTP id e14mr16990631vsp.182.1571216909051;
 Wed, 16 Oct 2019 02:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191004090114.30694-1-glaroque@baylibre.com> <20191004090114.30694-5-glaroque@baylibre.com>
In-Reply-To: <20191004090114.30694-5-glaroque@baylibre.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 16 Oct 2019 14:38:18 +0530
Message-ID: <CAHLCerN+SCuWZJw4OgR7KuDWpkXf5xo-1q=pe0axH2W=DffUXw@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] arm64: dts: meson: g12: Add minimal thermal zone
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 2:31 PM Guillaume La Roque <glaroque@baylibre.com> wrote:
>
> Add minimal thermal zone for two temperature sensor
> One is located close to the DDR and the other one is
> located close to the PLLs (between the CPU and GPU)
>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  .../boot/dts/amlogic/meson-g12-common.dtsi    | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 0660d9ef6a86..a98c16e163c2 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -12,6 +12,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
>  #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
> +#include <dt-bindings/thermal/thermal.h>
>
>  / {
>         interrupt-parent = <&gic>;
> @@ -94,6 +95,61 @@
>                 #size-cells = <2>;
>                 ranges;
>
> +               thermal-zones {
> +                       cpu_thermal: cpu-thermal {
> +                               polling-delay = <1000>;
> +                               polling-delay-passive = <100>;
> +                               thermal-sensors = <&cpu_temp>;
> +
> +                               trips {
> +                                       cpu_passive: cpu-passive {
> +                                               temperature = <85000>; /* millicelsius */
> +                                               hysteresis = <2000>; /* millicelsius */
> +                                               type = "passive";
> +                                       };
> +
> +                                       cpu_hot: cpu-hot {
> +                                               temperature = <95000>; /* millicelsius */
> +                                               hysteresis = <2000>; /* millicelsius */
> +                                               type = "hot";
> +                                       };
> +
> +                                       cpu_critical: cpu-critical {
> +                                               temperature = <110000>; /* millicelsius */
> +                                               hysteresis = <2000>; /* millicelsius */
> +                                               type = "critical";
> +                                       };
> +                               };
> +                       };
> +
> +                       ddr_thermal: ddr-thermal {
> +                               polling-delay = <1000>;
> +                               polling-delay-passive = <100>;
> +                               thermal-sensors = <&ddr_temp>;
> +
> +                               trips {
> +                                       ddr_passive: ddr-passive {
> +                                               temperature = <85000>; /* millicelsius */
> +                                               hysteresis = <2000>; /* millicelsius */
> +                                               type = "passive";
> +                                       };
> +
> +                                       ddr_critical: ddr-critical {
> +                                               temperature = <110000>; /* millicelsius */
> +                                               hysteresis = <2000>; /* millicelsius */
> +                                               type = "critical";
> +                                       };
> +                               };
> +
> +                               cooling-maps {
> +                                       map {
> +                                               trip = <&ddr_passive>;
> +                                               cooling-device = <&mali THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                                       };
> +                               };
> +                       };
> +               };
> +
>                 ethmac: ethernet@ff3f0000 {
>                         compatible = "amlogic,meson-axg-dwmac",
>                                      "snps,dwmac-3.70a",
> @@ -2412,6 +2468,7 @@
>                         assigned-clock-rates = <0>, /* Do Nothing */
>                                                <800000000>,
>                                                <0>; /* Do Nothing */
> +                       #cooling-cells = <2>;
>                 };
>         };
>
> --
> 2.17.1
>
