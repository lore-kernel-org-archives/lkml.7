Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AABAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75A02084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="miHsXDG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfCKSDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:03:09 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5151 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728039AbfCKSCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:02:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c86a2bc0000>; Mon, 11 Mar 2019 11:02:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 Mar 2019 11:02:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 Mar 2019 11:02:47 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Mar
 2019 18:02:46 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 11 Mar 2019 18:02:46 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.53]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c86a2c50004>; Mon, 11 Mar 2019 11:02:45 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <anrao@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 06/10] mmc: cqhci: allow hosts to specify dcmd cmd timing parameter
Date:   Mon, 11 Mar 2019 11:02:35 -0700
Message-ID: <1552327359-8036-6-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552327359-8036-1-git-send-email-skomatineni@nvidia.com>
References: <1552327359-8036-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552327356; bh=xXfxhjVfx7zZWxrfDnvmqGqXifxOh5qV+ofa+zpuvKs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=miHsXDG2LoaX1G/up29xg0uTiIG5s+45TUAnf2YY8zvrOabfuuHaZZewnrNsalN43
         e1ozW/7QV96ZMzw5F0AP6qkIMbIUFZeXKDObpemcjgbJjKqqJJ+mWqYPM6qUZJeC4c
         EPhBx2+Qnh02S6mODy/jKnQwjOwkKvVko9ZpUkgtyVcVUX/xgwg1gcpyK/cOsp2Bwk
         ZfmbqWe5XW+cv1hdpPP9PopfdGH5RvKA3lmn2CJeS2nd6PC9K7TJ2baulujJ05p+ki
         yrlc1iXS+2iFClTPRhy/8kX9DgpClr2dTJrSVP54k0l1WMtU+AcRuzGB+1kEm80azS
         9wP6Gek1FRyaA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds get_dcmd_cmd_timing interface to cqhci_host_ops to
allow hosts to specify CMD_TIMING bit of the DCMD task descriptor
command parameter.

This helps host driver to control whether the command can be issued
during data transfer or only during idle time.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/cqhci.c | 2 ++
 drivers/mmc/host/cqhci.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index a8af682a9182..9a02f9c82aeb 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -528,6 +528,8 @@ static void cqhci_prep_dcmd_desc(struct mmc_host *mmc,
 		}
 	}
 
+	if (cq_host->ops->get_dcmd_cmd_timing)
+		timing = cq_host->ops->get_dcmd_cmd_timing(mmc, mrq);
 	task_desc = (__le64 __force *)get_desc(cq_host, cq_host->dcmd_slot);
 	memset(task_desc, 0, cq_host->task_desc_len);
 	data |= (CQHCI_VALID(1) |
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index 9e68286a07b4..981158da3326 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -210,6 +210,8 @@ struct cqhci_host_ops {
 	u32 (*read_l)(struct cqhci_host *host, int reg);
 	void (*enable)(struct mmc_host *mmc);
 	void (*disable)(struct mmc_host *mmc, bool recovery);
+	u8 (*get_dcmd_cmd_timing)(struct mmc_host *mmc,
+				  struct mmc_request *mrq);
 };
 
 static inline void cqhci_writel(struct cqhci_host *host, u32 val, int reg)
-- 
2.7.4

