Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12875C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A4A206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576516233;
	bh=aUrdrOF8RVSAn+yHDF3btdZ2PsHXQPB4WZvqmB6jT8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=htWyclIcZK7xlTuprGYgO/LjuOd4J3+aiZ8xhUakBqRJAxYuKlU1CMg8jpE2PEnsm
	 kJoqGn/Ahi/qNGnLArc24VZ63LqwqIwhUUO8VmKhzX0ePQHWqrt9vnaA5CZPGIGQag
	 YdplkfGyWNU9RnNBlnY4Jkih0JWXV7eVnYyvjn/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfLPRKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:10:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:51456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbfLPRK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:10:28 -0500
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDAD7206EC;
        Mon, 16 Dec 2019 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576516228;
        bh=aUrdrOF8RVSAn+yHDF3btdZ2PsHXQPB4WZvqmB6jT8E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y6tSxMVL/XSZEra+SXXcuvQBkOLqI4FXRDeN0DGcByWAadeDp+10N8YFhQu4ZPTeZ
         rw2St3qYQi9bCiosAMR5zNZSwwLbLbhwsxMmqLBbYHIqeo9e3NmgmkvHyrKSLNRN6M
         ECjETUebqrgZeJS7NSgEUFNBMjWYLM6cCY7xRsY4=
Received: by mail-qv1-f51.google.com with SMTP id m14so2463613qvl.3;
        Mon, 16 Dec 2019 09:10:27 -0800 (PST)
X-Gm-Message-State: APjAAAWLjtV1m/vvRjsQGYQ+2p59/sHM8Zi4Zi83JqvRlo2dMqHdYalt
        VDF1IX5FP612yfuZ+m0E3wIxO8ZVeZL5DTrUyQ==
X-Google-Smtp-Source: APXvYqz1/8z5BbGYKxOHLX+RjTlBOF3diYL38YPIekXqt/2ChkEPgLihEvHxXbgXzbHA5XMi6Krc1r0YFDIZHXejRwc=
X-Received: by 2002:a05:6214:11ac:: with SMTP id u12mr244552qvv.85.1576516226960;
 Mon, 16 Dec 2019 09:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20191128154603.6911-1-arnaud.pouliquen@st.com>
 <20191213213916.GA1292@bogus> <7ac83aa6-0ec6-db4f-556d-a17c28d2bcab@st.com>
In-Reply-To: <7ac83aa6-0ec6-db4f-556d-a17c28d2bcab@st.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 16 Dec 2019 11:10:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKnbkO2rXKz376GZLdM4C9zA2zcM1ETGLFaABaxpBu7vA@mail.gmail.com>
Message-ID: <CAL_JsqKnbkO2rXKz376GZLdM4C9zA2zcM1ETGLFaABaxpBu7vA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: stm32: convert mlahb to json-schema
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 2:44 AM Arnaud POULIQUEN
<arnaud.pouliquen@st.com> wrote:
>
> Hello Rob,
>
> On 12/13/19 10:39 PM, Rob Herring wrote:
> > On Thu, Nov 28, 2019 at 04:46:03PM +0100, Arnaud Pouliquen wrote:
> >> Convert the ML-AHB bus bindings to DT schema format using json-schema
> >>
> >> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> >> ---
> >> Notice that this patch requests an update of the simple-bus schema to add
> >> the support of the "dma-ranges" property.
> >> A Pull request has been sent in parallel to the dt-schema github repo:
> >> https://github.com/devicetree-org/dt-schema/pull/30
> >>
> >> To remind the topic around the use of "dma-ranges" please
> >> refer to following discussion: https://lkml.org/lkml/2019/4/3/1261
> >> ---
> >>  .../devicetree/bindings/arm/stm32/mlahb.txt   | 37 ----------
> >>  .../bindings/arm/stm32/st,mlahb.yaml          | 69 +++++++++++++++++++
> >>  2 files changed, 69 insertions(+), 37 deletions(-)
> >>  delete mode 100644 Documentation/devicetree/bindings/arm/stm32/mlahb.txt
> >>  create mode 100644 Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/stm32/mlahb.txt b/Documentation/devicetree/bindings/arm/stm32/mlahb.txt
> >> deleted file mode 100644
> >> index 25307aa1eb9b..000000000000
> >> --- a/Documentation/devicetree/bindings/arm/stm32/mlahb.txt
> >> +++ /dev/null
> >> @@ -1,37 +0,0 @@
> >> -ML-AHB interconnect bindings
> >> -
> >> -These bindings describe the STM32 SoCs ML-AHB interconnect bus which connects
> >> -a Cortex-M subsystem with dedicated memories.
> >> -The MCU SRAM and RETRAM memory parts can be accessed through different addresses
> >> -(see "RAM aliases" in [1]) using different buses (see [2]) : balancing the
> >> -Cortex-M firmware accesses among those ports allows to tune the system
> >> -performance.
> >> -
> >> -[1]: https://www.st.com/resource/en/reference_manual/dm00327659.pdf
> >> -[2]: https://wiki.st.com/stm32mpu/wiki/STM32MP15_RAM_mapping
> >> -
> >> -Required properties:
> >> -- compatible: should be "simple-bus"
> >> -- dma-ranges: describes memory addresses translation between the local CPU and
> >> -       the remote Cortex-M processor. Each memory region, is declared with
> >> -       3 parameters:
> >> -             - param 1: device base address (Cortex-M processor address)
> >> -             - param 2: physical base address (local CPU address)
> >> -             - param 3: size of the memory region.
> >> -
> >> -The Cortex-M remote processor accessed via the mlahb interconnect is described
> >> -by a child node.
> >> -
> >> -Example:
> >> -mlahb {
> >> -    compatible = "simple-bus";
> >> -    #address-cells = <1>;
> >> -    #size-cells = <1>;
> >> -    dma-ranges = <0x00000000 0x38000000 0x10000>,
> >> -                 <0x10000000 0x10000000 0x60000>,
> >> -                 <0x30000000 0x30000000 0x60000>;
> >> -
> >> -    m4_rproc: m4@10000000 {
> >> -            ...
> >> -    };
> >> -};
> >> diff --git a/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml b/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
> >> new file mode 100644
> >> index 000000000000..8ad3f7c7f9ab
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
> >> @@ -0,0 +1,69 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: "http://devicetree.org/schemas/arm/stm32/st,mlahb.yaml#"
> >> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> >> +
> >> +title: STMicroelectronics STM32 ML-AHB interconnect bindings
> >> +
> >> +maintainers:
> >> +  - Fabien Dessenne <fabien.dessenne@st.com>
> >> +  - Arnaud Pouliquen <arnaud.pouliquen@st.com>
> >> +
> >> +description: |
> >> +  These bindings describe the STM32 SoCs ML-AHB interconnect bus which connects
> >> +  a Cortex-M subsystem with dedicated memories. The MCU SRAM and RETRAM memory
> >> +  parts can be accessed through different addresses (see "RAM aliases" in [1])
> >> +  using different buses (see [2]): balancing the Cortex-M firmware accesses
> >> +  among those ports allows to tune the system performance.
> >> +  [1]: https://www.st.com/resource/en/reference_manual/dm00327659.pdf
> >> +  [2]: https://wiki.st.com/stm32mpu/wiki/STM32MP15_RAM_mapping
> >> +
> >> +allOf:
> >> + - $ref: /schemas/simple-bus.yaml#
> >> +
> >> +properties:
> >> +  compatible:
> >> +    contains:
> >> +      enum:
> >> +        - st,mlahb
> >> +
> >> +  dma-ranges:
> >> +    description: |
> >> +      Describe memory addresses translation between the local CPU and the
> >> +      remote Cortex-M processor. Each memory region, is declared with
> >> +      3 parameters:
> >> +      - param 1: device base address (Cortex-M processor address)
> >> +      - param 2: physical base address (local CPU address)
> >> +      - param 3: size of the memory region.
> >> +    maxItems: 3
> >> +
> >> +  '#address-cells':
> >> +    const: 1
> >> +
> >> +  '#size-cells':
> >> +    const: 1
> >> +
> >> +required:
> >> +  - compatible
> >> +  - '#address-cells'
> >> +  - '#size-cells'
> >> +  - dma-ranges
> >> +
> >> +examples:
> >> +  - |
> >> +    mlahb: ahb {
> >> +      compatible = "st,mlahb", "simple-bus";
> >> +      #address-cells = <1>;
> >> +      #size-cells = <1>;
> >> +      reg = <0x10000000 0x40000>;
> >> +      dma-ranges = <0x00000000 0x38000000 0x10000>,
> >> +                   <0x10000000 0x10000000 0x60000>,
> >> +                   <0x30000000 0x30000000 0x60000>;
> >> +
> >
> > Fails to build:
> >
> > builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/stm32/st,mlahb.example.dt.yaml:
> > ahb: 'ranges' is a required property
> >
> > Run 'make dt_binding_check'
>
> Yes, that why i posted in parallel the PR on the tool:
> https://github.com/devicetree-org/dt-schema/pull/30.
>
> I don't know if you saw my answer on this post so i copy/paste  it here:
>
> How to describe the stm32mp1 coprocessor mapping and translations based on this "ranges" requirement?

Minimally, you just need to add an empty ranges. Otherwise, the
0x10000000 in reg in the child node is not considered a MMIO address.

> On stm32mp1 we have 2 RAM memories accessible by the Cortex-A7 running Linux and used by the Cortex-M4 coprocessor to run its code. Each Cortex has a specific mapping of the memories. Some memory translations are needed by:
>
> - rproc driver to load the Cortex-M4 firmware in RAMs
> - rpmsg & virtio frameworks for shared memory
>
> Here is the memory mapping:
>
> - RETRAM (64 kB);
>   - Cortex-A7 @ : 0x38000000
>   - Cortex-M4 @: 0x00000000
> - MCUSRAM (up to 384 kB)
>   - Cortex-A7 @ : 0x30000000 or 0x10000000 ( 2 addresses for the same memory)
>   - Cortex-M4 @: 0x30000000 or 0x10000000 ( 2 addresses for the same memory)
>   =>addresses used on both side depend on the MCURAM access optimization
>
> Today our upstreamed solution is based on dma-range only (https://lkml.org/lkml/2019/4/3/1261)
>
> What about adding an "unused" ranges property in DT to match the requirement?
>
>         mlahb {
>                 compatible = "simple-bus";
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 ranges = <0 0x38000000 0x10000>,
>                                <1 0x10000000 0x60000>,
>                                <2 0x30000000 0x60000>;

This is not valid with child addresses of 0, 1, and 2. 'ranges' is
purely about the view from the A7 to the M4. If you want to point 2
parent addresses to the same child region, you could do:

                ranges = <0x38000000 0x38000000 0x10000>,
                         <0x10000000 0x10000000 0x60000>,
                         <0x10000000 0x30000000 0x60000>;

Though I'm not sure what the OS address translation code will do in
this case. Probably just ignore the last entry.

>                 dma-ranges = <0x00000000 0x38000000 0x10000>,
>                              <0x10000000 0x10000000 0x60000>,
>                              <0x30000000 0x30000000 0x60000>;
>
>                 m4_rproc: m4@10000000 {
>                         ---
>                 };
>         };
>
> Thanks in advance for your feedback.
> Regards,
> Arnaud
>
> >
> >> +      m4_rproc: m4@10000000 {
> >> +       reg = <0x10000000 0x40000>;
> >> +      };
> >> +    };
> >> +
> >> +...
> >> --
> >> 2.17.1
> >>
