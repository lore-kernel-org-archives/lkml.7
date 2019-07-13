Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB75BC742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C8A20848
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="RZyeM72T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfGMLOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 07:14:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58939 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfGMLOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 07:14:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DBESDv3842162
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 04:14:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DBESDv3842162
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563016469;
        bh=xbLonGcsH9bZ/JLV8M3Qsu8bzQL8cjTdurkGkyehD/k=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=RZyeM72TuraFcimOnvJMiqGYHB97kBKzc+AMSmufrk2PUa3uDrW3Bsw19kP5wdrQd
         LVHuJeXybmVmOuZVsBMRQwbBHbdbAGamH7eSIKqR/CNSjfyjorW498/RBGvxG3fdQo
         SSazXeHjpXeWDsKJUwiIZ6tsPBA8rX3sP4Voi0OKDbiJIRzD6DaJs1IadbROZCvMPZ
         T0XEQjKKrgRZM9ZdmNeRHvc8996Cx0aPJaUXDQoSgzUv6/AwRlaICqFzGv3s4uu9aN
         AroHXPh9Xh3BoY7veFY2URa0+ZyAoZmecmWAhjEsoJJx0RR46LXYaP7adLYGm1mHwj
         m5guVlniNhLGw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DBEQSj3842159;
        Sat, 13 Jul 2019 04:14:26 -0700
Date:   Sat, 13 Jul 2019 04:14:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-68d41d8c94a31dfb8233ab90b9baf41a2ed2da68@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, torvalds@linux-foundation.org,
        will.deacon@arm.com, cai@lca.pw, duyuyang@gmail.com,
        akpm@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: mingo@kernel.org, will.deacon@arm.com,
          torvalds@linux-foundation.org, cai@lca.pw,
          akpm@linux-foundation.org, duyuyang@gmail.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          paulmck@linux.vnet.ibm.com, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190709101522.9117-1-duyuyang@gmail.com>
References: <20190709101522.9117-1-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/lockdep: Fix lock used or unused stats
 error
Git-Commit-ID: 68d41d8c94a31dfb8233ab90b9baf41a2ed2da68
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

Commit-ID:  68d41d8c94a31dfb8233ab90b9baf41a2ed2da68
Gitweb:     https://git.kernel.org/tip/68d41d8c94a31dfb8233ab90b9baf41a2ed2da68
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Tue, 9 Jul 2019 18:15:22 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 13 Jul 2019 11:24:53 +0200

locking/lockdep: Fix lock used or unused stats error

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
---
 kernel/locking/lockdep_proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 9c49ec645d8b..65b6a1600c8f 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -210,6 +210,7 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 		      nr_hardirq_read_safe = 0, nr_hardirq_read_unsafe = 0,
 		      sum_forward_deps = 0;
 
+#ifdef CONFIG_PROVE_LOCKING
 	list_for_each_entry(class, &all_lock_classes, lock_entry) {
 
 		if (class->usage_mask == 0)
@@ -241,12 +242,12 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
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
