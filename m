Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BB6C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59520218D0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfGCLFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:05:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51637 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbfGCLEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:04:12 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hid3a-0002cI-Ge; Wed, 03 Jul 2019 13:04:10 +0200
Message-Id: <20190703105916.471221576@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 03 Jul 2019 12:54:41 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch 10/18] x86/cpu: Move arch_smt_update() to a neutral place
References: <20190703105431.096822793@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_smt_update() will be used to control IPI/NMI broadcasting via the
shorthand mechanism. Keeping it in the bugs file and calling the apic
function from there is possible, but not really intuitive.

Move it to a neutral place and invoke the bugs function from there.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/bugs.h  |    2 ++
 arch/x86/kernel/cpu/bugs.c   |    2 +-
 arch/x86/kernel/cpu/common.c |    9 +++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/bugs.h
+++ b/arch/x86/include/asm/bugs.h
@@ -18,4 +18,6 @@ int ppro_with_ram_bug(void);
 static inline int ppro_with_ram_bug(void) { return 0; }
 #endif
 
+extern void cpu_bugs_smt_update(void);
+
 #endif /* _ASM_X86_BUGS_H */
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -700,7 +700,7 @@ static void update_mds_branch_idle(void)
 
 #define MDS_MSG_SMT "MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.\n"
 
-void arch_smt_update(void)
+void cpu_bugs_smt_update(void)
 {
 	/* Enhanced IBRS implies STIBP. No update required. */
 	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1927,3 +1927,12 @@ void microcode_check(void)
 	pr_warn("x86/CPU: CPU features have changed after loading microcode, but might not take effect.\n");
 	pr_warn("x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.\n");
 }
+
+/*
+ * Invoked from core CPU hotplug code after hotplug operations
+ */
+void arch_smt_update(void)
+{
+	/* Handle the speculative execution misfeatures */
+	cpu_bugs_smt_update();
+}


