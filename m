Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C689C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9603205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712308;
	bh=2QAsr3WAmydxI/msKJTBBTMS9RdXid/6wfLINpYNJ5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mH6Zcd4fB2HuuKfVpZ+r30RweGoVsBznlpkqMadf1BxiS4DXb8UE47LDbbq+nCe6Y
	 gg2pVKNHDH6iEgWWtYrSms4REnEAkBBptaeuVHYce7l1lE4aDXB82ENumaK8ribyZT
	 F/sDkWM82Hzb6qpkzX/PsWz+4l6Ix7bsT06b3ryA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391412AbfC0SpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391057AbfC0SVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:21:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F8B520651;
        Wed, 27 Mar 2019 18:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710869;
        bh=2QAsr3WAmydxI/msKJTBBTMS9RdXid/6wfLINpYNJ5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0O6nIBttf/giZbUx7iUwxn4KRu5UZONGGvyEPuSWarU5WYl8AuD0tBoLnky54cHIn
         lgpE/9eH3ZiTudw73iR6vHJqggVfQmwluccgtMDlt3nq6SxFeBJm4OjnzR0BX3adwe
         opef4LSnRv3DRzY9+uLH9M57Bz0KC8RyoItO53Ac=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.9 15/87] f2fs: do not use mutex lock in atomic context
Date:   Wed, 27 Mar 2019 14:19:28 -0400
Message-Id: <20190327182040.17444-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182040.17444-1-sashal@kernel.org>
References: <20190327182040.17444-1-sashal@kernel.org>
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
 fs/f2fs/trace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
index 73b4e1d1912a..501c283761d2 100644
--- a/fs/f2fs/trace.c
+++ b/fs/f2fs/trace.c
@@ -61,6 +61,7 @@ void f2fs_trace_pid(struct page *page)
 
 	page->private = pid;
 
+retry:
 	if (radix_tree_preload(GFP_NOFS))
 		return;
 
@@ -71,7 +72,12 @@ void f2fs_trace_pid(struct page *page)
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
-- 
2.19.1

