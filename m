Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D98C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F2F217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfICIcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:32:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59246 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbfICIcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:32:07 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i54EK-0002q6-In; Tue, 03 Sep 2019 10:32:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1948A1C0772;
        Tue,  3 Sep 2019 10:32:00 +0200 (CEST)
Date:   Tue, 03 Sep 2019 08:31:59 -0000
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Remove set_pages_x() and set_pages_nx()
Cc:     Christoph Hellwig <hch@lst.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190826075558.8125-4-hch@lst.de>
References: <20190826075558.8125-4-hch@lst.de>
MIME-Version: 1.0
Message-ID: <156749951990.13285.2642052726812267592.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     185be15143aa308184310df9fde3d409ca9f83bb
Gitweb:        https://git.kernel.org/tip/185be15143aa308184310df9fde3d409ca9f83bb
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Mon, 26 Aug 2019 09:55:56 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Sep 2019 09:26:37 +02:00

x86/mm: Remove set_pages_x() and set_pages_nx()

These wrappers don't provide a real benefit over just using
set_memory_x() and set_memory_nx().

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190826075558.8125-4-hch@lst.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/set_memory.h  |  2 --
 arch/x86/kernel/machine_kexec_32.c |  4 ++--
 arch/x86/mm/init_32.c              |  2 +-
 arch/x86/mm/pageattr.c             | 16 ----------------
 4 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 899ec9a..fd549c3 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -75,8 +75,6 @@ int set_pages_array_wb(struct page **pages, int addrinarray);
 
 int set_pages_uc(struct page *page, int numpages);
 int set_pages_wb(struct page *page, int numpages);
-int set_pages_x(struct page *page, int numpages);
-int set_pages_nx(struct page *page, int numpages);
 int set_pages_ro(struct page *page, int numpages);
 int set_pages_rw(struct page *page, int numpages);
 
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 77854b1..7b45e8d 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -148,7 +148,7 @@ int machine_kexec_prepare(struct kimage *image)
 {
 	int error;
 
-	set_pages_x(image->control_code_page, 1);
+	set_memory_x((unsigned long)page_address(image->control_code_page), 1);
 	error = machine_kexec_alloc_page_tables(image);
 	if (error)
 		return error;
@@ -162,7 +162,7 @@ int machine_kexec_prepare(struct kimage *image)
  */
 void machine_kexec_cleanup(struct kimage *image)
 {
-	set_pages_nx(image->control_code_page, 1);
+	set_memory_nx((unsigned long)page_address(image->control_code_page), 1);
 	machine_kexec_free_page_tables(image);
 }
 
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 4068abb..930edeb 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -916,7 +916,7 @@ static void mark_nxdata_nx(void)
 
 	if (__supported_pte_mask & _PAGE_NX)
 		printk(KERN_INFO "NX-protecting the kernel data: %luk\n", size >> 10);
-	set_pages_nx(virt_to_page(start), size >> PAGE_SHIFT);
+	set_memory_nx(start, size >> PAGE_SHIFT);
 }
 
 void mark_rodata_ro(void)
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 1f97a72..d5586a0 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -2113,22 +2113,6 @@ int set_pages_array_wb(struct page **pages, int numpages)
 }
 EXPORT_SYMBOL(set_pages_array_wb);
 
-int set_pages_x(struct page *page, int numpages)
-{
-	unsigned long addr = (unsigned long)page_address(page);
-
-	return set_memory_x(addr, numpages);
-}
-EXPORT_SYMBOL(set_pages_x);
-
-int set_pages_nx(struct page *page, int numpages)
-{
-	unsigned long addr = (unsigned long)page_address(page);
-
-	return set_memory_nx(addr, numpages);
-}
-EXPORT_SYMBOL(set_pages_nx);
-
 int set_pages_ro(struct page *page, int numpages)
 {
 	unsigned long addr = (unsigned long)page_address(page);
