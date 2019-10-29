Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89107CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A3C20717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732880AbfJ2Jwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:52:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47786 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731075AbfJ2Jwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:52:39 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iPOAn-0004PM-D1; Tue, 29 Oct 2019 10:52:21 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F41851C04C9;
        Tue, 29 Oct 2019 10:52:20 +0100 (CET)
Date:   Tue, 29 Oct 2019 09:52:20 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] context_tracking: Introduce context_tracking_enabled_cpu()
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191016025700.31277-8-frederic@kernel.org>
References: <20191016025700.31277-8-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157234274070.29376.6106888898574236448.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     097f2541c6e51e0c1cdb1e6d46ef08a624336518
Gitweb:        https://git.kernel.org/tip/097f2541c6e51e0c1cdb1e6d46ef08a624336518
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 16 Oct 2019 04:56:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Oct 2019 10:01:13 +01:00

context_tracking: Introduce context_tracking_enabled_cpu()

This allows us to check if a remote CPU runs context tracking
(ie: is nohz_full). We'll need that to reliably support "nice"
accounting on kcpustat.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rjw@rjwysocki.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Link: https://lkml.kernel.org/r/20191016025700.31277-8-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/context_tracking_state.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 08f125f..5877177 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -31,6 +31,11 @@ static inline bool context_tracking_enabled(void)
 	return static_branch_unlikely(&context_tracking_key);
 }
 
+static inline bool context_tracking_enabled_cpu(int cpu)
+{
+	return per_cpu(context_tracking.active, cpu);
+}
+
 static inline bool context_tracking_enabled_this_cpu(void)
 {
 	return __this_cpu_read(context_tracking.active);
@@ -43,6 +48,7 @@ static inline bool context_tracking_in_user(void)
 #else
 static inline bool context_tracking_in_user(void) { return false; }
 static inline bool context_tracking_enabled(void) { return false; }
+static inline bool context_tracking_enabled_cpu(int cpu) { return false; }
 static inline bool context_tracking_enabled_this_cpu(void) { return false; }
 #endif /* CONFIG_CONTEXT_TRACKING */
 
