Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD50BC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12BC218FC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfGCLEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:04:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51690 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfGCLEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:04:16 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hid3e-0002db-IR; Wed, 03 Jul 2019 13:04:14 +0200
Message-Id: <20190703105917.153388644@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 03 Jul 2019 12:54:48 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch 17/18] x86/apic/flat64: Add conditional IPI shorthands support
References: <20190703105431.096822793@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the shorthand broadcast delivery if the static key controlling it is
enabled. If not use the regular one by one IPI mechanism.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/apic_flat_64.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -80,7 +80,9 @@ static void flat_send_IPI_allbutself(int
 {
 	int cpu = smp_processor_id();
 
-	if (IS_ENABLED(CONFIG_HOTPLUG_CPU) || vector == NMI_VECTOR) {
+	if (static_branch_likely(&apic_use_ipi_shorthand)) {
+		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
+	} else {
 		if (!cpumask_equal(cpu_online_mask, cpumask_of(cpu))) {
 			unsigned long mask = cpumask_bits(cpu_online_mask)[0];
 
@@ -89,18 +91,15 @@ static void flat_send_IPI_allbutself(int
 
 			_flat_send_IPI_mask(mask, vector);
 		}
-	} else if (num_online_cpus() > 1) {
-		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
 	}
 }
 
 static void flat_send_IPI_all(int vector)
 {
-	if (vector == NMI_VECTOR) {
-		flat_send_IPI_mask(cpu_online_mask, vector);
-	} else {
+	if (static_branch_likely(&apic_use_ipi_shorthand))
 		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
-	}
+	else
+		flat_send_IPI_mask(cpu_online_mask, vector);
 }
 
 static unsigned int flat_get_apic_id(unsigned long x)
@@ -218,12 +217,19 @@ static void physflat_init_apic_ldr(void)
 
 static void physflat_send_IPI_allbutself(int vector)
 {
-	default_send_IPI_mask_allbutself_phys(cpu_online_mask, vector);
+	if (static_branch_likely(&apic_use_ipi_shorthand)) {
+		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
+	} else {
+		default_send_IPI_mask_allbutself_phys(cpu_online_mask, vector);
+	}
 }
 
 static void physflat_send_IPI_all(int vector)
 {
-	default_send_IPI_mask_sequence_phys(cpu_online_mask, vector);
+	if (static_branch_likely(&apic_use_ipi_shorthand))
+		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
+	else
+		default_send_IPI_mask_sequence_phys(cpu_online_mask, vector);
 }
 
 static int physflat_probe(void)


