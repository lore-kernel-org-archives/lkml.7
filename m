Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B044AC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9B5218D4
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jNnQ153z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfCXEpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 00:45:30 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7522 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfCXEp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 00:45:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c970b640000>; Sat, 23 Mar 2019 21:45:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 23 Mar 2019 21:45:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 23 Mar 2019 21:45:26 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 24 Mar
 2019 04:45:26 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 24 Mar
 2019 04:45:25 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 24 Mar 2019 04:45:25 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.168.175]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c970b640000>; Sat, 23 Mar 2019 21:45:25 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <anrao@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V4 06/10] mmc: cqhci: allow hosts to update dcmd cmd desc
Date:   Sat, 23 Mar 2019 21:45:23 -0700
Message-ID: <1553402727-23130-6-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
References: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553402724; bh=z6AeS4Pzw6X26u3f511uPp/WLjJuU16X7wgl8LT64Uk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=jNnQ153zhlPFkouUz4Bv20lHC0GWQ4BI61PQ53/5ntn/UalsNVNVo8bV0jikGChVb
         y6SXVTCctwWvJ5F+NoWOsr1itSG1lFjxwXevOmFhzWhjb8FdsgT5YSMrcC1FauJshc
         NhyACOFTuyLrEbpVY1TSNPqSSCgG8XzIsivpGCIfGC+jg5HDEybTPjliwOhv4aYoNf
         9iuX8EAUHbubrNBKAeIdkBlF2mWQZJScILzrArv16DzP3C7OEMoHHv2U4GdQJeEc27
         WACip/z7iBKbKlPAaBLMp5YLsar0MqwR1RvviN28gmx/ZW/qtsIVM2gNOHf8Rf6Sfb
         i1AI5YQ8zkH4w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds update_dcmd_desc interface to cqhci_host_ops to
allow hosts to update any of the DCMD task descriptor attributes
and parameters.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Ritesh Harjani <riteshh@codeaurora.org>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V4]: Minor fix of missing declaration of mmc_request

 drivers/mmc/host/cqhci.c | 2 ++
 drivers/mmc/host/cqhci.h | 3 +++
 2 files changed, 5 insertions(+)

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
index 9e68286a07b4..928ec491eecf 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -147,6 +147,7 @@
 
 struct cqhci_host_ops;
 struct mmc_host;
+struct mmc_request;
 struct cqhci_slot;
 
 struct cqhci_host {
@@ -210,6 +211,8 @@ struct cqhci_host_ops {
 	u32 (*read_l)(struct cqhci_host *host, int reg);
 	void (*enable)(struct mmc_host *mmc);
 	void (*disable)(struct mmc_host *mmc, bool recovery);
+	void (*update_dcmd_desc)(struct mmc_host *mmc, struct mmc_request *mrq,
+				 u64 *data);
 };
 
 static inline void cqhci_writel(struct cqhci_host *host, u32 val, int reg)
-- 
2.7.4

