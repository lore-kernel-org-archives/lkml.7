Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5247C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB85820855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554367859;
	bh=ufUbYLr5n/7HmABUvTtGoAIJUry4UA0HUooIFTVgVFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bwZ6MNNjzc51+ylAuntg/DX2JFLdiHPD/qXBiRTAfgPyiN58re8nYRMnjyQhBbufK
	 m3DmU17xn3TyQt1Aqw50UyoJpIslBmCvBWzXT7QZm4dcnkFY4uLgwFMfNoU4PmV2Us
	 xe6UbhcXyVul4ukLl2SqzVqe4SdJlX/PMLQ3HtNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbfDDIu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbfDDIu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:50:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6103820855;
        Thu,  4 Apr 2019 08:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367855;
        bh=ufUbYLr5n/7HmABUvTtGoAIJUry4UA0HUooIFTVgVFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GABWeqtpgVxxOKF4zPL121qPPWCa1jwkEDdETpGT+2/+q+pJuigBrrVGgaAGfZW+t
         ZfJRNDFztw+5KvKWL3y3dkV7wBoln7XNbm6JvS1gGmx3TDe2KyT2rXYJHvUeWqsPfX
         XtCiKcWn2pbejIRMfHrvtvkH2z/bQkK+r8L6nKwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 22/91] f2fs: do not use mutex lock in atomic context
Date:   Thu,  4 Apr 2019 10:47:06 +0200
Message-Id: <20190404084536.700737266@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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



