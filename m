Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24918C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE68D20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbfITORi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:17:38 -0400
Received: from foss.arm.com ([217.140.110.172]:45328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbfITORh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:17:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C15FC337;
        Fri, 20 Sep 2019 07:17:36 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0CAB3F67D;
        Fri, 20 Sep 2019 07:17:32 -0700 (PDT)
Subject: Re: [PATCH 2/2] dt-bindings: iommu: Convert Arm SMMUv3 to DT schema
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org
References: <20190920134829.16432-1-robh@kernel.org>
 <20190920134829.16432-2-robh@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8e9f4a42-defa-8dfe-2547-174395ef8b5d@arm.com>
Date:   Fri, 20 Sep 2019 15:17:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190920134829.16432-2-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2019 14:48, Rob Herring wrote:
> Convert the Arm SMMv3 binding to the DT schema format.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <Robin.Murphy@arm.com>
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   .../devicetree/bindings/iommu/arm,smmu-v3.txt |  77 -------------
>   .../bindings/iommu/arm,smmu-v3.yaml           | 103 ++++++++++++++++++
>   2 files changed, 103 insertions(+), 77 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>   create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> deleted file mode 100644
> index c9abbf3e4f68..000000000000
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> +++ /dev/null
> @@ -1,77 +0,0 @@
> -* ARM SMMUv3 Architecture Implementation
> -
> -The SMMUv3 architecture is a significant departure from previous
> -revisions, replacing the MMIO register interface with in-memory command
> -and event queues and adding support for the ATS and PRI components of
> -the PCIe specification.
> -
> -** SMMUv3 required properties:
> -
> -- compatible        : Should include:
> -
> -                      * "arm,smmu-v3" for any SMMUv3 compliant
> -                        implementation. This entry should be last in the
> -                        compatible list.
> -
> -- reg               : Base address and size of the SMMU.
> -
> -- interrupts        : Non-secure interrupt list describing the wired
> -                      interrupt sources corresponding to entries in
> -                      interrupt-names. If no wired interrupts are
> -                      present then this property may be omitted.
> -
> -- interrupt-names   : When the interrupts property is present, should
> -                      include the following:
> -                      * "eventq"    - Event Queue not empty
> -                      * "priq"      - PRI Queue not empty
> -                      * "cmdq-sync" - CMD_SYNC complete
> -                      * "gerror"    - Global Error activated
> -                      * "combined"  - The combined interrupt is optional,
> -				      and should only be provided if the
> -				      hardware supports just a single,
> -				      combined interrupt line.
> -				      If provided, then the combined interrupt
> -				      will be used in preference to any others.
> -
> -- #iommu-cells      : See the generic IOMMU binding described in
> -                        devicetree/bindings/pci/pci-iommu.txt
> -                      for details. For SMMUv3, must be 1, with each cell
> -                      describing a single stream ID. All possible stream
> -                      IDs which a device may emit must be described.
> -
> -** SMMUv3 optional properties:
> -
> -- dma-coherent      : Present if DMA operations made by the SMMU (page
> -                      table walks, stream table accesses etc) are cache
> -                      coherent with the CPU.
> -
> -                      NOTE: this only applies to the SMMU itself, not
> -                      masters connected upstream of the SMMU.
> -
> -- msi-parent        : See the generic MSI binding described in
> -                        devicetree/bindings/interrupt-controller/msi.txt
> -                      for a description of the msi-parent property.
> -
> -- hisilicon,broken-prefetch-cmd
> -                    : Avoid sending CMD_PREFETCH_* commands to the SMMU.
> -
> -- cavium,cn9900-broken-page1-regspace
> -                    : Replaces all page 1 offsets used for EVTQ_PROD/CONS,
> -		      PRIQ_PROD/CONS register access with page 0 offsets.
> -		      Set for Cavium ThunderX2 silicon that doesn't support
> -		      SMMU page1 register space.
> -
> -** Example
> -
> -        smmu@2b400000 {
> -                compatible = "arm,smmu-v3";
> -                reg = <0x0 0x2b400000 0x0 0x20000>;
> -                interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
> -                             <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
> -                             <GIC_SPI 77 IRQ_TYPE_EDGE_RISING>,
> -                             <GIC_SPI 79 IRQ_TYPE_EDGE_RISING>;
> -                interrupt-names = "eventq", "priq", "cmdq-sync", "gerror";
> -                dma-coherent;
> -                #iommu-cells = <1>;
> -                msi-parent = <&its 0xff0000>;
> -        };
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> new file mode 100644
> index 000000000000..1c97bcfbf82b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/arm,smmu-v3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM SMMUv3 Architecture Implementation
> +
> +maintainers:
> +  - Will Deacon <will@kernel.org>
> +  - Robin Murphy <Robin.Murphy@arm.com>
> +
> +description: |+
> +  The SMMUv3 architecture is a significant departure from previous
> +  revisions, replacing the MMIO register interface with in-memory command
> +  and event queues and adding support for the ATS and PRI components of
> +  the PCIe specification.
> +
> +properties:
> +  $nodename:
> +    pattern: "^iommu@[0-9a-f]*"
> +  compatible:
> +    const: arm,smmu-v3
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 4
> +
> +  interrupt-names:
> +    oneOf:
> +      - const: combined
> +        description:
> +          The combined interrupt is optional, and should only be provided if the
> +          hardware supports just a single, combined interrupt line.
> +          If provided, then the combined interrupt will be used in preference to
> +          any others.
> +      - items:
> +          - const: eventq     # Event Queue not empty
> +          - const: priq       # PRI Queue not empty
> +          - const: cmdq-sync  # CMD_SYNC complete
> +          - const: gerror     # Global Error activated
> +      - items:
> +          - const: eventq
> +          - const: gerror
> +          - const: priq
> +      - items:
> +          - const: eventq
> +          - const: gerror
> +      - items:
> +          - const: eventq
> +          - const: priq

This looks a bit off - in the absence of MSIs, at least "gerror" and 
"eventq" should be mandatory; "cmdq-sync" should probably also be from a 
binding perspective, but Linux doesn't care about it. PRI is an optional 
feature of the architecture, so that IRQ should always be optional. If 
we do have MSIs, then technically the implementation is allowed to not 
support wired IRQs at all, although in practice is likely to have at 
least "gerror" to signal the double-fault condition of a GERROR MSI 
write aborting.

Robin.

> +
> +  '#iommu-cells':
> +    const: 1
> +
> +  dma-coherent:
> +    description: |
> +      Present if page table walks made by the SMMU are cache coherent with the
> +      CPU.
> +
> +      NOTE: this only applies to the SMMU itself, not masters connected
> +      upstream of the SMMU.
> +
> +  msi-parent: true
> +
> +  hisilicon,broken-prefetch-cmd:
> +    type: boolean
> +    description: Avoid sending CMD_PREFETCH_* commands to the SMMU.
> +
> +  cavium,cn9900-broken-page1-regspace:
> +    type: boolean
> +    description:
> +      Replaces all page 1 offsets used for EVTQ_PROD/CONS, PRIQ_PROD/CONS
> +      register access with page 0 offsets. Set for Cavium ThunderX2 silicon that
> +      doesn't support SMMU page1 register space.
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#iommu-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |+
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    iommu@2b400000 {
> +            compatible = "arm,smmu-v3";
> +            reg = <0x2b400000 0x20000>;
> +            interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 77 IRQ_TYPE_EDGE_RISING>,
> +                         <GIC_SPI 79 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-names = "eventq", "priq", "cmdq-sync", "gerror";
> +            dma-coherent;
> +            #iommu-cells = <1>;
> +            msi-parent = <&its 0xff0000>;
> +    };
> 
