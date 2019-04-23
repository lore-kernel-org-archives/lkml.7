Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59196C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DCD20811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uSZwv/BB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfDWLQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:16:32 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40943 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDWLQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:16:31 -0400
Received: by mail-it1-f194.google.com with SMTP id k64so23060481itb.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 04:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mDddDEFyx868qYQMU+NLd8y62RLBKhnM110YJ+t7rgE=;
        b=uSZwv/BBFoYksCDLwSYQpDDmO61r1XBzWNz1XEhBNxWVSTqBLMsr1K6PQVhXdfA7Sh
         csOv1UJ4LZBs1VmQ15/3U+T7e2dI/asioCNOmIpLp+iHltsX1OXtLAamQ8i96GhXoB2I
         oe8S7nCX16mwgcOyKLQ9TqYpXZraDfPzacZAHbdUd64/yX1WnfD+Dp/D7rdZVfPwWQrY
         /4AoJWdr7PQa9d8PI/4vOQOi3vP7Kt08Fwd3AoU76O5gHH/JrQ5sszIxINnitgtOKqzI
         8yQEpO8kmoIdNSlWPL9MbSnkIjp7zq6flscJyEHl7VikaD8df/uVY1EKEhUmlltPf6cY
         B8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDddDEFyx868qYQMU+NLd8y62RLBKhnM110YJ+t7rgE=;
        b=Pf8A2m60KtbEuqsrqHWqaeFiZCvxf2Aq2to4WtZv1EUV9GpQ9OJV1DXayqo+XZ8F07
         /N+RVCqbO3WAg25sMlH9SzAB/gHvKGGW4cwPYDprzXZvMnrtShrphx/eDW6ylVrLPq+d
         eU8KiU49stpZQ4Gv4/ZneEi1gkE1hYpcd5zGuiX72r0Od1WjwyswzuiF3DwtGDefo8tm
         CesMcNHdDyyIIPMvkae3VQomjtnZC8yI0F1VYYCHSfazbWfPs5eNkEn55UQ9RA4S3S/j
         FGPXc8cjTrguIXEnwsp9cqauRGyFcjY5ejuSka8CcnBNHZl6tlJlx521hsf+v8mUl5eZ
         SxRg==
X-Gm-Message-State: APjAAAUb7AlpnbvKmS61CjU4xySoFw22BiyAj4LOI1nZuSHlO+qdQA5J
        5ghgg1ARfHAA8sWJ3mCQBQN3j5KEPoO9NophxlBY/Q==
X-Google-Smtp-Source: APXvYqyZLJQ2lAZMUR1Kvlscipudkp0AUkQIT2gBYuIMUAkZki5oyQezsgAw87+7hLYAcprER+aozpjBP72Ib2VXLhA=
X-Received: by 2002:a24:1312:: with SMTP id 18mr1366425itz.121.1556018190857;
 Tue, 23 Apr 2019 04:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190422071036.32671-1-vivek.gautam@codeaurora.org> <149dee19-e2eb-0b27-3df0-c99a05e8bea1@arm.com>
In-Reply-To: <149dee19-e2eb-0b27-3df0-c99a05e8bea1@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 23 Apr 2019 13:16:18 +0200
Message-ID: <CAKv+Gu-W4x-8Aha6vV6xjfmkt1X+Yhb_hjxXTsqdUyCpb4XHHA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] iommu/arm-smmu: Log CBFRSYNRA register on context fault
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 at 13:13, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 22/04/2019 08:10, Vivek Gautam wrote:
> > Bits[15:0] in CBFRSYNRA register contain information about
> > StreamID of the incoming transaction that generated the
> > fault. Dump CBFRSYNRA register to get this info.
> > This is specially useful in a distributed SMMU architecture
> > where multiple masters are connected to the SMMU.
> > SID information helps to quickly identify the faulting
> > master device.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >
> > Changes since v1:
> >   - Addressed review comments, given by Bjorn, for nits.
> >
> >   drivers/iommu/arm-smmu-regs.h | 2 ++
> >   drivers/iommu/arm-smmu.c      | 7 +++++--
> >   2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu-regs.h b/drivers/iommu/arm-smmu-regs.h
> > index a1226e4ab5f8..e9132a926761 100644
> > --- a/drivers/iommu/arm-smmu-regs.h
> > +++ b/drivers/iommu/arm-smmu-regs.h
> > @@ -147,6 +147,8 @@ enum arm_smmu_s2cr_privcfg {
> >   #define CBAR_IRPTNDX_SHIFT          24
> >   #define CBAR_IRPTNDX_MASK           0xff
> >
> > +#define ARM_SMMU_GR1_CBFRSYNRA(n)    (0x400 + ((n) << 2))
> > +
> >   #define ARM_SMMU_GR1_CBA2R(n)               (0x800 + ((n) << 2))
> >   #define CBA2R_RW64_32BIT            (0 << 0)
> >   #define CBA2R_RW64_64BIT            (1 << 0)
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 045d93884164..e000473f8205 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -575,7 +575,9 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> >       struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> >       struct arm_smmu_device *smmu = smmu_domain->smmu;
> > +     void __iomem *gr1_base = ARM_SMMU_GR1(smmu);
> >       void __iomem *cb_base;
> > +     u32 cbfrsynra;
>
> Nit: I would simply add to the existing "u32 fsr, fsynr;" declaration,
> but that's the sort of thing that could hopefully be fixed up when
> applying (or otherwise I might bulldoze it anyway in my eventual rework
> of register accesses throughout the driver). Regardless,
>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>
> >       cb_base = ARM_SMMU_CB(smmu, cfg->cbndx);
> >       fsr = readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
> > @@ -585,10 +587,11 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >
> >       fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
> >       iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
> > +     cbfrsynra = readl_relaxed(gr1_base + ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
> >
> >       dev_err_ratelimited(smmu->dev,
> > -     "Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
> > -                         fsr, iova, fsynr, cfg->cbndx);
> > +     "Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
> > +                         fsr, iova, fsynr, cbfrsynra, cfg->cbndx);
> >
> >       writel(fsr, cb_base + ARM_SMMU_CB_FSR);
> >       return IRQ_HANDLED;
> >
>

This is something I've had to hack up locally in the past, so

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
