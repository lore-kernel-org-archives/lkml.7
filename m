Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DA1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7D020856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbfDBKxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:53:04 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2520 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbfDBKwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:52:54 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [10.3.20.214])
        by Forcepoint Email with ESMTP id C4777617FE086F070D06;
        Tue,  2 Apr 2019 18:52:51 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 2 Apr 2019 18:52:51 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 2 Apr 2019 18:52:50 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/5] f2fs: add tracepoint for f2fs_filemap_fault()
Date:   Tue, 2 Apr 2019 18:52:21 +0800
Message-ID: <20190402105222.28374-4-yuchao0@huawei.com>
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

This patch adds tracepoint for f2fs_filemap_fault().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c              |  2 ++
 include/trace/events/f2fs.h | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 30d49467578e..578486e03427 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -39,6 +39,8 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 	ret = filemap_fault(vmf);
 	up_read(&F2FS_I(inode)->i_mmap_sem);
 
+	trace_f2fs_filemap_fault(inode, vmf->pgoff, ret);
+
 	return ret;
 }
 
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index a3916b4dd57e..1b39b50511f5 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1253,6 +1253,32 @@ DEFINE_EVENT(f2fs__page, f2fs_commit_inmem_page,
 	TP_ARGS(page, type)
 );
 
+TRACE_EVENT(f2fs_filemap_fault,
+
+	TP_PROTO(struct inode *inode, pgoff_t index, int ret),
+
+	TP_ARGS(inode, index, ret),
+
+	TP_STRUCT__entry(
+		__field(dev_t,	dev)
+		__field(ino_t,	ino)
+		__field(pgoff_t, index)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->index	= index;
+		__entry->ret	= ret;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, index = %lu, ret = %d",
+		show_dev_ino(__entry),
+		(unsigned long)__entry->index,
+		ret)
+);
+
 TRACE_EVENT(f2fs_writepages,
 
 	TP_PROTO(struct inode *inode, struct writeback_control *wbc, int type),
-- 
2.18.0.rc1

