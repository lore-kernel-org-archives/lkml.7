Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70725C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4DB2246A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w6RbkKLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbfKTN4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:56:09 -0500
Received: from mail-eopbgr690050.outbound.protection.outlook.com ([40.107.69.50]:40182
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727988AbfKTN4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:56:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwvKNc7bsig1u5P7/WpgFscG01FyP4Av7EQ7EpiV5UGWLd6xHjq1fbula2vCLYXLWxlI7wNVZJear77lmVo6sRcDH099KGw/Bbo1pbdU2Jxq/DVyHXRVMpNy+85T1ziNx8yAtb0W2exdHyZ7kBAgw0Jl7zHw+YBdZD4PUyDF4aBsAqcFsZNeQTFBXvesaOodGI+qzr/HqmE4Xj4q7+ssnnZjtHWviaXeoOS3tYP2V4/KNT/0R/9I8MKOqhYpgBkfJOJOTEe/C2oYBiDNuHTtmYaK8VvUF+W+GNTBtcEb/StZcINNZ3znaV1l9EIZhWwaBVxijoqy+x1Mq3spc7wdLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kykimmoerOAVcfnSSXXWrnmlfqHqOKaLjN2CqzV2b9w=;
 b=eSvwX44aLCivIMUjJb5uRm31D/LLzOUIWOlgbjOWvlk/5MAJTFqsvkhzB6yh31Bvq9K+shDobf/W02x75uvd9yILJjWpNqa2bg5mKXipHmRCylIa4Gnq+Be0x9buKY8o2kkGCe3XR3x7ukf7i16CY8JDuKSl9fnQZeI73bnl8VlJGmi30bq9WPCs2/I890bpWfYDYuaUqzZKegeMTBPlvi9YhTsrGLvRvVTxVIlKZC4piT2+cRll7s+RZ6vu+knKCqLgR9TE44VPXRMbT/OHINkj5h2VjGiZAKmlRXG81AykK33/twG8PqTZRCYerw8vdiICQcv5EcCg4k/OFOA0ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kykimmoerOAVcfnSSXXWrnmlfqHqOKaLjN2CqzV2b9w=;
 b=w6RbkKLK/SlBqlOy5f6nfypU2zBBIelYP8KFBDKnQn5pdDl6ed9W7hFDkujyxcPwbqBQ+1YvF650GaB/8N9Hvb2HWjsNIH2Iy5E0ihWJ9MeUO+zrbqiNXpfjFzH+MIgFCooNjzAMP7zVT7AfbpNpObHISDEOo8Er5htRjKV/+tY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from BY5PR12MB3860.namprd12.prod.outlook.com (10.255.138.89) by
 BY5PR12MB4321.namprd12.prod.outlook.com (52.135.53.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Wed, 20 Nov 2019 13:56:05 +0000
Received: from BY5PR12MB3860.namprd12.prod.outlook.com
 ([fe80::dc7:b2d0:b79d:88de]) by BY5PR12MB3860.namprd12.prod.outlook.com
 ([fe80::dc7:b2d0:b79d:88de%2]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 13:56:05 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 2/2] iommu/amd: Only support x2APIC with IVHD type 11h/40h
Date:   Wed, 20 Nov 2019 07:55:49 -0600
Message-Id: <1574258149-15602-3-git-send-email-suravee.suthikulpanit@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4fa18ad3-0e20-42c8-0f64-08d76dc16285
X-MS-TrafficTypeDiagnostic: BY5PR12MB4321:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4321F8C16050639280106D5DF34F0@BY5PR12MB4321.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(199004)(189003)(16586007)(6436002)(2906002)(316002)(6666004)(6486002)(66556008)(66476007)(36756003)(44832011)(186003)(48376002)(26005)(6116002)(3846002)(76176011)(50466002)(4326008)(6506007)(486006)(52116002)(14454004)(51416003)(305945005)(386003)(66946007)(50226002)(476003)(86362001)(8936002)(14444005)(81166006)(81156014)(4720700003)(2616005)(478600001)(5660300002)(7736002)(66066001)(8676002)(47776003)(25786009)(6512007)(446003)(99286004)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR12MB4321;H:BY5PR12MB3860.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2zWYbDLNIVjk5wegVm28E7sMuO8vbouSWGsDfwpAXhh8dTtUrzBNx75B48TPTckDEHTn3pUA0fTbAwteZZLQb6+fkLYUmG9IhpuXbmi6dsuIhHrzaOtqMI9qY1hb1Rt+sAsWuq80kPEnmfLFQ9HdWMgOLi+h8RWd0nPLNmiikpG1s+YAxYx0IUj06h+wi5yh7yFfxFVpa1brGnGVAeJPDxaJaRweRGHWhuNpa3DTklDdTtHfQ/gLF3RC54XKj4fkCMXseBfBd8cbsSUw1glYeadUNrU4ftTxWltgpzP6EtbbnjaUYZOaIE9zj1fWEyZCdWc2q4UmBlzE7CFGgJfNbPE74FwXwB7g7ZXDPaNGvEJ8DhJXJ3fX/JwC6o8CzFwgr8s5NjpCwTNWtk5CtVh+FL3mzvG7RU5HnVlBq/JFnlsiHPLIobgddNK/I0IGQfYh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa18ad3-0e20-42c8-0f64-08d76dc16285
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 13:56:04.9535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XH84MxgxA6Fk6S8StVMJLPYwTFvzDy+Hl3io24R+PbadxzueFLgvIrkLL6f51zI/rrGl5PrNV29tIzPetHJcRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation for IOMMU x2APIC support makes use of
the MMIO access to MSI capability block registers, which requires
checking EFR[MsiCapMmioSup]. However, only IVHD type 11h/40h contain
the information, and not in the IVHD type 10h IOMMU feature reporting
field. Since the BIOS in newer systems, which supports x2APIC, would
normally contain IVHD type 11h/40h, remove the IOMMU_FEAT_XTSUP_SHIFT
check for IVHD type 10h, and only support x2APIC with IVHD type 11h/40h.

Fixes: 66929812955b ('iommu/amd: Add support for X2APIC IOMMU interrupts')
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu_init.c  | 2 --
 drivers/iommu/amd_iommu_types.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 1dcc0b3..2be4020 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1520,8 +1520,6 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 			iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
 		if (((h->efr_attr & (0x1 << IOMMU_FEAT_GASUP_SHIFT)) == 0))
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
-		if (((h->efr_attr & (0x1 << IOMMU_FEAT_XTSUP_SHIFT)) == 0))
-			amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
 		break;
 	case 0x11:
 	case 0x40:
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 89b0c6e..3a94169 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -377,7 +377,6 @@
 #define IOMMU_CAP_EFR     27
 
 /* IOMMU Feature Reporting Field (for IVHD type 10h */
-#define IOMMU_FEAT_XTSUP_SHIFT	0
 #define IOMMU_FEAT_GASUP_SHIFT	6
 
 /* IOMMU Extended Feature Register (EFR) */
-- 
1.8.3.1

