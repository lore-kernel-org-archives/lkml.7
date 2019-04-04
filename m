Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20067C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EA3217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368121;
	bh=FMVVaGvFtVSgZApcofTydT3nCShyD/NF9XvMig0I8gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZM/S9Bx7/dkq65/IkF+9KH1WZpeQqKWRFaJk6L79jX1PBSV1f/FvY2iirsnw62D1Z
	 TmlHHJmqa9Zo3CAgMwALA5ORtWIL6yFmoQJ6tOh/k7oesBsuvahKfMVJZUNdm5NJPO
	 q84iXqcQZk9sPzwtjNFUPqotoYBQIoVd6jlFzjEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbfDDIzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:55:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729490AbfDDIzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:55:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B0FD217D4;
        Thu,  4 Apr 2019 08:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368113;
        bh=FMVVaGvFtVSgZApcofTydT3nCShyD/NF9XvMig0I8gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mAxzpDDCDdXKULTVCGpqczqo0CRTIU6zrPBdqYf2+ZDLNMpzQwbR7GGjC/PmpnPuN
         ELE3a1wsBe6blofLbB5tUKWukHD7Zguuo5op7PLWqkoSzMdmcQrADX7gzxSxFrZ1KC
         OqzU4ho/gSwihKlu5QlgyynLrYIB2YakYxqKCZZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 026/121] f2fs: do not use mutex lock in atomic context
Date:   Thu,  4 Apr 2019 10:46:54 +0200
Message-Id: <20190404084546.776090316@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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



