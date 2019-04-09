Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B18C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11C42084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfDIKRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:17:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41790 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726461AbfDIKRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:17:33 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4E19590136526AEF6836;
        Tue,  9 Apr 2019 18:17:31 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Tue, 9 Apr 2019 18:17:22 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <ebiederm@xmission.com>, <rppt@linux.ibm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <akpm@linux-foundation.org>, <ard.biesheuvel@linaro.org>
CC:     <horms@verge.net.au>, <takahiro.akashi@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-mm@kvack.org>, <wangkefeng.wang@huawei.com>,
        Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v3 1/4] x86: kdump: move reserve_crashkernel_low() into kexec_core.c
Date:   Tue, 9 Apr 2019 18:28:16 +0800
Message-ID: <20190409102819.121335-2-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409102819.121335-1-chenzhou10@huawei.com>
References: <20190409102819.121335-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting more than one crash kernel regions
in arm64 as x86_64 does, move reserve_crashkernel_low() into
kexec/kexec_core.c.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/x86/include/asm/kexec.h |  3 ++
 arch/x86/kernel/setup.c      | 66 +++++---------------------------------------
 include/linux/kexec.h        |  1 +
 kernel/kexec_core.c          | 53 +++++++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 59 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 003f2da..485a514 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -18,6 +18,9 @@
 
 # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
 
+/* 16M alignment for crash kernel regions */
+#define CRASH_ALIGN		(16 << 20)
+
 #ifndef __ASSEMBLY__
 
 #include <linux/string.h>
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3773905..4182035 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -447,9 +447,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 
 #ifdef CONFIG_KEXEC_CORE
 
-/* 16M alignment for crash kernel regions */
-#define CRASH_ALIGN		(16 << 20)
-
 /*
  * Keep the crash kernel below this limit.  On 32 bits earlier kernels
  * would limit the kernel to the low 512 MiB due to mapping restrictions.
@@ -463,59 +460,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 # define CRASH_ADDR_HIGH_MAX	MAXMEM
 #endif
 
-static int __init reserve_crashkernel_low(void)
-{
-#ifdef CONFIG_X86_64
-	unsigned long long base, low_base = 0, low_size = 0;
-	unsigned long total_low_mem;
-	int ret;
-
-	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
-
-	/* crashkernel=Y,low */
-	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size, &base);
-	if (ret) {
-		/*
-		 * two parts from lib/swiotlb.c:
-		 * -swiotlb size: user-specified with swiotlb= or default.
-		 *
-		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
-		 * to 8M for other buffers that may need to stay low too. Also
-		 * make sure we allocate enough extra low memory so that we
-		 * don't run out of DMA buffers for 32-bit devices.
-		 */
-		low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
-	} else {
-		/* passed with crashkernel=0,low ? */
-		if (!low_size)
-			return 0;
-	}
-
-	low_base = memblock_find_in_range(0, 1ULL << 32, low_size, CRASH_ALIGN);
-	if (!low_base) {
-		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
-		       (unsigned long)(low_size >> 20));
-		return -ENOMEM;
-	}
-
-	ret = memblock_reserve(low_base, low_size);
-	if (ret) {
-		pr_err("%s: Error reserving crashkernel low memblock.\n", __func__);
-		return ret;
-	}
-
-	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (System low RAM: %ldMB)\n",
-		(unsigned long)(low_size >> 20),
-		(unsigned long)(low_base >> 20),
-		(unsigned long)(total_low_mem >> 20));
-
-	crashk_low_res.start = low_base;
-	crashk_low_res.end   = low_base + low_size - 1;
-	insert_resource(&iomem_resource, &crashk_low_res);
-#endif
-	return 0;
-}
-
 static void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_size, crash_base, total_mem;
@@ -573,9 +517,13 @@ static void __init reserve_crashkernel(void)
 		return;
 	}
 
-	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
-		memblock_free(crash_base, crash_size);
-		return;
+	if (crash_base >= (1ULL << 32)) {
+		if (reserve_crashkernel_low()) {
+			memblock_free(crash_base, crash_size);
+			return;
+		}
+
+		insert_resource(&iomem_resource, &crashk_low_res);
 	}
 
 	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index b9b1bc5..6140cf8 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -281,6 +281,7 @@ extern void __crash_kexec(struct pt_regs *);
 extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
 int kexec_crash_loaded(void);
+int __init reserve_crashkernel_low(void);
 void crash_save_cpu(struct pt_regs *regs, int cpu);
 extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index d714044..f8e8f80 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -39,6 +39,8 @@
 #include <linux/compiler.h>
 #include <linux/hugetlb.h>
 #include <linux/frame.h>
+#include <linux/memblock.h>
+#include <linux/swiotlb.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -96,6 +98,57 @@ int kexec_crash_loaded(void)
 }
 EXPORT_SYMBOL_GPL(kexec_crash_loaded);
 
+int __init reserve_crashkernel_low(void)
+{
+	unsigned long long base, low_base = 0, low_size = 0;
+	unsigned long total_low_mem;
+	int ret;
+
+	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
+
+	/* crashkernel=Y,low */
+	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size, &base);
+	if (ret) {
+		/*
+		 * two parts from lib/swiotlb.c:
+		 * -swiotlb size: user-specified with swiotlb= or default.
+		 *
+		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
+		 * to 8M for other buffers that may need to stay low too. Also
+		 * make sure we allocate enough extra low memory so that we
+		 * don't run out of DMA buffers for 32-bit devices.
+		 */
+		low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
+	} else {
+		/* passed with crashkernel=0,low ? */
+		if (!low_size)
+			return 0;
+	}
+
+	low_base = memblock_find_in_range(0, 1ULL << 32, low_size, CRASH_ALIGN);
+	if (!low_base) {
+		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
+		       (unsigned long)(low_size >> 20));
+		return -ENOMEM;
+	}
+
+	ret = memblock_reserve(low_base, low_size);
+	if (ret) {
+		pr_err("%s: Error reserving crashkernel low memblock.\n", __func__);
+		return ret;
+	}
+
+	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (System low RAM: %ldMB)\n",
+		(unsigned long)(low_size >> 20),
+		(unsigned long)(low_base >> 20),
+		(unsigned long)(total_low_mem >> 20));
+
+	crashk_low_res.start = low_base;
+	crashk_low_res.end   = low_base + low_size - 1;
+
+	return 0;
+}
+
 /*
  * When kexec transitions to the new kernel there is a one-to-one
  * mapping between physical and virtual addresses.  On processors
-- 
2.7.4

