Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978DECA9EC6
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77308217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfJ3KEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 06:04:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51485 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfJ3KEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:04:12 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iPkpb-0008At-VY; Wed, 30 Oct 2019 11:04:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7B2D41C0072;
        Wed, 30 Oct 2019 11:03:59 +0100 (CET)
Date:   Wed, 30 Oct 2019 10:03:59 -0000
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Complain upon mutex API misuse in
 IRQ contexts
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, dave@stgolabs.net,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191025033634.3330-1-dave@stgolabs.net>
References: <20191025033634.3330-1-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <157242983900.29376.2332769194381838907.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a0855d24fc22d49cdc25664fb224caee16998683
Gitweb:        https://git.kernel.org/tip/a0855d24fc22d49cdc25664fb224caee16998683
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Thu, 24 Oct 2019 20:36:34 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 29 Oct 2019 12:22:52 +01:00

locking/mutex: Complain upon mutex API misuse in IRQ contexts

Add warning checks if mutex_trylock() or mutex_unlock() are used in
IRQ contexts, under CONFIG_DEBUG_MUTEXES=y.

While the mutex rules and semantics are explicitly documented, this allows
to expose any abusers and robustifies the whole thing.

While trylock and unlock are non-blocking, calling from IRQ context
is still forbidden (lock must be within the same context as unlock).

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dave@stgolabs.net
Link: https://lkml.kernel.org/r/20191025033634.3330-1-dave@stgolabs.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/mutex.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 5352ce5..54cc5f9 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -733,6 +733,9 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
  */
 void __sched mutex_unlock(struct mutex *lock)
 {
+#ifdef CONFIG_DEBUG_MUTEXES
+	WARN_ON(in_interrupt());
+#endif
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
 	if (__mutex_unlock_fast(lock))
 		return;
@@ -1413,6 +1416,7 @@ int __sched mutex_trylock(struct mutex *lock)
 
 #ifdef CONFIG_DEBUG_MUTEXES
 	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
+	WARN_ON(in_interrupt());
 #endif
 
 	locked = __mutex_trylock(lock);
