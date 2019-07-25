Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0D7C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974B121901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YtkdmN63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfGYOb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:31:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37561 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfGYOb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:31:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEVElc1040831
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:31:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEVElc1040831
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564065075;
        bh=hoseGCWE5nMIXSVq0mNdzHmOWD35L03iUP5wIYTL/jg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YtkdmN63ZJ9s4m3XL5lBp/Eha7kDKzoPGAm13Qds45gaxBUNQTlCRK0t46zLsRx3L
         jyZ4ZessYrD7V0cJogkTV4wDlyRemsUSWt1pIL5iTza7lj0IBHe4CLH7oCazabFF+G
         ncj8Ip/QATTcRRlsTWGYVO/PdZoq5p/wn6exaCiqNtYwXrGY/owoi3cH6lVbIrir6R
         fPD9pP92ud0U8vGzqa3Hxik0It50YZIdkPWAI+qDnP4O2oecWs8zq5/0cqCIWPgvQU
         VCiplComLDR8ZVpxP+/9KzRQvVpKQIrHrRs31zT47KBKR2SIz0Jtz2mTOi/QV5r7Jc
         QoSra8OfKKXEw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEVEpG1040828;
        Thu, 25 Jul 2019 07:31:14 -0700
Date:   Thu, 25 Jul 2019 07:31:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-bdda3b93e66085abf0b2c16bcdf471176e3c816a@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20190722105220.278327940@linutronix.de>
References: <20190722105220.278327940@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Move no_ipi_broadcast() out of 32bit
Git-Commit-ID: bdda3b93e66085abf0b2c16bcdf471176e3c816a
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

Commit-ID:  bdda3b93e66085abf0b2c16bcdf471176e3c816a
Gitweb:     https://git.kernel.org/tip/bdda3b93e66085abf0b2c16bcdf471176e3c816a
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:21 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:12:00 +0200

x86/apic: Move no_ipi_broadcast() out of 32bit

For the upcoming shorthand support for all APIC incarnations the command
line option needs to be available for 64 bit as well.

While at it, rename the control variable, make it static and mark it
__ro_after_init.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105220.278327940@linutronix.de

---
 arch/x86/kernel/apic/ipi.c      | 29 +++++++++++++++++++++++++++--
 arch/x86/kernel/apic/local.h    |  2 --
 arch/x86/kernel/apic/probe_32.c | 25 -------------------------
 3 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 7236fefde396..ca3bcdb7c4a8 100644
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
@@ -203,7 +228,7 @@ void default_send_IPI_allbutself(int vector)
 	if (num_online_cpus() < 2)
 		return;
 
-	if (no_broadcast || vector == NMI_VECTOR) {
+	if (apic_ipi_shorthand_off || vector == NMI_VECTOR) {
 		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
 	} else {
 		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
@@ -212,7 +237,7 @@ void default_send_IPI_allbutself(int vector)
 
 void default_send_IPI_all(int vector)
 {
-	if (no_broadcast || vector == NMI_VECTOR) {
+	if (apic_ipi_shorthand_off || vector == NMI_VECTOR) {
 		apic->send_IPI_mask(cpu_online_mask, vector);
 	} else {
 		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index 47c43381b444..bd074e5997b0 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -51,8 +51,6 @@ void default_send_IPI_single_phys(int cpu, int vector);
 void default_send_IPI_mask_sequence_phys(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_allbutself_phys(const struct cpumask *mask, int vector);
 
-extern int no_broadcast;
-
 #ifdef CONFIG_X86_32
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask, int vector);
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 7cc961d4f51f..0ac9fd667c99 100644
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
