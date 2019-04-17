Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DA6C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3ED20663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Gg5u+qbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbfDQOJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:09:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47329 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbfDQOJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:09:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HE8mic3933513
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:08:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HE8mic3933513
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555510129;
        bh=0ijtZvpm6+49PpbGXXquCEZKl436SSkVSVP3r17C+lg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Gg5u+qbY7M6kQxIzDthMd41xL7woCGoPlZLlOhDn74+xwjenm6Q4G5vmK4oHda7L5
         bfbJve2AnasgWqVgjVCLFBURP57gqCC1/E9sfZVeYpm/YZFFepnA8ZqWT3M80/VGEn
         eW90K+k2NsTaonfiC9eDptUIKdWxfUYZh0u8hGQmJtGjqTAUVFy/iov5h54OOR0Z87
         IU4USsnU9x5sV3EgoVCLJGDiQWO1ngT0flv0MvU1OwlzWtPRV9KutePsu3iB2omjV8
         /Atnf9z6PAIN/9v0eyKeHFdVhMVib9K0RhEfufdzodc26G+u9uFEdPFD7nTPkvTCUV
         ZgH+ULcW1krUg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HE8mNH3933510;
        Wed, 17 Apr 2019 07:08:48 -0700
Date:   Wed, 17 Apr 2019 07:08:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-019b17b3ffe48100e52f609ca1c6ed6e5a40cba1@git.kernel.org>
Cc:     sean.j.christopherson@intel.com, peterz@infradead.org,
        tglx@linutronix.de, luto@kernel.org, mingo@redhat.com,
        dave.hansen@linux.intel.com, chang.seok.bae@intel.com,
        x86@kernel.org, bp@suse.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        linux@dominikbrodowski.net, mingo@kernel.org,
        konrad.wilk@oracle.com
Reply-To: jpoimboe@redhat.com, linux@dominikbrodowski.net,
          mingo@kernel.org, konrad.wilk@oracle.com, x86@kernel.org,
          bp@suse.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
          mingo@redhat.com, dave.hansen@linux.intel.com,
          chang.seok.bae@intel.com, sean.j.christopherson@intel.com,
          peterz@infradead.org, tglx@linutronix.de, luto@kernel.org
In-Reply-To: <20190414160144.506807893@linutronix.de>
References: <20190414160144.506807893@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] x86/exceptions: Add structs for exception stacks
Git-Commit-ID: 019b17b3ffe48100e52f609ca1c6ed6e5a40cba1
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

Commit-ID:  019b17b3ffe48100e52f609ca1c6ed6e5a40cba1
Gitweb:     https://git.kernel.org/tip/019b17b3ffe48100e52f609ca1c6ed6e5a40cba1
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 14 Apr 2019 17:59:47 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 12:55:18 +0200

x86/exceptions: Add structs for exception stacks

At the moment everything assumes a full linear mapping of the various
exception stacks. Adding guard pages to the cpu entry area mapping of the
exception stacks will break that assumption.

As a preparatory step convert both the real storage and the effective
mapping in the cpu entry area from character arrays to structures.

To ensure that both arrays have the same ordering and the same size of the
individual stacks fill the members with a macro. The guard size is the only
difference between the two resulting structures. For now both have guard
size 0 until the preparation of all usage sites is done.

Provide a couple of helper macros which are used in the following
conversions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190414160144.506807893@linutronix.de
---
 arch/x86/include/asm/cpu_entry_area.h | 52 +++++++++++++++++++++++++++++++----
 arch/x86/kernel/cpu/common.c          |  2 +-
 arch/x86/mm/cpu_entry_area.c          |  8 ++----
 3 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 29c706415443..af8c312673de 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -7,6 +7,51 @@
 #include <asm/processor.h>
 #include <asm/intel_ds.h>
 
+#ifdef CONFIG_X86_64
+
+/* Macro to enforce the same ordering and stack sizes */
+#define ESTACKS_MEMBERS(guardsize)		\
+	char	DF_stack_guard[guardsize];	\
+	char	DF_stack[EXCEPTION_STKSZ];	\
+	char	NMI_stack_guard[guardsize];	\
+	char	NMI_stack[EXCEPTION_STKSZ];	\
+	char	DB_stack_guard[guardsize];	\
+	char	DB_stack[DEBUG_STKSZ];		\
+	char	MCE_stack_guard[guardsize];	\
+	char	MCE_stack[EXCEPTION_STKSZ];	\
+	char	IST_top_guard[guardsize];	\
+
+/* The exception stacks' physical storage. No guard pages required */
+struct exception_stacks {
+	ESTACKS_MEMBERS(0)
+};
+
+/*
+ * The effective cpu entry area mapping with guard pages. Guard size is
+ * zero until the code which makes assumptions about linear mappings is
+ * cleaned up.
+ */
+struct cea_exception_stacks {
+	ESTACKS_MEMBERS(0)
+};
+
+#define CEA_ESTACK_SIZE(st)					\
+	sizeof(((struct cea_exception_stacks *)0)->st## _stack)
+
+#define CEA_ESTACK_BOT(ceastp, st)				\
+	((unsigned long)&(ceastp)->st## _stack)
+
+#define CEA_ESTACK_TOP(ceastp, st)				\
+	(CEA_ESTACK_BOT(ceastp, st) + CEA_ESTACK_SIZE(st))
+
+#define CEA_ESTACK_OFFS(st)					\
+	offsetof(struct cea_exception_stacks, st## _stack)
+
+#define CEA_ESTACK_PAGES					\
+	(sizeof(struct cea_exception_stacks) / PAGE_SIZE)
+
+#endif
+
 /*
  * cpu_entry_area is a percpu region that contains things needed by the CPU
  * and early entry/exit code.  Real types aren't used for all fields here
@@ -32,12 +77,9 @@ struct cpu_entry_area {
 
 #ifdef CONFIG_X86_64
 	/*
-	 * Exception stacks used for IST entries.
-	 *
-	 * In the future, this should have a separate slot for each stack
-	 * with guard pages between them.
+	 * Exception stacks used for IST entries with guard pages.
 	 */
-	char exception_stacks[(N_EXCEPTION_STACKS - 1) * EXCEPTION_STKSZ + DEBUG_STKSZ];
+	struct cea_exception_stacks estacks;
 #endif
 #ifdef CONFIG_CPU_SUP_INTEL
 	/*
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0e4cb718fc4a..24b801ea7522 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1754,7 +1754,7 @@ void cpu_init(void)
 	 * set up and load the per-CPU TSS
 	 */
 	if (!oist->ist[0]) {
-		char *estacks = get_cpu_entry_area(cpu)->exception_stacks;
+		char *estacks = (char *)&get_cpu_entry_area(cpu)->estacks;
 
 		for (v = 0; v < N_EXCEPTION_STACKS; v++) {
 			estacks += exception_stack_sizes[v];
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index c2a54f75d335..6a09b84c13fe 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -13,8 +13,7 @@
 static DEFINE_PER_CPU_PAGE_ALIGNED(struct entry_stack_page, entry_stack_storage);
 
 #ifdef CONFIG_X86_64
-static DEFINE_PER_CPU_PAGE_ALIGNED(char, exception_stacks
-	[(N_EXCEPTION_STACKS - 1) * EXCEPTION_STKSZ + DEBUG_STKSZ]);
+static DEFINE_PER_CPU_PAGE_ALIGNED(struct exception_stacks, exception_stacks);
 #endif
 
 struct cpu_entry_area *get_cpu_entry_area(int cpu)
@@ -138,9 +137,8 @@ static void __init setup_cpu_entry_area(unsigned int cpu)
 #ifdef CONFIG_X86_64
 	BUILD_BUG_ON(sizeof(exception_stacks) % PAGE_SIZE != 0);
 	BUILD_BUG_ON(sizeof(exception_stacks) !=
-		     sizeof(((struct cpu_entry_area *)0)->exception_stacks));
-	cea_map_percpu_pages(&cea->exception_stacks,
-			     &per_cpu(exception_stacks, cpu),
+		     sizeof(((struct cpu_entry_area *)0)->estacks));
+	cea_map_percpu_pages(&cea->estacks, &per_cpu(exception_stacks, cpu),
 			     sizeof(exception_stacks) / PAGE_SIZE, PAGE_KERNEL);
 #endif
 	percpu_setup_debug_store(cpu);
