Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1271CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63DC2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ki0P2nef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfCMVqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:46:32 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19137 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbfCMVqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:46:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c897a0b0000>; Wed, 13 Mar 2019 14:45:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Mar 2019 14:45:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Mar 2019 14:45:59 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 21:45:59 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 21:45:58 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Mar 2019 21:45:58 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.74]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c897a160002>; Wed, 13 Mar 2019 14:45:58 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <anrao@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V3 06/10] mmc: cqhci: allow hosts to update dcmd cmd desc
Date:   Wed, 13 Mar 2019 14:45:48 -0700
Message-ID: <1552513552-23423-6-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552513547; bh=V+bfIzUrLXfJE1pDNTk7QEYBIHRBNMqDrsM2wxqxZTw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=Ki0P2nefs536r5Goc4X78Ziaj07p/wL0OwWcItotX8H66XlvbQuomTgCGbpy0KIit
         l/5x8vK+RLDveO3KXYQjAN1hcNeGJ9tj9RSSfqAkK0MnP8AK8FZEXEkKVCcRxFpUxt
         z4JhRIyLTdyy4GGD1+iKNyQ0huWDAqQao4tH1mf54GhElCm81W427Fzt45M8d0+rNQ
         3kJsEbrge7t1O6rG0aCx5mvB7Lreprl2ynfC+cmOdLxuBDcCZwNOl9wf1bhFsNusET
         Ak0u2VP0zbRYBn9eOpYVavr/L8n0GktEKofHtiSTTgl/Appl9H2L2Fuw4ySjcMzvIv
         Jb8Eu1fafZTZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds update_dcmd_desc interface to cqhci_host_ops to
allow hosts to update any of the DCMD task descriptor attributes
and parameters.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/cqhci.c | 2 ++
 drivers/mmc/host/cqhci.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index a8af682a9182..d59cb0a51964 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -537,6 +537,8 @@ static void cqhci_prep_dcmd_desc(struct mmc_host *mmc,
 		 CQHCI_ACT(0x5) |
 		 CQHCI_CMD_INDEX(mrq->cmd->opcode) |
 		 CQHCI_CMD_TIMING(timing) | CQHCI_RESP_TYPE(resp_type));
+	if (cq_host->ops->update_dcmd_desc)
+		cq_host->ops->update_dcmd_desc(mmc, mrq, &data);
 	*task_desc |= data;
 	desc = (u8 *)task_desc;
 	pr_debug("%s: cqhci: dcmd: cmd: %d timing: %d resp: %d\n",
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index 9e68286a07b4..8c8ec6f01c45 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -210,6 +210,8 @@ struct cqhci_host_ops {
 	u32 (*read_l)(struct cqhci_host *host, int reg);
 	void (*enable)(struct mmc_host *mmc);
 	void (*disable)(struct mmc_host *mmc, bool recovery);
+	void (*update_dcmd_desc)(struct mmc_host *mmc, struct mmc_request *mrq,
+				 u64 *data);
 };
 
 static inline void cqhci_writel(struct cqhci_host *host, u32 val, int reg)
-- 
2.7.4

