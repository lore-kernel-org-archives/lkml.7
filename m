Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B409C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E76205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfF1K3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:29:53 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:36897 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfF1K3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:29:53 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MekGB-1iEUSN2CMH-00aisc; Fri, 28 Jun 2019 12:29:22 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Yuyang Du <duyuyang@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] locking/lockdep: clean up #ifdef checks
Date:   Fri, 28 Jun 2019 12:29:03 +0200
Message-Id: <20190628102919.2345242-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8e/xrGp11CLAguE8bdi1+n04EkhlKPOQBlU5GTABjwnScXJ9Eob
 bHPV+QQKXSFk509jwouOk4slwYQkTXOpAek6xtTQJMJhI+Vr48rs/w9lIqnPPV+6VFtNS9C
 6O4DRU45klDso7IAXMdItfb/d7mm0PxsCv2RB+cWHnrC6GAJhJLdEN7ldQAxWl2Xt2hKW/p
 MZdgOe+PbvBWMj4TT09UQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oIfgM93huCo=:gXILo7squPk+PHdn2SMEaS
 YTIJ+GCtelKegLo4qmcuJ3dxiXtIZMeRjMfPeMZXjIqEmP1seFNotQW/yrKx9bKC+SF/2vinu
 bjkJxjm4b3MNbzNUF4oMhcVIrlPBOLBmvJ+JUDndYdyWgREXszgaKcZaghAyRpIA8wlBGRlnP
 wmrnJvOMUXgpDEdZGFY5/VXG3hH+SxReJZ2xByLjeG4KyxXrGCOPT+NjdqjPP8SkMTigVItVC
 NkypHY3VkpJdvmA+K31OI/8j0NiyrKcT33D9ml7BIGfbjdnzPJ5IXd+vN6xhAv9QMgTS7hDgg
 gw1jEWwjTjmhV4Nux9ltifEKMZnk8MRU6gvL6iNDni6ofkArVD+y9yBC7b7Tcag5LCt6NpRBP
 71m+0K9aGmYkaJbnWGowxOdygyQw4/95BXOxEpStUxRcDSqRhF8enYdhLYHOgg38S7143VoQ9
 p0giVODXJ161dFMMDJFMwI5AwivkjpcKIZlgpAWts6r5i/IfLIuJqa3pzcw9WDbIXPHdWl/8p
 osYABE9Ne3jgCVPw3pqwcNHxBCcwDA6zw0jw3QOT+CvA1ctQc2yaNk1JT/gFk52JpqoVHJxnt
 iKrbuiecblpYYX0kq4+3dL9gSoT44CKzxvQ1CikojAF3te4MjoBMKaYxRVTqbPtS9GycBqwW0
 3e4C4nvSaqryMAdy5XMl6ap6G2U6Vy04tcDOJjNvSh4FAh2XUnYcM5RZDw7PY4JDKXOqUj2Jt
 P3N7qb2ykiuk4zqHg79sBR5hEExDW3c0d1IFFQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Will Deacon points out, CONFIG_PROVE_LOCKING implies TRACE_IRQFLAGS,
so the conditions I added in the previous patch, and some others in the
same file can be simplified by only checking for the former.

No functional change.

Fixes: 886532aee3cd ("locking/lockdep: Move mark_lock() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/locking/lockdep.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 341f52117f88..4861cf8e274b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -448,7 +448,7 @@ static void print_lockdep_off(const char *bug_msg)
 
 unsigned long nr_stack_trace_entries;
 
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+#ifdef CONFIG_PROVE_LOCKING
 /*
  * Stack-trace: tightly packed array of stack backtrace
  * addresses. Protected by the graph_lock.
@@ -491,7 +491,7 @@ unsigned int max_lockdep_depth;
 DEFINE_PER_CPU(struct lockdep_stats, lockdep_stats);
 #endif
 
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+#ifdef CONFIG_PROVE_LOCKING
 /*
  * Locking printouts:
  */
@@ -2969,7 +2969,7 @@ static void check_chain_key(struct task_struct *curr)
 #endif
 }
 
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+#ifdef CONFIG_PROVE_LOCKING
 static int mark_lock(struct task_struct *curr, struct held_lock *this,
 		     enum lock_usage_bit new_bit);
 
@@ -3608,7 +3608,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	return ret;
 }
 
-#else /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
+#else /* CONFIG_PROVE_LOCKING */
 
 static inline int
 mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
@@ -3627,7 +3627,7 @@ static inline int separate_irq_context(struct task_struct *curr,
 	return 0;
 }
 
-#endif /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
+#endif /* CONFIG_PROVE_LOCKING */
 
 /*
  * Initialize a lock instance's lock-class mapping info:
@@ -4321,8 +4321,7 @@ static void __lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie
  */
 static void check_flags(unsigned long flags)
 {
-#if defined(CONFIG_PROVE_LOCKING) && defined(CONFIG_DEBUG_LOCKDEP) && \
-    defined(CONFIG_TRACE_IRQFLAGS)
+#if defined(CONFIG_PROVE_LOCKING) && defined(CONFIG_DEBUG_LOCKDEP)
 	if (!debug_locks)
 		return;
 
-- 
2.20.0

