Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFFBC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C23522BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="165J66KA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbfGYOXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:23:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56227 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387415AbfGYOXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:23:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PENhNo1037696
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:23:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PENhNo1037696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564064623;
        bh=148jjYnmwYxq2fLtfOm/J5Td0xl/byJ87dy4YkJbQW4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=165J66KANFk7eLoK2A6LGby7t3PWqnFK54DFW6kfYkK9gnQMl09HBjzkRxJ8rOzJc
         8m3Hf6MCkb5+uXb03ujtigWXh+sy8Lc0+RQs6t4yg2hSs+5SEe2xX8PlzzbKXpV+xk
         DznuyvPsrsR/XUFjRojnprU77614c81r+cpyQJRn3+rwqNyrqPv1nmNrwZjMrRGg9M
         X2R4gkxH2DRmIaXsmjj0zo823OfHME72xIa82tkKtwDifp8NHdrbWJwf2P5mGGdX2H
         1kJiTo1xo1Wng7guiazf3ksUzCHs4ZSKUF8+TaF27VlaitfbjCwh/A2QezGbNni3rk
         MGT2nXJAZqDUg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PENgLd1037693;
        Thu, 25 Jul 2019 07:23:42 -0700
Date:   Thu, 25 Jul 2019 07:23:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-cdc86c9d1f825d13cef85d9ebd3e73572602fb48@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20190722105219.252225936@linutronix.de>
References: <20190722105219.252225936@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Move IPI inlines into ipi.c
Git-Commit-ID: cdc86c9d1f825d13cef85d9ebd3e73572602fb48
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

Commit-ID:  cdc86c9d1f825d13cef85d9ebd3e73572602fb48
Gitweb:     https://git.kernel.org/tip/cdc86c9d1f825d13cef85d9ebd3e73572602fb48
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:10 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:11:57 +0200

x86/apic: Move IPI inlines into ipi.c

No point in having them in an header file.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105219.252225936@linutronix.de

---
 arch/x86/include/asm/ipi.h | 19 -------------------
 arch/x86/kernel/apic/ipi.c | 16 +++++++++++++---
 2 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/ipi.h b/arch/x86/include/asm/ipi.h
index f73076be546a..8d4911b122f3 100644
--- a/arch/x86/include/asm/ipi.h
+++ b/arch/x86/include/asm/ipi.h
@@ -71,27 +71,8 @@ extern void default_send_IPI_mask_sequence_phys(const struct cpumask *mask,
 extern void default_send_IPI_mask_allbutself_phys(const struct cpumask *mask,
 							 int vector);
 
-/* Avoid include hell */
-#define NMI_VECTOR 0x02
-
 extern int no_broadcast;
 
-static inline void __default_local_send_IPI_allbutself(int vector)
-{
-	if (no_broadcast || vector == NMI_VECTOR)
-		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
-	else
-		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector, apic->dest_logical);
-}
-
-static inline void __default_local_send_IPI_all(int vector)
-{
-	if (no_broadcast || vector == NMI_VECTOR)
-		apic->send_IPI_mask(cpu_online_mask, vector);
-	else
-		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector, apic->dest_logical);
-}
-
 #ifdef CONFIG_X86_32
 extern void default_send_IPI_mask_sequence_logical(const struct cpumask *mask,
 							 int vector);
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 82f9244fe61f..de9764605d31 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -198,15 +198,25 @@ void default_send_IPI_allbutself(int vector)
 	 * if there are no other CPUs in the system then we get an APIC send
 	 * error if we try to broadcast, thus avoid sending IPIs in this case.
 	 */
-	if (!(num_online_cpus() > 1))
+	if (num_online_cpus() < 2)
 		return;
 
-	__default_local_send_IPI_allbutself(vector);
+	if (no_broadcast || vector == NMI_VECTOR) {
+		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
+	} else {
+		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector,
+					    apic->dest_logical);
+	}
 }
 
 void default_send_IPI_all(int vector)
 {
-	__default_local_send_IPI_all(vector);
+	if (no_broadcast || vector == NMI_VECTOR) {
+		apic->send_IPI_mask(cpu_online_mask, vector);
+	} else {
+		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector,
+					    apic->dest_logical);
+	}
 }
 
 void default_send_IPI_self(int vector)
