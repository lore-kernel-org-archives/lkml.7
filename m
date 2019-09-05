Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4286C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE25206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 20:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404107AbfIEUuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:50:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44592 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404044AbfIEUuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:50:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i5yha-0001kd-KB; Thu, 05 Sep 2019 22:49:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2F3321C0DFA;
        Thu,  5 Sep 2019 22:49:58 +0200 (CEST)
Date:   Thu, 05 Sep 2019 20:49:58 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: refs/heads/timers/core] hrtimer: Add a missing bracket and hide
 `migration_base' on !SMP
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156771659817.12994.13601627409989265457.tip-bot2@tip-bot2>
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

The following commit has been merged into the refs/heads/timers/core branch of tip:

Commit-ID:     5d2295f3a93b04986d069ebeaf5b07725f9096c1
Gitweb:        https://git.kernel.org/tip/5d2295f3a93b04986d069ebeaf5b07725f9096c1
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 04 Sep 2019 16:55:27 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 05 Sep 2019 10:39:06 +02:00

hrtimer: Add a missing bracket and hide `migration_base' on !SMP

The recent change to avoid taking the expiry lock when a timer is currently
migrated missed to add a bracket at the end of the if statement leading to
compile errors.  Since that commit the variable `migration_base' is always
used but it is only available on SMP configuration thus leading to another
compile error.  The changelog says "The timer base and base->cpu_base
cannot be NULL in the code path", so it is safe to limit this check to SMP
configurations only.

Add the missing bracket to the if statement and hide `migration_base'
behind CONFIG_SMP bars.

[ tglx: Mark the functions inline ... ]

Fixes: 68b2c8c1e4210 ("hrtimer: Don't take expiry_lock when timer is currently migrated")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190904145527.eah7z56ntwobqm6j@linutronix.de

---
 kernel/time/hrtimer.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index ebbd0fb..0d4dc24 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -140,6 +140,11 @@ static struct hrtimer_cpu_base migration_cpu_base = {
 
 #define migration_base	migration_cpu_base.clock_base[0]
 
+static inline bool is_migration_base(struct hrtimer_clock_base *base)
+{
+	return base == &migration_base;
+}
+
 /*
  * We are using hashed locking: holding per_cpu(hrtimer_bases)[n].lock
  * means that all timers which are tied to this base via timer->base are
@@ -264,6 +269,11 @@ again:
 
 #else /* CONFIG_SMP */
 
+static inline bool is_migration_base(struct hrtimer_clock_base *base)
+{
+	return false;
+}
+
 static inline struct hrtimer_clock_base *
 lock_hrtimer_base(const struct hrtimer *timer, unsigned long *flags)
 {
@@ -1221,7 +1231,7 @@ void hrtimer_cancel_wait_running(const struct hrtimer *timer)
 	 * Just relax if the timer expires in hard interrupt context or if
 	 * it is currently on the migration base.
 	 */
-	if (!timer->is_soft || base == &migration_base)
+	if (!timer->is_soft || is_migration_base(base)) {
 		cpu_relax();
 		return;
 	}
