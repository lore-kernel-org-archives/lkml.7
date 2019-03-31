Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8646DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A10320870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbfCaWKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:10:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57604 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731591AbfCaWK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:10:29 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hAiep-0004qt-Tz; Mon, 01 Apr 2019 00:10:28 +0200
Message-Id: <20190331215135.403890024@linutronix.de>
User-Agent: quilt/0.65
Date:   Sun, 31 Mar 2019 23:40:27 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [patch 07/14] x86/cpu_entry_area: Prepare for IST guard pages
References: <20190331214020.836098943@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow guard pages between the IST stacks each stack needs to be mapped
individually.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/mm/cpu_entry_area.c |   36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -77,6 +77,33 @@ static void __init percpu_setup_debug_st
 #endif
 }
 
+#ifdef CONFIG_X86_64
+
+#define cea_map_stack(name)						\
+	npages = sizeof(estacks->name## _stack) / PAGE_SIZE;		\
+	cea_map_percpu_pages(cea->estacks.name## _stack,		\
+			     estacks->name## _stack, npages, PAGE_KERNEL)
+
+static void __init percpu_setup_exception_stacks(unsigned int cpu)
+{
+	struct exception_stacks *estacks = per_cpu_ptr(&exception_stacks, cpu);
+	struct cpu_entry_area *cea = get_cpu_entry_area(cpu);
+	unsigned int npages;
+
+	BUILD_BUG_ON(sizeof(exception_stacks) % PAGE_SIZE != 0);
+	/*
+	 * The exceptions stack mappings in the per cpu area are protected
+	 * by guard pages so each stack must be mapped seperately.
+	 */
+	cea_map_stack(DF);
+	cea_map_stack(NMI);
+	cea_map_stack(DB);
+	cea_map_stack(MCE);
+}
+#else
+static inline void percpu_setup_exception_stacks(unsigned int cpu) {}
+#endif
+
 /* Setup the fixmap mappings only once per-processor */
 static void __init setup_cpu_entry_area(unsigned int cpu)
 {
@@ -134,13 +161,8 @@ static void __init setup_cpu_entry_area(
 	per_cpu(cpu_entry_area, cpu) = cea;
 #endif
 
-#ifdef CONFIG_X86_64
-	BUILD_BUG_ON(sizeof(exception_stacks) % PAGE_SIZE != 0);
-	BUILD_BUG_ON(sizeof(exception_stacks) !=
-		     sizeof(((struct cpu_entry_area *)0)->estacks));
-	cea_map_percpu_pages(&cea->estacks, &per_cpu(exception_stacks, cpu),
-			     sizeof(exception_stacks) / PAGE_SIZE, PAGE_KERNEL);
-#endif
+	percpu_setup_exception_stacks(cpu);
+
 	percpu_setup_debug_store(cpu);
 }
 


