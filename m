Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703BFC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DB921841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="q+pR+ptS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfFNQbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:31:08 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10277 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfFNQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:31:08 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d03cbcb0000>; Fri, 14 Jun 2019 09:31:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 14 Jun 2019 09:31:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 14 Jun 2019 09:31:07 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 16:31:07 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 16:31:06 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 14 Jun 2019 16:31:06 +0000
Received: from dhcp-10-19-65-14.client.nvidia.com (Not Verified[10.19.65.14]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d03cbc80002>; Fri, 14 Jun 2019 09:31:05 -0700
From:   Bitan Biswas <bbiswas@nvidia.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     Bitan Biswas <bbiswas@nvidia.com>
Subject: [PATCH V2 1/2] mailbox: tegra: hsp: add noirq resume
Date:   Fri, 14 Jun 2019 09:31:00 -0700
Message-ID: <1560529861-31376-1-git-send-email-bbiswas@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560529867; bh=kY8VvquYLGjeRdDquvZL6OISFhZiac6UhQbP3UIP5JE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=q+pR+ptSZk7iIYbX4kggcTHh1rRcw1G0HKLD/RkTLBsO2h/xnsfGs1RulBUEuqDLE
         qc43SB2OkZJtQXBjF2Cv2Dv2LYVmUT5weYFet6NbQ7U/LpUz38nu1F8pPjh47fCdP1
         qaEVdM+wdVgovo6LUNeTm5N/EdNTrMzFZRIaNq5B5d6hugM9zHkS06f6mSasZva3i3
         ZAQu+Tcuo2c8QIhJYTU9uWNaJqgdy5tLH8Kqb54s32YAoCeAyiHadfhQ+5yfnIgC3j
         unZvygFHS5CjEPeDuCHGd79E62wn26A033Ynxe3vRibfkcSInHPoC0JwGp4DPWpK8Y
         zxWQnSl3bN7pw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add noirq resume instead of resume callback for Tegra HSP. Tegra HSP
resume needs tegra_hsp_doorbell_startup() call to fix timeout error for
tegra_bpmp_transfer() during genpd resume noirq on Jetson TX2.

Signed-off-by: Bitan Biswas <bbiswas@nvidia.com>
---
 drivers/mailbox/tegra-hsp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index 91f1a0c..91e223e 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -775,6 +775,12 @@ static int __maybe_unused tegra_hsp_resume(struct device *dev)
 {
 	struct tegra_hsp *hsp = dev_get_drvdata(dev);
 	unsigned int i;
+	struct tegra_hsp_doorbell *db;
+
+	list_for_each_entry(db, &hsp->doorbells, list) {
+		if (db && db->channel.chan)
+			tegra_hsp_doorbell_startup(db->channel.chan);
+	}
 
 	for (i = 0; i < hsp->num_sm; i++) {
 		struct tegra_hsp_mailbox *mb = &hsp->mailboxes[i];
@@ -786,7 +792,9 @@ static int __maybe_unused tegra_hsp_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(tegra_hsp_pm_ops, NULL, tegra_hsp_resume);
+static const struct dev_pm_ops tegra_hsp_pm_ops = {
+	.resume_noirq = tegra_hsp_resume,
+};
 
 static const struct tegra_hsp_db_map tegra186_hsp_db_map[] = {
 	{ "ccplex", TEGRA_HSP_DB_MASTER_CCPLEX, HSP_DB_CCPLEX, },
-- 
2.7.4

