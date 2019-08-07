Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F931C32756
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AF3217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Nv37NQ2c";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q3Ox/+VI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388867AbfHGWTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:19:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35714 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfHGWTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:19:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9B1C6608A5; Wed,  7 Aug 2019 22:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565216393;
        bh=AsxvbLeJVZmEE+jtGajQWWI22/FywEfAo7Ps7nevM1w=;
        h=From:To:Cc:Subject:Date:From;
        b=Nv37NQ2cJqFLUaZYxTPgpGRuiBMG3a/aduUmxQqm0hOEdFD0v8BHw/XkJvXx9MXLY
         QD6k4BLVMZrYqORNFL7AT6s57PpXlFeOzdBUsKxd4bF1CiiObO2CDt2MMO8KLcslDK
         PYuUm1tcheUeIatIS646Zg62x8xk/GzNpsgTy3DU=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6D93A608A5;
        Wed,  7 Aug 2019 22:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565216392;
        bh=AsxvbLeJVZmEE+jtGajQWWI22/FywEfAo7Ps7nevM1w=;
        h=From:To:Cc:Subject:Date:From;
        b=Q3Ox/+VICQiHcBcLyDCeEOg2zst+yk0qsF7GtHJI8k0lKTmAURfRpS2R1Iok0vbyh
         xOX7U18y23C8rJNCp+s0JyzOUKNjBrOa0M0d0yES4EM6nJ0VLIdOPQ29/8s0tGrRGi
         iF2L2ibuY46XWUR5y1HhjpQ7DsPxegjXw1f4G4B4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D93A608A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
        robin.murphy@arm.com, Will Deacon <will@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/2] iommu/arm-smmu: Split pagetable support
Date:   Wed,  7 Aug 2019 16:19:44 -0600
Message-Id: <1565216386-28309-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is part of an ongoing evolution for enabling split pagetable support for
arm-smmu. Previous versions can be found [1].

In the discussion for v2 Robin pointed out that this is a very Adreno specific
use case and that is exactly true. Not only do we want to configure and use a
pagetable in the TTBR1 space, we also want to configure the TTBR0 region but
not allocate a pagetable for it or touch it until the GPU hardware does so. As
much as I want it to be a generic concept it really isn't.

This revision leans into that idea. Most of the same io-pgtable code is there
but now it is wrapped as an Adreno GPU specific format that is selected by the
compatible string in the arm-smmu device.

Additionally, per Robin's suggestion we are skipping creating a TTBR0 pagetable
to save on wasted memory.

This isn't as clean as I would like it to be but I think that this is a better
direction than trying to pretend that the generic format would work.

I'm tempting fate by posting this and then taking some time off, but I wanted
to try to kick off a conversation or at least get some flames so I can try to
refine this again next week. Please take a look and give some advice on the
direction.

[1] https://patchwork.freedesktop.org/series/63403/

Jordan

Jordan Crouse (2):
  iommu/io-pgtable-arm: Add support for ARM_ADRENO_GPU_LPAE io-pgtable
    format
  iommu/arm-smmu: Add support for Adreno GPU pagetable formats

 drivers/iommu/arm-smmu.c       |   8 +-
 drivers/iommu/io-pgtable-arm.c | 214 ++++++++++++++++++++++++++++++++++++++---
 drivers/iommu/io-pgtable.c     |   1 +
 include/linux/io-pgtable.h     |   2 +
 4 files changed, 209 insertions(+), 16 deletions(-)

-- 
2.7.4

