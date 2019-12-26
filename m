Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED0DC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 23:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC9F2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 23:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577402643;
	bh=M3aj3XMObuG35r0wKDP7K7O4j9hjS/HD5FBxB0fvtUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OHzT0U33s1NXk5lJwBNb3+NZzigLi/HqpW9SNwVvzgLAC/MDdsORbwnnhrsKiVxnN
	 gl4bublrCX24iI6/gggjApF976DjXh9OCL59F9WAqurFEJGVpNpjVKIEr4WS7O9qzK
	 v5ti1K8Yt6ckEnSb2iRbiNaduBykijpW34lAtJaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfLZXYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 18:24:02 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46544 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLZXYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 18:24:01 -0500
Received: by mail-io1-f66.google.com with SMTP id t26so24390782ioi.13;
        Thu, 26 Dec 2019 15:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9KsCQEfq1kRvvmHmmrDw3NS4bMZHbvrPfpPID5mmpQ4=;
        b=hFx5ySFqeyamYEQKFyeWBnvHF3VCP18i/DDv0hL7sQtoO1HdUcMhVI/JZtPTjntM0h
         h1BRmxEqsb0pycobC6yzqu2QCKacoptCwaoityGawHKxI0QgUkns8NhhodSURv5BIbei
         7DEa/iWZEm+NGX6/2ihykmK74jmP8jfSWNZ8BuQM5Ps/IEqq8mbeuQNmEqcBADgiyguS
         KBVL3m36V1/d7MeRl48OA+l+8c/m8Cb8dgUeuu5DM8A/prbEYOPpOeIV6RE+TjsxmCCK
         rSCkJbesXpbumxKBjno1+meAaztBJHg9o1jBEechelRJXR/6sdNs2ZRgkOa1D6F+yiZR
         W1eA==
X-Gm-Message-State: APjAAAVVKeRhQVJ1L9vL8/jwL4ku5Bt74iUX6tGeE4YV3YnP/BDSP5Ct
        UdJcIDsu/wzAePAjITFgpFDDUzI=
X-Google-Smtp-Source: APXvYqwCJqGScRNBUIJKTrPsLs2KnUO10Ckv6zOKn+ji+jMCPtJXRL0tMXR0n/z5a3RVpFdWqFRLRg==
X-Received: by 2002:a5e:dd4c:: with SMTP id u12mr11056108iop.144.1577402640138;
        Thu, 26 Dec 2019 15:24:00 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z81sm11594513ilc.17.2019.12.26.15.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 15:23:59 -0800 (PST)
Date:   Thu, 26 Dec 2019 16:23:57 -0700
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        digetx@gmail.com, mperttunen@nvidia.com,
        gregkh@linuxfoundation.org, sboyd@kernel.org, mark.rutland@arm.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/19] dt-bindings: tegra: Convert Tegra PMC bindings
 to YAML
Message-ID: <20191226232357.GA11719@bogus>
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
 <1576880825-15010-5-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576880825-15010-5-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 02:26:50PM -0800, Sowjanya Komatineni wrote:
> This patch converts text based Tegra PMC bindings document to YAML
> schema for performing dt validation.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 300 ------------------
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.yaml     | 345 +++++++++++++++++++++
>  2 files changed, 345 insertions(+), 300 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml


> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
> new file mode 100644
> index 000000000000..e97eee672ae0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
> @@ -0,0 +1,345 @@
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
> +    enum:
> +      - nvidia,tegra20-pmc
> +      - nvidia,tegra20-pmc
> +      - nvidia,tegra30-pmc
> +      - nvidia,tegra114-pmc
> +      - nvidia,tegra124-pmc
> +      - nvidia,tegra210-pmc
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      Offset and length of the register set for the device.
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: clk32k_in
> +    description:
> +      Must includes entries pclk and clk32k_in.
> +      pclk is the Tegra clock of that name and clk32k_in is 32KHz clock
> +      input to Tegra.
> +
> +  clocks:
> +    maxItems: 2
> +    description:
> +      Must contain an entry for each entry in clock-names.
> +      See ../clocks/clocks-bindings.txt for details.
> +
> +  '#interrupt-cells':
> +    const: 2
> +    description:
> +      Specifies number of cells needed to encode an interrupt source.
> +      The value must be 2.
> +
> +  interrupt-controller: true
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
> +
> +    additionalProperties: false
> +
> +  powergates:
> +    type: object
> +    description:

This should end with '|' to preserve formatting.

> +      This node contains a hierarchy of power domain nodes, which should
> +      match the powergates on the Tegra SoC. Each powergate node
> +      represents a power-domain on the Tegra SoC that can be power-gated
> +      by the Tegra PMC.
> +      Hardware blocks belonging to a power domain should contain
> +      "power-domains" property that is a phandle pointing to corresponding
> +      powergate node.
> +      The name of the powergate node should be one of the below. Note that
> +      not every powergate is applicable to all Tegra devices and the following
> +      list shows which powergates are applicable to which devices.
> +      Please refer to Tegra TRM for mode details on the powergate nodes to
> +      use for each power-gate block inside Tegra.
> +      Name		Description			            Devices Applicable
> +      3d		  3D Graphics			            Tegra20/114/124/210
> +      3d0		  3D Graphics 0		            Tegra30
> +      3d1		  3D Graphics 1		            Tegra30
> +      aud		  Audio				                Tegra210
> +      dfd		  Debug				                Tegra210
> +      dis		  Display A			              Tegra114/124/210
> +      disb		Display B			              Tegra114/124/210
> +      heg		  2D Graphics		            	Tegra30/114/124/210
> +      iram		Internal RAM		            Tegra124/210
> +      mpe		  MPEG Encode			            All
> +      nvdec		NVIDIA Video Decode Engine	Tegra210
> +      nvjpg		NVIDIA JPEG Engine		      Tegra210
> +      pcie		PCIE				                Tegra20/30/124/210
> +      sata		SATA				                Tegra30/124/210
> +      sor		  Display interfaces       		Tegra124/210
> +      ve2		  Video Encode Engine 2		    Tegra210
> +      venc		Video Encode Engine		      All
> +      vdec		Video Decode Engine		      Tegra20/30/114/124
> +      vic		  Video Imaging Compositor	  Tegra124/210
> +      xusba		USB Partition A			        Tegra114/124/210
> +      xusbb		USB Partition B 		        Tegra114/124/210
> +      xusbc		USB Partition C			        Tegra114/124/210
> +
> +    patternProperties:
> +      "^[a-z0-9]+$":
> +        type: object
> +
> +        patternProperties:
> +          clocks:
> +            minItems: 1
> +            maxItems: 8
> +            description:
> +              Must contain an entry for each clock required by the PMC
> +              for controlling a power-gate.
> +              See ../clocks/clock-bindings.txt document for more details.
> +
> +          resets:
> +            minItems: 1
> +            maxItems: 8
> +            description:
> +              Must contain an entry for each reset required by the PMC
> +              for controlling a power-gate.
> +              See ../reset/reset.txt for more details.
> +
> +          '#power-domain-cells':
> +            const: 0
> +            description: Must be 0.
> +
> +        required:
> +          - clocks
> +          - resets
> +          - '#power-domain-cells'
> +
> +    additionalProperties: false
> +
> +patternProperties:
> +  "^[a-f0-9]+-[a-f0-9]+$":
> +    type: object
> +    description:
> +      This is a Pad configuration node. On Tegra SOCs a pad is a set of
> +      pins which are configured as a group. The pin grouping is a fixed
> +      attribute of the hardware. The PMC can be used to set pad power state
> +      and signaling voltage. A pad can be either in active or power down mode.
> +      The support for power state and signaling voltage configuration varies
> +      depending on the pad in question. 3.3V and 1.8V signaling voltages
> +      are supported on pins where software controllable signaling voltage
> +      switching is available.
> +
> +      The pad configuration state nodes are placed under the pmc node and they
> +      are referred to by the pinctrl client properties. For more information
> +      see Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt.
> +      The pad name should be used as the value of the pins property in pin
> +      configuration nodes.
> +
> +      The following pads are present on Tegra124 and Tegra132
> +      audio		   bb		      cam		      comp       csia	 	   csb
> +      cse        dsi        dsib		    dsic		   dsid		   hdmi
> +      hsic		   hv         lvds		    mipi-bias  nand		   pex-bias
> +      pex-clk1	 pex-clk2   pex-cntrl   sdmmc1		 sdmmc3		 sdmmc4
> +      sys_ddc		 uart		    usb0		    usb1       usb2		   usb_bias

Remove the tabs. This is not readable.

> +
> +      The following pads are present on Tegra210
> +      audio		  audio-hv	 cam		   csia       csib		      csic
> +      csid		  csie       csif		   dbg		    debug-nonao	  dmic
> +      dp		    dsi		     dsib		   dsic       dsid		      emmc
> +      emmc2		  gpio       hdmi		   hsic		    lvds		      mipi-bias
> +      pex-bias	pex-clk1	 pex-clk2	 pex-cntrl  sdmmc1		    sdmmc3
> +      spi		    spi-hv     uart		   usb0		    usb1		      usb2
> +      usb3		  usb-bias
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
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - clock-names
> +  - clocks
> +
> +dependencies:
> +  "nvidia,suspend-mode": ["nvidia,core-pwr-off-time", "nvidia,cpu-pwr-off-time"]
> +  "nvidia,core-pwr-off-time": ["nvidia,core-pwr-good-time"]
> +  "nvidia,cpu-pwr-off-time": ["nvidia,cpu-pwr-good-time"]
> +
> +examples:
> +  - |
> +
> +    #include <dt-bindings/clock/tegra210-car.h>
> +    #include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
> +
> +    tegra_pmc: pmc@7000e400 {
> +              compatible = "nvidia,tegra210-pmc";
> +              reg = <0x0 0x7000e400 0x0 0x400>;
> +              clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
> +              clock-names = "pclk", "clk32k_in";
> +
> +              nvidia,invert-interrupt;
> +              nvidia,suspend-mode = <0>;
> +              nvidia,cpu-pwr-good-time = <0>;
> +              nvidia,cpu-pwr-off-time = <0>;
> +              nvidia,core-pwr-good-time = <4587 3876>;
> +              nvidia,core-pwr-off-time = <39065>;
> +              nvidia,core-power-req-active-high;
> +              nvidia,sys-clock-req-active-high;
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
> +    };
> -- 
> 2.7.4
> 
