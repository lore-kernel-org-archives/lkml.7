Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383FEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026F320B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568990421;
	bh=w5tYeug1R2mxVT3RRStiSka22psHpZ2y2hQYY5KJCsA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aHT3Dr0jKikmRqrYB7jD5SNusPHQEjJGmHq0f8J7ylJF3tqlECriM45HrNaE8aOQ5
	 86fWWY1PEWOsMxdVdUcFFjkob/wm7RZpXYUzdbQOKud8lpNb5sLL3np7W+KEMC7x9Q
	 ACOGaRHeeajFrrAIOnxwOu6e3ZgYueMGo7JpYss8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393069AbfITOkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392859AbfITOkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:40:20 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6B9F20B7C;
        Fri, 20 Sep 2019 14:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568990419;
        bh=w5tYeug1R2mxVT3RRStiSka22psHpZ2y2hQYY5KJCsA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r/WldTVnwYXpHea8VcHmxyADtdDI3KT0xwv6xPAj0Ha/+H8JMfKjX8GiKeN990/CS
         8QfIf3du7+lkyb35Ce1y2zm58duTqlDuBZqNbQzHrzv8KUQTXL6msCKzz6ftbZB0YZ
         RPqRIDTLJfLyBiPfPY486wguXLxzerr+xCJoS308=
Received: by mail-qt1-f169.google.com with SMTP id x4so8893466qtq.8;
        Fri, 20 Sep 2019 07:40:18 -0700 (PDT)
X-Gm-Message-State: APjAAAV85p7Bvt+Laubwyp/KuGwTR0sNn42i7JQzU9RAMBzGfuU87ea5
        aiRYHLAlkUpkLFVewkdLurhk/0x9d4wndKa+aQ==
X-Google-Smtp-Source: APXvYqyVo5dyO/cVk4f8RdytA/CVTD1Ln+9JQR1Sut4HCLTGqsiKBfT/NQQfR68qW4LY93kib5+j6RMgXLDcgp933gs=
X-Received: by 2002:ac8:6982:: with SMTP id o2mr3622618qtq.143.1568990417965;
 Fri, 20 Sep 2019 07:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190920134829.16432-1-robh@kernel.org> <20190920134829.16432-2-robh@kernel.org>
 <8e9f4a42-defa-8dfe-2547-174395ef8b5d@arm.com>
In-Reply-To: <8e9f4a42-defa-8dfe-2547-174395ef8b5d@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 20 Sep 2019 09:40:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJCZDb_C-fHm6KfDQAZ=Gek8pbJfBHMv=6xaf74-h9aYA@mail.gmail.com>
Message-ID: <CAL_JsqJCZDb_C-fHm6KfDQAZ=Gek8pbJfBHMv=6xaf74-h9aYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: iommu: Convert Arm SMMUv3 to DT schema
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 9:17 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 20/09/2019 14:48, Rob Herring wrote:
> > Convert the Arm SMMv3 binding to the DT schema format.
> >
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <Robin.Murphy@arm.com>
> > Cc: iommu@lists.linux-foundation.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >   .../devicetree/bindings/iommu/arm,smmu-v3.txt |  77 -------------
> >   .../bindings/iommu/arm,smmu-v3.yaml           | 103 ++++++++++++++++++
> >   2 files changed, 103 insertions(+), 77 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> >   create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml

> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> > new file mode 100644
> > index 000000000000..1c97bcfbf82b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
> > @@ -0,0 +1,103 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iommu/arm,smmu-v3.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ARM SMMUv3 Architecture Implementation
> > +
> > +maintainers:
> > +  - Will Deacon <will@kernel.org>
> > +  - Robin Murphy <Robin.Murphy@arm.com>
> > +
> > +description: |+
> > +  The SMMUv3 architecture is a significant departure from previous
> > +  revisions, replacing the MMIO register interface with in-memory command
> > +  and event queues and adding support for the ATS and PRI components of
> > +  the PCIe specification.
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^iommu@[0-9a-f]*"
> > +  compatible:
> > +    const: arm,smmu-v3
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 4
> > +
> > +  interrupt-names:
> > +    oneOf:
> > +      - const: combined
> > +        description:
> > +          The combined interrupt is optional, and should only be provided if the
> > +          hardware supports just a single, combined interrupt line.
> > +          If provided, then the combined interrupt will be used in preference to
> > +          any others.
> > +      - items:
> > +          - const: eventq     # Event Queue not empty
> > +          - const: priq       # PRI Queue not empty
> > +          - const: cmdq-sync  # CMD_SYNC complete
> > +          - const: gerror     # Global Error activated
> > +      - items:
> > +          - const: eventq
> > +          - const: gerror
> > +          - const: priq
> > +      - items:
> > +          - const: eventq
> > +          - const: gerror
> > +      - items:
> > +          - const: eventq
> > +          - const: priq
>
> This looks a bit off - in the absence of MSIs, at least "gerror" and
> "eventq" should be mandatory; "cmdq-sync" should probably also be from a
> binding perspective, but Linux doesn't care about it. PRI is an optional
> feature of the architecture, so that IRQ should always be optional. If
> we do have MSIs, then technically the implementation is allowed to not
> support wired IRQs at all, although in practice is likely to have at
> least "gerror" to signal the double-fault condition of a GERROR MSI
> write aborting.

Well, now I'm not sure where I came up with the last case, it can be
dropped. These are the cases we have:

arch/arm64/boot/dts/arm/fvp-base-revc.dts:
interrupt-names = "eventq", "priq", "cmdq-sync", "gerror";
arch/arm64/boot/dts/hisilicon/hip07.dtsi:
interrupt-names = "eventq", "gerror", "priq";
arch/arm64/boot/dts/ti/k3-j721e-main.dtsi:
interrupt-names = "eventq", "gerror";

I'm fine if we leave warnings and expect dts files to be fixed.

In an ideal world we'd have this with optional irq on the end:

      - minItems: 3
        maxItems: 4
        items:
          - const: eventq     # Event Queue not empty
          - const: cmdq-sync  # CMD_SYNC complete
          - const: gerror     # Global Error activated
          - const: priq       # PRI Queue not empty


A less invasive approach would be:

      - items:
          - const: eventq     # Event Queue not empty
          - const: priq       # PRI Queue not empty
          - const: cmdq-sync  # CMD_SYNC complete
          - const: gerror     # Global Error activated
      - minItems: 2
        maxItems: 4
        items:
          - const: eventq
          - const: gerror
          - const: priq
          - const: cmdq-sync

Rob
