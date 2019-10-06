Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCFBC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 23:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826D02077B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 23:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfJFXw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 19:52:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60462 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfJFXw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 19:52:28 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iHGK9-0002Y6-HK; Sun, 06 Oct 2019 23:52:25 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     christian.brauner@ubuntu.com
Cc:     bsingharora@gmail.com, elver@google.com,
        linux-kernel@vger.kernel.org,
        syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH] taskstats: fix data-race
Date:   Mon,  7 Oct 2019 01:52:16 +0200
Message-Id: <20191006235216.7483-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191005112806.13960-1-christian.brauner@ubuntu.com>
References: <20191005112806.13960-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When assiging and testing taskstats in taskstats_exit() there's a race
when writing and reading sig->stats when a thread-group with more than
one thread exits:

cpu0:
thread catches fatal signal and whole thread-group gets taken down
 do_exit()
 do_group_exit()
 taskstats_exit()
 taskstats_tgid_alloc()
The tasks reads sig->stats holding sighand lock seeing garbage.

cpu1:
task calls exit_group()
 do_exit()
 do_group_exit()
 taskstats_exit()
 taskstats_tgid_alloc()
The task takes sighand lock and assigns new stats to sig->stats.

Fix this by using READ_ONCE() and smp_store_release().

Reported-by: syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 */
Link: https://lore.kernel.org/r/20191005112806.13960-1-christian.brauner@ubuntu.com

/* v2 */
- Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>:
  - fix the original double-checked locking using memory barriers
---
 kernel/taskstats.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 13a0f2e6ebc2..8ee046e8a792 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -554,24 +554,25 @@ static int taskstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
 static struct taskstats *taskstats_tgid_alloc(struct task_struct *tsk)
 {
 	struct signal_struct *sig = tsk->signal;
-	struct taskstats *stats;
+	struct taskstats *stats_new, *stats;
 
-	if (sig->stats || thread_group_empty(tsk))
-		goto ret;
+	stats = READ_ONCE(sig->stats);
+	if (stats || thread_group_empty(tsk))
+		return stats;
 
 	/* No problem if kmem_cache_zalloc() fails */
-	stats = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
+	stats_new = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
 
 	spin_lock_irq(&tsk->sighand->siglock);
 	if (!sig->stats) {
-		sig->stats = stats;
-		stats = NULL;
+		smp_store_release(&sig->stats, stats_new);
+		stats_new = NULL;
 	}
 	spin_unlock_irq(&tsk->sighand->siglock);
 
-	if (stats)
-		kmem_cache_free(taskstats_cache, stats);
-ret:
+	if (stats_new)
+		kmem_cache_free(taskstats_cache, stats_new);
+
 	return sig->stats;
 }
 
-- 
2.23.0

