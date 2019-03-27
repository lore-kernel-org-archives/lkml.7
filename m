Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EAFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA32D2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713796;
	bh=zaDTXdjfMbS1jH6Z8XQbqs5o4+9CDRqddkzitMiCk88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QV3MmGusS2WcCIKouDmkztjqCgASeYlPTe3JDiKNld2pCMPLamqJdOKYk5i0/on5Y
	 m+M/KUsSEiHyr5JytpNisj6DWnoSV081VphDAjTbVWz4pWLAomcnILtVo5Z+QcOtAa
	 71950lxeNKL9ci6Lrnu0qWV8M7m9XUlqvOqpzDZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389682AbfC0TJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388290AbfC0SLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:11:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD5AE217D9;
        Wed, 27 Mar 2019 18:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710282;
        bh=zaDTXdjfMbS1jH6Z8XQbqs5o4+9CDRqddkzitMiCk88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VKlNssHhxj4zueWC9ePvlj07yw0oUNnGTIHsgpC8XjXceE2o2mPQoUgHvpg0IZCSz
         rdx5qOyznXeG7LTBSr7DL2Xum/jXU0p8TTh/5NZ18iiuUeiwWlIyUi4tkX5wqLHBEQ
         OdhQy6AEdsYeGKh2lx9KKzxJ/R3/FfRUWqKW9Bf4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 031/192] f2fs: do not use mutex lock in atomic context
Date:   Wed, 27 Mar 2019 14:07:43 -0400
Message-Id: <20190327181025.13507-31-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sahitya Tummala <stummala@codeaurora.org>

[ Upstream commit 9083977dabf3833298ddcd40dee28687f1e6b483 ]

Fix below warning coming because of using mutex lock in atomic context.

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:98
in_atomic(): 1, irqs_disabled(): 0, pid: 585, name: sh
Preemption disabled at: __radix_tree_preload+0x28/0x130
Call trace:
 dump_backtrace+0x0/0x2b4
 show_stack+0x20/0x28
 dump_stack+0xa8/0xe0
 ___might_sleep+0x144/0x194
 __might_sleep+0x58/0x8c
 mutex_lock+0x2c/0x48
 f2fs_trace_pid+0x88/0x14c
 f2fs_set_node_page_dirty+0xd0/0x184

Do not use f2fs_radix_tree_insert() to avoid doing cond_resched() with
spin_lock() acquired.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/trace.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
index a1fcd00bbb2b..8ac1851a21c0 100644
--- a/fs/f2fs/trace.c
+++ b/fs/f2fs/trace.c
@@ -17,7 +17,7 @@
 #include "trace.h"
 
 static RADIX_TREE(pids, GFP_ATOMIC);
-static struct mutex pids_lock;
+static spinlock_t pids_lock;
 static struct last_io_info last_io;
 
 static inline void __print_last_io(void)
@@ -61,23 +61,29 @@ void f2fs_trace_pid(struct page *page)
 
 	set_page_private(page, (unsigned long)pid);
 
+retry:
 	if (radix_tree_preload(GFP_NOFS))
 		return;
 
-	mutex_lock(&pids_lock);
+	spin_lock(&pids_lock);
 	p = radix_tree_lookup(&pids, pid);
 	if (p == current)
 		goto out;
 	if (p)
 		radix_tree_delete(&pids, pid);
 
-	f2fs_radix_tree_insert(&pids, pid, current);
+	if (radix_tree_insert(&pids, pid, current)) {
+		spin_unlock(&pids_lock);
+		radix_tree_preload_end();
+		cond_resched();
+		goto retry;
+	}
 
 	trace_printk("%3x:%3x %4x %-16s\n",
 			MAJOR(inode->i_sb->s_dev), MINOR(inode->i_sb->s_dev),
 			pid, current->comm);
 out:
-	mutex_unlock(&pids_lock);
+	spin_unlock(&pids_lock);
 	radix_tree_preload_end();
 }
 
@@ -122,7 +128,7 @@ void f2fs_trace_ios(struct f2fs_io_info *fio, int flush)
 
 void f2fs_build_trace_ios(void)
 {
-	mutex_init(&pids_lock);
+	spin_lock_init(&pids_lock);
 }
 
 #define PIDVEC_SIZE	128
@@ -150,7 +156,7 @@ void f2fs_destroy_trace_ios(void)
 	pid_t next_pid = 0;
 	unsigned int found;
 
-	mutex_lock(&pids_lock);
+	spin_lock(&pids_lock);
 	while ((found = gang_lookup_pids(pid, next_pid, PIDVEC_SIZE))) {
 		unsigned idx;
 
@@ -158,5 +164,5 @@ void f2fs_destroy_trace_ios(void)
 		for (idx = 0; idx < found; idx++)
 			radix_tree_delete(&pids, pid[idx]);
 	}
-	mutex_unlock(&pids_lock);
+	spin_unlock(&pids_lock);
 }
-- 
2.19.1

