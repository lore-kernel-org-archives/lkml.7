Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C966C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFAB21901
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ldpu2DBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfGYOfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:35:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42149 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGYOfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:35:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEYqLZ1041492
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:34:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEYqLZ1041492
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564065293;
        bh=dzRXLwICJs05qEhjaUnllj551q3kE/mxDStl4a7zD20=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ldpu2DBf8AVi8BlKdTilbXxheyR8/a2fT5ko2VK7feVXy80FNkPdGiEGwFxZ42enD
         xI9yMantsAsnFSVsu31iMOQrIVBQ6/5Stxpd34ZRjlpxQaUpneDjrMULZZEYWUoozI
         3ECgb/JcoSe/86/VNUwOBq8Id+GKgnusJYxblO86Ow5FEmb2Ft/kToeNjMeyDd2lWY
         sNZcZtjzZYr5kFpo+xaWUST1YBG1Nh/nSBk7e6a0DuuHHcfenCAGkybqeLNizIsI8q
         vuQ1IbIs3sp/CfFeF8IYscN2rMa8EkBpKOQtXjcC8G0s03VQnISBhwXj7/XebbLTGR
         YrIbYsy7YeZXA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEYq4h1041489;
        Thu, 25 Jul 2019 07:34:52 -0700
Date:   Thu, 25 Jul 2019 07:34:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-1f0ad660488b8eb2450d1834af6a156104281194@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org
In-Reply-To: <20190722105220.860244707@linutronix.de>
References: <20190722105220.860244707@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Remove the shorthand decision logic
Git-Commit-ID: 1f0ad660488b8eb2450d1834af6a156104281194
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

Commit-ID:  1f0ad660488b8eb2450d1834af6a156104281194
Gitweb:     https://git.kernel.org/tip/1f0ad660488b8eb2450d1834af6a156104281194
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:27 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:12:02 +0200

x86/apic: Remove the shorthand decision logic

All callers of apic->send_IPI_all() and apic->send_IPI_allbutself() contain
the decision logic for shorthand invocation already and invoke
send_IPI_mask() if the prereqisites are not satisfied.

Remove the now redundant decision logic in the 32bit implementation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105220.860244707@linutronix.de

---
 arch/x86/kernel/apic/ipi.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 117ee2323f59..71363b0d4a67 100644
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
@@ -293,27 +287,12 @@ void default_send_IPI_mask_logical(const struct cpumask *cpumask, int vector)
 
 void default_send_IPI_allbutself(int vector)
 {
-	/*
-	 * if there are no other CPUs in the system then we get an APIC send
-	 * error if we try to broadcast, thus avoid sending IPIs in this case.
-	 */
-	if (num_online_cpus() < 2)
-		return;
-
-	if (apic_ipi_shorthand_off || vector == NMI_VECTOR) {
-		apic->send_IPI_mask_allbutself(cpu_online_mask, vector);
-	} else {
-		__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
-	}
+	__default_send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
 }
 
 void default_send_IPI_all(int vector)
 {
-	if (apic_ipi_shorthand_off || vector == NMI_VECTOR) {
-		apic->send_IPI_mask(cpu_online_mask, vector);
-	} else {
-		__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
-	}
+	__default_send_IPI_shortcut(APIC_DEST_ALLINC, vector);
 }
 
 void default_send_IPI_self(int vector)
