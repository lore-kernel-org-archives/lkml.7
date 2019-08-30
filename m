Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A720C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A95E22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfH3HJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:09:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6141 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbfH3HJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:09:02 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1F047236FDFC497CB1F2;
        Fri, 30 Aug 2019 15:08:56 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 30 Aug 2019 15:08:49 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <dyoung@redhat.com>, <bhsharma@redhat.com>
CC:     <horms@verge.net.au>, <guohanjun@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v6 1/4] x86: kdump: move reserve_crashkernel_low() into crash_core.c
Date:   Fri, 30 Aug 2019 15:11:57 +0800
Message-ID: <20190830071200.56169-2-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190830071200.56169-1-chenzhou10@huawei.com>
References: <20190830071200.56169-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting reserve_crashkernel_low in arm64 as
x86_64 does, move reserve_crashkernel_low() into kernel/crash_core.c.

Note, in arm64, we reserve low memory if and only if crashkernel=X,low
is specified. Different with x86_64, don't set low memory automatically.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/x86/include/asm/kexec.h |  3 ++
 arch/x86/kernel/setup.c      | 65 ++++----------------------------------------
 include/linux/crash_core.h   |  4 +++
 include/linux/kexec.h        |  1 -
 kernel/crash_core.c          | 65 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 78 insertions(+), 60 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 5e7d6b4..bf21d6c 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -18,6 +18,9 @@
 
 # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
 
+/* 16M alignment for crash kernel regions */
+#define CRASH_ALIGN		SZ_16M
+
 #ifndef __ASSEMBLY__
 
 #include <linux/string.h>
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index bbe35bf..2b437c4 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -449,9 +449,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 
 #ifdef CONFIG_KEXEC_CORE
 
-/* 16M alignment for crash kernel regions */
-#define CRASH_ALIGN		SZ_16M
-
 /*
  * Keep the crash kernel below this limit.
  *
@@ -473,59 +470,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 # define CRASH_ADDR_HIGH_MAX	SZ_64T
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
@@ -589,9 +533,12 @@ static void __init reserve_crashkernel(void)
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
+		insert_resource(&iomem_resource, &crashk_low_res);
 	}
 
 	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 525510a..9192e43 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -6,6 +6,8 @@
 #include <linux/elfcore.h>
 #include <linux/elf.h>
 
+#include <asm/kexec.h>
+
 #define CRASH_CORE_NOTE_NAME	   "CORE"
 #define CRASH_CORE_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
 #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(CRASH_CORE_NOTE_NAME), 4)
@@ -63,6 +65,7 @@ phys_addr_t paddr_vmcoreinfo_note(void);
 extern unsigned char *vmcoreinfo_data;
 extern size_t vmcoreinfo_size;
 extern u32 *vmcoreinfo_note;
+extern struct resource crashk_low_res;
 
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len);
@@ -74,5 +77,6 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
+int __init reserve_crashkernel_low(void);
 
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index b9b1bc5..62330aa 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -306,7 +306,6 @@ extern int kexec_load_disabled;
 /* Location of a reserved region to hold the crash kernel.
  */
 extern struct resource crashk_res;
-extern struct resource crashk_low_res;
 extern note_buf_t __percpu *crash_notes;
 
 /* flag to track if kexec reboot is in progress */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 9f1557b..13cdf35 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -7,6 +7,8 @@
 #include <linux/crash_core.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/memblock.h>
+#include <linux/swiotlb.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -292,6 +294,69 @@ int __init parse_crashkernel_low(char *cmdline,
 				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
 }
 
+int __init reserve_crashkernel_low(void)
+{
+#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
+	unsigned long long base, low_base = 0, low_size = 0;
+	unsigned long total_low_mem;
+	int ret;
+
+	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
+
+	/* crashkernel=Y,low */
+	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size,
+			&base);
+	if (ret) {
+#ifdef CONFIG_X86_64
+		/*
+		 * two parts from lib/swiotlb.c:
+		 * -swiotlb size: user-specified with swiotlb= or default.
+		 *
+		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
+		 * to 8M for other buffers that may need to stay low too. Also
+		 * make sure we allocate enough extra low memory so that we
+		 * don't run out of DMA buffers for 32-bit devices.
+		 */
+		low_size = max(swiotlb_size_or_default() + (8UL << 20),
+				256UL << 20);
+#else
+		/*
+		 * in arm64, reserve low memory if and only if crashkernel=X,low
+		 * specified.
+		 */
+		return -EINVAL;
+#endif
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
+		pr_err("%s: Error reserving crashkernel low memblock.\n",
+				__func__);
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
+#endif
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
-- 
2.7.4

