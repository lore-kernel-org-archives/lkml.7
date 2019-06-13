Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D4AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199AB208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441729;
	bh=MJS7yvKUa19erwoVH5y45fZ1qZjemf3n4yflpZz+0dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=outAWVxqiad7A9/cB9i2BgTJwS9OikpUuly4RjKnmim/g4wXVDHRo8vNV7aD2TxZV
	 iBxG5+xktO/YxIilV45EN3jnbKL7NpNU3oX6uC9rE0w3MZUtMgFz9xsysK8cZzfBy4
	 F613oyNTvKk4wmFnuUE7nPhMWd3sJfFLCq79BVBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390914AbfFMQCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731413AbfFMIsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:48:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ECA9215EA;
        Thu, 13 Jun 2019 08:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415686;
        bh=MJS7yvKUa19erwoVH5y45fZ1qZjemf3n4yflpZz+0dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LeHxfZ3M6u3nsak/tpsowCZe/jNiS7tAUb7vFTRY5zbtdVOMy1JEWyDTN9q+PtfeW
         B8HlkEJL+UHj+govU2HitSJKPVmTN0nSmVeBa3VGhegfYPZ6548Zvd3/BjWeE6Z5ia
         2KGsVjRsr1e8xQbgfpQ8e2IdiaZVVVcf51vHEXcM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 089/155] iommu/arm-smmu-v3: Dont disable SMMU in kdump kernel
Date:   Thu, 13 Jun 2019 10:33:21 +0200
Message-Id: <20190613075658.081599160@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3f54c447df34ff9efac7809a4a80fd3208efc619 ]

Disabling the SMMU when probing from within a kdump kernel so that all
incoming transactions are terminated can prevent the core of the crashed
kernel from being transferred off the machine if all I/O devices are
behind the SMMU.

Instead, continue to probe the SMMU after it is disabled so that we can
reinitialise it entirely and re-attach the DMA masters as they are reset.
Since the kdump kernel may not have drivers for all of the active DMA
masters, we suppress fault reporting to avoid spamming the console and
swamping the IRQ threads.

Reported-by: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Tested-by: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Tested-by: Bhupesh Sharma <bhsharma@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d3880010c6cf..d8b73da6447d 100644
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
@@ -2553,6 +2549,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		return ret;
 	}
 
+	if (is_kdump_kernel())
+		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
 
 	/* Enable the SMMU interface, or ensure bypass */
 	if (!bypass || disable_bypass) {
-- 
2.20.1



