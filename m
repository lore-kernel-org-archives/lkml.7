Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD04C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CD3229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gy4YFFrG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388424AbfGYOcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:32:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44199 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387499AbfGYOcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:32:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEVwNH1040923
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:31:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEVwNH1040923
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564065119;
        bh=viAqp5PK8WBKuavBTRK/65o3+h/4xj+eiA+wD1CWSA4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gy4YFFrGcpqp12j3kRgxewagJEggmPnlhqWCWa2IT9cPYSJ9+zWxRQ1ooAVjUiG+a
         +RLjAq9b5dTZqR0zR2X8YmH777eEJ94CJYLxRH74fgnV3GiJVoT9e0Rc82irqe+1sI
         9R3K5DqrK3sqo/O/QoZZ56fNjAYTDRt61n+noS5YzJi5BH9qUCq5DKyPTNUCE3I42H
         p9A7mGSI+XAq3dMCX+L245QC4YtkuTlHkZwmN44mEDVXb9T3aNet80LFNZFBrgsdJK
         Pi7MHSspaF3Yt8C67iwEXcGvVpGCgsLxe+WZDFJkYGvKloLKOm76pTv6E35FY4qcax
         56NjRjjuTJ+sQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEVwV21040920;
        Thu, 25 Jul 2019 07:31:58 -0700
Date:   Thu, 25 Jul 2019 07:31:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-6a1cb5f5c6413222b8532722562dd1edb5fdfd38@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, hpa@zytor.com, mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20190722105220.386410643@linutronix.de>
References: <20190722105220.386410643@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Add static key to Control IPI shorthands
Git-Commit-ID: 6a1cb5f5c6413222b8532722562dd1edb5fdfd38
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6a1cb5f5c6413222b8532722562dd1edb5fdfd38
Gitweb:     https://git.kernel.org/tip/6a1cb5f5c6413222b8532722562dd1edb5fdfd38
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:22 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:12:00 +0200

x86/apic: Add static key to Control IPI shorthands

The IPI shorthand functionality delivers IPI/NMI broadcasts to all CPUs in
the system. This can have similar side effects as the MCE broadcasting when
CPUs are waiting in the BIOS or are offlined.

The kernel tracks already the state of offlined CPUs whether they have been
brought up at least once so that the CR4 MCE bit is set to make sure that
MCE broadcasts can't brick the machine.

Utilize that information and compare it to the cpu_present_mask. If all
present CPUs have been brought up at least once then the broadcast side
effect is mitigated by disabling regular interrupt/IPI delivery in the APIC
itself and by the cpu offline check at the begin of the NMI handler.

Use a static key to switch between broadcasting via shorthands or sending
the IPI/NMI one by one.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105220.386410643@linutronix.de

---
 arch/x86/include/asm/apic.h  |  2 ++
 arch/x86/kernel/apic/ipi.c   | 24 +++++++++++++++++++++++-
 arch/x86/kernel/apic/local.h |  6 ++++++
 arch/x86/kernel/cpu/common.c |  2 ++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index cae7e0d02476..4a0d349ab44d 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -505,8 +505,10 @@ extern int default_check_phys_apicid_present(int phys_apicid);
 
 #ifdef CONFIG_SMP
 bool apic_id_is_primary_thread(unsigned int id);
+void apic_smt_update(void);
 #else
 static inline bool apic_id_is_primary_thread(unsigned int id) { return false; }
+static inline void apic_smt_update(void) { }
 #endif
 
 extern void irq_enter(void);
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index ca3bcdb7c4a8..5bd8a001a887 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -5,6 +5,8 @@
 
 #include "local.h"
 
+DEFINE_STATIC_KEY_FALSE(apic_use_ipi_shorthand);
+
 #ifdef CONFIG_SMP
 #ifdef CONFIG_HOTPLUG_CPU
 #define DEFAULT_SEND_IPI	(1)
@@ -28,7 +30,27 @@ static int __init print_ipi_mode(void)
 	return 0;
 }
 late_initcall(print_ipi_mode);
-#endif
+
+void apic_smt_update(void)
+{
+	/*
+	 * Do not switch to broadcast mode if:
+	 * - Disabled on the command line
+	 * - Only a single CPU is online
+	 * - Not all present CPUs have been at least booted once
+	 *
+	 * The latter is important as the local APIC might be in some
+	 * random state and a broadcast might cause havoc. That's
+	 * especially true for NMI broadcasting.
+	 */
+	if (apic_ipi_shorthand_off || num_online_cpus() == 1 ||
+	    !cpumask_equal(cpu_present_mask, &cpus_booted_once_mask)) {
+		static_branch_disable(&apic_use_ipi_shorthand);
+	} else {
+		static_branch_enable(&apic_use_ipi_shorthand);
+	}
+}
+#endif /* CONFIG_SMP */
 
 static inline int __prepare_ICR2(unsigned int mask)
 {
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index bd074e5997b0..391594cd5ca9 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -7,6 +7,9 @@
  * (c) 1998-99, 2000 Ingo Molnar <mingo@redhat.com>
  * (c) 2002,2003 Andi Kleen, SuSE Labs.
  */
+
+#include <linux/jump_label.h>
+
 #include <asm/apic.h>
 
 /* APIC flat 64 */
@@ -22,6 +25,9 @@ int x2apic_phys_pkg_id(int initial_apicid, int index_msb);
 void x2apic_send_IPI_self(int vector);
 
 /* IPI */
+
+DECLARE_STATIC_KEY_FALSE(apic_use_ipi_shorthand);
+
 static inline unsigned int __prepare_ICR(unsigned int shortcut, int vector,
 					 unsigned int dest)
 {
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1ee6598c5d83..e0489d2860d3 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1953,4 +1953,6 @@ void arch_smt_update(void)
 {
 	/* Handle the speculative execution misfeatures */
 	cpu_bugs_smt_update();
+	/* Check whether IPI broadcasting can be enabled */
+	apic_smt_update();
 }
