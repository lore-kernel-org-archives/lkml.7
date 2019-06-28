Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F91C5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABA2208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HASIAZx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfF1JKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:10:41 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34476 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF1JKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:10:40 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5S9APlg043287;
        Fri, 28 Jun 2019 04:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561713025;
        bh=PyzXqhCWhSAbLB5+/1FsHp/HhykuAK3VDCsltKyHkjM=;
        h=From:To:CC:Subject:Date;
        b=HASIAZx39UXcn/CCT75M4FcplifCc6kQNhPFDRY72paGex9EZw+fcaRTcMHFW5ws6
         0MfzJ6lWWK6kddiR6GZs9+w9C2isfJVSxbwIbFAoatd+5KdJYW+WMAe34zzyaXDr4x
         HONLRwllUmzL73C9dL73ZJe8tj7TeeIYvghx8w8U=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5S9APnv115253
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jun 2019 04:10:25 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 28
 Jun 2019 04:10:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 28 Jun 2019 04:10:25 -0500
Received: from pratyush-laptop.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5S9ALY9077598;
        Fri, 28 Jun 2019 04:10:22 -0500
From:   Pratyush Yadav <p-yadav1@ti.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <wmills@ti.com>, <nsekhar@ti.com>, <lokeshvutla@ti.com>,
        Pratyush Yadav <p-yadav1@ti.com>
Subject: [PATCH] iommu/arm-smmu-v3: Fix incorrect fields being passed to prefetch command
Date:   Fri, 28 Jun 2019 14:39:53 +0530
Message-ID: <20190628090953.23606-1-p-yadav1@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the SMMUv3 spec [0] section 4.2.1, command 0x1
(CMD_PREFETCH_CONFIG) does not take address and size as parameters. It
only takes  StreamID, SSec, SubstreamID, and SSV. Address and Size are
parameters for command 0x2 (CMD_PREFETCH_ADDR).

Tested on kernel 4.19 on TI J721E SOC.

[0] https://static.docs.arm.com/ihi0070/a/IHI_0070A_SMMUv3.pdf

Signed-off-by: Pratyush Yadav <p-yadav1@ti.com>
---
 drivers/iommu/arm-smmu-v3.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4d5a694f02c2..2d4dfd909436 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -413,6 +413,7 @@ struct arm_smmu_cmdq_ent {
 	/* Command-specific fields */
 	union {
 		#define CMDQ_OP_PREFETCH_CFG	0x1
+		#define CMDQ_OP_PREFETCH_ADDR	0x2
 		struct {
 			u32			sid;
 			u8			size;
@@ -805,10 +806,12 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	case CMDQ_OP_TLBI_EL2_ALL:
 	case CMDQ_OP_TLBI_NSNH_ALL:
 		break;
-	case CMDQ_OP_PREFETCH_CFG:
-		cmd[0] |= FIELD_PREP(CMDQ_PREFETCH_0_SID, ent->prefetch.sid);
+	case CMDQ_OP_PREFETCH_ADDR:
 		cmd[1] |= FIELD_PREP(CMDQ_PREFETCH_1_SIZE, ent->prefetch.size);
 		cmd[1] |= ent->prefetch.addr & CMDQ_PREFETCH_1_ADDR_MASK;
+		/* Fallthrough */
+	case CMDQ_OP_PREFETCH_CFG:
+		cmd[0] |= FIELD_PREP(CMDQ_PREFETCH_0_SID, ent->prefetch.sid);
 		break;
 	case CMDQ_OP_CFGI_STE:
 		cmd[0] |= FIELD_PREP(CMDQ_CFGI_0_SID, ent->cfgi.sid);
-- 
2.17.1

