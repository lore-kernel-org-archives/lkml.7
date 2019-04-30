Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0085C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8532E20675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XcStXd6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfD3L03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:26:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48259 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfD3L02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:26:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3UBOr6F1349846
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Apr 2019 04:24:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3UBOr6F1349846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556623494;
        bh=SKqyjkKkUDLjBS9G3beqEjgVckXlIO1PsPx1XhNUISI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=XcStXd6M/gWcgu2M+2Hq1tGTsdkj3k50DGBx5L+bkCmoCfccwMicjrxS2lAAOWw2e
         2N6wJfiJu6iT15y91ZX4h9AcaRNdjAtPROZoSuAlykKJNfvKhIElr4mQOCXGcEdumv
         C1cXiGCYStc9Z+wEKqNu2Xn+YhTxNXgaWPW7wJP8leI0++ncXRKtEOE3p4OB6ruLqw
         2vaXjg0tP8W8Fxbc7D2YzPzJeztUF4IdBuVgaz6AIEXi2YsnSaXi8UzC+hCpn6ag/G
         9suXH+HA1xFOi7upLXLgduSz5nNYgX4Scy0gWksHBcf0tywYnS4mJ9fqnYJQxzHxJQ
         qZz0HCnYkBhOQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3UBOq4P1349843;
        Tue, 30 Apr 2019 04:24:52 -0700
Date:   Tue, 30 Apr 2019 04:24:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rick Edgecombe <tipbot@zytor.com>
Message-ID: <tip-d253ca0c3865a8d9a8c01143cf20425e0be4d0ce@git.kernel.org>
Cc:     riel@surriel.com, will.deacon@arm.com, luto@kernel.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        dave.hansen@linux.intel.com, mingo@kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        peterz@infradead.org, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        rick.p.edgecombe@intel.com, kernel-hardening@lists.openwall.com,
        linux_dti@icloud.com, bp@alien8.de, nadav.amit@gmail.com,
        hpa@zytor.com
Reply-To: peterz@infradead.org, torvalds@linux-foundation.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          ard.biesheuvel@linaro.org, akpm@linux-foundation.org,
          rick.p.edgecombe@intel.com, kernel-hardening@lists.openwall.com,
          hpa@zytor.com, nadav.amit@gmail.com, linux_dti@icloud.com,
          bp@alien8.de, will.deacon@arm.com, riel@surriel.com,
          kristen@linux.intel.com, deneen.t.dock@intel.com,
          luto@kernel.org, mingo@kernel.org, dave.hansen@linux.intel.com
In-Reply-To: <20190426001143.4983-15-namit@vmware.com>
References: <20190426001143.4983-15-namit@vmware.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/cpa: Add set_direct_map_*() functions
Git-Commit-ID: d253ca0c3865a8d9a8c01143cf20425e0be4d0ce
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d253ca0c3865a8d9a8c01143cf20425e0be4d0ce
Gitweb:     https://git.kernel.org/tip/d253ca0c3865a8d9a8c01143cf20425e0be4d0ce
Author:     Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate: Thu, 25 Apr 2019 17:11:34 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Apr 2019 12:37:56 +0200

x86/mm/cpa: Add set_direct_map_*() functions

Add two new functions set_direct_map_default_noflush() and
set_direct_map_invalid_noflush() for setting the direct map alias for the
page to its default valid permissions and to an invalid state that cannot
be cached in a TLB, respectively. These functions do not flush the TLB.

Note, __kernel_map_pages() does something similar but flushes the TLB and
doesn't reset the permission bits to default on all architectures.

Also add an ARCH config ARCH_HAS_SET_DIRECT_MAP for specifying whether
these have an actual implementation or a default empty one.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <akpm@linux-foundation.org>
Cc: <ard.biesheuvel@linaro.org>
Cc: <deneen.t.dock@intel.com>
Cc: <kernel-hardening@lists.openwall.com>
Cc: <kristen@linux.intel.com>
Cc: <linux_dti@icloud.com>
Cc: <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190426001143.4983-15-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/Kconfig                      |  4 ++++
 arch/x86/Kconfig                  |  1 +
 arch/x86/include/asm/set_memory.h |  3 +++
 arch/x86/mm/pageattr.c            | 14 +++++++++++---
 include/linux/set_memory.h        | 11 +++++++++++
 5 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 33687dddd86a..88e5a92a9e58 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -249,6 +249,10 @@ config ARCH_HAS_FORTIFY_SOURCE
 config ARCH_HAS_SET_MEMORY
 	bool
 
+# Select if arch has all set_direct_map_invalid/default() functions
+config ARCH_HAS_SET_DIRECT_MAP
+	bool
+
 # Select if arch init_task must go in the __init_task_data section
 config ARCH_TASK_STRUCT_ON_STACK
        bool
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bd6f93ce0633..cee3f22ce8d1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -65,6 +65,7 @@ config X86
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
 	select ARCH_HAS_UACCESS_MCSAFE		if X86_64 && X86_MCE
 	select ARCH_HAS_SET_MEMORY
+	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 07a25753e85c..ae7b909dc242 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -85,6 +85,9 @@ int set_pages_nx(struct page *page, int numpages);
 int set_pages_ro(struct page *page, int numpages);
 int set_pages_rw(struct page *page, int numpages);
 
+int set_direct_map_invalid_noflush(struct page *page);
+int set_direct_map_default_noflush(struct page *page);
+
 extern int kernel_set_to_readonly;
 void set_kernel_text_rw(void);
 void set_kernel_text_ro(void);
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 4c570612e24e..3574550192c6 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -2209,8 +2209,6 @@ int set_pages_rw(struct page *page, int numpages)
 	return set_memory_rw(addr, numpages);
 }
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
-
 static int __set_pages_p(struct page *page, int numpages)
 {
 	unsigned long tempaddr = (unsigned long) page_address(page);
@@ -2249,6 +2247,17 @@ static int __set_pages_np(struct page *page, int numpages)
 	return __change_page_attr_set_clr(&cpa, 0);
 }
 
+int set_direct_map_invalid_noflush(struct page *page)
+{
+	return __set_pages_np(page, 1);
+}
+
+int set_direct_map_default_noflush(struct page *page)
+{
+	return __set_pages_p(page, 1);
+}
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
 	if (PageHighMem(page))
@@ -2282,7 +2291,6 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 }
 
 #ifdef CONFIG_HIBERNATION
-
 bool kernel_page_present(struct page *page)
 {
 	unsigned int level;
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 2a986d282a97..b5071497b8cb 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -17,6 +17,17 @@ static inline int set_memory_x(unsigned long addr,  int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
+#ifndef CONFIG_ARCH_HAS_SET_DIRECT_MAP
+static inline int set_direct_map_invalid_noflush(struct page *page)
+{
+	return 0;
+}
+static inline int set_direct_map_default_noflush(struct page *page)
+{
+	return 0;
+}
+#endif
+
 #ifndef set_mce_nospec
 static inline int set_mce_nospec(unsigned long pfn)
 {
