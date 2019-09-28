Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F88C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 08:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B6B2082F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 08:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569657755;
	bh=7r4x/xOBVKIryWPeO1cbNSCirEK4o0T+ejZK1ZnMUG8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=JrV1R/p8e2iBbkk0t2bQwCa9GYz8jIaYGJu00LL4Bf5hvPjTthmTcATrDcQhtscrg
	 94AubxE5PXzMNtjEDazHgaC/WNywogcUG7fRED/5j4YrO2oNdyUkrZHO4/xh393h98
	 ey5OYorRjLB8cT8sKhcdQema0brhDP6FIai53F6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfI1ICe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 04:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfI1ICe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 04:02:34 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47C502075C;
        Sat, 28 Sep 2019 08:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569657753;
        bh=7r4x/xOBVKIryWPeO1cbNSCirEK4o0T+ejZK1ZnMUG8=;
        h=From:To:Cc:Subject:Date:From;
        b=n0p1q46eN85Ic/K8oKeWP3PROrk6h3rnwGiUuKFyROku4hqcdrjA/CMfDbkS24Yxu
         HNDfkbahjcs73EZuzcblH9xf7qgDoIGj20gsu7eHiJmKhGbdPtuT8n1BLQ4+FAWfRs
         ypYn2MG9AOXzt/PWtIo+PPNIyscPjQgUK1HW52uI=
From:   Mike Rapoport <rppt@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v4] arm64: use generic free_initrd_mem()
Date:   Sat, 28 Sep 2019 11:02:26 +0300
Message-Id: <1569657746-31672-1-git-send-email-rppt@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

arm64 calls memblock_free() for the initrd area in its implementation of
free_initrd_mem(), but this call has no actual effect that late in the boot
process. By the time initrd is freed, all the reserved memory is managed by
the page allocator and the memblock.reserved is unused, so the only purpose
of the memblock_free() call is to keep track of initrd memory for debugging
and accounting.

Without the memblock_free() call the only difference between arm64 and the
generic versions of free_initrd_mem() is the memory poisoning.

Move memblock_free() call to the generic code, enable it there
for the architectures that define ARCH_KEEP_MEMBLOCK and use the generic
implementation of free_initrd_mem() on arm64.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---

v4:
* memblock_free() aligned area around the initrd

v3:
* fix powerpc build

v2:
* add memblock_free() to the generic free_initrd_mem()
* rebase on the current upstream


 arch/arm64/mm/init.c | 12 ------------
 init/initramfs.c     |  8 ++++++++
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 45c00a5..87a0e3b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -580,18 +580,6 @@ void free_initmem(void)
 	unmap_kernel_range((u64)__init_begin, (u64)(__init_end - __init_begin));
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	unsigned long aligned_start, aligned_end;
-
-	aligned_start = __virt_to_phys(start) & PAGE_MASK;
-	aligned_end = PAGE_ALIGN(__virt_to_phys(end));
-	memblock_free(aligned_start, aligned_end - aligned_start);
-	free_reserved_area((void *)start, (void *)end, 0, "initrd");
-}
-#endif
-
 /*
  * Dump out memory limit information on panic.
  */
diff --git a/init/initramfs.c b/init/initramfs.c
index c47dad0..8ec1be4 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -10,6 +10,7 @@
 #include <linux/syscalls.h>
 #include <linux/utime.h>
 #include <linux/file.h>
+#include <linux/memblock.h>
 
 static ssize_t __init xwrite(int fd, const char *p, size_t count)
 {
@@ -529,6 +530,13 @@ extern unsigned long __initramfs_size;
 
 void __weak free_initrd_mem(unsigned long start, unsigned long end)
 {
+#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
+	unsigned long aligned_start = ALIGN_DOWN(start, PAGE_SIZE);
+	unsigned long aligned_end = ALIGN(end, PAGE_SIZE);
+
+	memblock_free(__pa(aligned_start), aligned_end - aligned_start);
+#endif
+
 	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
 			"initrd");
 }
-- 
2.7.4

