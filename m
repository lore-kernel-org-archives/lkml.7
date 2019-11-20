Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48C3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E22822467
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lCDJfRBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbfKTN4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:56:08 -0500
Received: from mail-eopbgr690050.outbound.protection.outlook.com ([40.107.69.50]:40182
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731004AbfKTN4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:56:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guMK7EZ/37LE9LWMGIQUbhf0l9SHjhlzWgJAGvdFtwaZV8x+9fwCf0S8NtwBhHdOcSgftUQ5S6wDRa1BOB+fjL/WZFVNd+VDTeDh8pnoH+2gO5BCw1NAm0GRP3TwMLYLMrC1V6v8fsQQPiUtw15hVsy9xQkmSGMQULqAHuBrzwclknFIHp6Eog3vwWMJranPS6SZf8ujPDjtRWqVsK+f4dcA0JYiHUlSCkYS9qWQgeXj0c6qer+vExL8kgRrzZOSopA83DXbcCoMQkCuF5qAgE5AhXLmaxKj61O6vjc+dTmp6eY26P9ZevEVJDr7e8j70JsKVlZzDzqVC/+xUu1rsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAZS9IiI7FGZ5Mvv23bFskuGYbwlByEO4yctITik4+8=;
 b=McTIRLK6QslT6B1u7Q2NANHXht+qcXmBnUgijrgRjvh/ks6UWWatJlaZYfsriQ5WhV2SE7UWSoX2Yt2C0xDSaM4lIbIu6kbB+GvhTvM0/Z+3W3xthXdvgIJTEuDWTy5a9qYTXyDYIcEZZMo/ClmzV4G6d35BIZo1bIKu/GhRvR2HXj8/mGCy+Ja1kklUTh8omixtaMq2Y0VuOWEJLvKjSyFb5staTzE7spuLHftemOJKfjzP4tl72gNswxJi4+DiRybjjSgK5ahvwQBYrOSxox4MEHv2cBwTC93+v2FgpZ89dYYoJOq6jXGDyywMSL0fqkyxgTtdS9JRbuo2hoyVEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAZS9IiI7FGZ5Mvv23bFskuGYbwlByEO4yctITik4+8=;
 b=lCDJfRBZTSXrSMm/y6DX54FRYYC2F5H/HLx4+3dU7UxxMwwAU1NPg1TEtEsVSzLwtJMQ5VHmxEzoptiSsIOsYQs3RlNCXFH2GzriJXZXvKTTlLkDLmbKPafyrR8AiC+9kxRd+bYe1YhUwRcsV4HZ+Lll2yRV5DHqpoCvVHt32+c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from BY5PR12MB3860.namprd12.prod.outlook.com (10.255.138.89) by
 BY5PR12MB4321.namprd12.prod.outlook.com (52.135.53.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Wed, 20 Nov 2019 13:56:03 +0000
Received: from BY5PR12MB3860.namprd12.prod.outlook.com
 ([fe80::dc7:b2d0:b79d:88de]) by BY5PR12MB3860.namprd12.prod.outlook.com
 ([fe80::dc7:b2d0:b79d:88de%2]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 13:56:03 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/2] iommu/amd: Check feature support bit before accessing MSI capability registers
Date:   Wed, 20 Nov 2019 07:55:48 -0600
Message-Id: <1574258149-15602-2-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574258149-15602-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1574258149-15602-1-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN2PR01CA0044.prod.exchangelabs.com (2603:10b6:800::12) To
 BY5PR12MB3860.namprd12.prod.outlook.com (2603:10b6:a03:1ac::25)
MIME-Version: 1.0
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc86970f-3177-4880-6fcb-08d76dc161bd
X-MS-TrafficTypeDiagnostic: BY5PR12MB4321:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4321F0C3E5B6317E330A0D7EF34F0@BY5PR12MB4321.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(199004)(189003)(16586007)(6436002)(2906002)(316002)(6666004)(6486002)(66556008)(66476007)(36756003)(44832011)(186003)(48376002)(26005)(6116002)(3846002)(76176011)(50466002)(4326008)(6506007)(486006)(52116002)(14454004)(51416003)(305945005)(386003)(66946007)(50226002)(476003)(86362001)(8936002)(14444005)(81166006)(81156014)(4720700003)(2616005)(478600001)(5660300002)(7736002)(66066001)(8676002)(47776003)(25786009)(6512007)(446003)(99286004)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR12MB4321;H:BY5PR12MB3860.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3uRbzF5/nvPDqk6QbAiR8Z4Ng5bAQiSqTCDQdTLlC7Mw/gp59ro4XvOLzpL3qNSLsPcKQ1ngWqQsk/RjfuKz44xY1+8Vy+dxWUjfa4dBbQhFSP/yBMKya4CXoWeJQFLIxG8P3iCBMd0zswFT/abOaJmnPtAT5S/t+ItCQQuhdBS34fhHc4LycKgLHqtmPSoIRjSH82QnfVvI0THXEjMNV+NQGS4tgH7TheUNf4RkBVl7taVjvVeH1M+ZVEtikeEKtl5G2xHJZP/AJa6AikiCi6anfFBeeGWN4JKVTxNzmM5/FwpZQBcF/uBhjsL9hDm0buDMUs6U13m+N5UnRe7zdP5D/WnR92P7QnLL++C7sIcEVayxjefeYuy7tCAFf4xl35d/1k8PsjZOfvfiEEXAu3YU5/fPNpfxbqPgEfFJBbqHwBDmbl1LzT5M3QsXXoCn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc86970f-3177-4880-6fcb-08d76dc161bd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 13:56:03.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIlu3vSlwssBnmbH/yFtaa+dCK3DklZyLrBjDBC83D9+IQaeyELEdmEVpbNzPylm6cWVABJ7aIk8t/RlUzcEDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOMMU MMIO access to MSI capability registers is available only if
the EFR[MsiCapMmioSup] is set. Current implementation assumes this bit
is set if the EFR[XtSup] is set, which might not be the case.

Fix by checking the EFR[MsiCapMmioSup] before accessing the MSI address
low/high and MSI data registers via the MMIO.

Fixes: 66929812955b ('iommu/amd: Add support for X2APIC IOMMU interrupts')
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu_init.c  | 17 ++++++++++++-----
 drivers/iommu/amd_iommu_types.h |  1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 4413aa6..1dcc0b3 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -146,7 +146,7 @@ struct ivmd_header {
 bool amd_iommu_irq_remap __read_mostly;
 
 int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
-static int amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
+static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 
 static bool amd_iommu_detected;
 static bool __initdata amd_iommu_disabled;
@@ -1531,8 +1531,15 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
 		if (((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0))
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
-		if (((h->efr_reg & (0x1 << IOMMU_EFR_XTSUP_SHIFT)) == 0))
-			amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
+		/*
+		 * Note: Since iommu_update_intcapxt() leverages
+		 * the IOMMU MMIO access to MSI capability block registers
+		 * for MSI address lo/hi/data, we need to check both
+		 * EFR[XtSup] and EFR[MsiCapMmioSup] for x2APIC support.
+		 */
+		if ((h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT)) &&
+		    (h->efr_reg & BIT(IOMMU_EFR_MSICAPMMIOSUP_SHIFT)))
+			amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
 		break;
 	default:
 		return -EINVAL;
@@ -1981,8 +1988,8 @@ static int iommu_init_intcapxt(struct amd_iommu *iommu)
 	struct irq_affinity_notify *notify = &iommu->intcapxt_notify;
 
 	/**
-	 * IntCapXT requires XTSup=1, which can be inferred
-	 * amd_iommu_xt_mode.
+	 * IntCapXT requires XTSup=1 and MsiCapMmioSup=1,
+	 * which can be inferred from amd_iommu_xt_mode.
 	 */
 	if (amd_iommu_xt_mode != IRQ_REMAP_X2APIC_MODE)
 		return 0;
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 34d63af..89b0c6e 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -383,6 +383,7 @@
 /* IOMMU Extended Feature Register (EFR) */
 #define IOMMU_EFR_XTSUP_SHIFT	2
 #define IOMMU_EFR_GASUP_SHIFT	7
+#define IOMMU_EFR_MSICAPMMIOSUP_SHIFT	46
 
 #define MAX_DOMAIN_ID 65536
 
-- 
1.8.3.1

