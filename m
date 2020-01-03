Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F1CC00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 23:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECE121835
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 23:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578094740;
	bh=tKRbuPDXxSPAzgzBKBs/BO/vVVMpIv+NTkaM7Bbjk1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=euw4fHehgmajxgydAoPmp1BIXRWooNDa9qU7kLx+GruqjaQdXu+QnWnnuqHO5lMLl
	 1IfV8sronLWaHNJbSzZLMmPa+1HVq30xLNO0wi4qvP48yP/VqtXnOdoZUpcU+CD0uZ
	 8YwG6cpnjo4iqg6Rk6LreLVxAkyX32Sg4/bopz4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgACXi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 18:38:59 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35081 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgACXi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 18:38:59 -0500
Received: by mail-il1-f195.google.com with SMTP id g12so37978521ild.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 15:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QR8QcOFYKz9bZ1NVIjXxfjQi9Bn7stsPnISGj8MXVRg=;
        b=DbtcU99AAI6yhplDulyFfpumenn/jtSniWqV38mtMC7ObJfhllW3W8RJU/+A5F2ovy
         487jWDSREED0Azc7PFo7IPrLm5ZJ2g4Ruq7jPTdHgSE/XPDxMmFdcXsKPgpBhj7cm0LG
         vN3HbXLBK4rQ+d2U/bFFSCijFZYYt4VMqUC20yoJ2Epaed92gqu6rdXUHo98kXELkdVN
         JeDgDMGwqv0YcKHn149QZbpYNtO1vOn7nIUjg6zRktAAM2Ak/LiMZL3PrtkbqATd5ULE
         +qWnKpl6qvrYHXxPn+1pja66iB6R/65G02ue4sIU6dVVXJwX12+ssGIU+dLeEe2lWKj6
         HnOQ==
X-Gm-Message-State: APjAAAVQh8SQsq3wO6rwSm6lJJ8R5OK/ajRl/hXRcfHGTrag2wGUZ/47
        s9aDel9E0vlfJc1zJ/Ax/w8/OZE=
X-Google-Smtp-Source: APXvYqwe/iqFOA7HMp7l7aWmJNBHPnvP1JE0ipxReTPo5mn5Ce/n6dZAGvMUDJbhU5cpToUL8R5Ang==
X-Received: by 2002:a92:d30d:: with SMTP id x13mr82710814ila.170.1578094738243;
        Fri, 03 Jan 2020 15:38:58 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g62sm21428816ile.39.2020.01.03.15.38.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 15:38:57 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a5
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 16:38:55 -0700
Date:   Fri, 3 Jan 2020 16:38:55 -0700
From:   Rob Herring <robh@kernel.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, linux-omap@vger.kernel.org,
        s-anna@ti.com, devicetree@vger.kernel.org
Subject: Re: [RESEND PATCHv4 01/14] dt-bindings: remoteproc: Add OMAP
 remoteproc bindings
Message-ID: <20200103233855.GA19897@bogus>
References: <20200102131845.12992-2-t-kristo@ti.com>
 <20200102132512.13248-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200102132512.13248-1-t-kristo@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 03:25:12PM +0200, Tero Kristo wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> Add the device tree bindings document for the IPU and DSP
> remote processor devices on OMAP4+ SoCs.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Suman Anna <s-anna@ti.com>
> [t-kristo@ti.com: converted to schema]
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> v4: added ti,bootreg-shift and ti,autosuspend-delay properties
> 
>  .../remoteproc/ti,omap-remoteproc.yaml        | 329 ++++++++++++++++++
>  1 file changed, 329 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.yaml
> new file mode 100644
> index 000000000000..f53d58efaae3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.yaml
> @@ -0,0 +1,329 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/ti,omap-remoteproc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OMAP4+ Remoteproc Devices
> +
> +maintainers:
> +  - Suman Anna <s-anna@ti.com>
> +
> +description:
> +  The OMAP family of SoCs usually have one or more slave processor sub-systems
> +  that are used to offload some of the processor-intensive tasks, or to manage
> +  other hardware accelerators, for achieving various system level goals.
> +
> +  The processor cores in the sub-system are usually behind an IOMMU, and may
> +  contain additional sub-modules like Internal RAM and/or ROMs, L1 and/or L2
> +  caches, an Interrupt Controller, a Cache Controller etc.
> +
> +  The OMAP SoCs usually have a DSP processor sub-system and/or an IPU processor
> +  sub-system. The DSP processor sub-system can contain any of the TI's C64x,
> +  C66x or C67x family of DSP cores as the main execution unit. The IPU processor
> +  sub-system usually contains either a Dual-Core Cortex-M3 or Dual-Core
> +  Cortex-M4 processors.
> +
> +  Each remote processor sub-system is represented as a single DT node. Each node
> +  has a number of required or optional properties that enable the OS running on
> +  the host processor (MPU) to perform the device management of the remote
> +  processor and to communicate with the remote processor. The various properties
> +  can be classified as constant or variable. The constant properties are
> +  dictated by the SoC and does not change from one board to another having the
> +  same SoC. Examples of constant properties include 'iommus', 'reg'. The
> +  variable properties are dictated by the system integration aspects such as
> +  memory on the board, or configuration used within the corresponding firmware
> +  image. Examples of variable properties include 'mboxes', 'memory-region',
> +  'timers', 'watchdog-timers' etc.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,omap4-dsp
> +      - ti,omap5-dsp
> +      - ti,dra7-dsp
> +      - ti,omap4-ipu
> +      - ti,omap5-ipu
> +      - ti,dra7-ipu
> +
> +  iommus:
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      phandles to OMAP IOMMU nodes, that need to be programmed
> +      for this remote processor to access any external RAM memory or
> +      other peripheral device address spaces. This property usually
> +      has only a single phandle. Multiple phandles are used only in
> +      cases where the sub-system has different ports for different
> +      sub-modules within the processor sub-system (eg: DRA7 DSPs),
> +      and need the same programming in both the MMUs.
> +
> +  mboxes:
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      OMAP Mailbox specifier denoting the sub-mailbox, to be used for
> +      communication with the remote processor. The specifier format is
> +      as per the bindings,
> +      Documentation/devicetree/bindings/mailbox/omap-mailbox.txt
> +      This property should match with the sub-mailbox node used in
> +      the firmware image.
> +
> +  clocks:
> +    description: |
> +      Main functional clock for the remote processor
> +
> +  resets:
> +    description: |
> +      Reset handles for the remote processor
> +
> +  memory-region:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      phandle to the reserved memory node to be associated
> +      with the remoteproc device. The reserved memory node
> +      can be a CMA memory node, and should be defined as
> +      per the bindings,
> +      Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> +
> +  firmware-name:
> +    description: |
> +      Default name of the firmware to load to the remote processor.
> +
> +# Optional properties:
> +# --------------------
> +# Some of these properties are mandatory on some SoCs, and some are optional
> +# depending on the configuration of the firmware image to be executed on the
> +# remote processor. The conditions are mentioned for each property.
> +#
> +# The following are the optional properties:
> +
> +  reg:
> +    description: |
> +      Address space for any remoteproc memories present on
> +      the SoC. Should contain an entry for each value in
> +      'reg-names'. These are mandatory for all DSP and IPU
> +      processors that have them (OMAP4/OMAP5 DSPs do not have
> +      any RAMs)
> +
> +  reg-names:
> +    description: |
> +      Required names for each of the address spaces defined in
> +      the 'reg' property. Should contain a string from among
> +      the following names, each representing the corresponding
> +      internal RAM memory region.

The schema is more constrained than 'a string from among the following 
names'. 'l2ram' is the only valid 1st entry for example.

> +    minItems: 1
> +    maxItems: 3
> +    items:
> +      - const: l2ram
> +      - const: l1pram
> +      - const: l1dram
> +
> +  ti,bootreg:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      Should be a pair of the phandle to the System Control
> +      Configuration region that contains the boot address
> +      register, and the register offset of the boot address
> +      register within the System Control module. This property
> +      is required for all the DSP instances on OMAP4, OMAP5
> +      and DRA7xx SoCs.
> +
> +  ti,bootreg-shift:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Describes the bit position of the boot address field within
> +      the ti,bootreg.

Just make this a 2nd cell value for ti,bootreg. There's nothing to gain 
with 2 properties.

> +
> +  ti,autosuspend-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Custom autosuspend delay for the remoteproc in milliseconds.

Needs a standard unit suffix and then you can drop the type.

> +
> +  ti,timers:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      One or more phandles to OMAP DMTimer nodes, that serve
> +      as System/Tick timers for the OS running on the remote
> +      processors. This will usually be a single timer if the
> +      processor sub-system is running in SMP mode, or one per
> +      core in the processor sub-system. This can also be used
> +      to reserve specific timers to be dedicated to the
> +      remote processors.
> +
> +      This property is mandatory on remote processors requiring
> +      external tick wakeup, and to support Power Management
> +      features. The timers to be used should match with the
> +      timers used in the firmware image.
> +
> +  ti,watchdog-timers:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      One or more phandles to OMAP DMTimer nodes, used to
> +      serve as Watchdog timers for the processor cores. This
> +      will usually be one per executing processor core, even
> +      if the processor sub-system is running a SMP OS.
> +
> +      The timers to be used should match with the watchdog
> +      timers used in the firmware image.
> +
> +if:
> +  properties:
> +    compatible:
> +      enum:
> +        - ti,dra7-dsp
> +then:
> +  properties:
> +    reg:
> +      minItems: 3
> +      maxItems: 3
> +    ti,bootreg:
> +      minItems: 1
> +      maxItems: 1

What are you trying to express here? That ti,bootreg is only 1 
phandle+args or it's only a phandle (with no arg cells)? This does the 
former (I think), but I'm not clear when it would be more than 1.

> +    ti,bootreg-shift:
> +      minItems: 1
> +      maxItems: 1
> +
> +else:
> +  if:
> +    properties:
> +      compatible:
> +        enum:
> +          - ti,omap4-ipu
> +          - ti,omap5-ipu
> +          - ti,dra7-ipu
> +  then:
> +    properties:
> +      reg:
> +        minItems: 1
> +        maxItems: 1
> +
> +  else:
> +    properties:
> +      reg:
> +        maxItems: 0

This is not how you express 'reg' is not present. You want 'reg: false'. 
Also, I assume for some compatibles, 'reg' is required which you haven't 
expressed.

> +      ti,bootreg:
> +        minItems: 1
> +        maxItems: 1
> +
> +required:
> +  - compatible
> +  - iommus
> +  - mboxes
> +  - memory-region
> +  - clocks
> +  - resets
> +  - firmware-name
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    //Example 1: OMAP4 DSP
> +
> +    /* DSP Reserved Memory node */
> +    #include <dt-bindings/clock/omap4.h>
> +    reserved-memory {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        dsp_memory_region: dsp-memory@98000000 {
> +            compatible = "shared-dma-pool";
> +            reg = <0x98000000 0x800000>;
> +            reusable;
> +        };
> +    };
> +
> +    /* DSP node */
> +    ocp {
> +        dsp: dsp {
> +            compatible = "ti,omap4-dsp";
> +            ti,bootreg = <&scm_conf 0x304>;
> +            iommus = <&mmu_dsp>;
> +            mboxes = <&mailbox &mbox_dsp>;
> +            memory-region = <&dsp_memory_region>;
> +            ti,timers = <&timer5>;
> +            ti,watchdog-timers = <&timer6>;
> +            clocks = <&tesla_clkctrl OMAP4_DSP_CLKCTRL 0>;
> +            resets = <&prm_tesla 0>, <&prm_tesla 1>;
> +            firmware-name = "omap4-dsp-fw.xe64T";
> +        };
> +    };
> +
> +  - |+
> +
> +    //Example 2: OMAP5 IPU
> +
> +    /* IPU Reserved Memory node */
> +    #include <dt-bindings/clock/omap5.h>
> +    reserved-memory {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        ipu_memory_region: ipu-memory@95800000 {
> +            compatible = "shared-dma-pool";
> +            reg = <0 0x95800000 0 0x3800000>;
> +            reusable;
> +        };
> +    };
> +
> +    /* IPU node */
> +    ocp {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        ipu: ipu@55020000 {
> +            compatible = "ti,omap5-ipu";
> +            reg = <0x55020000 0x10000>;
> +            reg-names = "l2ram";
> +            iommus = <&mmu_ipu>;
> +            mboxes = <&mailbox &mbox_ipu>;
> +            memory-region = <&ipu_memory_region>;
> +            ti,timers = <&timer3>, <&timer4>;
> +            ti,watchdog-timers = <&timer9>, <&timer11>;
> +            clocks = <&ipu_clkctrl OMAP5_MMU_IPU_CLKCTRL 0>;
> +            resets = <&prm_core 2>;
> +            firmware-name = "omap5-ipu-fw.xem";
> +        };
> +    };
> +
> +  - |+
> +
> +    //Example 3: DRA7xx/AM57xx DSP
> +
> +    /* DSP1 Reserved Memory node */
> +    #include <dt-bindings/clock/dra7.h>
> +    reserved-memory {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        dsp1_memory_region: dsp1-memory@99000000 {
> +            compatible = "shared-dma-pool";
> +            reg = <0x0 0x99000000 0x0 0x4000000>;
> +            reusable;
> +        };
> +    };
> +
> +    /* DSP1 node */
> +    ocp {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        dsp1: dsp@40800000 {
> +            compatible = "ti,dra7-dsp";
> +            reg = <0x40800000 0x48000>,
> +                  <0x40e00000 0x8000>,
> +                  <0x40f00000 0x8000>;
> +            reg-names = "l2ram", "l1pram", "l1dram";
> +            ti,bootreg = <&scm_conf 0x55c>;
> +            iommus = <&mmu0_dsp1>, <&mmu1_dsp1>;
> +            mboxes = <&mailbox5 &mbox_dsp1_ipc3x>;
> +            memory-region = <&dsp1_memory_region>;
> +            ti,timers = <&timer5>;
> +            ti,watchdog-timers = <&timer10>;
> +            resets = <&prm_dsp1 0>;
> +            clocks = <&dsp1_clkctrl DRA7_DSP1_MMU0_DSP1_CLKCTRL 0>;
> +            firmware-name = "dra7-dsp1-fw.xe66";
> +        };
> +    };
> -- 
> 2.17.1
> 
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
