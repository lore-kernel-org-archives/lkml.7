Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36743C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21C121901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="h1gDyByv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388442AbfGYOcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:32:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44587 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387460AbfGYOcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:32:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEWgHI1041006
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:32:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEWgHI1041006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564065162;
        bh=N4iAT71LA6XGfbF9tPy4FRP7LIWxR1aOQDqTy2iClgY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=h1gDyByvu4M2rUejDD3IGBsxWXiOMX9feRfdTHc6AxZPVI/61RFKihYMMJFwPVRCB
         vWLIuzZyCYOW25EOnYeKj3yZzK55LMSBt0Tg2lp8SEuZkSuc7+tgJDvI9nfrTA3jaI
         iDvEK4QEhq8T9c9b7UsO7BYH1lk3j/3becqxgPFODUiGdjJCUsZATzDlLDtD1+4wVc
         1RHAvxekgRcJvONOmWbiZX4Y5c9Y/NZn0KOB0uXUp16HVVpzD1ZLc4E82n4zMEA6I/
         XcaY7pKH12IKAAxWx+Y5Ok3ByTO55cUzv31OPiAuStgDMt3cIrpYJVlzeShQ9qBIgI
         FQOUzfiWrqMqw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEWfll1041003;
        Thu, 25 Jul 2019 07:32:41 -0700
Date:   Thu, 25 Jul 2019 07:32:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-22ca7ee933a39f542ff6f81fc64f8036eff56519@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          peterz@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190722105220.492691679@linutronix.de>
References: <20190722105220.492691679@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Provide and use helper for
 send_IPI_allbutself()
Git-Commit-ID: 22ca7ee933a39f542ff6f81fc64f8036eff56519
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

Commit-ID:  22ca7ee933a39f542ff6f81fc64f8036eff56519
Gitweb:     https://git.kernel.org/tip/22ca7ee933a39f542ff6f81fc64f8036eff56519
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:23 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:12:00 +0200

x86/apic: Provide and use helper for send_IPI_allbutself()

To support IPI shorthands wrap invocations of apic->send_IPI_allbutself()
in a helper function, so the static key controlling the shorthand mode is
only in one place.

Fixup all callers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105220.492691679@linutronix.de

---
 arch/x86/include/asm/apic.h |  2 ++
 arch/x86/kernel/apic/ipi.c  | 12 ++++++++++++
 arch/x86/kernel/kgdb.c      |  2 +-
 arch/x86/kernel/reboot.c    |  7 +------
 arch/x86/kernel/smp.c       |  4 ++--
 5 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 4a0d349ab44d..de86c6c15228 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -177,6 +177,8 @@ extern void lapic_online(void);
 extern void lapic_offline(void);
 extern bool apic_needs_pit(void);
 
+extern void apic_send_IPI_allbutself(unsigned int vector);
+
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
 #define local_apic_timer_c2_ok		1
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 5bd8a001a887..f53de3e0145e 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -50,6 +50,18 @@ void apic_smt_update(void)
 		static_branch_enable(&apic_use_ipi_shorthand);
 	}
 }
+
+void apic_send_IPI_allbutself(unsigned int vector)
+{
+	if (num_online_cpus() < 2)
+		return;
+
+	if (static_branch_likely(&apic_use_ipi_shorthand))
+		apic->send_IPI_allbutself(vector);
+	else
+		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
+}
+
 #endif /* CONFIG_SMP */
 
 static inline int __prepare_ICR2(unsigned int mask)
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index a53dfb09880f..c44fe7d8d9a4 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -416,7 +416,7 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
  */
 void kgdb_roundup_cpus(void)
 {
-	apic->send_IPI_allbutself(NMI_VECTOR);
+	apic_send_IPI_allbutself(NMI_VECTOR);
 }
 #endif
 
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 09d6bded3c1e..0cc7c0b106bb 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -828,11 +828,6 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 	return NMI_HANDLED;
 }
 
-static void smp_send_nmi_allbutself(void)
-{
-	apic->send_IPI_allbutself(NMI_VECTOR);
-}
-
 /*
  * Halt all other CPUs, calling the specified function on each of them
  *
@@ -861,7 +856,7 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 	 */
 	wmb();
 
-	smp_send_nmi_allbutself();
+	apic_send_IPI_allbutself(NMI_VECTOR);
 
 	/* Kick CPUs looping in NMI context. */
 	WRITE_ONCE(crash_ipi_issued, 1);
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 231fa230ebc7..b8ad1876a081 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -215,7 +215,7 @@ static void native_stop_other_cpus(int wait)
 		/* sync above data before sending IRQ */
 		wmb();
 
-		apic->send_IPI_allbutself(REBOOT_VECTOR);
+		apic_send_IPI_allbutself(REBOOT_VECTOR);
 
 		/*
 		 * Don't wait longer than a second for IPI completion. The
@@ -241,7 +241,7 @@ static void native_stop_other_cpus(int wait)
 
 			pr_emerg("Shutting down cpus with NMI\n");
 
-			apic->send_IPI_allbutself(NMI_VECTOR);
+			apic_send_IPI_allbutself(NMI_VECTOR);
 		}
 		/*
 		 * Don't wait longer than 10 ms if the caller didn't
