Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF49C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5AE21E6B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732190AbfGVS6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:58:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38087 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbfGVS5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:57:06 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpdUf-0002Pw-3L; Mon, 22 Jul 2019 20:57:05 +0200
Message-Id: <20190722105219.910317273@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 22 Jul 2019 20:47:17 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [patch V3 12/25] x86/cpu: Move arch_smt_update() to a neutral place
References: <20190722104705.550071814@linutronix.de>
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
@@ -1905,3 +1905,12 @@ void microcode_check(void)
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


