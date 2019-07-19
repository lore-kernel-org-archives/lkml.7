Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AFDC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE3921851
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509848;
	bh=pkTf96GPsvsFHL1NG2XS8lwWbwExHS7tZbx1OIsBK4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qBV5FBiQOLGWApX7Z2+4DcNA8KlNOe3++/G/o++Qb7aRHxtoSII/EYIl9LwZ19GrF
	 mqgTN42DEHjmpsCMQEJTwcGQEog15vWzCkDh7x1lvWiVyOhg+lWebS094SI1J4yCdv
	 L7jrSt8cFFLI0oxEdUKllkV0aGB6TxQifQK2pQ6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389487AbfGSER1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388822AbfGSEOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:14:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CC592189E;
        Fri, 19 Jul 2019 04:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509662;
        bh=pkTf96GPsvsFHL1NG2XS8lwWbwExHS7tZbx1OIsBK4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YLEYz4wf25mVAWkKEjXMesmuGon6xj+sV6Qby8pBkU61B/DKwLeQtrGS4xBEoKJSz
         92cRjbjkG3YC+/QhtlCgOtaZnMIBtrcf4gZn+WlRqI27iH6gV/gZWGgdakXuVB9z11
         ZEUoH/pYLPt+41FnFXAhkCdcNVC4fWGTy8YP7uvc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yuyang Du <duyuyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>, arnd@arndb.de,
        frederic@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 45/45] locking/lockdep: Fix lock used or unused stats error
Date:   Fri, 19 Jul 2019 00:13:04 -0400
Message-Id: <20190719041304.18849-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719041304.18849-1-sashal@kernel.org>
References: <20190719041304.18849-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuyang Du <duyuyang@gmail.com>

[ Upstream commit 68d41d8c94a31dfb8233ab90b9baf41a2ed2da68 ]

The stats variable nr_unused_locks is incremented every time a new lock
class is register and decremented when the lock is first used in
__lock_acquire(). And after all, it is shown and checked in lockdep_stats.

However, under configurations that either CONFIG_TRACE_IRQFLAGS or
CONFIG_PROVE_LOCKING is not defined:

The commit:

  091806515124b20 ("locking/lockdep: Consolidate lock usage bit initialization")

missed marking the LOCK_USED flag at IRQ usage initialization because
as mark_usage() is not called. And the commit:

  886532aee3cd42d ("locking/lockdep: Move mark_lock() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING")

further made mark_lock() not defined such that the LOCK_USED cannot be
marked at all when the lock is first acquired.

As a result, we fix this by not showing and checking the stats under such
configurations for lockdep_stats.

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: arnd@arndb.de
Cc: frederic@kernel.org
Link: https://lkml.kernel.org/r/20190709101522.9117-1-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/lockdep_proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index a0f61effad25..c482de6f5262 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -229,6 +229,7 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 		      nr_hardirq_read_safe = 0, nr_hardirq_read_unsafe = 0,
 		      sum_forward_deps = 0;
 
+#ifdef CONFIG_PROVE_LOCKING
 	list_for_each_entry(class, &all_lock_classes, lock_entry) {
 
 		if (class->usage_mask == 0)
@@ -260,12 +261,12 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 		if (class->usage_mask & LOCKF_ENABLED_HARDIRQ_READ)
 			nr_hardirq_read_unsafe++;
 
-#ifdef CONFIG_PROVE_LOCKING
 		sum_forward_deps += lockdep_count_forward_deps(class);
-#endif
 	}
 #ifdef CONFIG_DEBUG_LOCKDEP
 	DEBUG_LOCKS_WARN_ON(debug_atomic_read(nr_unused_locks) != nr_unused);
+#endif
+
 #endif
 	seq_printf(m, " lock-classes:                  %11lu [max: %lu]\n",
 			nr_lock_classes, MAX_LOCKDEP_KEYS);
-- 
2.20.1

