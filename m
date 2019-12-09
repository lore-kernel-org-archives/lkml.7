Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C536C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8532068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FfCcdABm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfLIXOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:14:02 -0500
Received: from mail-eopbgr680054.outbound.protection.outlook.com ([40.107.68.54]:55654
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbfLIXOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:14:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdiU1bHeVYXvVM8nubBRT/9xrXTixtDCkFu4BBopdxbIJTI8PBK1XWRTE3OtX7GMyWqqmJhIt5MebWWHQjXe5hFRnKXTXp1HXjkq8dohVAeViRWT+p73qQsEUASyrF3tvH2fnYqg9MYupm8N5n/X3Q2ePoF+yxyQarH5Jg8lLibqP4CfZ0iIQRYvOWqpWUupM7rjrp6gF8u8o81lruYp1TlrpJ1WrCAjqeant6i6HNNvVgnRZx6h3Q305ez4/lS93c8uRM2haiUjmsZaO8lu/027kfTVfFnWDF3yvsKjoXqf4dp+z+BlrX2VaH4ea61p6XCHxhapv1tU70r2WRLvww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K3RVfaN0TSFLA3fb3BthM/BR/coXB1vsOKAt17TWg8=;
 b=Qmy0Mkrb/NHFN9jlIUZ6dLjMIN3ckSYBJ5KwxdRlNNeMu6GpJ+t9Y6OSNDvMAT0nObDINM6tazMM81KYI8IYEh6oi+U6waXW2J28acgCUV0p8TMh0bpX3I51ElYiibweYky5s+rPbcQjcsJz+IFcF/nv4aXvLOW/ypy2YW7CPUB+uvGDrJaEjiaPWLBeanTcTF1sKmcR/P+WyrjBMpLhEqMxLg9lisqC6ekfWcwG+7YmcjYGkEPnD/6Dovevyf3NErWiWC1RHVK2hNsbF8ySQHIw0mESvpebZstrNTgz0W8nxQumC6Uafv3zP3EOIgZUsZNqRaAAo7rnSeH6hdD8lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K3RVfaN0TSFLA3fb3BthM/BR/coXB1vsOKAt17TWg8=;
 b=FfCcdABmj5TE27mUmsgXuynSAVgoKPTy/P5l+omZRGWLC+vATsZ+7X2JiLjQ0ujvlADiarkfVuzXckV0fYRCVCEfPC0BVzf8GcogRyJrW5ja0mMYODK8FYZEtBUFvnyEeWNtVAJBATqZK2GzDl1HbaTWTe7u05/RU9XVV/tSr9I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ashish.Kalra@amd.com; 
Received: from DM6PR12MB3610.namprd12.prod.outlook.com (20.178.198.149) by
 DM6PR12MB3657.namprd12.prod.outlook.com (10.255.76.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Mon, 9 Dec 2019 23:13:57 +0000
Received: from DM6PR12MB3610.namprd12.prod.outlook.com
 ([fe80::f83a:1a61:e61c:16d]) by DM6PR12MB3610.namprd12.prod.outlook.com
 ([fe80::f83a:1a61:e61c:16d%4]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 23:13:57 +0000
From:   Ashish Kalra <Ashish.Kalra@amd.com>
To:     hch@lst.de, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        peterz@infradead.org, dave.hansen@linux-intel.com,
        konrad.wilk@oracle.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, brijesh.singh@amd.com,
        Thomas.Lendacky@amd.com
Subject: [PATCH v2] swiotlb: Adjust SWIOTBL bounce buffer size for SEV guests.
Date:   Mon,  9 Dec 2019 23:13:46 +0000
Message-Id: <20191209231346.5602-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0025.namprd21.prod.outlook.com
 (2603:10b6:805:106::35) To DM6PR12MB3610.namprd12.prod.outlook.com
 (2603:10b6:5:3a::21)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8358388-e86d-4140-d8d9-08d77cfd778b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:|DM6PR12MB3657:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB36570E0930E8A281175747518E580@DM6PR12MB3657.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02462830BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(199004)(189003)(81156014)(305945005)(186003)(26005)(6636002)(81166006)(8676002)(7416002)(1076003)(66946007)(2906002)(66556008)(8936002)(66476007)(5660300002)(6506007)(316002)(2616005)(6666004)(86362001)(52116002)(36756003)(478600001)(6512007)(6486002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3657;H:DM6PR12MB3610.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDUaKOw6wZroVC7xzqoTHhm/BBg43EPUfJ4HiTZy/1gSjxAQ4DMFusTqW8fiqLlSNd5q1DKi9gIrfpmlh8+zwZrlkOWVFDNDp+obkais+wzhb8z6/TTeOJLTvk5EClWgS9yZG9zHYJmNZhtdbGkKvJd1SnabTP+InkkNpSl5an88lWzpiqC+idheUgDJYdWEB7pmvyUKuO3I1GnjbijObGHavHcvdDoc2QMtShOicXujrjcfa1yLoiLIlrrYd2TeGApQflHNmyr8rV7XcSbPExF4qnHlsoa8hkjTvBEiGwyaNO++DpRJFR2qgjjgHjcC5LP1Ciue+cBQM3KNCTdM1Ix4tKIpFOS6de5mlZo0jrUY11XKZZCrSlaP6MCOo4rjUklMp7quNBqma1cxhpGbiz7KwRKNlOzFnSPTXaUm8nB+/hKobUlizia4VSMW07AqIayffH/TifmSuZVqbAN62XqYts42+GHdIfn8P6xQBmUTLFCuZdn4oJVgc4yu6uK+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8358388-e86d-4140-d8d9-08d77cfd778b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2019 23:13:57.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QsEPuLf+vLJc9Ee5AcD9xVEEua1nhQa74AfK/HJlYpIyKP3Luf38p2Jevzk614Kcr9380YKXb+s+CZ88xVdk7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3657
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
Changes in v2:
 - Fix compile errors as
Reported-by: kbuild test robot <lkp@intel.com>

 arch/x86/Kconfig           |  1 +
 arch/x86/mm/mem_encrypt.c  | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/dma-direct.h | 10 ++++++++++
 kernel/dma/Kconfig         |  3 +++
 kernel/dma/swiotlb.c       | 14 ++++++++++++--
 5 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5e8949953660..e75622e58d34 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1522,6 +1522,7 @@ config AMD_MEM_ENCRYPT
 	select DYNAMIC_PHYSICAL_MASK
 	select ARCH_USE_MEMREMAP_PROT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
+	select ARCH_HAS_ADJUST_SWIOTLB_DEFAULT
 	---help---
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index a03614bd3e1a..f4bd4b431ba1 100644
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
index 24b8684aa21d..85507d21493f 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -35,6 +35,16 @@ static inline bool force_dma_unencrypted(struct device *dev)
 }
 #endif /* CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 
+#ifdef CONFIG_ARCH_HAS_ADJUST_SWIOTLB_DEFAULT
+unsigned long adjust_swiotlb_default_size(unsigned long default_size);
+#else
+static inline unsigned long adjust_swiotlb_default_size
+		(unsigned long default_size)
+{
+	return default_size;
+}
+#endif	/* CONFIG_ARCH_HAS_ADJUST_SWIOTLB_DEFAULT */
+
 /*
  * If memory encryption is supported, phys_to_dma will set the memory encryption
  * bit in the DMA address, and dma_to_phys will clear it.  The raw __phys_to_dma
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 4c103a24e380..851c4500ff88 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -54,6 +54,9 @@ config ARCH_HAS_DMA_PREP_COHERENT
 config ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	bool
 
+config ARCH_HAS_ADJUST_SWIOTLB_DEFAULT
+	bool
+
 config DMA_NONCOHERENT_CACHE_SYNC
 	bool
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9280d6f8271e..7dd72bd88f1c 100644
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

