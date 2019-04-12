Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538FDC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC1B20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfDLLx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:53:59 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2544 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726772AbfDLLx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:53:57 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 8081B8CBEFB6FAD585BA;
        Fri, 12 Apr 2019 19:53:45 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 12 Apr 2019 19:53:44 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 12 Apr 2019 19:53:44 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix wrong __is_meta_io() macro
Date:   Fri, 12 Apr 2019 19:53:38 +0800
Message-ID: <20190412115339.16936-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes codes as below:
- don't use is_read_io() as a condition to judge the meta IO.
- use .is_por to replace .is_meta to indicate IO is from recovery explicitly.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 4 ++--
 fs/f2fs/data.c       | 3 ++-
 fs/f2fs/f2fs.h       | 5 ++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index eadb67bd4ed7..58eb2b66600b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -66,7 +66,7 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
 		.old_blkaddr = index,
 		.new_blkaddr = index,
 		.encrypted_page = NULL,
-		.is_meta = is_meta,
+		.is_por = !is_meta,
 	};
 	int err;
 
@@ -189,7 +189,7 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 		.op_flags = sync ? (REQ_META | REQ_PRIO) : REQ_RAHEAD,
 		.encrypted_page = NULL,
 		.in_list = false,
-		.is_meta = (type != META_POR),
+		.is_por = (type == META_POR),
 	};
 	struct blk_plug plug;
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index cbf4681525d8..d9000134792f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -403,7 +403,8 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 			fio->encrypted_page : fio->page;
 
 	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
-			__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
+			fio->is_por ? META_POR :
+			(__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC)))
 		return -EFAULT;
 
 	trace_f2fs_submit_page_bio(page, fio);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 42855bd6252f..80e17eab4fa7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1046,7 +1046,7 @@ struct f2fs_io_info {
 	bool submitted;		/* indicate IO submission */
 	int need_lock;		/* indicate we need to lock cp_rwsem */
 	bool in_list;		/* indicate fio is in io_list */
-	bool is_meta;		/* indicate borrow meta inode mapping or not */
+	bool is_por;		/* indicate IO is from recovery or not */
 	bool retry;		/* need to reallocate block address */
 	enum iostat_type io_type;	/* io type */
 	struct writeback_control *io_wbc; /* writeback control */
@@ -2830,8 +2830,7 @@ static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi,
 
 #define __is_large_section(sbi)		((sbi)->segs_per_sec > 1)
 
-#define __is_meta_io(fio) (PAGE_TYPE_OF_BIO((fio)->type) == META &&	\
-				(!is_read_io((fio)->op) || (fio)->is_meta))
+#define __is_meta_io(fio) (PAGE_TYPE_OF_BIO((fio)->type) == META)
 
 bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 					block_t blkaddr, int type);
-- 
2.18.0.rc1

