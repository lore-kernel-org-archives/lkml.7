Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15094C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E418C22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfH3HJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:09:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39958 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727963AbfH3HJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:09:02 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2998F6AC2362E99A6B72;
        Fri, 30 Aug 2019 15:09:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 30 Aug 2019 15:08:51 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <dyoung@redhat.com>, <bhsharma@redhat.com>
CC:     <horms@verge.net.au>, <guohanjun@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v6 2/4] arm64: kdump: reserve crashkenel above 4G for crash dump kernel
Date:   Fri, 30 Aug 2019 15:11:58 +0800
Message-ID: <20190830071200.56169-3-chenzhou10@huawei.com>
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

Crashkernel=X tries to reserve memory for the crash dump kernel under
4G. If crashkernel=X,low is specified simultaneously, reserve spcified
size low memory for crash kdump kernel devices firstly and then reserve
memory above 4G.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/arm64/include/asm/kexec.h |  3 +++
 arch/arm64/kernel/setup.c      |  8 +++++++-
 arch/arm64/mm/init.c           | 31 +++++++++++++++++++++++++++++--
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 12a561a..88279a9 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -25,6 +25,9 @@
 
 #define KEXEC_ARCH KEXEC_ARCH_AARCH64
 
+/* 2M alignment for crash kernel regions */
+#define CRASH_ALIGN		SZ_2M
+
 #ifndef __ASSEMBLY__
 
 /**
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 9c4bad7..2ead608 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -231,7 +231,13 @@ static void __init request_standard_resources(void)
 		    kernel_data.end <= res->end)
 			request_resource(res, &kernel_data);
 #ifdef CONFIG_KEXEC_CORE
-		/* Userspace will find "Crash kernel" region in /proc/iomem. */
+		/*
+		 * Userspace will find "Crash kernel" region in /proc/iomem.
+		 * Note: the low region is renamed as Crash kernel (low).
+		 */
+		if (crashk_low_res.end && crashk_low_res.start >= res->start &&
+				crashk_low_res.end <= res->end)
+			request_resource(res, &crashk_low_res);
 		if (crashk_res.end && crashk_res.start >= res->start &&
 		    crashk_res.end <= res->end)
 			request_resource(res, &crashk_res);
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f3c7952..c99f845 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -64,6 +64,7 @@ static void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_base, crash_size;
 	int ret;
+	phys_addr_t crash_max = ARCH_LOW_ADDRESS_LIMIT;
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base);
@@ -71,12 +72,38 @@ static void __init reserve_crashkernel(void)
 	if (ret || !crash_size)
 		return;
 
+	ret = reserve_crashkernel_low();
+	if (!ret && crashk_low_res.end) {
+		/*
+		 * If crashkernel=X,low specified, there may be two regions,
+		 * we need to make some changes as follows:
+		 *
+		 * 1. rename the low region as "Crash kernel (low)"
+		 * In order to distinct from the high region and make no effect
+		 * to the use of existing kexec-tools, rename the low region as
+		 * "Crash kernel (low)".
+		 *
+		 * 2. change the upper bound for crash memory
+		 * Set MEMBLOCK_ALLOC_ACCESSIBLE upper bound for crash memory.
+		 *
+		 * 3. mark the low region as "nomap"
+		 * The low region is intended to be used for crash dump kernel
+		 * devices, just mark the low region as "nomap" simply.
+		 */
+		const char *rename = "Crash kernel (low)";
+
+		crashk_low_res.name = rename;
+		crash_max = MEMBLOCK_ALLOC_ACCESSIBLE;
+		memblock_mark_nomap(crashk_low_res.start,
+				    resource_size(&crashk_low_res));
+	}
+
 	crash_size = PAGE_ALIGN(crash_size);
 
 	if (crash_base == 0) {
 		/* Current arm64 boot protocol requires 2MB alignment */
-		crash_base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
-				crash_size, SZ_2M);
+		crash_base = memblock_find_in_range(0, crash_max, crash_size,
+				SZ_2M);
 		if (crash_base == 0) {
 			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
 				crash_size);
-- 
2.7.4

