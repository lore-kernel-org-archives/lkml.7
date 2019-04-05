Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0132BC10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC1B218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbfDEPL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:11:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48967 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731662AbfDEPL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:11:27 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hCQV1-0005uy-Je; Fri, 05 Apr 2019 17:11:23 +0200
Message-Id: <20190405150930.696035459@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 05 Apr 2019 17:07:23 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch V2 25/29] x86/irq/32: Invoke irq_ctx_init() from init_IRQ()
References: <20190405150658.237064784@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq_ctx_init() is invoked from native_init_IRQ() or from xen_init_IRQ()
code. There is no reason to have this split. The interrupt stacks must be
allocated no matter what.

Invoke it from init_IRQ() before invoking the native or XEN init
implementation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
---
 arch/x86/kernel/irqinit.c        |    4 ++--
 drivers/xen/events/events_base.c |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -91,6 +91,8 @@ void __init init_IRQ(void)
 	for (i = 0; i < nr_legacy_irqs(); i++)
 		per_cpu(vector_irq, 0)[ISA_IRQ_VECTOR(i)] = irq_to_desc(i);
 
+	irq_ctx_init(smp_processor_id());
+
 	x86_init.irqs.intr_init();
 }
 
@@ -104,6 +106,4 @@ void __init native_init_IRQ(void)
 
 	if (!acpi_ioapic && !of_ioapic && nr_legacy_irqs())
 		setup_irq(2, &irq2);
-
-	irq_ctx_init(smp_processor_id());
 }
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1687,7 +1687,6 @@ void __init xen_init_IRQ(void)
 
 #ifdef CONFIG_X86
 	if (xen_pv_domain()) {
-		irq_ctx_init(smp_processor_id());
 		if (xen_initial_domain())
 			pci_xen_initial_domain();
 	}


