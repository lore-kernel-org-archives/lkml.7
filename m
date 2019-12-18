Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D911C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D942176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576704592;
	bh=OLcr17vQiaq3/yEhYtOFPnQl+mL6KgCKEMsLrFYQTAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cY80pLq8KRzNEevZ1KCwyOf7Z7hTEUotn8eioIStYxaxYN86jZYhns5tlKO7zg1Ja
	 mZx/EhqnNFSoVQMv351X6E0hBslwHJwDeavfTc0d66PvPR8RI0jT/VhDHC3pvsPSwg
	 Zc3lrmwwsMw/gxAaoUpEfXUpc7u0uLgKJTJqQjas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfLRV3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:29:50 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42745 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfLRV3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:29:50 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so4193955otd.9;
        Wed, 18 Dec 2019 13:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wDM2oXW2WjLIWJ8dtwbGxlrEWHYPFuBas0gxx7BnSyk=;
        b=sVQDNtr24XZS99PbPvJnqpXJDuVgmc/adWOiS4MRKw5CXCSWBWYUFd6ktKA0udrHtS
         +fAh1TlUwUnqylJ77xCIr4+CRPcqifmawwSDsVO2sUT+kUVLIcoxyNqEp2BqarSGpZkg
         SNvyIC5/66k37q54LmSN3PegwE7VjNamSwfbdrZIIUzGfUa8JZV5OHxG83jqCd/GmU9J
         U3Okcv+iIrNpuVA/6pFs0675MZk8W9PmXDbJbj4fNX03iPwYz4EqCZaTBp0PPxWY4ktt
         hQpgTL2eBpUVjng+2P9tH5BUtOHUd05shfKtKUIjnPumPB2WSs5fqWf4ZsqmqvwfvEOb
         XW0w==
X-Gm-Message-State: APjAAAVVtKnF2sfa//VnvEaFqkCIEH+K6yQSwalUZ4lPX/gDHTpcttHS
        KbyQdv7j/++/F8XOhUBqsZzNxVQjZg==
X-Google-Smtp-Source: APXvYqwwFlopGqEycjvv03iWJXBVdFJM2gdClxHivGjG43t9jARXi0qUCBWzYv02BTbrZZiBCvZyyg==
X-Received: by 2002:a9d:588d:: with SMTP id x13mr4751412otg.6.1576704588690;
        Wed, 18 Dec 2019 13:29:48 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i2sm1239454oth.39.2019.12.18.13.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 13:29:47 -0800 (PST)
Date:   Wed, 18 Dec 2019 15:29:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, mark.rutland@arm.com, pdeschrijver@nvidia.com,
        pgaikwad@nvidia.com, spujar@nvidia.com, josephl@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/19] dt-bindings: tegra: Convert Tegra PMC bindings
 to YAML
Message-ID: <20191218212946.GA5498@bogus>
References: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
 <1576613046-17159-5-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576613046-17159-5-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 12:03:51PM -0800, Sowjanya Komatineni wrote:
> This patch adds YAML schema for Tegra PMC bindings.

$subject says convert. Where's removing the old file?

> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.yaml     | 291 +++++++++++++++++++++
>  1 file changed, 291 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
> new file mode 100644
> index 000000000000..ab614f1be177
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
> @@ -0,0 +1,291 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/tegra/nvidia,tegra20-pmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tegra Power Management Controller (PMC)
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Jonathan Hunter <jonathanh@nvidia.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: nvidia,tegra20-pmc
> +          - const: nvidia,tegra20-pmc
> +          - const: nvidia,tegra30-pmc
> +          - const: nvidia,tegra114-pmc
> +          - const: nvidia,tegra124-pmc
> +          - const: nvidia,tegra210-pmc

So compatible is supposed to be all 6 strings? You want an 'enum' here.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: pclk, clk32k_in
> +    description:
> +      pclk is the Tegra clock of that name and clk32k_in is 32KHz clock
> +      input to Tegra.
> +
> +  clocks:
> +    maxItems: 2
> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      Tegra PMC has clk_out_1, clk_out_2, and clk_out_3.
> +      Consumer of PMC clock should specify the desired clock by having
> +      the clock ID in its "clocks" phandle cell with pmc clock provider.
> +      See include/dt-bindings/soc/tegra-pmc.h for the list of Tegra PMC
> +      clock IDs.
> +
> +  nvidia,invert-interrupt:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Inverts the PMU interrupt signal.
> +      The PMU is an external Power Management Unit, whose interrupt output
> +      signal is fed into the PMC. This signal is optionally inverted, and
> +      then fed into the ARM GIC. The PMC is not involved in the detection
> +      or handling of this interrupt signal, merely its inversion.
> +
> +  nvidia,core-power-req-active-high:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Core power request active-high.
> +
> +  nvidia,sys-clock-req-active-high:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: System clock request active-high.
> +
> +  nvidia,combined-power-req:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: combined power request for CPU and Core.
> +
> +  nvidia,cpu-pwr-good-en:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      CPU power good signal from external PMIC to PMC is enabled.
> +
> +  nvidia,suspend-mode:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [0, 1, 2]
> +    description:
> +      The suspend mode that the platform should use.
> +      Mode 0 is for LP0, CPU + Core voltage off and DRAM in self-refresh
> +      Mode 1 is for LP1, CPU voltage off and DRAM in self-refresh
> +      Mode 2 is for LP2, CPU voltage off
> +
> +  nvidia,cpu-pwr-good-time:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: CPU power good time in uSec.
> +
> +  nvidia,cpu-pwr-off-time:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: CPU power off time in uSec.
> +
> +  nvidia,core-pwr-good-time:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      <Oscillator-stable-time Power-stable-time>
> +      Core power good time in uSec.
> +
> +  nvidia,core-pwr-off-time:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Core power off time in uSec.
> +
> +  nvidia,lp0-vec:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      <start length> Starting address and length of LP0 vector.
> +      The LP0 vector contains the warm boot code that is executed
> +      by AVP when resuming from the LP0 state.
> +      The AVP (Audio-Video Processor) is an ARM7 processor and
> +      always being the first boot processor when chip is power on
> +      or resume from deep sleep mode. When the system is resumed
> +      from the deep sleep mode, the warm boot code will restore
> +      some PLLs, clocks and then brings up CPU0 for resuming the
> +      system.
> +
> +  i2c-thermtrip:
> +    type: object
> +    description:
> +      On Tegra30, Tegra114 and Tegra124 if i2c-thermtrip subnode exists,
> +      hardware-triggered thermal reset will be enabled.
> +
> +    properties:
> +      nvidia,i2c-controller-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          ID of I2C controller to send poweroff command to PMU.
> +          Valid values are described in section 9.2.148
> +          "APBDEV_PMC_SCRATCH53_0" of the Tegra K1 Technical Reference
> +          Manual.
> +
> +      nvidia,bus-addr:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Bus address of the PMU on the I2C bus.
> +
> +      nvidia,reg-addr:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: PMU I2C register address to issue poweroff command.
> +
> +      nvidia,reg-data:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Poweroff command to write to PMU.
> +
> +      nvidia,pinmux-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Pinmux used by the hardware when issuing Poweroff command.
> +          Defaults to 0. Valid values are described in section 12.5.2
> +          "Pinmux Support" of the Tegra4 Technical Reference Manual.
> +
> +    required:
> +      - nvidia,i2c-controller-id
> +      - nvidia,bus-addr
> +      - nvidia,reg-addr
> +      - nvidia,reg-data

       additionalProperties: false

> +
> +  powergates:
> +    type: object
> +    description:
> +      This node contains a hierarchy of power domain nodes, which should
> +      match the powergates on the Tegra SoC. Each powergate node
> +      represents a power-domain on the Tegra SoC that can be power-gated
> +      by the Tegra PMC.
> +      Hardware blocks belonging to a power domain should contain
> +      "power-domains" property that is a phandle pointing to corresponding
> +      powergate node.
> +      Please refer to Tegra TRM for mode details on the powergate nodes to
> +      use for each power-gate block inside Tegra.
> +
> +    patternProperties:
> +      "^[a-z0-9]+$":
> +        if:
> +          type: object

It's better if you have node name patterns to match on than have to do 
this if/then.

> +        then:
> +          patternProperties:
> +            clocks:
> +              description:
> +                Must contain an entry for each clock required by the PMC
> +                for controlling a power-gate.
> +                See ../clocks/clock-bindings.txt document for more details.
> +
> +            resets:
> +              description:
> +                Must contain an entry for each reset required by the PMC
> +                for controlling a power-gate.
> +                See ../reset/reset.txt for more details.
> +
> +            '#power-domain-cells':
> +              description: Must be 0.
> +
> +    required:
> +      - clocks
> +      - resets
> +      - '#power-domain-cells'

These need property definitions.

> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    type: object
> +
> +    properties:
> +      pins:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description: Must contain name of the pad(s) to be configured.
> +
> +      low-power-enable:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: Configure the pad into power down mode.
> +
> +      low-power-disable:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description: Configure the pad into active mode.
> +
> +      power-source:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Must contain either TEGRA_IO_PAD_VOLTAGE_1V8 or
> +          TEGRA_IO_PAD_VOLTAGE_3V3 to select between signaling voltages.
> +          The values are defined in
> +          include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h.
> +          Power state can be configured on all Tegra124 and Tegra132
> +          pads. None of the Tegra124 or Tegra132 pads support signaling
> +          voltage switching.
> +          All of the listed Tegra210 pads except pex-cntrl support power
> +          state configuration. Signaling voltage switching is supported
> +          on below Tegra210 pads.
> +          audio, audio-hv, cam, dbg, dmic, gpio, pex-cntrl, sdmmc1,
> +          sdmmc3, spi, spi-hv, and uart.
> +
> +    required:
> +      - pins
> +
> +required:
> +  - compatible
> +  - reg
> +  - clock-names
> +  - clocks
> +  - '#clock-cells'
> +
> +if:
> +  properties:
> +    nvidia,suspend-mode:
> +      contains:
> +        const: 2
> +
> +then:
> +  required:
> +    - nvidia,cpu-pwr-good-time
> +    - nvidia,cpu-pwr-off-time
> +    - nvidia,core-pwr-good-time
> +    - nvidia,core-pwr-off-time
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/tegra-pmc.h>
> +
> +    pmc: pmc@7000e400 {
> +              compatible = "nvidia,tegra210-pmc";
> +              reg = <0x0 0x7000e400 0x0 0x400>;
> +              clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
> +              clock-names = "pclk", "clk32k_in";
> +              #clock-cells = <1>;
> +
> +              powergates {
> +                    pd_audio: aud {
> +                            clocks = <&tegra_car TEGRA210_CLK_APE>,
> +                                     <&tegra_car TEGRA210_CLK_APB2APE>;
> +                            resets = <&tegra_car 198>;
> +                            #power-domain-cells = <0>;
> +                    };
> +
> +                    pd_xusbss: xusba {
> +                            clocks = <&tegra_car TEGRA210_CLK_XUSB_SS>;
> +                            resets = <&tegra_car TEGRA210_CLK_XUSB_SS>;
> +                            #power-domain-cells = <0>;
> +                    };
> +              };
> +
> +              sdmmc1_3v3: sdmmc1-3v3 {
> +                      pins = "sdmmc1";
> +                      power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
> +              };
> +
> +              sdmmc1_1v8: sdmmc1-1v8 {
> +                      pins = "sdmmc1";
> +                      power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
> +              };
> +
> +              nvidia,invert-interrupt;
> +              nvidia,suspend-mode = <0>;
> +              nvidia,cpu-pwr-good-time = <0>;
> +              nvidia,cpu-pwr-off-time = <0>;
> +              nvidia,core-pwr-good-time = <4587 3876>;
> +              nvidia,core-pwr-off-time = <39065>;
> +              nvidia,core-power-req-active-high;
> +              nvidia,sys-clock-req-active-high;
> +    };
> -- 
> 2.7.4
> 
