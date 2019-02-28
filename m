Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA01BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11EC218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374015;
	bh=Ibxb2J9TlnnhXg1xOMqOqmVKGFZX/Hu6JuSa1Dlg120=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MPH//uORZX1IRoO2J4Ry+55/e5UG6WWFgag9GoopyjtdrXHXzM6uTSNE6ig/P6cmt
	 bKCq+FOP+UF6QOYdTH0dexowPuexobONc5Gm8MjLMhQy4vEc+mVAZzJOIIcB4V6vkr
	 w2zL2AzvPxn0oIQFn5fJV8fdh+aR7UT9DXg84jKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbfB1RNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:13:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:58266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387687AbfB1RNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:13:30 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03399218E0;
        Thu, 28 Feb 2019 17:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374009;
        bh=Ibxb2J9TlnnhXg1xOMqOqmVKGFZX/Hu6JuSa1Dlg120=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZL1O33VWyb0BJ9LpsCn4OEye0KN8BPJkBCRcFUCwphtyl8UtDZ1zHdZX/+obM5Km7
         m2aUqrb3tEw4sr859HyDPDJxjA+LBk9yEepnoxVWAZ8EPHQHwwhIcuMVozGxvmURL7
         3L48PW+M64t7c84jaqbj+EY711FdkGlHWj4Zc+MI=
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
Subject: [PATCH 11/37] locking/lockdep: Save stack trace for each softirq vector involved
Date:   Thu, 28 Feb 2019 18:12:16 +0100
Message-Id: <20190228171242.32144-12-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to save as much traces as we have softirq vectors involved
in a given usage. Expand the stack trace record code accordingly.

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
 include/linux/lockdep.h  |  3 ++-
 kernel/locking/lockdep.c | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 06669f20a30a..69d2dac3d821 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -31,8 +31,9 @@ extern int lock_stat;
 /*
  * We'd rather not expose kernel/lockdep_states.h this wide, but we do need
  * the total number of states... :-(
+ * 1 bit for LOCK_USED, 4 bits for hardirqs and 4 * NR_SOFTIRQS bits
  */
-#define XXX_LOCK_USAGE_STATES		(1+2*4)
+#define XXX_LOCK_USAGE_STATES		(1 + (1 + 10) * 4)
 
 /*
  * NR_LOCKDEP_CACHING_CLASSES ... Number of classes
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 9a5f2dbc3812..a369e7de3ade 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3147,6 +3147,18 @@ static inline int separate_irq_context(struct task_struct *curr,
 
 #endif /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
 
+static int save_trace_mask(struct lock_class *class, u64 mask)
+{
+	int bit;
+
+
+	for_each_bit_nr(mask, bit)
+		if (!save_trace(class->usage_traces + bit))
+			return -1;
+
+	return 0;
+}
+
 /*
  * Mark a lock with a usage bit, and validate the state transition:
  */
@@ -3174,7 +3186,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 
 	hlock_class(this)->usage_mask |= new_mask;
 
-	if (!save_trace(hlock_class(this)->usage_traces + new_usage->bit))
+	if (save_trace_mask(hlock_class(this), new_mask) < 0)
 		return 0;
 
 	switch (new_usage->bit) {
-- 
2.21.0

