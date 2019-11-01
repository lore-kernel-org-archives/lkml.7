Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D226FCA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96B42085B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 17:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572628608;
	bh=0VLtvy1Li+X4S07iJZuXHqdU+xhvhoGmzB/HsuY/Ov8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m1VClcJJncOTST8YegAG2Tt/NsB6+E1/a0f+Qyqi/RwFHQJBj/70ujHYpReNYNPZb
	 fGyeapsh11R/Y1/PRiKEbgaJyJ+751McmWbNasAccEWBPDv2RZVm+FxLMnkGnhk1e1
	 /SEprrJkWIXd+0lmmm6mCNpRIQrB5/gXihC6/fAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfKARQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 13:16:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfKARQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 13:16:47 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 517FE2085B;
        Fri,  1 Nov 2019 17:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572628107;
        bh=0VLtvy1Li+X4S07iJZuXHqdU+xhvhoGmzB/HsuY/Ov8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DhjUBZFokLgKbeFcbFEYX+4/vgqse2DiRVLKOazVZ7jeSb7JJau3jICFIlREBp6nT
         A+WLX6ce3gzd42JF2h9Cg4xGQoCIXemZxX1i6yPRrzNMm67AYjFlW6Fsw8fi7xer+z
         sESre9SUiTkjKoBixYasHL22b9CjBvICA0uJ/WmM=
Date:   Fri, 1 Nov 2019 17:08:23 +0000
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2] dt-bindings: iommu: Convert Arm SMMUv3 to DT schema
Message-ID: <20191101170822.GE3603@willie-the-truck>
References: <20191014191256.12697-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014191256.12697-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Oct 14, 2019 at 02:12:56PM -0500, Rob Herring wrote:
> Convert the Arm SMMv3 binding to the DT schema format.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <Robin.Murphy@arm.com>
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
> - Refine interrupt definition based on Robin's comments
> 
>  .../devicetree/bindings/iommu/arm,smmu-v3.txt |  77 --------------
>  .../bindings/iommu/arm,smmu-v3.yaml           | 100 ++++++++++++++++++
>  2 files changed, 100 insertions(+), 77 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
>  create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml

[...]

> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> new file mode 100644
> index 000000000000..662cbc4592c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> @@ -0,0 +1,100 @@
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
> +          - const: eventq     # Event Queue not empt
> +          - const: priq       # PRI Queue not empty
> +          - const: cmdq-sync  # CMD_SYNC complete
> +          - const: gerror     # Global Error activated
> +      - minItems: 2
> +        maxItems: 4
> +        items:
> +          - const: eventq
> +          - const: gerror
> +          - const: priq
> +          - const: cmdq-sync

I find it a bit odd to say "minItems: 2" here since, for example, if you
have an SMMU that supports PRI then you really want the PRIQ interrupt
hooked up. The only one never care about in the current driver is cmdq-sync,
but that's just a driver quirk.

Also, if the thing supports MSIs then it might not have any wired interrupts
at all. Hmm.

> +
> +  '#iommu-cells':
> +    const: 1
> +
> +  dma-coherent:
> +    description: |
> +      Present if page table walks made by the SMMU are cache coherent with the
> +      CPU.

This looks like you've taken the text from SMMUv2 by accident. For SMMUv3,
it's not just about page table walks, but *any* DMA operations made by the
SMMU (e.g. STE lookup). I don't see the need to change the current text tbh.

Will
