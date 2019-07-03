Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C446C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F741218A5
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 11:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfGCLEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:04:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51679 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfGCLEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:04:15 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hid3d-0002dI-Pz; Wed, 03 Jul 2019 13:04:13 +0200
Message-Id: <20190703105917.044463061@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 03 Jul 2019 12:54:47 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Nadav Amit <namit@vmware.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [patch 16/18] x86/apic: Convert 32bit to IPI shorthand static key
References: <20190703105431.096822793@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Broadcast now depends on the fact that all present CPUs have been booted
once so handling broadcast IPIs is not doing any harm. In case that a CPU
is offline, it does not react to regular IPIs and the NMI handler returns
early.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/ipi.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

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
@@ -250,7 +244,7 @@ void default_send_IPI_allbutself(int vec
 	if (num_online_cpus() < 2)
 		return;
 
-	if (apic_ipi_shorthand_off || vector == NMI_VECTOR) {
+	if (static_branch_likely(&apic_use_ipi_shorthand)) {
 		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
 	} else {
 		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
@@ -259,7 +253,7 @@ void default_send_IPI_allbutself(int vec
 
 void default_send_IPI_all(int vector)
 {
-	if (apic_ipi_shorthand_off || vector == NMI_VECTOR) {
+	if (static_branch_likely(&apic_use_ipi_shorthand)) {
 		apic->send_IPI_mask(cpu_online_mask, vector);
 	} else {
 		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);


