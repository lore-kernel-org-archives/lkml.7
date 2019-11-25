Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B98BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6053020740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfKYQ3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:29:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39724 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbfKYQ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:29:54 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iZHFE-0001Su-6B; Mon, 25 Nov 2019 17:29:48 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C91361C1AFF;
        Mon, 25 Nov 2019 17:29:47 +0100 (CET)
Date:   Mon, 25 Nov 2019 16:29:47 -0000
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/setup: Enhance the comments
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>
MIME-Version: 1.0
Message-ID: <157469938760.21853.2579898398606046611.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     b74374fef924e0adb8cb1d84313d467965ca0f00
Gitweb:        https://git.kernel.org/tip/b74374fef924e0adb8cb1d84313d467965ca0f00
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 18 Nov 2019 16:03:39 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Nov 2019 17:49:19 +01:00

x86/setup: Enhance the comments

Update various comments, fix outright mistakes and meaningless descriptions.

Also harmonize the style across the file, both in form and in language.

Cc: linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/setup.c | 41 ++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 26a4a73..a871381 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -43,11 +43,11 @@
 #include <asm/vsyscall.h>
 
 /*
- * max_low_pfn_mapped: highest direct mapped pfn under 4GB
- * max_pfn_mapped:     highest direct mapped pfn over 4GB
+ * max_low_pfn_mapped: highest directly mapped pfn < 4 GB
+ * max_pfn_mapped:     highest directly mapped pfn > 4 GB
  *
  * The direct mapping only covers E820_TYPE_RAM regions, so the ranges and gaps are
- * represented by pfn_mapped
+ * represented by pfn_mapped[].
  */
 unsigned long max_low_pfn_mapped;
 unsigned long max_pfn_mapped;
@@ -57,14 +57,23 @@ RESERVE_BRK(dmi_alloc, 65536);
 #endif
 
 
-static __initdata unsigned long _brk_start = (unsigned long)__brk_base;
-unsigned long _brk_end = (unsigned long)__brk_base;
+/*
+ * Range of the BSS area. The size of the BSS area is determined
+ * at link time, with RESERVE_BRK*() facility reserving additional
+ * chunks.
+ */
+static __initdata
+unsigned long _brk_start = (unsigned long)__brk_base;
+unsigned long _brk_end   = (unsigned long)__brk_base;
 
 struct boot_params boot_params;
 
 /*
- * Machine setup..
+ * These are the four main kernel memory regions, we put them into
+ * the resource tree so that kdump tools and other debugging tools
+ * recover it:
  */
+
 static struct resource rodata_resource = {
 	.name	= "Kernel rodata",
 	.start	= 0,
@@ -95,16 +104,16 @@ static struct resource bss_resource = {
 
 
 #ifdef CONFIG_X86_32
-/* cpu data as detected by the assembly code in head_32.S */
+/* CPU data as detected by the assembly code in head_32.S */
 struct cpuinfo_x86 new_cpu_data;
 
-/* common cpu data for all cpus */
+/* Common CPU data for all CPUs */
 struct cpuinfo_x86 boot_cpu_data __read_mostly;
 EXPORT_SYMBOL(boot_cpu_data);
 
 unsigned int def_to_bigsmp;
 
-/* for MCA, but anyone else can use it if they want */
+/* For MCA, but anyone else can use it if they want */
 unsigned int machine_id;
 unsigned int machine_submodel_id;
 unsigned int BIOS_revision;
@@ -384,15 +393,15 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 /*
  * Keep the crash kernel below this limit.
  *
- * On 32 bits earlier kernels would limit the kernel to the low 512 MiB
+ * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
  * due to mapping restrictions.
  *
- * On 64bit, kdump kernel need be restricted to be under 64TB, which is
+ * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
  * the upper limit of system RAM in 4-level paging mode. Since the kdump
- * jumping could be from 5-level to 4-level, the jumping will fail if
- * kernel is put above 64TB, and there's no way to detect the paging mode
- * of the kernel which will be loaded for dumping during the 1st kernel
- * bootup.
+ * jump could be from 5-level paging to 4-level paging, the jump will fail if
+ * the kernel is put above 64 TB, and during the 1st kernel bootup there's
+ * no good way to detect the paging mode of the target kernel which will be
+ * loaded for dumping.
  */
 #ifdef CONFIG_X86_32
 # define CRASH_ADDR_LOW_MAX	SZ_512M
@@ -803,7 +812,7 @@ void __init setup_arch(char **cmdline_p)
 	/*
 	 * Note: Quark X1000 CPUs advertise PGE incorrectly and require
 	 * a cr3 based tlb flush, so the following __flush_tlb_all()
-	 * will not flush anything because the cpu quirk which clears
+	 * will not flush anything because the CPU quirk which clears
 	 * X86_FEATURE_PGE has not been invoked yet. Though due to the
 	 * load_cr3() above the TLB has been flushed already. The
 	 * quirk is invoked before subsequent calls to __flush_tlb_all()
