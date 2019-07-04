Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16916C46484
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA84218D0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfGDQfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:35:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59696 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfGDQeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:34:08 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hj4gP-0005gc-CU; Thu, 04 Jul 2019 18:34:05 +0200
Message-Id: <20190704155609.835639680@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 17:52:01 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch V2 16/25] x86/apic: Move no_ipi_broadcast() out of 32bit
References: <20190704155145.617706117@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the upcoming shorthand support for all APIC incarnations the command
line option needs to be available for 64 bit as well.

While at it, rename the control variable, make it static and mark it
__ro_after_init.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/ipi.c      |   29 +++++++++++++++++++++++++++--
 arch/x86/kernel/apic/local.h    |    2 --
 arch/x86/kernel/apic/probe_32.c |   25 -------------------------
 3 files changed, 27 insertions(+), 29 deletions(-)

--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -5,6 +5,31 @@
 
 #include "local.h"
 
+#ifdef CONFIG_SMP
+#ifdef CONFIG_HOTPLUG_CPU
+#define DEFAULT_SEND_IPI	(1)
+#else
+#define DEFAULT_SEND_IPI	(0)
+#endif
+
+static int apic_ipi_shorthand_off __ro_after_init = DEFAULT_SEND_IPI;
+
+static __init int apic_ipi_shorthand(char *str)
+{
+	get_option(&str, &apic_ipi_shorthand_off);
+	return 1;
+}
+__setup("no_ipi_broadcast=", apic_ipi_shorthand);
+
+static int __init print_ipi_mode(void)
+{
+	pr_info("IPI shorthand broadcast: %s\n",
+		apic_ipi_shorthand_off ? "disabled" : "enabled");
+	return 0;
+}
+late_initcall(print_ipi_mode);
+#endif
+
 static inline int __prepare_ICR2(unsigned int mask)
 {
 	return SET_APIC_DEST_FIELD(mask);
@@ -203,7 +228,7 @@ void default_send_IPI_allbutself(int vec
 	if (num_online_cpus() < 2)
 		return;
 
-	if (no_broadcast || vector == NMI_VECTOR) {
+	if (apic_ipi_shorthand_off || vector == NMI_VECTOR) {
 		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
 	} else {
 		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
@@ -212,7 +237,7 @@ void default_send_IPI_allbutself(int vec
 
 void default_send_IPI_all(int vector)
 {
-	if (no_broadcast || vector == NMI_VECTOR) {
+	if (apic_ipi_shorthand_off || vector == NMI_VECTOR) {
 		apic->send_IPI_mask(cpu_online_mask, vector);
 	} else {
 		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -51,8 +51,6 @@ void default_send_IPI_single_phys(int cp
 void default_send_IPI_mask_sequence_phys(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_allbutself_phys(const struct cpumask *mask, int vector);
 
-extern int no_broadcast;
-
 #ifdef CONFIG_X86_32
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask, int vector);
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -15,31 +15,6 @@
 
 #include "local.h"
 
-#ifdef CONFIG_HOTPLUG_CPU
-#define DEFAULT_SEND_IPI	(1)
-#else
-#define DEFAULT_SEND_IPI	(0)
-#endif
-
-int no_broadcast = DEFAULT_SEND_IPI;
-
-static __init int no_ipi_broadcast(char *str)
-{
-	get_option(&str, &no_broadcast);
-	pr_info("Using %s mode\n",
-		no_broadcast ? "No IPI Broadcast" : "IPI Broadcast");
-	return 1;
-}
-__setup("no_ipi_broadcast=", no_ipi_broadcast);
-
-static int __init print_ipi_mode(void)
-{
-	pr_info("Using IPI %s mode\n",
-		no_broadcast ? "No-Shortcut" : "Shortcut");
-	return 0;
-}
-late_initcall(print_ipi_mode);
-
 static int default_x86_32_early_logical_apicid(int cpu)
 {
 	return 1 << cpu;


