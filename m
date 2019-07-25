Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701F3C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4524321901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="B41EQv6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfGYOfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:35:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42019 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGYOfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:35:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEZaea1041604
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:35:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEZaea1041604
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564065337;
        bh=toiFBANopWShzu1Mx5HLB113RH40QXcaqUbN2Vzib2Y=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=B41EQv6I+m2dBeMmdvVxNNSnONgXSMmpWUk+JsQ3bqGzjkenvjq9Ktf4SYgRstcyv
         DP4B6njR/2djt7SBvwIvXJXmiGPOn6V0+laCSv+rC94ypo+qrubw7lAp6JlgdoqTgQ
         OdOm+PJGZDiPVM5HOHUBZSpJl+HB/uokyyv3lt9nZ20y9fUWf6R/mjmXlkAzoZqaUh
         eb59+EPC0eFExp/Mky3Azm7aU58819GrsJczenO5Mfa20T9SsIWx6g3owVeTxldaz6
         /vYTZ3Te5/WVgrT46mvDfAhsV8tqCEctxYjRKLBcyJYDv+p9uf8BjM80lNjSNi9DCK
         4Mz4G6e02wDFA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEZaC51041601;
        Thu, 25 Jul 2019 07:35:36 -0700
Date:   Thu, 25 Jul 2019 07:35:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-dea978632e8400b84888bad20df0cd91c18f0aec@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20190722105220.951534451@linutronix.de>
References: <20190722105220.951534451@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Share common IPI helpers
Git-Commit-ID: dea978632e8400b84888bad20df0cd91c18f0aec
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

Commit-ID:  dea978632e8400b84888bad20df0cd91c18f0aec
Gitweb:     https://git.kernel.org/tip/dea978632e8400b84888bad20df0cd91c18f0aec
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:28 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:12:02 +0200

x86/apic: Share common IPI helpers

The 64bit implementations need the same wrappers around
__default_send_IPI_shortcut() as 32bit.

Move them out of the 32bit section.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105220.951534451@linutronix.de

---
 arch/x86/kernel/apic/ipi.c   | 30 +++++++++++++++---------------
 arch/x86/kernel/apic/local.h |  6 +++---
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 71363b0d4a67..6ca0f91372fd 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -226,6 +226,21 @@ void default_send_IPI_single(int cpu, int vector)
 	apic->send_IPI_mask(cpumask_of(cpu), vector);
 }
 
+void default_send_IPI_allbutself(int vector)
+{
+	__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
+}
+
+void default_send_IPI_all(int vector)
+{
+	__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
+}
+
+void default_send_IPI_self(int vector)
+{
+	__default_send_IPI_shortcut(APIC_DEST_SELF, vector);
+}
+
 #ifdef CONFIG_X86_32
 
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask,
@@ -285,21 +300,6 @@ void default_send_IPI_mask_logical(const struct cpumask *cpumask, int vector)
 	local_irq_restore(flags);
 }
 
-void default_send_IPI_allbutself(int vector)
-{
-	__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
-}
-
-void default_send_IPI_all(int vector)
-{
-	__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
-}
-
-void default_send_IPI_self(int vector)
-{
-	__default_send_IPI_shortcut(APIC_DEST_SELF, vector);
-}
-
 /* must come after the send_IPI functions above for inlining */
 static int convert_apicid_to_cpu(int apic_id)
 {
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index 391594cd5ca9..69ba777cef98 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -56,12 +56,12 @@ void default_send_IPI_single(int cpu, int vector);
 void default_send_IPI_single_phys(int cpu, int vector);
 void default_send_IPI_mask_sequence_phys(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_allbutself_phys(const struct cpumask *mask, int vector);
+void default_send_IPI_allbutself(int vector);
+void default_send_IPI_all(int vector);
+void default_send_IPI_self(int vector);
 
 #ifdef CONFIG_X86_32
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_logical(const struct cpumask *mask, int vector);
-void default_send_IPI_allbutself(int vector);
-void default_send_IPI_all(int vector);
-void default_send_IPI_self(int vector);
 #endif
