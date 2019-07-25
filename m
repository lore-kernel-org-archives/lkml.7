Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07BFC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9904F21901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QW0w2cwR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbfGYO35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:29:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58571 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfGYO34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:29:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PETkRx1040460
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:29:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PETkRx1040460
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564064986;
        bh=m7i+lQ5M3WfjqYcaz4/SJINxKzCuUBmdzSlgmOBVRDk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=QW0w2cwR+GNpYcMqmHUuqAKry5tBb6ei6sYCFgpzS6MitKXvjN0wbSrguSG6GBmeT
         btJyaw2HsW6e6mNk4LrNtH+Lvnjj4ThzuCfIXNwvLw8FUOHFKsDJpVF9XVj2Cmh7kH
         U72IlKRM7GQMXiwBMxBxbAIZu5j/PyICsrcPv7QsLeIZCYxX9agaehFX63TX0TRB1/
         PJENN9srywxELstkRN5CJFwfinRyEVpEeoSuEgc4w0KFAG43BA3L230jnSooFiuMAB
         4cog5gAIXu5HOjc05kBN+XdFXZnSz2CMURiGDfA9lhAxx5l5frSrAXlHdCFIGBfBEW
         rw1InddIrQP/Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PETkwE1040457;
        Thu, 25 Jul 2019 07:29:46 -0700
Date:   Thu, 25 Jul 2019 07:29:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-3994ff90acc3b115734fe532720c37a499c502ce@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hpa@zytor.com, peterz@infradead.org
In-Reply-To: <20190722105220.094613426@linutronix.de>
References: <20190722105220.094613426@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Remove dest argument from
 __default_send_IPI_shortcut()
Git-Commit-ID: 3994ff90acc3b115734fe532720c37a499c502ce
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

Commit-ID:  3994ff90acc3b115734fe532720c37a499c502ce
Gitweb:     https://git.kernel.org/tip/3994ff90acc3b115734fe532720c37a499c502ce
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:19 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:11:59 +0200

x86/apic: Remove dest argument from __default_send_IPI_shortcut()

The SDM states:

  "The destination shorthand field of the ICR allows the delivery mode to be
   by-passed in favor of broadcasting the IPI to all the processors on the
   system bus and/or back to itself (see Section 10.6.1, Interrupt Command
   Register (ICR)). Three destination shorthands are supported: self, all
   excluding self, and all including self. The destination mode is ignored
   when a destination shorthand is used."

So there is no point to supply the destination mode to the shorthand
delivery function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105220.094613426@linutronix.de

---
 arch/x86/kernel/apic/apic_flat_64.c |  6 ++----
 arch/x86/kernel/apic/ipi.c          | 15 +++++++--------
 arch/x86/kernel/apic/local.h        |  2 +-
 arch/x86/kernel/apic/probe_64.c     |  2 +-
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index f8594b844637..004611a44962 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -90,8 +90,7 @@ static void flat_send_IPI_allbutself(int vector)
 			_flat_send_IPI_mask(mask, vector);
 		}
 	} else if (num_online_cpus() > 1) {
-		__default_send_IPI_shortcut(APIC_DEST_ALLBUT,
-					    vector, apic->dest_logical);
+		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
 	}
 }
 
@@ -100,8 +99,7 @@ static void flat_send_IPI_all(int vector)
 	if (vector == NMI_VECTOR) {
 		flat_send_IPI_mask(cpu_online_mask, vector);
 	} else {
-		__default_send_IPI_shortcut(APIC_DEST_ALLINC,
-					    vector, apic->dest_logical);
+		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
 	}
 }
 
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 6fa9f6ca7eef..50c9dcc6f60e 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -16,7 +16,7 @@ static inline void __xapic_wait_icr_idle(void)
 		cpu_relax();
 }
 
-void __default_send_IPI_shortcut(unsigned int shortcut, int vector, unsigned int dest)
+void __default_send_IPI_shortcut(unsigned int shortcut, int vector)
 {
 	/*
 	 * Subtle. In the case of the 'never do double writes' workaround
@@ -33,9 +33,10 @@ void __default_send_IPI_shortcut(unsigned int shortcut, int vector, unsigned int
 	__xapic_wait_icr_idle();
 
 	/*
-	 * No need to touch the target chip field
+	 * No need to touch the target chip field. Also the destination
+	 * mode is ignored when a shorthand is used.
 	 */
-	cfg = __prepare_ICR(shortcut, vector, dest);
+	cfg = __prepare_ICR(shortcut, vector, 0);
 
 	/*
 	 * Send the IPI. The write to APIC_ICR fires this off.
@@ -202,8 +203,7 @@ void default_send_IPI_allbutself(int vector)
 	if (no_broadcast || vector == NMI_VECTOR) {
 		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
 	} else {
-		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector,
-					    apic->dest_logical);
+		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
 	}
 }
 
@@ -212,14 +212,13 @@ void default_send_IPI_all(int vector)
 	if (no_broadcast || vector == NMI_VECTOR) {
 		apic->send_IPI_mask(cpu_online_mask, vector);
 	} else {
-		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector,
-					    apic->dest_logical);
+		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
 	}
 }
 
 void default_send_IPI_self(int vector)
 {
-	__default_send_IPI_shortcut(APIC_DEST_SELF, vector, apic->dest_logical);
+	__default_send_IPI_shortcut(APIC_DEST_SELF, vector);
 }
 
 /* must come after the send_IPI functions above for inlining */
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index 95adac0e785b..47c43381b444 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -38,7 +38,7 @@ static inline unsigned int __prepare_ICR(unsigned int shortcut, int vector,
 	return icr;
 }
 
-void __default_send_IPI_shortcut(unsigned int shortcut, int vector, unsigned int dest);
+void __default_send_IPI_shortcut(unsigned int shortcut, int vector);
 
 /*
  * This is used to send an IPI with no shorthand notation (the destination is
diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index e0e1e3380ea2..fb457b540e78 100644
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -40,7 +40,7 @@ void __init default_setup_apic_routing(void)
 
 void apic_send_IPI_self(int vector)
 {
-	__default_send_IPI_shortcut(APIC_DEST_SELF, vector, APIC_DEST_PHYSICAL);
+	__default_send_IPI_shortcut(APIC_DEST_SELF, vector);
 }
 
 int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
