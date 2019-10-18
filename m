Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B860CA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48667222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504121AbfJRFF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:05:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54300 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392464AbfJRFFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:05:15 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ECBBA6BC8956766E9295;
        Fri, 18 Oct 2019 11:19:40 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Fri, 18 Oct 2019 11:19:33 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        David Howells <dhowells@redhat.com>,
        <linux-afs@lists.infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH v2 23/33] fs: afs: Use pr_warn instead of pr_warning
Date:   Fri, 18 Oct 2019 11:18:40 +0800
Message-ID: <20191018031850.48498-23-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018031850.48498-1-wangkefeng.wang@huawei.com>
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
pr_warning"), removing pr_warning so all logging messages use a
consistent <prefix>_warn style. Let's do it.

Cc: David Howells <dhowells@redhat.com>
Cc: linux-afs@lists.infradead.org
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/afs/flock.c     |  4 ++--
 fs/afs/inode.c     | 13 ++++++-------
 fs/afs/yfsclient.c |  4 ++--
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index d5e5a6ddc847..0f2a94ba73cb 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -346,8 +346,8 @@ void afs_lock_work(struct work_struct *work)
 		if (ret < 0) {
 			trace_afs_flock_ev(vnode, NULL, afs_flock_extend_fail,
 					   ret);
-			pr_warning("AFS: Failed to extend lock on {%llx:%llx} error %d\n",
-				   vnode->fid.vid, vnode->fid.vnode, ret);
+			pr_warn("AFS: Failed to extend lock on {%llx:%llx} error %d\n",
+				vnode->fid.vid, vnode->fid.vnode, ret);
 		}
 
 		spin_lock(&vnode->lock);
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 46d2d7cb461d..281470fe1183 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -34,8 +34,7 @@ static noinline void dump_vnode(struct afs_vnode *vnode, struct afs_vnode *paren
 {
 	static unsigned long once_only;
 
-	pr_warn("kAFS: AFS vnode with undefined type %u\n",
-		vnode->status.type);
+	pr_warn("kAFS: AFS vnode with undefined type %u\n", vnode->status.type);
 	pr_warn("kAFS: A=%d m=%o s=%llx v=%llx\n",
 		vnode->status.abort_code,
 		vnode->status.mode,
@@ -175,11 +174,11 @@ static void afs_apply_status(struct afs_fs_cursor *fc,
 	BUG_ON(test_bit(AFS_VNODE_UNSET, &vnode->flags));
 
 	if (status->type != vnode->status.type) {
-		pr_warning("Vnode %llx:%llx:%x changed type %u to %u\n",
-			   vnode->fid.vid,
-			   vnode->fid.vnode,
-			   vnode->fid.unique,
-			   status->type, vnode->status.type);
+		pr_warn("Vnode %llx:%llx:%x changed type %u to %u\n",
+			vnode->fid.vid,
+			vnode->fid.vnode,
+			vnode->fid.unique,
+			status->type, vnode->status.type);
 		afs_protocol_error(NULL, -EBADMSG, afs_eproto_bad_status);
 		return;
 	}
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 3ee7abf4b2d0..9ac035c17dc4 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -152,8 +152,8 @@ static void yfs_check_req(struct afs_call *call, __be32 *bp)
 		pr_err("kAFS: %s: Request buffer overflow (%zu>%u)\n",
 		       call->type->name, len, call->request_size);
 	else if (len < call->request_size)
-		pr_warning("kAFS: %s: Request buffer underflow (%zu<%u)\n",
-			   call->type->name, len, call->request_size);
+		pr_warn("kAFS: %s: Request buffer underflow (%zu<%u)\n",
+			call->type->name, len, call->request_size);
 }
 
 /*
-- 
2.20.1

