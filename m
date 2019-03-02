Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9904FC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 05:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E0220857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 05:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="P0q1FNJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfCBFU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 00:20:58 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17585 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbfCBFUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 00:20:49 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7a12ab0000>; Fri, 01 Mar 2019 21:20:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 01 Mar 2019 21:20:49 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 01 Mar 2019 21:20:49 -0800
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 2 Mar
 2019 05:20:48 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 2 Mar 2019 05:20:48 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.172.134]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c7a12ae0000>; Fri, 01 Mar 2019 21:20:48 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <anrao@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 07/11] mmc: cqhci: add quirk for setting DCMD CMD_TIMING
Date:   Fri, 1 Mar 2019 21:20:21 -0800
Message-ID: <1551504025-3541-7-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551504043; bh=smkvq17VQm70eK2SbYDgI2Z1aLuFj6uiizFN4E5yrd0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=P0q1FNJuIMd61AvhJV2AFdje3MPyZgy8vbyU6ZixYZ+Lw86XHouLJH9pYAujBIB7D
         TBNqzM4ZoA13LYhEuE0aOdR4AYTsyHEfposIMw3y3H7RRJrjnuiOBbCr7GHi+TWr66
         r6m//27yOeMH/B7id+5FWhKosRD5DRu7SN7H2Ja+3/ICBmQgHDB2kwjqAQgKbusaqv
         L9LVb6HapDH+EpnX8J5V/ThMFF/0gkDtSlpt7muJ+yiELm7fcI44ZCg2FrcC4S9RpT
         Itc0UCoKUNOeMWn1uqgFREPlOAADp24JRJifrPFjtVkTQjEJxGvosZSmBKWT0pXTMp
         u4m5hchxmP4ZA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a quirk for setting CMD_TIMING to 1 in descriptor
for DCMD with R1B response type to allow the command to be sent to
device during data activity or busy time.

Tegra186 CQHCI host has bug where it selects DATA_PRESENT_SELECT
to 1 by CQHCI controller for DCMDs with R1B response type and
since DCMD does not trigger any data transfer, DCMD task complete
happens leaving the DATA FSM of host controller in wait state for
data.

This effects the data transfer task issued after R1B DCMD task
and no interrupt is generated for the data transfer task.

SW WAR for this issue is to set CMD_TIMING bit to 1 in DCMD task
descriptor and as DCMD task descriptor preparation is done by
cqhci driver, this patch adds cqequirk to handle this.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/cqhci.c | 5 ++++-
 drivers/mmc/host/cqhci.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index a8af682a9182..b34c07125f32 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -521,7 +521,10 @@ static void cqhci_prep_dcmd_desc(struct mmc_host *mmc,
 	} else {
 		if (mrq->cmd->flags & MMC_RSP_R1B) {
 			resp_type = 0x3;
-			timing = 0x0;
+			if (cq_host->quirks & CQHCI_QUIRK_CMD_TIMING_R1B_DCMD)
+				timing = 0x1;
+			else
+				timing = 0x0;
 		} else {
 			resp_type = 0x2;
 			timing = 0x1;
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index 9e68286a07b4..f96d8565cc07 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -170,6 +170,7 @@ struct cqhci_host {
 
 	u32 quirks;
 #define CQHCI_QUIRK_SHORT_TXFR_DESC_SZ	0x1
+#define CQHCI_QUIRK_CMD_TIMING_R1B_DCMD	0x2
 
 	bool enabled;
 	bool halted;
-- 
2.7.4

