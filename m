Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE6ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EB320684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571764203;
	bh=xTmSlesjwuvQB/ttZuJe9Q+nvlZ4oNZrThcEz9NFU1o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1iULM2u6Ls/pqx12kMv9eZcGwJYe+nCtESADzp7CS2949wzHCz5eVaHMhh5CQBkx3
	 YbI78IDw3KfzYxh6f62zsuztm89Yq+w0YFfne3rhayxRtdDQl49t3VH54cG3riJMPD
	 lTV+oVXYwnBwDxcIwPfK+EdwO4ZHz1Jt7KmgpEo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732512AbfJVRKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 13:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731061AbfJVRKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 13:10:01 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE2432084B;
        Tue, 22 Oct 2019 17:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571764199;
        bh=xTmSlesjwuvQB/ttZuJe9Q+nvlZ4oNZrThcEz9NFU1o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZwC1wWWJoVKj2W0uHHHyi/uRfU9F9ta+GpWogpLu6jfNlMy0J3u9X53qF2/KagU3/
         mOQQtcJMVrYJBFO6UctQRbcaOgCQLeYpjQaC0H4XeDO4MqFwUGFf9Z7jpibSEoswoQ
         X1FE7VMyRtOaudpsbMt9cVBULG4UsUQOvTd1KThE=
Received: by mail-qk1-f173.google.com with SMTP id u22so16921744qkk.11;
        Tue, 22 Oct 2019 10:09:59 -0700 (PDT)
X-Gm-Message-State: APjAAAVHg/4/ansEh9TK/6nqYqbu4MQrrh8ZkvYZgn40louHn8VseQ7Z
        lTXugJ5qm5nXvkEJsKPloMysmYtUrflX6TQJwA==
X-Google-Smtp-Source: APXvYqwm/98XLMtQMVPE560nGDd/xxKOCJ+oWLPvKwkCs1ZvfHH0yztYXkoT3fICY0k3/UPNlTOQ8Ty6T5Y03ASJyAY=
X-Received: by 2002:a05:620a:12f1:: with SMTP id f17mr4056323qkl.152.1571764198912;
 Tue, 22 Oct 2019 10:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191014191256.12697-1-robh@kernel.org> <72f211ff-4d5a-933c-eb08-22916d8f50c7@arm.com>
In-Reply-To: <72f211ff-4d5a-933c-eb08-22916d8f50c7@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Oct 2019 12:09:47 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+McnE1q6=5fpBm0FC4GONDDRNCqQafYzbsWfW6soAT9Q@mail.gmail.com>
Message-ID: <CAL_Jsq+McnE1q6=5fpBm0FC4GONDDRNCqQafYzbsWfW6soAT9Q@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: iommu: Convert Arm SMMUv3 to DT schema
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

On Tue, Oct 22, 2019 at 11:54 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 14/10/2019 20:12, Rob Herring wrote:
> > Convert the Arm SMMv3 binding to the DT schema format.
> >
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <Robin.Murphy@arm.com>
> > Cc: iommu@lists.linux-foundation.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v2:
> > - Refine interrupt definition based on Robin's comments
> >
> >   .../devicetree/bindings/iommu/arm,smmu-v3.txt |  77 --------------
> >   .../bindings/iommu/arm,smmu-v3.yaml           | 100 ++++++++++++++++++
> >   2 files changed, 100 insertions(+), 77 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> >   create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml

[...]

> > +  interrupt-names:
> > +    oneOf:
> > +      - const: combined
> > +        description:
> > +          The combined interrupt is optional, and should only be provided if the
> > +          hardware supports just a single, combined interrupt line.
> > +          If provided, then the combined interrupt will be used in preference to
> > +          any others.
> > +      - items:
> > +          - const: eventq     # Event Queue not empt
> > +          - const: priq       # PRI Queue not empty
> > +          - const: cmdq-sync  # CMD_SYNC complete
> > +          - const: gerror     # Global Error activated
>
> Isn't this effectively redundant with the 4-item case of the version
> below? If it's purely about the ordering, and we can't express "one or
> more of any of:" without spelling out all 64 possible permutations, then
> TBH I'd rather just settle on a single definition that can work for all
> current cases and update the Fast Model DT if necessary.

We can allow any order if needed (such as already having lots of
permutations), but in general the order is supposed to be defined.

Updating the Fast Model DT seems okay to me. I'll shift the comments
to the below entry and drop this one (and fix the example).

> Otherwise, though, this looks like a fair starting point to me;
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks.

>
> > +      - minItems: 2
> > +        maxItems: 4
> > +        items:
> > +          - const: eventq
> > +          - const: gerror
> > +          - const: priq
> > +          - const: cmdq-sync
> > +
> > +  '#iommu-cells':
> > +    const: 1
> > +
> > +  dma-coherent:
> > +    description: |
> > +      Present if page table walks made by the SMMU are cache coherent with the
> > +      CPU.
> > +
> > +      NOTE: this only applies to the SMMU itself, not masters connected
> > +      upstream of the SMMU.
> > +
> > +  msi-parent: true
> > +
> > +  hisilicon,broken-prefetch-cmd:
> > +    type: boolean
> > +    description: Avoid sending CMD_PREFETCH_* commands to the SMMU.
> > +
> > +  cavium,cn9900-broken-page1-regspace:
> > +    type: boolean
> > +    description:
> > +      Replaces all page 1 offsets used for EVTQ_PROD/CONS, PRIQ_PROD/CONS
> > +      register access with page 0 offsets. Set for Cavium ThunderX2 silicon that
> > +      doesn't support SMMU page1 register space.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#iommu-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |+
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    iommu@2b400000 {
> > +            compatible = "arm,smmu-v3";
> > +            reg = <0x2b400000 0x20000>;
> > +            interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
> > +                         <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
> > +                         <GIC_SPI 77 IRQ_TYPE_EDGE_RISING>,
> > +                         <GIC_SPI 79 IRQ_TYPE_EDGE_RISING>;
> > +            interrupt-names = "eventq", "priq", "cmdq-sync", "gerror";
> > +            dma-coherent;
> > +            #iommu-cells = <1>;
> > +            msi-parent = <&its 0xff0000>;
> > +    };
> >
