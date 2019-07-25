Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AC4C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE0C21901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TJORIaNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfGYOgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:36:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36241 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfGYOgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:36:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEaL3P1041913
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:36:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEaL3P1041913
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564065382;
        bh=qhgFm+stInfnzDs+bAC0oJ71+oVPFsEfCxYmASJm62E=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TJORIaNvo5L1j8I8W9cu0k4ozV9xbJ5xYJQ93LC8OrhA2CkqvcZ0X9Y4HUUAxAEWx
         OUT7vL8IlywLzO/8U+nnEGgxbWTXKr0IJfyd6jjavGjObtuILp5ryWA1ywZiyhuvkS
         oqk4lwqYNSzfEs+kTCtZw0fHUfFyavQup+IHqvJgHGnNx90qIMwpmt9ZEBcwsu/I/J
         cQDfF2/vMj/qvAgxZBtibeX3kQfr7FXsbBgcxu1H1yqf1nQi6XjWONNgU16hNen49Z
         8/S8bgubsBwaAUv3B05mRU6SFU1YubKGbcvNH2YUCkvdkFlq33LWjU42+w4Jtbd0RC
         aEHwlqnkF0XnQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEaLAB1041910;
        Thu, 25 Jul 2019 07:36:21 -0700
Date:   Thu, 25 Jul 2019 07:36:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-2510d09e9dabc265341f164e0b45b2dfdcb7ef36@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, peterz@infradead.org, mingo@kernel.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20190722105221.042964120@linutronix.de>
References: <20190722105221.042964120@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic/flat64: Remove the IPI shorthand decision
 logic
Git-Commit-ID: 2510d09e9dabc265341f164e0b45b2dfdcb7ef36
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

Commit-ID:  2510d09e9dabc265341f164e0b45b2dfdcb7ef36
Gitweb:     https://git.kernel.org/tip/2510d09e9dabc265341f164e0b45b2dfdcb7ef36
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:29 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:12:02 +0200

x86/apic/flat64: Remove the IPI shorthand decision logic

All callers of apic->send_IPI_all() and apic->send_IPI_allbutself() contain
the decision logic for shorthand invocation already and invoke
send_IPI_mask() if the prereqisites are not satisfied.

Remove the now redundant decision logic in the APIC code and the duplicate
helper in probe_64.c.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105221.042964120@linutronix.de

---
 arch/x86/include/asm/apic.h         |  4 ---
 arch/x86/kernel/apic/apic_flat_64.c | 49 +++++--------------------------------
 arch/x86/kernel/apic/probe_64.c     |  7 ------
 3 files changed, 6 insertions(+), 54 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index de86c6c15228..2ebc17d9c72c 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -468,10 +468,6 @@ static inline unsigned default_get_apic_id(unsigned long x)
 #define TRAMPOLINE_PHYS_LOW		0x467
 #define TRAMPOLINE_PHYS_HIGH		0x469
 
-#ifdef CONFIG_X86_64
-extern void apic_send_IPI_self(int vector);
-#endif
-
 extern void generic_bigsmp_probe(void);
 
 #ifdef CONFIG_X86_LOCAL_APIC
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 004611a44962..7862b152a052 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -76,33 +76,6 @@ flat_send_IPI_mask_allbutself(const struct cpumask *cpumask, int vector)
 	_flat_send_IPI_mask(mask, vector);
 }
 
-static void flat_send_IPI_allbutself(int vector)
-{
-	int cpu = smp_processor_id();
-
-	if (IS_ENABLED(CONFIG_HOTPLUG_CPU) || vector == NMI_VECTOR) {
-		if (!cpumask_equal(cpu_online_mask, cpumask_of(cpu))) {
-			unsigned long mask = cpumask_bits(cpu_online_mask)[0];
-
-			if (cpu < BITS_PER_LONG)
-				__clear_bit(cpu, &mask);
-
-			_flat_send_IPI_mask(mask, vector);
-		}
-	} else if (num_online_cpus() > 1) {
-		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
-	}
-}
-
-static void flat_send_IPI_all(int vector)
-{
-	if (vector == NMI_VECTOR) {
-		flat_send_IPI_mask(cpu_online_mask, vector);
-	} else {
-		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
-	}
-}
-
 static unsigned int flat_get_apic_id(unsigned long x)
 {
 	return (x >> 24) & 0xFF;
@@ -164,9 +137,9 @@ static struct apic apic_flat __ro_after_init = {
 	.send_IPI			= default_send_IPI_single,
 	.send_IPI_mask			= flat_send_IPI_mask,
 	.send_IPI_mask_allbutself	= flat_send_IPI_mask_allbutself,
-	.send_IPI_allbutself		= flat_send_IPI_allbutself,
-	.send_IPI_all			= flat_send_IPI_all,
-	.send_IPI_self			= apic_send_IPI_self,
+	.send_IPI_allbutself		= default_send_IPI_allbutself,
+	.send_IPI_all			= default_send_IPI_all,
+	.send_IPI_self			= default_send_IPI_self,
 
 	.inquire_remote_apic		= default_inquire_remote_apic,
 
@@ -216,16 +189,6 @@ static void physflat_init_apic_ldr(void)
 	 */
 }
 
-static void physflat_send_IPI_allbutself(int vector)
-{
-	default_send_IPI_mask_allbutself_phys(cpu_online_mask, vector);
-}
-
-static void physflat_send_IPI_all(int vector)
-{
-	default_send_IPI_mask_sequence_phys(cpu_online_mask, vector);
-}
-
 static int physflat_probe(void)
 {
 	if (apic == &apic_physflat || num_possible_cpus() > 8 ||
@@ -267,9 +230,9 @@ static struct apic apic_physflat __ro_after_init = {
 	.send_IPI			= default_send_IPI_single_phys,
 	.send_IPI_mask			= default_send_IPI_mask_sequence_phys,
 	.send_IPI_mask_allbutself	= default_send_IPI_mask_allbutself_phys,
-	.send_IPI_allbutself		= physflat_send_IPI_allbutself,
-	.send_IPI_all			= physflat_send_IPI_all,
-	.send_IPI_self			= apic_send_IPI_self,
+	.send_IPI_allbutself		= default_send_IPI_allbutself,
+	.send_IPI_all			= default_send_IPI_all,
+	.send_IPI_self			= default_send_IPI_self,
 
 	.inquire_remote_apic		= default_inquire_remote_apic,
 
diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index fb457b540e78..29f0e0984557 100644
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -36,13 +36,6 @@ void __init default_setup_apic_routing(void)
 		x86_platform.apic_post_init();
 }
 
-/* Same for both flat and physical. */
-
-void apic_send_IPI_self(int vector)
-{
-	__default_send_IPI_shortcut(APIC_DEST_SELF, vector);
-}
-
 int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 {
 	struct apic **drv;
