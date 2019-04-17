Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B1BC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1E520872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XMYlvMzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbfDQONi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:13:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57279 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbfDQONi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:13:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HEDBbX3934390
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:13:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HEDBbX3934390
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510392;
        bh=q7j0S7BGkVusU9JNxHv7W3kZSET8B+kbmzJPSUAM7NI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=XMYlvMzo/rJ7CN24TrsMjEV5zWA2VdlmwIMjm1zHq5Ua4yerb7hHkV3w6wpE05x3n
         cHGJ8BoQ+hYz6HgIkF18SourtkvxKY+7kCOIDRiFLcugXntf2dqdSkZkXLwn3qH90D
         mCYPWQfjhKm99oh8mdF4ZPKeNSPPtZmQL0QfUCmDm4hNjtGFcBbt50ZLttPN9x8ULd
         a007h0SgU5DyrYJ+8nm/JbiARltIoU9yNoIp1f/5ASRMru1PaWE79bYnwJ+VjNQUz4
         jDfhFE2+318/GdGT6D3pfXPjIWLEKvdgw9cx3hxFpjB2PHvdA6qkoa0H+skRi8DzWO
         Cpaw9j9biof/Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HEDBFc3934387;
        Wed, 17 Apr 2019 07:13:11 -0700
Date:   Wed, 17 Apr 2019 07:13:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-f6ef73224a0f0400c3979c8bc68b383f9d2eb9d8@git.kernel.org>
Cc:     jpoimboe@redhat.com, peterz@infradead.org, hpa@zytor.com,
        x86@kernel.org, chang.seok.bae@intel.com, mingo@kernel.org,
        mingo@redhat.com, linux@dominikbrodowski.net, bp@suse.de,
        tglx@linutronix.de, konrad.wilk@oracle.com,
        sean.j.christopherson@intel.com, linux-kernel@vger.kernel.org,
        luto@kernel.org
Reply-To: jpoimboe@redhat.com, peterz@infradead.org, x86@kernel.org,
          chang.seok.bae@intel.com, mingo@kernel.org, hpa@zytor.com,
          bp@suse.de, konrad.wilk@oracle.com, tglx@linutronix.de,
          mingo@redhat.com, linux@dominikbrodowski.net,
          linux-kernel@vger.kernel.org, luto@kernel.org,
          sean.j.christopherson@intel.com
In-Reply-To: <20190414160145.061686012@linutronix.de>
References: <20190414160145.061686012@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/cpu: Prepare TSS.IST setup for guard pages
Git-Commit-ID: f6ef73224a0f0400c3979c8bc68b383f9d2eb9d8
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

Commit-ID:  f6ef73224a0f0400c3979c8bc68b383f9d2eb9d8
Gitweb:     https://git.kernel.org/tip/f6ef73224a0f0400c3979c8bc68b383f9d2eb9d8
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 17:59:53 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 14:29:22 +0200

x86/cpu: Prepare TSS.IST setup for guard pages

Convert the TSS.IST setup code to use the cpu entry area information
directly instead of assuming a linear mapping of the IST stacks.

The store to orig_ist[] is no longer required as there are no users
anymore.

This is the last preparatory step towards IST guard pages.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160145.061686012@linutronix.de
---
 arch/x86/kernel/cpu/common.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 24b801ea7522..4b01b71415f5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -507,19 +507,6 @@ void load_percpu_segment(int cpu)
 DEFINE_PER_CPU(struct cpu_entry_area *, cpu_entry_area);
 #endif
 
-#ifdef CONFIG_X86_64
-/*
- * Special IST stacks which the CPU switches to when it calls
- * an IST-marked descriptor entry. Up to 7 stacks (hardware
- * limit), all of them are 4K, except the debug stack which
- * is 8K.
- */
-static const unsigned int exception_stack_sizes[N_EXCEPTION_STACKS] = {
-	  [0 ... N_EXCEPTION_STACKS - 1]	= EXCEPTION_STKSZ,
-	  [ESTACK_DB]				= DEBUG_STKSZ
-};
-#endif
-
 /* Load the original GDT from the per-cpu structure */
 void load_direct_gdt(int cpu)
 {
@@ -1690,17 +1677,14 @@ static void setup_getcpu(int cpu)
  * initialized (naturally) in the bootstrap process, such as the GDT
  * and IDT. We reload them nevertheless, this function acts as a
  * 'CPU state barrier', nothing should get across.
- * A lot of state is already set up in PDA init for 64 bit
  */
 #ifdef CONFIG_X86_64
 
 void cpu_init(void)
 {
-	struct orig_ist *oist;
+	int cpu = raw_smp_processor_id();
 	struct task_struct *me;
 	struct tss_struct *t;
-	unsigned long v;
-	int cpu = raw_smp_processor_id();
 	int i;
 
 	wait_for_master_cpu(cpu);
@@ -1715,7 +1699,6 @@ void cpu_init(void)
 		load_ucode_ap();
 
 	t = &per_cpu(cpu_tss_rw, cpu);
-	oist = &per_cpu(orig_ist, cpu);
 
 #ifdef CONFIG_NUMA
 	if (this_cpu_read(numa_node) == 0 &&
@@ -1753,16 +1736,12 @@ void cpu_init(void)
 	/*
 	 * set up and load the per-CPU TSS
 	 */
-	if (!oist->ist[0]) {
-		char *estacks = (char *)&get_cpu_entry_area(cpu)->estacks;
-
-		for (v = 0; v < N_EXCEPTION_STACKS; v++) {
-			estacks += exception_stack_sizes[v];
-			oist->ist[v] = t->x86_tss.ist[v] =
-					(unsigned long)estacks;
-			if (v == ESTACK_DB)
-				per_cpu(debug_stack_addr, cpu) = (unsigned long)estacks;
-		}
+	if (!t->x86_tss.ist[0]) {
+		t->x86_tss.ist[ESTACK_DF] = __this_cpu_ist_top_va(DF);
+		t->x86_tss.ist[ESTACK_NMI] = __this_cpu_ist_top_va(NMI);
+		t->x86_tss.ist[ESTACK_DB] = __this_cpu_ist_top_va(DB);
+		t->x86_tss.ist[ESTACK_MCE] = __this_cpu_ist_top_va(MCE);
+		per_cpu(debug_stack_addr, cpu) = t->x86_tss.ist[ESTACK_DB];
 	}
 
 	t->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET;
