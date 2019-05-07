Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D47C04AAE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DC720856
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfEGDmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 23:42:12 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7730 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727356AbfEGDmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 23:42:12 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5923ECCBB0A73C5F1D49;
        Tue,  7 May 2019 11:42:10 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 7 May 2019 11:42:02 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <akpm@linux-foundation.org>, <ard.biesheuvel@linaro.org>,
        <rppt@linux.ibm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <ebiederm@xmission.com>
CC:     <horms@verge.net.au>, <takahiro.akashi@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-mm@kvack.org>, <wangkefeng.wang@huawei.com>,
        Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH 2/4] arm64: kdump: support reserving crashkernel above 4G
Date:   Tue, 7 May 2019 11:50:56 +0800
Message-ID: <20190507035058.63992-3-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507035058.63992-1-chenzhou10@huawei.com>
References: <20190507035058.63992-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When crashkernel is reserved above 4G in memory, kernel should
reserve some amount of low memory for swiotlb and some DMA buffers.

Meanwhile, support crashkernel=X,[high,low] in arm64. When use
crashkernel=X parameter, try low memory first and fall back to high
memory unless "crashkernel=X,high" is specified.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/arm64/include/asm/kexec.h |  3 +++
 arch/arm64/kernel/setup.c      |  3 +++
 arch/arm64/mm/init.c           | 34 ++++++++++++++++++++++++++++------
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 67e4cb7..32949bf 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -28,6 +28,9 @@
 
 #define KEXEC_ARCH KEXEC_ARCH_AARCH64
 
+/* 2M alignment for crash kernel regions */
+#define CRASH_ALIGN	SZ_2M
+
 #ifndef __ASSEMBLY__
 
 /**
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 413d566..82cd9a0 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -243,6 +243,9 @@ static void __init request_standard_resources(void)
 			request_resource(res, &kernel_data);
 #ifdef CONFIG_KEXEC_CORE
 		/* Userspace will find "Crash kernel" region in /proc/iomem. */
+		if (crashk_low_res.end && crashk_low_res.start >= res->start &&
+		    crashk_low_res.end <= res->end)
+			request_resource(res, &crashk_low_res);
 		if (crashk_res.end && crashk_res.start >= res->start &&
 		    crashk_res.end <= res->end)
 			request_resource(res, &crashk_res);
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d2adffb..3fcd739 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -74,20 +74,37 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
 static void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_base, crash_size;
+	bool high = false;
 	int ret;
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base);
 	/* no crashkernel= or invalid value specified */
-	if (ret || !crash_size)
-		return;
+	if (ret || !crash_size) {
+		/* crashkernel=X,high */
+		ret = parse_crashkernel_high(boot_command_line,
+				memblock_phys_mem_size(),
+				&crash_size, &crash_base);
+		if (ret || !crash_size)
+			return;
+		high = true;
+	}
 
 	crash_size = PAGE_ALIGN(crash_size);
 
 	if (crash_base == 0) {
-		/* Current arm64 boot protocol requires 2MB alignment */
-		crash_base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
-				crash_size, SZ_2M);
+		/*
+		 * Try low memory first and fall back to high memory
+		 * unless "crashkernel=size[KMG],high" is specified.
+		 */
+		if (!high)
+			crash_base = memblock_find_in_range(0,
+					ARCH_LOW_ADDRESS_LIMIT,
+					crash_size, CRASH_ALIGN);
+		if (!crash_base)
+			crash_base = memblock_find_in_range(0,
+					memblock_end_of_DRAM(),
+					crash_size, CRASH_ALIGN);
 		if (crash_base == 0) {
 			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
 				crash_size);
@@ -105,13 +122,18 @@ static void __init reserve_crashkernel(void)
 			return;
 		}
 
-		if (!IS_ALIGNED(crash_base, SZ_2M)) {
+		if (!IS_ALIGNED(crash_base, CRASH_ALIGN)) {
 			pr_warn("cannot reserve crashkernel: base address is not 2MB aligned\n");
 			return;
 		}
 	}
 	memblock_reserve(crash_base, crash_size);
 
+	if (crash_base >= SZ_4G && reserve_crashkernel_low()) {
+		memblock_free(crash_base, crash_size);
+		return;
+	}
+
 	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
 		crash_base, crash_base + crash_size, crash_size >> 20);
 
-- 
2.7.4

