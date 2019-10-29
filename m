Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F6CCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C7921479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbfJ2Jwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:52:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47753 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbfJ2Jwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:52:35 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iPOAm-0004NY-IL; Tue, 29 Oct 2019 10:52:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EFE6D1C047B;
        Tue, 29 Oct 2019 10:52:19 +0100 (CET)
Date:   Tue, 29 Oct 2019 09:52:19 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] context_tracking: Check static key on
 context_tracking_enabled_*cpu()
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
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
In-Reply-To: <20191016025700.31277-11-frederic@kernel.org>
References: <20191016025700.31277-11-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157234273969.29376.9417573638381911938.tip-bot2@tip-bot2>
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

Commit-ID:     023e9deb51c9e1aafacbd421e55beadcb8e87f53
Gitweb:        https://git.kernel.org/tip/023e9deb51c9e1aafacbd421e55beadcb8e87f53
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 16 Oct 2019 04:56:56 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Oct 2019 10:01:16 +01:00

context_tracking: Check static key on context_tracking_enabled_*cpu()

guest_enter() doesn't call context_tracking_enabled() before calling
context_tracking_enabled_this_cpu(). Therefore the guest code doesn't
benefit from the static key on the fast path.

Just make sure that context_tracking_enabled_*cpu() functions check
the static key by themselves to propagate the optimization.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Rafael J . Wysocki <rjw@rjwysocki.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Link: https://lkml.kernel.org/r/20191016025700.31277-11-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/context_tracking_state.h | 4 ++--
 include/linux/vtime.h                  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 5877177..e7fe667 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -33,12 +33,12 @@ static inline bool context_tracking_enabled(void)
 
 static inline bool context_tracking_enabled_cpu(int cpu)
 {
-	return per_cpu(context_tracking.active, cpu);
+	return context_tracking_enabled() && per_cpu(context_tracking.active, cpu);
 }
 
 static inline bool context_tracking_enabled_this_cpu(void)
 {
-	return __this_cpu_read(context_tracking.active);
+	return context_tracking_enabled() && __this_cpu_read(context_tracking.active);
 }
 
 static inline bool context_tracking_in_user(void)
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index e2733bf..2cdeca0 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -33,12 +33,12 @@ static inline bool vtime_accounting_enabled(void)
 
 static inline bool vtime_accounting_enabled_cpu(int cpu)
 {
-	return (vtime_accounting_enabled() && context_tracking_enabled_cpu(cpu));
+	return context_tracking_enabled_cpu(cpu);
 }
 
 static inline bool vtime_accounting_enabled_this_cpu(void)
 {
-	return (vtime_accounting_enabled() && context_tracking_enabled_this_cpu());
+	return context_tracking_enabled_this_cpu();
 }
 
 extern void vtime_task_switch_generic(struct task_struct *prev);
