Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C25C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1352720857
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfDPHCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:02:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56919 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfDPHCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:02:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3G71KbM3320492
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 00:01:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3G71EgR3320489;
        Tue, 16 Apr 2019 00:01:14 -0700
Date:   Tue, 16 Apr 2019 00:01:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-8b39adbee805c539a461dbf208b125b096152b1c@git.kernel.org>
Cc:     torvalds@linux-foundation.org, will.deacon@arm.com,
        bvanassche@acm.org, linux-kernel@vger.kernel.org,
        shhuiw@foxmail.com, mingo@kernel.org, longman@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: hpa@zytor.com, mingo@kernel.org, shhuiw@foxmail.com,
          will.deacon@arm.com, torvalds@linux-foundation.org,
          bvanassche@acm.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, tglx@linutronix.de, longman@redhat.com
In-Reply-To: <20190415170538.23491-1-bvanassche@acm.org>
References: <20190415170538.23491-1-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/lockdep: Make lockdep_unregister_key()
 honor 'debug_locks' again
Git-Commit-ID: 8b39adbee805c539a461dbf208b125b096152b1c
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

Commit-ID:  8b39adbee805c539a461dbf208b125b096152b1c
Gitweb:     https://git.kernel.org/tip/8b39adbee805c539a461dbf208b125b096152b1c
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Mon, 15 Apr 2019 10:05:38 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 08:21:51 +0200

locking/lockdep: Make lockdep_unregister_key() honor 'debug_locks' again

If lockdep_register_key() and lockdep_unregister_key() are called with
debug_locks == false then the following warning is reported:

  WARNING: CPU: 2 PID: 15145 at kernel/locking/lockdep.c:4920 lockdep_unregister_key+0x1ad/0x240

That warning is reported because lockdep_unregister_key() ignores the
value of 'debug_locks' and because the behavior of lockdep_register_key()
depends on whether or not 'debug_locks' is set. Fix this inconsistency
by making lockdep_unregister_key() take 'debug_locks' again into
account.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: shenghui <shhuiw@foxmail.com>
Fixes: 90c1cba2b3b3 ("locking/lockdep: Zap lock classes even with lock debugging disabled")
Link: http://lkml.kernel.org/r/20190415170538.23491-1-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e16766ff184b..e221be724fe8 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4907,8 +4907,9 @@ void lockdep_unregister_key(struct lock_class_key *key)
 		return;
 
 	raw_local_irq_save(flags);
-	arch_spin_lock(&lockdep_lock);
-	current->lockdep_recursion = 1;
+	if (!graph_lock())
+		goto out_irq;
+
 	pf = get_pending_free();
 	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
 		if (k == key) {
@@ -4920,8 +4921,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	WARN_ON_ONCE(!found);
 	__lockdep_free_key_range(pf, key, 1);
 	call_rcu_zapped(pf);
-	current->lockdep_recursion = 0;
-	arch_spin_unlock(&lockdep_lock);
+	graph_unlock();
+out_irq:
 	raw_local_irq_restore(flags);
 
 	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
