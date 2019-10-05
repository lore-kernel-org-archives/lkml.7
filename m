Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C584CC3E8AB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 11:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AFF222C5
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 11:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfJEL2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 07:28:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40128 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfJEL2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 07:28:13 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iGiEL-0007UH-Tx; Sat, 05 Oct 2019 11:28:10 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com
Cc:     bsingharora@gmail.com, elver@google.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH] taskstats: fix data-race
Date:   Sat,  5 Oct 2019 13:28:06 +0200
Message-Id: <20191005112806.13960-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <0000000000009b403005942237bf@google.com>
References: <0000000000009b403005942237bf@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When assiging and testing taskstats in taskstats
taskstats_exit() there's a race around writing and reading sig->stats.

cpu0:
task calls exit()
do_exit()
	-> taskstats_exit()
		-> taskstats_tgid_alloc()
The task takes sighand lock and assigns new stats to sig->stats.

cpu1:
task catches signal
do_exit()
	-> taskstats_tgid_alloc()
		-> taskstats_exit()
The tasks reads sig->stats __without__ holding sighand lock seeing
garbage.

Fix this by taking sighand lock when reading sig->stats.

Reported-by: syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 kernel/taskstats.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 13a0f2e6ebc2..58b145234c4a 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -553,26 +553,32 @@ static int taskstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
 
 static struct taskstats *taskstats_tgid_alloc(struct task_struct *tsk)
 {
+	int empty;
+	struct taskstats *stats_new, *stats = NULL;
 	struct signal_struct *sig = tsk->signal;
-	struct taskstats *stats;
-
-	if (sig->stats || thread_group_empty(tsk))
-		goto ret;
 
 	/* No problem if kmem_cache_zalloc() fails */
-	stats = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
+	stats_new = kmem_cache_zalloc(taskstats_cache, GFP_KERNEL);
+
+	empty = thread_group_empty(tsk);
 
 	spin_lock_irq(&tsk->sighand->siglock);
+	if (sig->stats || empty) {
+		stats = sig->stats;
+		spin_unlock_irq(&tsk->sighand->siglock);
+		goto free_cache;
+	}
+
 	if (!sig->stats) {
-		sig->stats = stats;
-		stats = NULL;
+		sig->stats = stats_new;
+		spin_unlock_irq(&tsk->sighand->siglock);
+		return stats_new;
 	}
 	spin_unlock_irq(&tsk->sighand->siglock);
 
-	if (stats)
-		kmem_cache_free(taskstats_cache, stats);
-ret:
-	return sig->stats;
+free_cache:
+	kmem_cache_free(taskstats_cache, stats_new);
+	return stats;
 }
 
 /* Send pid data out on exit */
-- 
2.23.0

