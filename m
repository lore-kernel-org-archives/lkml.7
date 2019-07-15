Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E049C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798E12182B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199302;
	bh=CSB78d8VQ4feoU4JwRr3dlatwl1DWkW0ll3nurdJ/58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qlumJ0clACfs/GR//1JNkr2vByW6MFHVM86uZRQshy8PfxkJS1eCs1UCqvGMEV6LS
	 F8DQHE019s6G//sTcaklXCnUVtsOnKP0mJFfWFRzax8gqP59B2oaUexd4p9CJs0vv9
	 bBtNKu9FpYSvTYnSwH8nCWAR3Eu9kxZ8XnAaf5qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387457AbfGOOBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387408AbfGOOBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:01:34 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F91B217D9;
        Mon, 15 Jul 2019 14:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199294;
        bh=CSB78d8VQ4feoU4JwRr3dlatwl1DWkW0ll3nurdJ/58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJAGaYfzshm4StsO40w4aXppPw0rhrNCrm58Xz6qA5IKuNlrrmv1oa5JD2mIRRzLz
         7hb+v/0TPoUqU/wjCZvTGkS8NmcaDTSlg8xsbXdVOeS7KqIwmFFzbhYiaQslNyoh3r
         RasA6UuFSMxmqUNrJedHm9DbtpFarGXjNR1orFZc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Manoj Kumar <Manoj.Kumar3@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.2 229/249] iommu/arm-smmu-v3: Invalidate ATC when detaching a device
Date:   Mon, 15 Jul 2019 09:46:34 -0400
Message-Id: <20190715134655.4076-229-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

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

