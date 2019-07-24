Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15C6C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83164229F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996931;
	bh=Ag/Y4uB+I8AbYtTVHO4ERvH1pTAoGtX+TNBxH7ChFPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1QdlrdIvu0VAPqghrYONu20v/Spl4aknHpO7u5fH/EJj3d9hv7QIYoq9XrCA3WaL+
	 3Uak240er1+YXFHxp98mtrKfz6YFeJKFrjGjkC6ZBvn4SCsCc8Vs2UbB18asgHuXd7
	 Uh23c/T8sw4B8aL594QD08gm/voqtUSYEu6Jui0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389209AbfGXTfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:35:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388927AbfGXTdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:33:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DE3B229F4;
        Wed, 24 Jul 2019 19:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996803;
        bh=Ag/Y4uB+I8AbYtTVHO4ERvH1pTAoGtX+TNBxH7ChFPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lml/9AUr61onDU/eTkilOunP5vaNnnDLJDJ9/wqggZqLCgJRCVlhN/RWoR232nbdx
         C9UHTPTBLQuZqcp15x6kVrMn4nEGFZOBNOFSpSP0zPUkkPNNAqilrXIZzT6zdvsYPA
         H2WTNIsFlaA7l+LbWGdK8DAsY3hHJxycN3E2b2sM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manoj Kumar <Manoj.Kumar3@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 223/413] iommu/arm-smmu-v3: Invalidate ATC when detaching a device
Date:   Wed, 24 Jul 2019 21:18:34 +0200
Message-Id: <20190724191750.813644164@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8dd8f005bdd45823fc153ef490239558caf6ff20 ]

We make the invalid assumption in arm_smmu_detach_dev() that the ATC is
clear after calling pci_disable_ats(). For one thing, only enabling the
PCIe ATS capability constitutes an implicit invalidation event, so the
comment was wrong. More importantly, the ATS capability isn't necessarily
disabled by pci_disable_ats() in a PF, if the associated VFs have ATS
enabled. Explicitly invalidate all ATC entries in arm_smmu_detach_dev().
The endpoint cannot form new ATC entries because STE.EATS is clear.

Fixes: 9ce27afc0830 ("iommu/arm-smmu-v3: Add support for PCI ATS")
Reported-by: Manoj Kumar <Manoj.Kumar3@arm.com>
Reported-by: Robin Murphy <Robin.Murphy@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm-smmu-v3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4d5a694f02c2..0fee8f7957ec 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1884,9 +1884,13 @@ static int arm_smmu_enable_ats(struct arm_smmu_master *master)
 
 static void arm_smmu_disable_ats(struct arm_smmu_master *master)
 {
+	struct arm_smmu_cmdq_ent cmd;
+
 	if (!master->ats_enabled || !dev_is_pci(master->dev))
 		return;
 
+	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
+	arm_smmu_atc_inv_master(master, &cmd);
 	pci_disable_ats(to_pci_dev(master->dev));
 	master->ats_enabled = false;
 }
@@ -1906,7 +1910,6 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 	master->domain = NULL;
 	arm_smmu_install_ste_for_dev(master);
 
-	/* Disabling ATS invalidates all ATC entries */
 	arm_smmu_disable_ats(master);
 }
 
-- 
2.20.1



