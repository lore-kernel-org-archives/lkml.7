Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25EEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7640A2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfDDPag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:30:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34262 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfDDPaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:30:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77B45169E;
        Thu,  4 Apr 2019 08:30:35 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 214603F59C;
        Thu,  4 Apr 2019 08:30:33 -0700 (PDT)
Date:   Thu, 4 Apr 2019 16:30:31 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] iommu/arm-smmu-v3: make sure the kdump kernel can
 work well when smmu is enabled
Message-ID: <20190404153031.GE27558@fuggles.cambridge.arm.com>
References: <20190318131243.20716-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318131243.20716-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen Lei,

On Mon, Mar 18, 2019 at 09:12:41PM +0800, Zhen Lei wrote:
> v1 --> v2:
> 1. Drop part2. Now, we only use the SMMUv3 hardware feature STE.config=0b000
> (Report abort to device, no event recorded) to suppress the event messages
> caused by the unexpected devices.
> 2. rewrite the patch description.

This issue came up a while back:

https://lore.kernel.org/linux-pci/20180302103032.GB19323@arm.com/

and I'd still prefer to solve it using the disable_bypass logic which we
already have. Something along the lines of the diff below?

We're relying on the DMA API not subsequently requesting a passthrough
domain, but it should only do that if you've configured your crashkernel
to do so.

Will

--->8

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d3880010c6cf..91b8f3b2ee25 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2454,13 +2454,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
 	if (reg & CR0_SMMUEN) {
-		if (is_kdump_kernel()) {
-			arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
-			arm_smmu_device_disable(smmu);
-			return -EBUSY;
-		}
-
 		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
+		WARN_ON(is_kdump_kernel() && !disable_bypass);
+		arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
 	}
 
 	ret = arm_smmu_device_disable(smmu);
