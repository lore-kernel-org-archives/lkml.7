Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6668CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812082087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbfJ2JfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:35:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:48532 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726096AbfJ2JfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:35:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11C1EB325;
        Tue, 29 Oct 2019 09:35:13 +0000 (UTC)
To:     the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>, bsd@redhat.com
From:   Jan Beulich <jbeulich@suse.com>
Subject: [PATCH] x86/apic/32: avoid bogus LDR warnings
Message-ID: <666d8f91-b5a8-1afd-7add-821e72a35f03@suse.com>
Date:   Tue, 29 Oct 2019 10:34:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The removal of the LDR initialization for bigsmp has surfaced a warning per AP:

WARNING: CPU: 1 PID: 0 at arch/x86/kernel/apic/apic.c:1626 setup_local_APIC.cold+0x26/0x8c
Modules linked in:
Supported: No, Unreleased kernel
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.3.4-2019-10-04-jb32 #3 SLE0 (unreleased)
Hardware name: Dell Inc. Precision Tower 7810/0GWHMW, BIOS A27 06/25/2018
EIP: setup_local_APIC.cold+0x5b/0xc5
Code: ...
EAX: 00000024 EBX: 00000000 ECX: c15947f8 EDX: 00200082
ESI: 00000002 EDI: 00000001 EBP: 00000000 ESP: e9887f38
DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00210096
CR0: 80050033 CR2: 00000000 CR3: 0164f000 CR4: 001406b0
Call Trace:
 ? vprintk_default+0xf/0x20
 ? fpu__init_cpu_generic+0x5c/0x60
 ? cpu_init+0x174/0x330
 ? apic_ap_setup+0x5/0x10
 ? start_secondary+0x4d/0x180
 ? startup_32_smp+0x164/0x168

Only do the check and override when the APIC is actually run in a setup
using logical destination mode.

Fixes: bae3a8d3308 ("x86/apic: Do not initialize LDR and DFR for bigsmp")
Signed-off-by: Jan Beulich <jbeulich@suse.com>

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1586,9 +1586,6 @@ static void setup_local_APIC(void)
 {
 	int cpu = smp_processor_id();
 	unsigned int value;
-#ifdef CONFIG_X86_32
-	int logical_apicid, ldr_apicid;
-#endif
 
 	if (disable_apic) {
 		disable_ioapic_support();
@@ -1626,16 +1623,21 @@ static void setup_local_APIC(void)
 	apic->init_apic_ldr();
 
 #ifdef CONFIG_X86_32
-	/*
-	 * APIC LDR is initialized.  If logical_apicid mapping was
-	 * initialized during get_smp_config(), make sure it matches the
-	 * actual value.
-	 */
-	logical_apicid = early_per_cpu(x86_cpu_to_logical_apicid, cpu);
-	ldr_apicid = GET_APIC_LOGICAL_ID(apic_read(APIC_LDR));
-	WARN_ON(logical_apicid != BAD_APICID && logical_apicid != ldr_apicid);
-	/* always use the value from LDR */
-	early_per_cpu(x86_cpu_to_logical_apicid, cpu) = ldr_apicid;
+	if (apic->dest_logical) {
+		int logical_apicid, ldr_apicid;
+
+		/*
+		 * APIC LDR is initialized.  If logical_apicid mapping was
+		 * initialized during get_smp_config(), make sure it matches
+		 * the actual value.
+		 */
+		logical_apicid = early_per_cpu(x86_cpu_to_logical_apicid, cpu);
+		ldr_apicid = GET_APIC_LOGICAL_ID(apic_read(APIC_LDR));
+		if (logical_apicid != BAD_APICID)
+			WARN_ON(logical_apicid != ldr_apicid);
+		/* Always use the value from LDR. */
+		early_per_cpu(x86_cpu_to_logical_apicid, cpu) = ldr_apicid;
+	}
 #endif
 
 	/*
