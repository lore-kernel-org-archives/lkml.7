Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD3DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24CB205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712837;
	bh=zGcHxBEsShYjZ9xRcSMhQNvMJ4Y+7qBAGQJ37MAc+8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hVwavB18OzmBErodR7uCcXGpXsJ8PdKP8gUrYw7Qb1HXiNV4bIif4wfZW1LVuXwPY
	 EssXXC3FwGwABpnFZqfT5vP1nTaCda2P+zBGwHcFKg3btPAUcGHMEPfzpm56IkAu/P
	 pSDE8L9o6BiZOhuBTm9EN5E0b6wWS4NX/bk2cuQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390725AbfC0Sx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390208AbfC0SRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:17:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7635A2177E;
        Wed, 27 Mar 2019 18:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710630;
        bh=zGcHxBEsShYjZ9xRcSMhQNvMJ4Y+7qBAGQJ37MAc+8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1l/fkilaLFYN4q/qNEu4bkfAgqFZVltnse38QaO7g19F1R51oE38ZW50zVURPMaml
         AbmkiG6OYjddbUmen6PTNekmTy4+lQaJRHLCrB4YtWZG7f54E6ogVV9fydLoQE3DWI
         c+IiceVS2Rx4rCvaT3IEX71VB4GHZHJLjV0EZUmA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.14 021/123] f2fs: do not use mutex lock in atomic context
Date:   Wed, 27 Mar 2019 14:14:45 -0400
Message-Id: <20190327181628.15899-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
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
index bccbbf2616d2..8ac1851a21c0 100644
--- a/fs/f2fs/trace.c
+++ b/fs/f2fs/trace.c
@@ -61,6 +61,7 @@ void f2fs_trace_pid(struct page *page)
 
 	set_page_private(page, (unsigned long)pid);
 
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

