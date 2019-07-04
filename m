Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04850C46486
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D755B218BC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfGDQen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:34:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59768 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfGDQeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:34:13 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hj4gV-0005jD-Ta; Thu, 04 Jul 2019 18:34:12 +0200
Message-Id: <20190704155610.718298800@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 04 Jul 2019 17:52:10 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch V2 25/25] x86/apic/x2apic: Implement IPI shorthands support
References: <20190704155145.617706117@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers of apic->send_IPI_all() and apic->send_IPI_allbutself() contain
the decision logic for shorthand invocation already and invoke
send_IPI_mask() if the prereqisites are not satisfied.

Implement shorthand support for x2apic.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Remove the decision logic now that it is already done in the callers
---
 arch/x86/kernel/apic/local.h          |    1 +
 arch/x86/kernel/apic/x2apic_cluster.c |    4 ++--
 arch/x86/kernel/apic/x2apic_phys.c    |   12 ++++++++++--
 3 files changed, 13 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -23,6 +23,7 @@ unsigned int x2apic_get_apic_id(unsigned
 u32 x2apic_set_apic_id(unsigned int id);
 int x2apic_phys_pkg_id(int initial_apicid, int index_msb);
 void x2apic_send_IPI_self(int vector);
+void __x2apic_send_IPI_shorthand(int vector, u32 which);
 
 /* IPI */
 
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -82,12 +82,12 @@ x2apic_send_IPI_mask_allbutself(const st
 
 static void x2apic_send_IPI_allbutself(int vector)
 {
-	__x2apic_send_IPI_mask(cpu_online_mask, vector, APIC_DEST_ALLBUT);
+	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLBUT);
 }
 
 static void x2apic_send_IPI_all(int vector)
 {
-	__x2apic_send_IPI_mask(cpu_online_mask, vector, APIC_DEST_ALLINC);
+	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLINC);
 }
 
 static u32 x2apic_calc_apicid(unsigned int cpu)
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -75,12 +75,12 @@ static void
 
 static void x2apic_send_IPI_allbutself(int vector)
 {
-	__x2apic_send_IPI_mask(cpu_online_mask, vector, APIC_DEST_ALLBUT);
+	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLBUT);
 }
 
 static void x2apic_send_IPI_all(int vector)
 {
-	__x2apic_send_IPI_mask(cpu_online_mask, vector, APIC_DEST_ALLINC);
+	__x2apic_send_IPI_shorthand(vector, APIC_DEST_ALLINC);
 }
 
 static void init_x2apic_ldr(void)
@@ -112,6 +112,14 @@ void __x2apic_send_IPI_dest(unsigned int
 	native_x2apic_icr_write(cfg, apicid);
 }
 
+void __x2apic_send_IPI_shorthand(int vector, u32 which)
+{
+	unsigned long cfg = __prepare_ICR(which, vector, 0);
+
+	x2apic_wrmsr_fence();
+	native_x2apic_icr_write(cfg, 0);
+}
+
 unsigned int x2apic_get_apic_id(unsigned long id)
 {
 	return id;


