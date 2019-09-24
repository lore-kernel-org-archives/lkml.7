Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C92C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECD2214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569323938;
	bh=tFkdaGeZtd91YFNsc/Pa5qegXdqG8lH//NYPnIEFC0E=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=YUx8ZZoPyKKy0crb3YP4Sodm0kKLHz5jmW5/XNmKEDHmwLDErU2NiHv0oax+QhK8s
	 U+Ec5a3lG7hoyrVc5E0V/UdYCj5FpScB/XSDTajfxpHMCv5tWR/ufPWM22BYu5n3rZ
	 Z23eMH3BmMpu2b5kFJQUk4IfS6QBa7kvMiigkwBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504641AbfIXLS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504627AbfIXLS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:18:56 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBA3A20872;
        Tue, 24 Sep 2019 11:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569323936;
        bh=tFkdaGeZtd91YFNsc/Pa5qegXdqG8lH//NYPnIEFC0E=;
        h=From:To:Cc:Subject:Date:From;
        b=JYJhhKII+1lGyJPnOcRgDW0y3p7vpBNb6VukZh4HmqfEZv59sbB4CQRgeEcnVMP9I
         Bo6SwQy6R603X31CvMg/QZo1oDPMOKhAi6jAGVVX77srXHsEVIeitfRvXmQWz7MlG0
         wCAudZ2K8f4Y7Na0+qyumGF3G2NvnpjwSZUuHfME=
From:   Mike Rapoport <rppt@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2] arm64: use generic free_initrd_mem()
Date:   Tue, 24 Sep 2019 14:18:48 +0300
Message-Id: <1569323928-10154-1-git-send-email-rppt@kernel.org>
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

v2 changes:
* add memblock_free() to the generic free_initrd_mem()
* rebase on the current upstream

 arch/arm64/mm/init.c | 12 ------------
 init/initramfs.c     |  4 ++++
 2 files changed, 4 insertions(+), 12 deletions(-)

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
index c47dad0..403c6a0 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -531,6 +531,10 @@ void __weak free_initrd_mem(unsigned long start, unsigned long end)
 {
 	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
 			"initrd");
+
+#ifdef CONFIG_ARCH_KEEP_MEMBLOCK
+	memblock_free(__virt_to_phys(start), end - start);
+#endif
 }
 
 #ifdef CONFIG_KEXEC_CORE
-- 
2.7.4

