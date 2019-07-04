Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F1EC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA08218BC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfGDQe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:34:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59751 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfGDQeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:34:12 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hj4gU-0005ip-Gm; Thu, 04 Jul 2019 18:34:10 +0200
Message-Id: <20190704155610.505371909@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 17:52:08 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch V2 23/25] x86/apic: Share common IPI helpers
References: <20190704155145.617706117@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 64bit implementations need the same wrappers around
__default_send_IPI_shortcut() as 32bit.

Move them out of the 32bit section.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/kernel/apic/ipi.c   |   30 +++++++++++++++---------------
 arch/x86/kernel/apic/local.h |    6 +++---
 2 files changed, 18 insertions(+), 18 deletions(-)

--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -226,6 +226,21 @@ void default_send_IPI_single(int cpu, in
 	apic->send_IPI_mask(cpumask_of(cpu), vector);
 }
 
+void default_send_IPI_allbutself(int vector)
+{
+	__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
+}
+
+void default_send_IPI_all(int vector)
+{
+	__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
+}
+
+void default_send_IPI_self(int vector)
+{
+	__default_send_IPI_shortcut(APIC_DEST_SELF, vector);
+}
+
 #ifdef CONFIG_X86_32
 
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask,
@@ -285,21 +300,6 @@ void default_send_IPI_mask_logical(const
 	local_irq_restore(flags);
 }
 
-void default_send_IPI_allbutself(int vector)
-{
-	__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
-}
-
-void default_send_IPI_all(int vector)
-{
-	__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
-}
-
-void default_send_IPI_self(int vector)
-{
-	__default_send_IPI_shortcut(APIC_DEST_SELF, vector);
-}
-
 /* must come after the send_IPI functions above for inlining */
 static int convert_apicid_to_cpu(int apic_id)
 {
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -56,12 +56,12 @@ void default_send_IPI_single(int cpu, in
 void default_send_IPI_single_phys(int cpu, int vector);
 void default_send_IPI_mask_sequence_phys(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_allbutself_phys(const struct cpumask *mask, int vector);
+void default_send_IPI_allbutself(int vector);
+void default_send_IPI_all(int vector);
+void default_send_IPI_self(int vector);
 
 #ifdef CONFIG_X86_32
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_logical(const struct cpumask *mask, int vector);
-void default_send_IPI_allbutself(int vector);
-void default_send_IPI_all(int vector);
-void default_send_IPI_self(int vector);
 #endif


