Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AB3C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F0C229FA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="eBuUYksT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfGXNWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:22:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48611 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfGXNWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:22:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6ODMJ1T548860
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 24 Jul 2019 06:22:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6ODMJ1T548860
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563974540;
        bh=HTvdMoYmj62/nIKk37CBNQtbiGBHSzDh/WTcWcvePQU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=eBuUYksTYbY/iFc+rOHdZrrCCnU+5DZYhvlJ+LOLAqQMA8HAIlIJmZTbNuURD57pn
         xoLdX6G+b3hnFLWvnPze/YNyPTl+i9toQDFjHYiJhXW6LU2mB09dw/XXCeLYiRqdA/
         Gki1QDVhT8Cw42xy0fbMewq5206uwoA6aG99rAggOlBpRAvShOd4A3/+3FstjlsdWM
         2CGQzUyJO1uLPitJBoCy2O43cTG5qkOwF1W9WljwW5JvFFZEfQEYJCGePeavPrIO36
         t1o0sE9XoF6SjXKCsZxtx9+wbYkqs7d2OCEojEcuFbCa4oKAiXHf4uqGaWL5TBPjjv
         BwOHEQQCX0BzQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6ODMJXs548857;
        Wed, 24 Jul 2019 06:22:19 -0700
Date:   Wed, 24 Jul 2019 06:22:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jan Kiszka <tipbot@zytor.com>
Message-ID: <tip-21e450d21ccad4cb7c7984c29ff145012b47736d@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        jan.kiszka@siemens.com, mingo@kernel.org
Reply-To: mingo@kernel.org, jan.kiszka@siemens.com, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <0fbbcb64-5f26-4ffb-1bb9-4f5f48426893@siemens.com>
References: <0fbbcb64-5f26-4ffb-1bb9-4f5f48426893@siemens.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Avoid redundant interrupt disable in
 load_mm_cr4()
Git-Commit-ID: 21e450d21ccad4cb7c7984c29ff145012b47736d
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

Commit-ID:  21e450d21ccad4cb7c7984c29ff145012b47736d
Gitweb:     https://git.kernel.org/tip/21e450d21ccad4cb7c7984c29ff145012b47736d
Author:     Jan Kiszka <jan.kiszka@siemens.com>
AuthorDate: Tue, 18 Jun 2019 09:32:11 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 24 Jul 2019 14:43:37 +0200

x86/mm: Avoid redundant interrupt disable in load_mm_cr4()

load_mm_cr4() is always called with interrupts disabled from:

 - switch_mm_irqs_off()
 - refresh_pce(), which is a on_each_cpu() callback

Thus, disabling interrupts in cr4_set/clear_bits() is redundant.

Implement cr4_set/clear_bits_irqsoff() helpers, rename load_mm_cr4() to
load_mm_cr4_irqsoff() and use the new helpers. The new helpers do not need
a lockdep assert as __cr4_set() has one already.

The renaming in combination with the checks in __cr4_set() ensure that any
changes in the boundary conditions at the call sites will be detected.

[ tglx: Massaged change log ]

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/0fbbcb64-5f26-4ffb-1bb9-4f5f48426893@siemens.com
---
 arch/x86/events/core.c             |  2 +-
 arch/x86/include/asm/mmu_context.h |  8 ++++----
 arch/x86/include/asm/tlbflush.h    | 30 +++++++++++++++++++++++-------
 arch/x86/mm/tlb.c                  |  2 +-
 4 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 81b005e4c7d9..cfe256ca76df 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2087,7 +2087,7 @@ static int x86_pmu_event_init(struct perf_event *event)
 
 static void refresh_pce(void *ignored)
 {
-	load_mm_cr4(this_cpu_read(cpu_tlbstate.loaded_mm));
+	load_mm_cr4_irqsoff(this_cpu_read(cpu_tlbstate.loaded_mm));
 }
 
 static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 9024236693d2..16ae821483c8 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -28,16 +28,16 @@ static inline void paravirt_activate_mm(struct mm_struct *prev,
 
 DECLARE_STATIC_KEY_FALSE(rdpmc_always_available_key);
 
-static inline void load_mm_cr4(struct mm_struct *mm)
+static inline void load_mm_cr4_irqsoff(struct mm_struct *mm)
 {
 	if (static_branch_unlikely(&rdpmc_always_available_key) ||
 	    atomic_read(&mm->context.perf_rdpmc_allowed))
-		cr4_set_bits(X86_CR4_PCE);
+		cr4_set_bits_irqsoff(X86_CR4_PCE);
 	else
-		cr4_clear_bits(X86_CR4_PCE);
+		cr4_clear_bits_irqsoff(X86_CR4_PCE);
 }
 #else
-static inline void load_mm_cr4(struct mm_struct *mm) {}
+static inline void load_mm_cr4_irqsoff(struct mm_struct *mm) {}
 #endif
 
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index dee375831962..6f66d841262d 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -290,26 +290,42 @@ static inline void __cr4_set(unsigned long cr4)
 }
 
 /* Set in this cpu's CR4. */
-static inline void cr4_set_bits(unsigned long mask)
+static inline void cr4_set_bits_irqsoff(unsigned long mask)
 {
-	unsigned long cr4, flags;
+	unsigned long cr4;
 
-	local_irq_save(flags);
 	cr4 = this_cpu_read(cpu_tlbstate.cr4);
 	if ((cr4 | mask) != cr4)
 		__cr4_set(cr4 | mask);
-	local_irq_restore(flags);
 }
 
 /* Clear in this cpu's CR4. */
-static inline void cr4_clear_bits(unsigned long mask)
+static inline void cr4_clear_bits_irqsoff(unsigned long mask)
 {
-	unsigned long cr4, flags;
+	unsigned long cr4;
 
-	local_irq_save(flags);
 	cr4 = this_cpu_read(cpu_tlbstate.cr4);
 	if ((cr4 & ~mask) != cr4)
 		__cr4_set(cr4 & ~mask);
+}
+
+/* Set in this cpu's CR4. */
+static inline void cr4_set_bits(unsigned long mask)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	cr4_set_bits_irqsoff(mask);
+	local_irq_restore(flags);
+}
+
+/* Clear in this cpu's CR4. */
+static inline void cr4_clear_bits(unsigned long mask)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	cr4_clear_bits_irqsoff(mask);
 	local_irq_restore(flags);
 }
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 4de9704c4aaf..e6a9edc5baaf 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -440,7 +440,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
 
 	if (next != real_prev) {
-		load_mm_cr4(next);
+		load_mm_cr4_irqsoff(next);
 		switch_ldt(real_prev, next);
 	}
 }
