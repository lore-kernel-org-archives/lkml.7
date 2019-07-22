Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A712EC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8611421E70
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbfGVS5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:57:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38176 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbfGVS5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:57:14 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpdUm-0002Sd-Bu; Mon, 22 Jul 2019 20:57:12 +0200
Message-Id: <20190722105220.860244707@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 22 Jul 2019 20:47:27 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [patch V3 22/25] x86/apic: Remove the shorthand decision logic
References: <20190722104705.550071814@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All callers of apic->send_IPI_all() and apic->send_IPI_allbutself() contain
the decision logic for shorthand invocation already and invoke
send_IPI_mask() if the prereqisites are not satisfied.

Remove the now redundant decision logic in the 32bit implementation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Remove the decision logic now that it is already done in the callers
---
 arch/x86/kernel/apic/ipi.c |   27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -8,13 +8,7 @@
 DEFINE_STATIC_KEY_FALSE(apic_use_ipi_shorthand);
 
 #ifdef CONFIG_SMP
-#ifdef CONFIG_HOTPLUG_CPU
-#define DEFAULT_SEND_IPI	(1)
-#else
-#define DEFAULT_SEND_IPI	(0)
-#endif
-
-static int apic_ipi_shorthand_off __ro_after_init = DEFAULT_SEND_IPI;
+static int apic_ipi_shorthand_off __ro_after_init;
 
 static __init int apic_ipi_shorthand(char *str)
 {
@@ -293,27 +287,12 @@ void default_send_IPI_mask_logical(const
 
 void default_send_IPI_allbutself(int vector)
 {
-	/*
-	 * if there are no other CPUs in the system then we get an APIC send
-	 * error if we try to broadcast, thus avoid sending IPIs in this case.
-	 */
-	if (num_online_cpus() < 2)
-		return;
-
-	if (apic_ipi_shorthand_off || vector == NMI_VECTOR) {
-		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
-	} else {
-		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
-	}
+	__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
 }
 
 void default_send_IPI_all(int vector)
 {
-	if (apic_ipi_shorthand_off || vector == NMI_VECTOR) {
-		apic->send_IPI_mask(cpu_online_mask, vector);
-	} else {
-		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
-	}
+	__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
 }
 
 void default_send_IPI_self(int vector)


