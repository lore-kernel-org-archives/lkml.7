Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52A0C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44412075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfKKJco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:32:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55754 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfKKJcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:32:42 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iU63l-000379-BG; Mon, 11 Nov 2019 10:32:33 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F0E1D1C03AB;
        Mon, 11 Nov 2019 10:32:32 +0100 (CET)
Date:   Mon, 11 Nov 2019 09:32:32 -0000
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irq_work: Fix irq_work_claim() memory ordering
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191108160858.31665-3-frederic@kernel.org>
References: <20191108160858.31665-3-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <157346475270.29376.12510079913530639928.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     25269871db1ad0cbbaafd5098cbdb40c8db4ccb9
Gitweb:        https://git.kernel.org/tip/25269871db1ad0cbbaafd5098cbdb40c8db4ccb9
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 08 Nov 2019 17:08:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 11 Nov 2019 09:03:31 +01:00

irq_work: Fix irq_work_claim() memory ordering

When irq_work_claim() finds IRQ_WORK_PENDING flag already set, we just
return and don't raise a new IPI. We expect the destination to see
and handle our latest updades thanks to the pairing atomic_xchg()
in irq_work_run_list().

But cmpxchg() doesn't guarantee a full memory barrier upon failure. So
it's possible that the destination misses our latest updates.

So use atomic_fetch_or() instead that is unconditionally fully ordered
and also performs exactly what we want here and simplify the code.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191108160858.31665-3-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/irq_work.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index df0dbf4..255454a 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -29,24 +29,16 @@ static DEFINE_PER_CPU(struct llist_head, lazy_list);
  */
 static bool irq_work_claim(struct irq_work *work)
 {
-	int flags, oflags, nflags;
+	int oflags;
 
+	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED, &work->flags);
 	/*
-	 * Start with our best wish as a premise but only trust any
-	 * flag value after cmpxchg() result.
+	 * If the work is already pending, no need to raise the IPI.
+	 * The pairing atomic_xchg() in irq_work_run() makes sure
+	 * everything we did before is visible.
 	 */
-	flags = atomic_read(&work->flags) & ~IRQ_WORK_PENDING;
-	for (;;) {
-		nflags = flags | IRQ_WORK_CLAIMED;
-		oflags = atomic_cmpxchg(&work->flags, flags, nflags);
-		if (oflags == flags)
-			break;
-		if (oflags & IRQ_WORK_PENDING)
-			return false;
-		flags = oflags;
-		cpu_relax();
-	}
-
+	if (oflags & IRQ_WORK_PENDING)
+		return false;
 	return true;
 }
 
