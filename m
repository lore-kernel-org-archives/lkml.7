Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4BDC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 00:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25892464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 00:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="15k+VCdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfLFAhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 19:37:09 -0500
Received: from mail-eopbgr680070.outbound.protection.outlook.com ([40.107.68.70]:33376
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbfLFAhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 19:37:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNHQnmMMfKQ9jDq4hfv9enslDlzZiFJu49rZMKfDfPfi7SrsAKRdcLmnac+xp6cw1IzOd+fpavYQDQfZ9hIVG4rqF4s6ByQkY8wRZUsrsqC+5vjLQvr7AMDgLIYT3yZnmEGQJix+moL61mysimdLoaQl5gxRABTlsKvjcY1RzIgGHYrSFQSmnnSQjhtQymef8dJMptNryxtRERuRMfksfpvzZp301dkinHt16ILhmc3oRSDjBGGMATyRzzckANIGOw1gY3dTCuAD/lmZ50m3pvre9ARrXTiWFHdbT3mKPoaPezAQ4A/CVo64t9aKVf6LTldB4ZIRD2TDlGpX/JdYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GifN/QxvrA35z19LtQYDYsIrO8zGe93Dg+nfXgJud/4=;
 b=Rkm3qEz4fLdAW9U98QBPMokX4P6on2HXxdC2+KGa7mVHjL01raUgJWJDDjU88GGlHitkX9BypOLOHmAQf3bCLn2jx5nnk2MT759VMs9CbaJhLWTCPSdTr1udXCom8IGfx6ushBap4qIFw0cSIVeVgUH4UTUAFtKTcfyExeigb0KoO6wbO3mw5/qrr5aZtDWdtUgxcgj+8iuxPuRqcBkmerNGdsEyu7K5fdZd58w9iKyfOdhATL7olZtwximKpb4v17yTvC0Us4u2Wd3kgaP/0IIUZtAiODS6JZD5z6qJomS3bIkp5alUrvW9qSXz1V3RQL75APF6KzSuJMVQlbU0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GifN/QxvrA35z19LtQYDYsIrO8zGe93Dg+nfXgJud/4=;
 b=15k+VCdx53FkrPx0Tz+T3qtjPK+6lF3Nfn+dFe123+LUrdE4QpALG2TbHRQKaSPSxK9vF2aRsefHc/Cw9MKTAfyhNWr9R7Cp8Ed4YcsJI5U2ixZOqilKi0Fi3PojZ6Fz/qto7eTWPUUPIGtW/NVEVAFsoExWdXPENdclXqza2ms=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ashish.Kalra@amd.com; 
Received: from DM6PR12MB3610.namprd12.prod.outlook.com (20.178.198.149) by
 DM6PR12MB3114.namprd12.prod.outlook.com (20.178.31.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Fri, 6 Dec 2019 00:37:03 +0000
Received: from DM6PR12MB3610.namprd12.prod.outlook.com
 ([fe80::f83a:1a61:e61c:16d]) by DM6PR12MB3610.namprd12.prod.outlook.com
 ([fe80::f83a:1a61:e61c:16d%4]) with mapi id 15.20.2495.014; Fri, 6 Dec 2019
 00:37:03 +0000
From:   Ashish Kalra <Ashish.Kalra@amd.com>
To:     hch@lst.de, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux-intel.com,
        konrad.wilk@oracle.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, brijesh.singh@amd.com,
        Thomas.Lendacky@amd.com
Subject: [PATCH] swiotlb: Adjust SWIOTBL bounce buffer size for SEV guests.
Date:   Fri,  6 Dec 2019 00:36:52 +0000
Message-Id: <20191206003652.14102-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0047.namprd12.prod.outlook.com
 (2603:10b6:802:20::18) To DM6PR12MB3610.namprd12.prod.outlook.com
 (2603:10b6:5:3a::21)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e4cd81ed-67f6-4a35-7406-08d779e469c8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:|DM6PR12MB3114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3114B26FE1FBFB675A0597B98E5F0@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0243E5FD68
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(189003)(199004)(26005)(16586007)(186003)(36756003)(6506007)(7416002)(6666004)(66946007)(50226002)(1076003)(50466002)(316002)(86362001)(8936002)(6512007)(48376002)(6636002)(305945005)(25786009)(14454004)(99286004)(2616005)(14444005)(6486002)(478600001)(5660300002)(52116002)(51416003)(66556008)(66476007)(8676002)(81156014)(81166006)(2906002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3114;H:DM6PR12MB3610.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gn7sd5wXQMDGuIVFlKYB8oTzvQfLYHM+ROASTJlhvjH+w+jwMtCeutvLouDJKCiaV4PMAk7roQq86fA36tCtnSjQlvOydEP14e7ZwkNNu21nAOZcIo9sSwXaAuR7HaM3CT1VqCwqwJ33Joykt3OpDgzOBDFu3UocSziLs9dzud7Ca2WehdKce5WY2rW0E30JZNX9f8YdZmUw3NpI+136xqtHQ/MztlBZSMb8v4mn2AvYagJbYdjvhBkYLSI+Xb/xnwEtlyskV7SuBGAmyWmgBwTMavZDSoJ1pCs5LFiUXUVZAKoH+85uK1nHN3tNShpkPfPCl9X7ctSHvEiogYNj0j0lwI1+BlQoOwa+nOdjcFP8OvVZVV4r0dqI56pb/LhDmF8xch4W9roxqNWP7kP6sRNO2VrJKMS9CtrdviDeYDULZE+NwK04+/v/sO/6dmI7TRixVoY2LLK6S7E78FEgEW7kMtl127uCS+2ccwpeudFD4hF7ROTY/UkUrDQCvEw2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cd81ed-67f6-4a35-7406-08d779e469c8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 00:37:03.3241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIODkuSePIbo44Wf8xCjeqa0CfRHC1JR+bsgj6Gv8bD40fB12IY2jDtQmPRKBRjg7YRHFb91YSjsRy1msBvYKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashish Kalra <ashish.kalra@amd.com>

For SEV, all DMA to and from guest has to use shared
(un-encrypted) pages. SEV uses SWIOTLB to make this happen
without requiring changes to device drivers. However,
depending on workload being run, the default 64MB of SWIOTLB
might not be enough and SWIOTLB may run out of buffers to
use for DMA, resulting in I/O errors.

Increase the default size of SWIOTLB for SEV guests using
a minimum value of 128MB and a maximum value of 512MB,
determining on amount of provisioned guest memory.

The SWIOTLB default size adjustment is added as an
architecture specific interface/callback to allow
architectures such as those supporting memory encryption
to adjust/expand SWIOTLB size for their use.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/Kconfig           |  1 +
 arch/x86/mm/mem_encrypt.c  | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/dma-direct.h | 10 ++++++++++
 kernel/dma/Kconfig         |  3 +++
 kernel/dma/swiotlb.c       | 14 ++++++++++++--
 5 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d6e1faa28c58..c48bddf4b5b7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1533,6 +1533,7 @@ config AMD_MEM_ENCRYPT
 	select DYNAMIC_PHYSICAL_MASK
 	select ARCH_USE_MEMREMAP_PROT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
+	select ARCH_HAS_ADJUST_SWIOTLB_DEFAULT
 	---help---
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 9268c12458c8..12e586b37a92 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -376,6 +376,42 @@ bool force_dma_unencrypted(struct device *dev)
 	return false;
 }
 
+#define TOTAL_MEM_1G	0x40000000U
+#define TOTAL_MEM_4G	0x100000000U
+
+/*
+ * Override for SWIOTLB default size adjustment -
+ * ARCH_HAS_ADJUST_SWIOTLB_DEFAULT
+ */
+unsigned long adjust_swiotlb_default_size(unsigned long default_size)
+{
+	/*
+	 * For SEV, all DMA has to occur via shared/unencrypted pages.
+	 * SEV uses SWOTLB to make this happen without changing device
+	 * drivers. However, depending on the workload being run, the
+	 * default 64MB of SWIOTLB may not be enough & SWIOTLB may
+	 * run out of buffers for using DMA, resulting in I/O errors.
+	 * Increase the default size of SWIOTLB for SEV guests using
+	 * a minimum value of 128MB and a maximum value of 512GB,
+	 * depending on amount of provisioned guest memory.
+	 */
+	if (sev_active()) {
+		unsigned long total_mem = get_num_physpages() << PAGE_SHIFT;
+
+		if (total_mem <= TOTAL_MEM_1G)
+			default_size = default_size * 2;
+		else if (total_mem <= TOTAL_MEM_4G)
+			default_size = default_size * 4;
+		else
+			default_size = default_size * 8;
+
+		pr_info_once("SEV is active, SWIOTLB default size set to %luMB\n",
+			     default_size >> 20);
+	}
+
+	return default_size;
+}
+
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_free_decrypted_mem(void)
 {
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index adf993a3bd58..481943e08c94 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -41,6 +41,16 @@ static inline bool force_dma_unencrypted(struct device *dev)
 }
 #endif /* CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 
+#ifdef CONFIG_ARCH_HAS_ADJUST_SWIOTLB_DEFAULT
+unsigned long adjust_swiotlb_default_size(unsigned long default_size);
+#else
+static inline unsigned long adjust_swiotlb_default_size
+		(unsigned long default_size);
+{
+	return default_size;
+}
+#endif	/* CONFIG_ARCH_HAS_ADJUST_SWIOTLB_DEFAULT */
+
 /*
  * If memory encryption is supported, phys_to_dma will set the memory encryption
  * bit in the DMA address, and dma_to_phys will clear it.  The raw __phys_to_dma
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 73c5c2b8e824..9fd88f45f48f 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -57,6 +57,9 @@ config ARCH_HAS_DMA_COHERENT_TO_PFN
 config ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	bool
 
+config ARCH_HAS_ADJUST_SWIOTLB_DEFAULT
+	bool
+
 config DMA_NONCOHERENT_CACHE_SYNC
 	bool
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 673a2cdb2656..346838edf9e5 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -155,11 +155,21 @@ void swiotlb_set_max_segment(unsigned int val)
 #define IO_TLB_DEFAULT_SIZE (64UL<<20)
 unsigned long swiotlb_size_or_default(void)
 {
+	unsigned long default_size = IO_TLB_DEFAULT_SIZE;
 	unsigned long size;
 
+	/*
+	 * If swiotlb size/amount of slabs are not defined on kernel command
+	 * line, then give a chance to architectures to adjust swiotlb
+	 * size, this may be required by some architectures such as those
+	 * supporting memory encryption.
+	 */
+	if (!io_tlb_nslabs)
+		default_size = adjust_swiotlb_default_size(default_size);
+
 	size = io_tlb_nslabs << IO_TLB_SHIFT;
 
-	return size ? size : (IO_TLB_DEFAULT_SIZE);
+	return size ? size : default_size;
 }
 
 void swiotlb_print_info(void)
@@ -245,7 +255,7 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 void  __init
 swiotlb_init(int verbose)
 {
-	size_t default_size = IO_TLB_DEFAULT_SIZE;
+	unsigned long default_size = swiotlb_size_or_default();
 	unsigned char *vstart;
 	unsigned long bytes;
 
-- 
2.17.1

