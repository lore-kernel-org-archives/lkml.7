Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA1AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC7A208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfDBKxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:53:10 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2521 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729575AbfDBKwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:52:53 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [10.3.20.213])
        by Forcepoint Email with ESMTP id 14953D123829FF00D58E;
        Tue,  2 Apr 2019 18:52:52 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 2 Apr 2019 18:52:51 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 2 Apr 2019 18:52:51 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5/5] f2fs: add tracepoint for f2fs_file_write_iter()
Date:   Tue, 2 Apr 2019 18:52:22 +0800
Message-ID: <20190402105222.28374-5-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190402105222.28374-1-yuchao0@huawei.com>
References: <20190402105222.28374-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds tracepoint for f2fs_file_write_iter().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c              | 28 +++++++++++++++++++---------
 include/trace/events/f2fs.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 578486e03427..65e14ec7366f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3037,15 +3037,21 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(file);
 	ssize_t ret;
 
-	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
-		return -EIO;
+	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode)))) {
+		ret = -EIO;
+		goto out;
+	}
 
-	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT))
-		return -EINVAL;
+	if ((iocb->ki_flags & IOCB_NOWAIT) && !(iocb->ki_flags & IOCB_DIRECT)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	if (!inode_trylock(inode)) {
-		if (iocb->ki_flags & IOCB_NOWAIT)
-			return -EAGAIN;
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			ret = -EAGAIN;
+			goto out;
+		}
 		inode_lock(inode);
 	}
 
@@ -3068,7 +3074,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 						clear_inode_flag(inode,
 								FI_NO_PREALLOC);
 						inode_unlock(inode);
-						return -EAGAIN;
+						ret = -EAGAIN;
+						goto out;
 				}
 
 		} else {
@@ -3079,7 +3086,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			if (err) {
 				clear_inode_flag(inode, FI_NO_PREALLOC);
 				inode_unlock(inode);
-				return err;
+				ret = err;
+				goto out;
 			}
 		}
 		ret = __generic_file_write_iter(iocb, from);
@@ -3093,7 +3101,9 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			f2fs_update_iostat(F2FS_I_SB(inode), APP_WRITE_IO, ret);
 	}
 	inode_unlock(inode);
-
+out:
+	trace_f2fs_file_write_iter(inode, iocb->ki_pos,
+					iov_iter_count(from), ret);
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
 	return ret;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 1b39b50511f5..9d63457c1232 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -533,6 +533,37 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
 		__entry->err)
 );
 
+TRACE_EVENT(f2fs_file_write_iter,
+
+	TP_PROTO(struct inode *inode, unsigned long offset,
+		unsigned long length, int ret),
+
+	TP_ARGS(inode, offset, length, ret),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(unsigned long, offset)
+		__field(unsigned long, length)
+		__field(int,	ret)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->offset	= offset;
+		__entry->length	= length;
+		__entry->ret	= ret;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, "
+		"offset = %lu, length = %lu, written(err) = %d",
+		show_dev_ino(__entry),
+		__entry->offset,
+		__entry->length,
+		__entry->ret)
+);
+
 TRACE_EVENT(f2fs_map_blocks,
 	TP_PROTO(struct inode *inode, struct f2fs_map_blocks *map, int ret),
 
-- 
2.18.0.rc1

