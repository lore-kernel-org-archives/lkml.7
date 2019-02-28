Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5512DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255FC218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374175;
	bh=VYq8fxJu0libeGzq/JPTURequJLCJPHqKm+QOUm5Xto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ecCwHNU/WMeDPQLWOa7nuBUlJLozXXPHoR3W61Mdhc/jPQAXRyQ35Ek6Bm64tqZWW
	 pfrJ9W6Ok+eCbPMUlYmGVo8/oPmI/a0bLCU1pWtB2AwxWXdB7K74uLgZXqM4SLFYtS
	 83Hz91n4tugfR3/9KTEVE/Nph6hRx8DTiLZQR6bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbfB1RNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:13:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387557AbfB1RNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:13:17 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8A09218D8;
        Thu, 28 Feb 2019 17:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551373995;
        bh=VYq8fxJu0libeGzq/JPTURequJLCJPHqKm+QOUm5Xto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZMbx25TTgy6ltDcZvbR0AX1EEU3lU4iXGeGax718J8p7JZpcKFTtfAbtxucojj16L
         GWo0Xr+0dvJM7EeTWRD8jArtp6rIM/Hs1M7d4pgZF5pgzmHng5CCquLzYW2bhfx0A2
         56UdlADbyxT9mAMUbKrZe3CRyySbvNddk1ueyeWM=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 07/37] locking/lockdep: Prepare valid_state() to handle plain masks
Date:   Thu, 28 Feb 2019 18:12:12 +0100
Message-Id: <20190228171242.32144-8-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mark_lock_irq() is going to deal with lock usages that gather multiple
softirq vectors at once. Therefore the validation through valid_state()
will need to handle expanded usage masks.

So enhance valid_state() to that purpose.

Reviewed-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/locking/lockdep.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ac1efd16f3e7..2321b5e16cdf 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -487,7 +487,21 @@ static inline u64 lock_flag(enum lock_usage_bit bit)
 
 static u64 lock_usage_mask(struct lock_usage *usage)
 {
-	return lock_flag(usage->bit);
+	u64 vectors = usage->vector;
+	u64 mask = 0ULL;
+	int nr;
+
+	if (!vectors)
+		return lock_flag(usage->bit);
+
+	/* Only softirqs can have non-zero vectors */
+	WARN_ON_ONCE(usage->bit < LOCK_USED_IN_SOFTIRQ ||
+		     usage->bit > LOCK_ENABLED_SOFTIRQ_READ);
+
+	for_each_bit_nr(vectors, nr)
+		mask |= lock_flag(usage->bit) << (4 * nr);
+
+	return mask;
 }
 
 static char get_usage_char(struct lock_class *class, enum lock_usage_bit bit)
@@ -2558,10 +2572,23 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
  */
 static inline int
 valid_state(struct task_struct *curr, struct held_lock *this,
-	    enum lock_usage_bit new_bit, enum lock_usage_bit bad_bit)
+	    u64 new_mask, u64 bad_mask)
 {
-	if (unlikely(hlock_class(this)->usage_mask & lock_flag(bad_bit)))
+	u64 bad_intersec;
+
+	bad_intersec = hlock_class(this)->usage_mask & bad_mask;
+
+	if (unlikely(bad_intersec)) {
+		enum lock_usage_bit new_bit, bad_bit;
+		int err;
+
+		err = find_exclusive_match(new_mask,
+					   bad_intersec, &new_bit, &bad_bit);
+		if (WARN_ON_ONCE(err < 0))
+			return err;
+
 		return print_usage_bug(curr, this, bad_bit, new_bit);
+	}
 	return 1;
 }
 
@@ -2753,7 +2780,8 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	 * Validate that this particular lock does not have conflicting
 	 * usage states.
 	 */
-	if (!valid_state(curr, this, new_usage->bit, excl_usage.bit))
+	if (!valid_state(curr, this, lock_usage_mask(new_usage),
+			 lock_usage_mask(&excl_usage)))
 		return 0;
 
 	/*
@@ -2769,7 +2797,8 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	 */
 	if (!read) {
 		excl_usage.bit += LOCK_USAGE_READ_MASK;
-		if (!valid_state(curr, this, new_usage->bit, excl_usage.bit))
+		if (!valid_state(curr, this, lock_usage_mask(new_usage),
+				 lock_usage_mask(&excl_usage)))
 			return 0;
 
 		if (STRICT_READ_CHECKS &&
-- 
2.21.0

