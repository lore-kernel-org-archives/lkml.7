Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3939C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCA42177B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 18:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfDVS6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 14:58:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:60350 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728742AbfDVS6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 14:58:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 11:58:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,382,1549958400"; 
   d="scan'208";a="136417158"
Received: from linksys13920.jf.intel.com (HELO rpedgeco-DESK5.jf.intel.com) ([10.54.75.11])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2019 11:58:42 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v4 14/23] x86/mm/cpa: Add set_direct_map_ functions
Date:   Mon, 22 Apr 2019 11:57:56 -0700
Message-Id: <20190422185805.1169-15-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190422185805.1169-1-rick.p.edgecombe@intel.com>
References: <20190422185805.1169-1-rick.p.edgecombe@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two new functions set_direct_map_default_noflush() and
set_direct_map_invalid_noflush() for setting the direct map alias for the
page to its default valid permissions and to an invalid state that cannot
be cached in a TLB, respectively. These functions do not flush the TLB.

Note, __kernel_map_pages() does something similar but flushes the TLB and
doesn't reset the permission bits to default on all architectures.

Also add an ARCH config ARCH_HAS_SET_DIRECT_MAP for specifying whether
these have an actual implementation or a default empty one.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/Kconfig                      |  4 ++++
 arch/x86/Kconfig                  |  1 +
 arch/x86/include/asm/set_memory.h |  3 +++
 arch/x86/mm/pageattr.c            | 14 +++++++++++---
 include/linux/set_memory.h        | 11 +++++++++++
 5 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 3ab446bd12ef..5e43fcbad4ca 100644
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
index 2ec5e850b807..45d788354376 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -66,6 +66,7 @@ config X86
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
-- 
2.17.1

