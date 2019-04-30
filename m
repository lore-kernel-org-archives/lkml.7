Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EA7C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E75F20835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="m2XXsiHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfD3LSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:18:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50349 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfD3LSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:18:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3UBI0nW1346868
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Apr 2019 04:18:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3UBI0nW1346868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556623080;
        bh=iVUAx2Bubh49DKX266pi1uDMbz1jQDL6ubH1m7QOUEw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=m2XXsiHUbHw6knN55s4hDiFeIZJ6BrfbG2WZMC3mu12ZhHOCTHSmB32ini4U3oz5q
         Xw62FKUg/QVtqweDahTQd7ooQiD8os+WafrI9qBkc/Sz4UaDPHySTmmMm2Xrke/AOY
         1ozK5gIguYsLjOOgSH8lgiNTeosmI4w0SbIvoBagclu3yOcrB+f8k+iyaWc7ZAw5N2
         wR8qGU10QVoxHagNXW+jyMl1dg9JP2ypz1khtJdEXREv0rItVL5h3fABXTmF2ee32H
         sh61t44YfhzCBjTISo/w6JTeRnRHl4lXqG4ZgFF5LmzXd6dJV/6PQXlYDIM5tt8/jq
         /vf+/o1USJi6A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3UBHxDq1346863;
        Tue, 30 Apr 2019 04:17:59 -0700
Date:   Tue, 30 Apr 2019 04:17:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-aad42dd44db086c79ca3f470ad563d2ac4ac218d@git.kernel.org>
Cc:     namit@vmware.com, linux-kernel@vger.kernel.org,
        rick.p.edgecombe@intel.com, peterz@infradead.org, bp@alien8.de,
        luto@kernel.org, riel@surriel.com, acme@kernel.org, lkp@intel.com,
        mingo@kernel.org, dave.hansen@linux.intel.com, hpa@zytor.com,
        torvalds@linux-foundation.org, tglx@linutronix.de
Reply-To: bp@alien8.de, peterz@infradead.org, luto@kernel.org,
          linux-kernel@vger.kernel.org, namit@vmware.com,
          rick.p.edgecombe@intel.com, hpa@zytor.com, tglx@linutronix.de,
          torvalds@linux-foundation.org, riel@surriel.com,
          mingo@kernel.org, dave.hansen@linux.intel.com, lkp@intel.com,
          acme@kernel.org
In-Reply-To: <20190426232303.28381-6-nadav.amit@gmail.com>
References: <20190426232303.28381-6-nadav.amit@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] uprobes: Initialize uprobes earlier
Git-Commit-ID: aad42dd44db086c79ca3f470ad563d2ac4ac218d
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

Commit-ID:  aad42dd44db086c79ca3f470ad563d2ac4ac218d
Gitweb:     https://git.kernel.org/tip/aad42dd44db086c79ca3f470ad563d2ac4ac218d
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Fri, 26 Apr 2019 16:22:44 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Apr 2019 12:37:51 +0200

uprobes: Initialize uprobes earlier

In order to have a separate address space for text poking, we need to
duplicate init_mm early during start_kernel(). This, however, introduces
a problem since uprobes functions are called from dup_mmap(), but
uprobes is still not initialized in this early stage.

Since uprobes initialization is necassary for fork, and since all the
dependant initialization has been done when fork is initialized (percpu
and vmalloc), move uprobes initialization to fork_init(). It does not
seem uprobes introduces any security problem for the poking_mm.

Crash and burn if uprobes initialization fails, similarly to other early
initializations. Change the init_probes() name to probes_init() to match
other early initialization functions name convention.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@linux-foundation.org
Cc: ard.biesheuvel@linaro.org
Cc: deneen.t.dock@intel.com
Cc: kernel-hardening@lists.openwall.com
Cc: kristen@linux.intel.com
Cc: linux_dti@icloud.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190426232303.28381-6-nadav.amit@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/uprobes.h | 5 +++++
 kernel/events/uprobes.c | 8 +++-----
 kernel/fork.c           | 1 +
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 103a48a48872..12bf0b68ed92 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -115,6 +115,7 @@ struct uprobes_state {
 	struct xol_area		*xol_area;
 };
 
+extern void __init uprobes_init(void);
 extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
 extern bool is_swbp_insn(uprobe_opcode_t *insn);
@@ -154,6 +155,10 @@ extern void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 struct uprobes_state {
 };
 
+static inline void uprobes_init(void)
+{
+}
+
 #define uprobe_get_trap_addr(regs)	instruction_pointer(regs)
 
 static inline int
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index c5cde87329c7..e6a0d6be87e3 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2294,16 +2294,14 @@ static struct notifier_block uprobe_exception_nb = {
 	.priority		= INT_MAX-1,	/* notified after kprobes, kgdb */
 };
 
-static int __init init_uprobes(void)
+void __init uprobes_init(void)
 {
 	int i;
 
 	for (i = 0; i < UPROBES_HASH_SZ; i++)
 		mutex_init(&uprobes_mmap_mutex[i]);
 
-	if (percpu_init_rwsem(&dup_mmap_sem))
-		return -ENOMEM;
+	BUG_ON(percpu_init_rwsem(&dup_mmap_sem));
 
-	return register_die_notifier(&uprobe_exception_nb);
+	BUG_ON(register_die_notifier(&uprobe_exception_nb));
 }
-__initcall(init_uprobes);
diff --git a/kernel/fork.c b/kernel/fork.c
index 9dcd18aa210b..44fba5e5e916 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -815,6 +815,7 @@ void __init fork_init(void)
 #endif
 
 	lockdep_init_task(&init_task);
+	uprobes_init();
 }
 
 int __weak arch_dup_task_struct(struct task_struct *dst,
