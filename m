Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CF2C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EE321920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568805335;
	bh=Z1ZIFhhy6smRaUk/cnY/1dt44ZCoDTqFKOckpsCYBxw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BVwt8cgE8V7b2BwnPpxj6PJiXqGnGHBt+KPC59KAiskKH8E0TFcUBfwDooAe9PfvF
	 BvTLOSsY54GeSunydiITZJhDMJ9mQKXrBAMwyfwLjZlI5TRxF5TN/LSGlmkwLmZ/iB
	 fx0uZ3aOiPuHnW+hM0UHGuvpXZ6rIInVV5A4ZULM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbfIRLPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 07:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbfIRLPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:15:34 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EA8A21920;
        Wed, 18 Sep 2019 11:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568805333;
        bh=Z1ZIFhhy6smRaUk/cnY/1dt44ZCoDTqFKOckpsCYBxw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tdoNm7MQM6vlD8Re6p+4+TuUhvb08H7edBsKvOUfJfR+FTIcHmtJQQ5J8sWbMUlSS
         b2JaTeE+3aiZE+izXmc0Pyc0Cd+i5ljeUswsogSlbZV/K2cvcGTxGHiWIYVlUjaGnh
         X7j3MRHojIedB0CkIhuMj+sG/4fs441A5OUQi3i0=
Received: by mail-lj1-f172.google.com with SMTP id q64so6763815ljb.12;
        Wed, 18 Sep 2019 04:15:32 -0700 (PDT)
X-Gm-Message-State: APjAAAXt2KJioMhrcpVLvBIGZIK6vDigNmtFQ5lLNnuhab8/dEar847O
        yRGC+hOy7nVFLDOZRC4c3VGEWqJC7qnNPmOL5xA=
X-Google-Smtp-Source: APXvYqwqIMrcCSDnVOm7QL2aENfE9D2HYtsS7Rg6tiAb7a6LF8Si7qSp+YiCRLA7O5nuNdgm649/uCGZusiMIQO21ws=
X-Received: by 2002:a2e:3201:: with SMTP id y1mr1880694ljy.5.1568805331254;
 Wed, 18 Sep 2019 04:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190917120634eucas1p20addfc4e369468561714f3c44d3d8bf5@eucas1p2.samsung.com>
 <20190917111413.22711-1-m.falkowski@samsung.com> <20190917120627.28357-1-m.falkowski@samsung.com>
In-Reply-To: <20190917120627.28357-1-m.falkowski@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 18 Sep 2019 13:15:19 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc=OXLY3ynUKGhVduuiSyzT_1Po19Hhwd6fGkbaar8GQQ@mail.gmail.com>
Message-ID: <CAJKOXPc=OXLY3ynUKGhVduuiSyzT_1Po19Hhwd6fGkbaar8GQQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: sound: Convert Samsung SMDK audio complex
To:     Maciej Falkowski <m.falkowski@samsung.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, sbkim73@samsung.com,
        s.nawrocki@samsung.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Andrzej Hajda <a.hajda@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019 at 14:06, Maciej Falkowski <m.falkowski@samsung.com> wrote:
>
> Convert Samsung SMDK audio complex to newer dt-schema format.
>
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2:
> - Added missing Signed-off-by certificate

I understood you cannot certify that you have the rights to send the
patch. Adding someone's else Signed-off-by does not solve the problem
of lack of such permission. Marek could certify that but you cannot
certify for him. Otherwise it really makes the process bogus - anyone
can add Linus' SoB and say that Linus certified the rights to include
this contribution.

In my understanding of Developer's Certificate of Origin 1.1, these
patches do not meet the criteria and therefore should not be included
from that point of view.

One minor comment further.

> ---
>  .../bindings/sound/samsung,smdk-wm8994.txt    | 14 -------
>  .../bindings/sound/samsung,smdk-wm8994.yaml   | 38 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 14 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.yaml
>
> diff --git a/Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt b/Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt
> deleted file mode 100644
> index 4686646fb122..000000000000
> --- a/Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.txt
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -Samsung SMDK audio complex
> -
> -Required properties:
> -- compatible : "samsung,smdk-wm8994"
> -- samsung,i2s-controller: The phandle of the Samsung I2S0 controller
> -- samsung,audio-codec: The phandle of the WM8994 audio codec
> -Example:
> -
> -sound {
> -               compatible = "samsung,smdk-wm8994";
> -
> -               samsung,i2s-controller = <&i2s0>;
> -               samsung,audio-codec = <&wm8994>;
> -};
> diff --git a/Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.yaml b/Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.yaml
> new file mode 100644
> index 000000000000..a66c0dfdeb57
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/samsung,smdk-wm8994.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/samsung,smdk-wm8994.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung SoC SMDK audio complex
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +  - Sangbeom Kim <sbkim73@samsung.com>

Unfortunately there was no mails coming from Sangbeom Kim so I think
he is not active in maintaining these pieces. Let's skip this entry.

Best regards,
Krzysztof

> +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
> +
> +properties:
> +  compatible:
> +    const: "samsung,smdk-wm8994"
> +
> +  samsung,i2s-controller:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of the Samsung I2S0 controller
> +
> +  samsung,audio-codec:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of the WM8994 audio codec
> +
> +required:
> +  - compatible
> +  - samsung,i2s-controller
> +  - samsung,audio-codec
> +
> +examples:
> +  - |
> +    sound {
> +        compatible = "samsung,smdk-wm8994";
> +        samsung,i2s-controller = <&i2s0>;
> +        samsung,audio-codec = <&wm8994>;
> +    };
> +
> --
> 2.17.1
>
