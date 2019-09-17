Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E44C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A539E21924
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568725553;
	bh=6dx+pGYbMKZYGufowQPf+5IJvdiHtWxdf/mNfFBW+XI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=g3i6yovaVuvIgy2dajUrpHZdPoYnad9aw+Q1j+A6Z9XJkq5W6dy/8lfFq1n6FHf8P
	 ktgRkYXJDnQW/uAFgCBNGcUPBUc0r7vN3PfJQ3DdaIZeLTP4Q/GgkFht9G48bhPe3X
	 F7NVw/Lju4TmJ/Q1zI+4AT1Y9rY5DFMj/1jkaLaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfIQNFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfIQNFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:05:52 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACE5521897;
        Tue, 17 Sep 2019 13:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568725551;
        bh=6dx+pGYbMKZYGufowQPf+5IJvdiHtWxdf/mNfFBW+XI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y0AjA5Ai77LxzbSqLfZnFwbvFq6nGMeUSrnIqextmcWyJY8IFhnKTk4DKegpGcAPF
         51sMV/v90zXf9r53PWp/Vk/jglOBRJq8FJ6r9zkFw22al9veV1fET0kW6MLWU4jjHN
         FDBB7NtqwpDA0Pikh9YORVSDrIiqi1HFHDB5FgXw=
Received: by mail-qk1-f181.google.com with SMTP id s18so3898903qkj.3;
        Tue, 17 Sep 2019 06:05:51 -0700 (PDT)
X-Gm-Message-State: APjAAAXakWmkwrS00yehNpyet9X+drlZ7x8oR1/1Z7yMCYdsDoY9K1UY
        IoDkLaGTF4KrlNTcecsTqoRHeWYuG/UfKXYOJg==
X-Google-Smtp-Source: APXvYqz2HPAde8iLviBNps8veZshe4FIhl9v/4PCg3wURvc7VWi1W+/WDS08X9I33YRoPGdWrfn+3FvonmV20YnIfeo=
X-Received: by 2002:a37:be87:: with SMTP id o129mr3695035qkf.254.1568725550865;
 Tue, 17 Sep 2019 06:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190917120517eucas1p1188d244fac2d10d7990363ff25ffb70d@eucas1p1.samsung.com>
 <20190917111413.22711-1-m.falkowski@samsung.com> <20190917120452.28135-1-m.falkowski@samsung.com>
In-Reply-To: <20190917120452.28135-1-m.falkowski@samsung.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 17 Sep 2019 08:05:38 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJmjUR63i_hKUuZwDu42rebwABHu62bQoxTRRJu5yObEA@mail.gmail.com>
Message-ID: <CAL_JsqJmjUR63i_hKUuZwDu42rebwABHu62bQoxTRRJu5yObEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: Convert Samsung I2S controller
 to dt-schema
To:     Maciej Falkowski <m.falkowski@samsung.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 7:05 AM Maciej Falkowski
<m.falkowski@samsung.com> wrote:
>
> Convert Samsung I2S controller to newer dt-schema format.
>
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2:
> - Added missing Signed-off-by certificate
> ---
>  .../devicetree/bindings/sound/samsung-i2s.txt |  84 -------------
>  .../bindings/sound/samsung-i2s.yaml           | 119 ++++++++++++++++++
>  2 files changed, 119 insertions(+), 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.yaml

> diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.yaml b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
> new file mode 100644
> index 000000000000..59dc76035cb4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/samsung-i2s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung SoC I2S controller
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +  - Sangbeom Kim <sbkim73@samsung.com>
> +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
> +
> +properties:
> +  compatible:
> +    description: |
> +      samsung,s3c6410-i2s: for 8/16/24bit stereo I2S.
> +
> +      samsung,s5pv210-i2s: for 8/16/24bit multichannel(5.1) I2S with
> +      secondary fifo, s/w reset control and internal mux for root clk src.
> +
> +      samsung,exynos5420-i2s: for 8/16/24bit multichannel(5.1) I2S for
> +      playback, stereo channel capture, secondary fifo using internal
> +      or external dma, s/w reset control, internal mux for root clk src
> +      and 7.1 channel TDM support for playback. TDM (Time division multiplexing)
> +      is to allow transfer of multiple channel audio data on single data line.
> +
> +      samsung,exynos7-i2s: with all the available features of exynos5 i2s.
> +
> +      exynos7 I2S has 7.1 channel TDM support for capture, secondary fifo
> +      with only external dma and more no.of root clk sampling frequencies.
> +
> +      samsung,exynos7-i2s1: I2S1 on previous samsung platforms supports
> +      stereo channels. exynos7 i2s1 upgraded to 5.1 multichannel with
> +      slightly modified bit offsets.
> +    enum:
> +      - "samsung,s3c6410-i2s"
> +      - "samsung,s5pv210-i2s"
> +      - "samsung,exynos5420-i2s"
> +      - "samsung,exynos7-i2s"
> +      - "samsung,exynos7-i2s1"

No need for quotes here.

> +
> +  reg:
> +    maxItems: 1
> +
> +  dmas:
> +    description: list of DMA controller phandle and DMA request line ordered pairs.

How many?

> +
> +  dma-names:
> +    description: |
> +      identifier string for each DMA request line in the dmas property.
> +      These strings correspond 1:1 with the ordered pairs in dmas.
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +          - const: iis
> +      - items:
> +          - const: iis
> +          - const: i2s_opclk0
> +      - items:
> +          - const: iis
> +          - const: i2s_opclk0
> +          - const: i2s_opclk1
> +    description: |
> +      "iis" is the i2s bus clock.
> +      For i2s1 and i2s2 - "iis", "i2s_opclk0"
> +      For i2s0 - "iis", "i2s_opclk0", "i2s_opclk1"
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  samsung,idma-addr:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Internal DMA register base address of the audio
> +      sub system(used in secondary sound source).
> +
> +  pinctrl-0:
> +    description: Should specify pin control groups used for this controller.
> +
> +  pinctrl-names:
> +    const: default
> +
> +  "#sound-dai-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - dmas
> +  - dma-names
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +    i2s0: i2s@3830000 {
> +        compatible = "samsung,s5pv210-i2s";
> +        reg = <0x03830000 0x100>;
> +        dmas = <&pdma0 10
> +                &pdma0 9
> +                &pdma0 8>;
> +        dma-names = "tx", "rx", "tx-sec";
> +        clocks = <&clock_audss 0>, // EXYNOS_I2S_BUS
> +                <&clock_audss 0>, // EXYNOS_I2S_BUS
> +                <&clock_audss 0>; // EXYNOS_SCLK_I2S
> +        clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
> +        #clock-cells = <1>;
> +        samsung,idma-addr = <0x03000000>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&i2s0_bus>;
> +        #sound-dai-cells = <1>;
> +    };
> +
> --
> 2.17.1
>
