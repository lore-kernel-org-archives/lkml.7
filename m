Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09886C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54F421783
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569326609;
	bh=FVXD0EQ8IlB715/pO2lsW/M4CnnPoY9GcJoAlb/ACJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UbGX5IrM/ziQntM0S6i9A2qNd2/BucRs8rnaPCI6gAOV2v0zIj+1YEwnFMFUnlMhY
	 V9/dG/Cjyiv+S4Ek2OkCAQqGKDqe7mEYBb7gn6V/rDE1W1eqmUCL9xEKZR1luUyuQ+
	 oriBaTbn61y4bLCI5EJUbFBb9SjVOnNBte1/expo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440913AbfIXMD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:03:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50659 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439102AbfIXMD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:03:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so1975334wmg.0;
        Tue, 24 Sep 2019 05:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sjo+Lrj1qTUgmSuAuE79qD+nBwV4Q3y5awIkpd/H5wg=;
        b=Giah2ejId29lTxWALXaHZOxeGzs2PIkylL61a2OL/6zyXrzfPBDcePvjRI1WNIj2zH
         fdiG3nw8MnXDHnnf6H7I66nTjfCzi6ba5s+YKGIcVRUcPAyexym3WuMsU+fLMpBAYOYr
         NXO3LwLvLSq+oSbBW+c3i/oX3DDJbNTDpY+j7SoCTpoOfX3P3c9cRw7qWfLaJP/5OgL8
         0dbi3xV9k3GjWojICazZlArb3CkaE7Zt0lBBg3CbRmrRYv4XdbMWulWFMuvbQoYAukuz
         OJjxVwD8vQ1OHaUOe3Q8cWxoHJM3XSVKTvdGw+/xw2jerxuL+9aJsjzAhejp7eBi5CZu
         IhHA==
X-Gm-Message-State: APjAAAWouL1vXQtmYziD8ZwVbHpQSVNvo4KvQ3LwLu8LQvcfG4EAs7pI
        7SdrgSS000OnFrTxBliUpiU=
X-Google-Smtp-Source: APXvYqxZUbaQ37Q13q+S246AZAj41v5+UhfcJZ+9QSSa+hiONfo7LI4ynD8TRc4Sr2xXkpcP4vHssQ==
X-Received: by 2002:a1c:cf8c:: with SMTP id f134mr2504729wmg.174.1569326605171;
        Tue, 24 Sep 2019 05:03:25 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id y186sm3279338wmb.41.2019.09.24.05.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 05:03:23 -0700 (PDT)
Date:   Tue, 24 Sep 2019 14:03:20 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>
Subject: Re: [PATCH v4] dt-bindings: sound: Convert Samsung I2S controller to
 dt-schema
Message-ID: <20190924120320.GB9218@pi3>
References: <CGME20190924115601eucas1p13b27b09fcd22bb3961fa2491380c40eb@eucas1p1.samsung.com>
 <20190924115553.25982-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924115553.25982-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 01:55:53PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Convert Samsung I2S controller to newer dt-schema format.
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v4:
> - Removed description of i2s device nodes' clocks from
> 'clocks' property.
> - Added 'clock-output-names' property.
> - Added description of clock names.
> - Added '#clock-cells' property to required properties
> - Description of the provided clocks moved to samsung-i2s.h
> in separate patch
> 
> Best regards,
> Maciej Falkowski
> ---
>  .../devicetree/bindings/sound/samsung-i2s.txt |  84 -----------
>  .../bindings/sound/samsung-i2s.yaml           | 136 ++++++++++++++++++
>  2 files changed, 136 insertions(+), 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.txt b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
> deleted file mode 100644
> index a88cb00fa096..000000000000
> --- a/Documentation/devicetree/bindings/sound/samsung-i2s.txt
> +++ /dev/null
> @@ -1,84 +0,0 @@
> -* Samsung I2S controller
> -
> -Required SoC Specific Properties:
> -
> -- compatible : should be one of the following.
> -   - samsung,s3c6410-i2s: for 8/16/24bit stereo I2S.
> -   - samsung,s5pv210-i2s: for 8/16/24bit multichannel(5.1) I2S with
> -     secondary fifo, s/w reset control and internal mux for root clk src.
> -   - samsung,exynos5420-i2s: for 8/16/24bit multichannel(5.1) I2S for
> -     playback, stereo channel capture, secondary fifo using internal
> -     or external dma, s/w reset control, internal mux for root clk src
> -     and 7.1 channel TDM support for playback. TDM (Time division multiplexing)
> -     is to allow transfer of multiple channel audio data on single data line.
> -   - samsung,exynos7-i2s: with all the available features of exynos5 i2s,
> -     exynos7 I2S has 7.1 channel TDM support for capture, secondary fifo
> -     with only external dma and more no.of root clk sampling frequencies.
> -   - samsung,exynos7-i2s1: I2S1 on previous samsung platforms supports
> -     stereo channels. exynos7 i2s1 upgraded to 5.1 multichannel with
> -     slightly modified bit offsets.
> -
> -- reg: physical base address of the controller and length of memory mapped
> -  region.
> -- dmas: list of DMA controller phandle and DMA request line ordered pairs.
> -- dma-names: identifier string for each DMA request line in the dmas property.
> -  These strings correspond 1:1 with the ordered pairs in dmas.
> -- clocks: Handle to iis clock and RCLK source clk.
> -- clock-names:
> -  i2s0 uses some base clocks from CMU and some are from audio subsystem internal
> -  clock controller. The clock names for i2s0 should be "iis", "i2s_opclk0" and
> -  "i2s_opclk1" as shown in the example below.
> -  i2s1 and i2s2 uses clocks from CMU. The clock names for i2s1 and i2s2 should
> -  be "iis" and "i2s_opclk0".
> -  "iis" is the i2s bus clock and i2s_opclk0, i2s_opclk1 are sources of the root
> -  clk. i2s0 has internal mux to select the source of root clk and i2s1 and i2s2
> -  doesn't have any such mux.
> -- #clock-cells: should be 1, this property must be present if the I2S device
> -  is a clock provider in terms of the common clock bindings, described in
> -  ../clock/clock-bindings.txt.
> -- clock-output-names (deprecated): from the common clock bindings, names of
> -  the CDCLK I2S output clocks, suggested values are "i2s_cdclk0", "i2s_cdclk1",
> -  "i2s_cdclk3" for the I2S0, I2S1, I2S2 devices respectively.
> -
> -There are following clocks available at the I2S device nodes:
> - CLK_I2S_CDCLK    - the CDCLK (CODECLKO) gate clock,
> - CLK_I2S_RCLK_PSR - the RCLK prescaler divider clock (corresponding to the
> -		    IISPSR register),
> - CLK_I2S_RCLK_SRC - the RCLKSRC mux clock (corresponding to RCLKSRC bit in
> -		    IISMOD register).
> -
> -Refer to the SoC datasheet for availability of the above clocks.
> -The CLK_I2S_RCLK_PSR and CLK_I2S_RCLK_SRC clocks are usually only available
> -in the IIS Multi Audio Interface.
> -
> -Note: Old DTs may not have the #clock-cells property and then not use the I2S
> -node as a clock supplier.
> -
> -Optional SoC Specific Properties:
> -
> -- samsung,idma-addr: Internal DMA register base address of the audio
> -  sub system(used in secondary sound source).
> -- pinctrl-0: Should specify pin control groups used for this controller.
> -- pinctrl-names: Should contain only one value - "default".
> -- #sound-dai-cells: should be 1.
> -
> -
> -Example:
> -
> -i2s0: i2s@3830000 {
> -	compatible = "samsung,s5pv210-i2s";
> -	reg = <0x03830000 0x100>;
> -	dmas = <&pdma0 10
> -		&pdma0 9
> -		&pdma0 8>;
> -	dma-names = "tx", "rx", "tx-sec";
> -	clocks = <&clock_audss EXYNOS_I2S_BUS>,
> -		<&clock_audss EXYNOS_I2S_BUS>,
> -		<&clock_audss EXYNOS_SCLK_I2S>;
> -	clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
> -	#clock-cells = <1>;
> -	samsung,idma-addr = <0x03000000>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&i2s0_bus>;
> -	#sound-dai-cells = <1>;
> -};
> diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.yaml b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
> new file mode 100644
> index 000000000000..7d2750c26f11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
> @@ -0,0 +1,136 @@
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
> +      exynos7 I2S has 7.1 channel TDM support for capture, secondary fifo
> +      with only external dma and more no.of root clk sampling frequencies.
> +
> +      samsung,exynos7-i2s1: I2S1 on previous samsung platforms supports
> +      stereo channels. exynos7 i2s1 upgraded to 5.1 multichannel with
> +      slightly modified bit offsets.
> +    enum:
> +      - samsung,s3c6410-i2s
> +      - samsung,s5pv210-i2s
> +      - samsung,exynos5420-i2s
> +      - samsung,exynos7-i2s
> +      - samsung,exynos7-i2s1
> +
> +  reg:
> +    maxItems: 1
> +
> +  dmas:
> +    minItems: 2
> +    maxItems: 3
> +
> +  dma-names:
> +    oneOf:
> +      - items:
> +          - const: tx
> +          - const: rx
> +      - items:
> +          - const: tx
> +          - const: rx
> +          - const: tx-sec
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +          - const: iis
> +      - items: # for i2s0
> +          - const: iis
> +          - const: i2s_opclk0
> +          - const: i2s_opclk1
> +      - items: # for i2s1 and i2s2
> +          - const: iis
> +          - const: i2s_opclk0
> +    description: |
> +      "iis" is the i2s bus clock and i2s_opclk0, i2s_opclk1 are sources
> +      of the root clk. i2s0 has internal mux to select the source
> +      of root clk and i2s1 and i2s2 doesn't have any such mux.
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clock-output-names: # deprecated

Instead:
  deprecated: true

> +    oneOf:
> +      - items: # for i2s0
> +          - const: i2s_cdclk0
> +      - items: # for i2s1
> +          - const: i2s_cdclk1
> +      - items: # for i2s2
> +          - const: i2s_cdclk2
> +    description: Names of the CDCLK I2S output clocks.
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
> +  - "#clock-cells"

Before, this was not a required property, except when registering a
clock provider. Are you 100% sure it we need to register clock provider
on every SoC?

For example, Exynos3250 does not do it... others also might.

Best regards,
Krzysztof


> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/exynos-audss-clk.h>
> +
> +    i2s0: i2s@3830000 {
> +        compatible = "samsung,s5pv210-i2s";
> +        reg = <0x03830000 0x100>;
> +        dmas = <&pdma0 10>,
> +                <&pdma0 9>,
> +                <&pdma0 8>;
> +        dma-names = "tx", "rx", "tx-sec";
> +        clocks = <&clock_audss EXYNOS_I2S_BUS>,
> +                <&clock_audss EXYNOS_I2S_BUS>,
> +                <&clock_audss EXYNOS_SCLK_I2S>;
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
> 
> 
