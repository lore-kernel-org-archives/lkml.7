Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD6BC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C0421479
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WPW2uuEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfECQG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 12:06:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40950 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfECQG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:06:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id h11so7334580wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VC/Snkdb47YXCrhgoVCm8m87mFow4IXpldKitSIRUm4=;
        b=WPW2uuEQYZhVva1B/kFnzPjaUlaLUB7LHz6G2b/8uJ84ih5o3328e4rXxAUboiXgUM
         J/wO/bHE9XT2eWIiMQWFFY5/3GImZUeiGivUZ/JkzYISpmhpqGhUZgckgutcZLdPVu2S
         UhqkY4W/e+7AWHeB+jtIcDwEjVA+2jagvE048=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VC/Snkdb47YXCrhgoVCm8m87mFow4IXpldKitSIRUm4=;
        b=K0YppmAOMxnALdkdSzmGjVk5LOm0jnftfUrePYELg+daE0D4/LrJ3tz4iRX81tkGmM
         r2hbAw4110gKHP0cYZpNq/j6yeUueCKpf8yyPtAmMP2dl5OkK8jxvgrLC0PRaPBWey2C
         7aHjb0zE8IUnkQwigEFNuAJ1A8terpWtbCG5plKcjjddtL6iJib82N2BwdYJju101fsZ
         FD25glp5j2Q2wPOw2TiSVfPde88NN+dFV8iEWliyZGZBhNc6xpnCeqXxD06bLThtJnXs
         p9sdf56o2s9ckAIviv2uO3I+E4ZxNRDnBcPLowpezL1CqQs2CVqqK7AoJb6+Cfifmd3b
         9/og==
X-Gm-Message-State: APjAAAXnuvADsVMen+Xk5QkpAd/Omiw7fJ5DK9NbywO4H5uNzZsNKIZh
        7PfKbFRoFAEOMGIj06Pik6nCXyGikjzsGG6SN9f76g==
X-Google-Smtp-Source: APXvYqyFNFaVsmW8OnGepbzg6L4B75nNvpeBtq+W+EyuOasPwlpVHMRBxacV7yDrHYb0ES1XvOUdH+XTu4EYyVOp/1w=
X-Received: by 2002:a05:600c:204d:: with SMTP id p13mr7183118wmg.53.1556899615681;
 Fri, 03 May 2019 09:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <1556892334-16270-1-git-send-email-srinath.mannam@broadcom.com> <20190503155306.GA6461@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190503155306.GA6461@e121166-lin.cambridge.arm.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Fri, 3 May 2019 21:36:44 +0530
Message-ID: <CABe79T4gMT723uZ1tJ6b4CDZ8y97CshSKtd0MRqXCktJx85+jA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] PCIe Host request to reserve IOVA
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Eric Auger <eric.auger@redhat.com>, poza@codeaurora.org,
        Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

Thanks a lot.

Regards,
Srinath.

On Fri, May 3, 2019 at 9:23 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, May 03, 2019 at 07:35:31PM +0530, Srinath Mannam wrote:
> > This patch set will reserve IOVA addresses for DMA memory holes.
> >
> > The IPROC host controller allows only a few ranges of physical address
> > as inbound PCI addresses which are listed through dma-ranges DT property.
> > Added dma_ranges list field of PCI host bridge structure to hold these
> > allowed inbound address ranges in sorted order.
> >
> > Process this list and reserve IOVA addresses that are not present in its
> > resource entries (ie DMA memory holes) to prevent allocating IOVA
> > addresses that cannot be allocated as inbound addresses.
> >
> > This patch set is based on Linux-5.1-rc3.
> >
> > Changes from v5:
> >   - Addressed Robin Murphy, Lorenzo review comments.
> >     - Error handling in dma ranges list processing.
> >     - Used commit messages given by Lorenzo to all patches.
> >
> > Changes from v4:
> >   - Addressed Bjorn, Robin Murphy and Auger Eric review comments.
> >     - Commit message modification.
> >     - Change DMA_BIT_MASK to "~(dma_addr_t)0".
> >
> > Changes from v3:
> >   - Addressed Robin Murphy review comments.
> >     - pcie-iproc: parse dma-ranges and make sorted resource list.
> >     - dma-iommu: process list and reserve gaps between entries
> >
> > Changes from v2:
> >   - Patch set rebased to Linux-5.0-rc2
> >
> > Changes from v1:
> >   - Addressed Oza review comments.
> >
> > Srinath Mannam (3):
> >   PCI: Add dma_ranges window list
> >   iommu/dma: Reserve IOVA for PCIe inaccessible DMA address
> >   PCI: iproc: Add sorted dma ranges resource entries to host bridge
> >
> >  drivers/iommu/dma-iommu.c           | 35 ++++++++++++++++++++++++++---
> >  drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
> >  drivers/pci/probe.c                 |  3 +++
> >  include/linux/pci.h                 |  1 +
> >  4 files changed, 79 insertions(+), 4 deletions(-)
>
> I have applied the series to pci/iova-dma-ranges, targeting v5.2,
> thanks.
>
> Lorenzo
