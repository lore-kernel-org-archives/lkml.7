Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA80C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E972054F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368983;
	bh=rAcSbZ6Gr+PImTQl6O0ij9Zhh8zAH5WRkopHpYhcdFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jRwpsDn8vxMlZ1RP6PPvjvNrOkOOAUMzNKywnSGeOzJsJlibafggp51eySE5DupmR
	 kkwNDqJbmprVPI7QIf+C9hKEC22H3JfpqsKEhqAgkpHEU5iMdC1+/AdayX7QbpJcCk
	 p78ueGgLhmY4Ux+IMuA18WSHBbOv3pHHfxXHBsuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732649AbfDDJJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732858AbfDDJJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:09:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8437B20693;
        Thu,  4 Apr 2019 09:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368975;
        bh=rAcSbZ6Gr+PImTQl6O0ij9Zhh8zAH5WRkopHpYhcdFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mFhgSvATnDmkzWAY76vqHWAtut1QiUNKPxHi6IINbNsrST9qanzwue92CyImMx2CH
         v28y87F0yNRMxupicpyCTYuavbz0CDVnDIve0M17U+FAIXs/tHa4D4kXkkv0yrAE+0
         l6yDVDA2ylGBinC4BEmJBsnlnms2BEUZ8m9u+3sE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 037/246] f2fs: do not use mutex lock in atomic context
Date:   Thu,  4 Apr 2019 10:45:37 +0200
Message-Id: <20190404084620.351216498@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index ce2a5eb210b6..d0ab533a9ce8 100644
--- a/fs/f2fs/trace.c
+++ b/fs/f2fs/trace.c
@@ -14,7 +14,7 @@
 #include "trace.h"
 
 static RADIX_TREE(pids, GFP_ATOMIC);
-static struct mutex pids_lock;
+static spinlock_t pids_lock;
 static struct last_io_info last_io;
 
 static inline void __print_last_io(void)
@@ -58,23 +58,29 @@ void f2fs_trace_pid(struct page *page)
 
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
 
@@ -119,7 +125,7 @@ void f2fs_trace_ios(struct f2fs_io_info *fio, int flush)
 
 void f2fs_build_trace_ios(void)
 {
-	mutex_init(&pids_lock);
+	spin_lock_init(&pids_lock);
 }
 
 #define PIDVEC_SIZE	128
@@ -147,7 +153,7 @@ void f2fs_destroy_trace_ios(void)
 	pid_t next_pid = 0;
 	unsigned int found;
 
-	mutex_lock(&pids_lock);
+	spin_lock(&pids_lock);
 	while ((found = gang_lookup_pids(pid, next_pid, PIDVEC_SIZE))) {
 		unsigned idx;
 
@@ -155,5 +161,5 @@ void f2fs_destroy_trace_ios(void)
 		for (idx = 0; idx < found; idx++)
 			radix_tree_delete(&pids, pid[idx]);
 	}
-	mutex_unlock(&pids_lock);
+	spin_unlock(&pids_lock);
 }
-- 
2.19.1



