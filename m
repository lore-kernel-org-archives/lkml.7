Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD12C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AE8218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfGCLEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:04:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51601 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfGCLEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:04:09 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hid3X-0002bQ-Mf; Wed, 03 Jul 2019 13:04:07 +0200
Message-Id: <20190703105915.895135937@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 03 Jul 2019 12:54:35 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch 04/18] x86/apic: Move IPI inlines into ipi.c
References: <20190703105431.096822793@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No point in having them in an header file.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/ipi.h |   19 -------------------
 arch/x86/kernel/apic/ipi.c |   16 +++++++++++++---
 2 files changed, 13 insertions(+), 22 deletions(-)

--- a/arch/x86/include/asm/ipi.h
+++ b/arch/x86/include/asm/ipi.h
@@ -71,27 +71,8 @@ extern void default_send_IPI_mask_sequen
 extern void default_send_IPI_mask_allbutself_phys(const struct cpumask *mask,
 							 int vector);
 
-/* Avoid include hell */
-#define NMI_VECTOR 0x02
-
 extern int no_broadcast;
 
-static inline void __default_local_send_IPI_allbutself(int vector)
-{
-	if (no_broadcast || vector == NMI_VECTOR)
-		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
-	else
-		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector, apic->dest_logical);
-}
-
-static inline void __default_local_send_IPI_all(int vector)
-{
-	if (no_broadcast || vector == NMI_VECTOR)
-		apic->send_IPI_mask(cpu_online_mask, vector);
-	else
-		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector, apic->dest_logical);
-}
-
 #ifdef CONFIG_X86_32
 extern void default_send_IPI_mask_sequence_logical(const struct cpumask *mask,
 							 int vector);
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -198,15 +198,25 @@ void default_send_IPI_allbutself(int vec
 	 * if there are no other CPUs in the system then we get an APIC send
 	 * error if we try to broadcast, thus avoid sending IPIs in this case.
 	 */
-	if (!(num_online_cpus() > 1))
+	if (num_online_cpus() < 2)
 		return;
 
-	__default_local_send_IPI_allbutself(vector);
+	if (no_broadcast || vector == NMI_VECTOR) {
+		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
+	} else {
+		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector,
+					    apic->dest_logical);
+	}
 }
 
 void default_send_IPI_all(int vector)
 {
-	__default_local_send_IPI_all(vector);
+	if (no_broadcast || vector == NMI_VECTOR) {
+		apic->send_IPI_mask(cpu_online_mask, vector);
+	} else {
+		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector,
+					    apic->dest_logical);
+	}
 }
 
 void default_send_IPI_self(int vector)


