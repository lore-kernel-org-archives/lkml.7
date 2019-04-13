Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA07C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 13:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55572073F
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 13:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfDMNo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 09:44:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6740 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726301AbfDMNo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 09:44:57 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 691E52414F166A587303;
        Sat, 13 Apr 2019 21:44:51 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Sat, 13 Apr 2019
 21:44:44 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <hubcap@omnibond.com>, <martin@omnibond.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@lists.orangefs.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] orangefs: Make some functions static
Date:   Sat, 13 Apr 2019 21:41:36 +0800
Message-ID: <20190413134136.36652-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warnings:

fs/orangefs/super.c:155:5: warning: symbol 'orangefs_write_inode' was not declared. Should it be static?
fs/orangefs/inode.c:387:5: warning: symbol 'orangefs_write_begin' was not declared. Should it be static?
fs/orangefs/inode.c:445:5: warning: symbol 'orangefs_write_end' was not declared. Should it be static?
fs/orangefs/file.c:607:5: warning: symbol 'orangefs_flush' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/orangefs/file.c  |  2 +-
 fs/orangefs/inode.c | 13 ++++++++-----
 fs/orangefs/super.c |  3 ++-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index a2bbed1..a35c170 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -604,7 +604,7 @@ static int orangefs_file_open(struct inode * inode, struct file *file)
 	return generic_file_open(inode, file);
 }
 
-int orangefs_flush(struct file *file, fl_owner_t id)
+static int orangefs_flush(struct file *file, fl_owner_t id)
 {
 	/*
 	 * This is vfs_fsync_range(file, 0, LLONG_MAX, 0) without the
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index d572e807..46235dd 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -384,9 +384,10 @@ static int orangefs_readpage(struct file *file, struct page *page)
 	return ret;
 }
 
-int orangefs_write_begin(struct file *file, struct address_space *mapping,
-    loff_t pos, unsigned len, unsigned flags, struct page **pagep,
-    void **fsdata)
+static int
+orangefs_write_begin(struct file *file, struct address_space *mapping,
+		     loff_t pos, unsigned int len, unsigned int flags,
+		     struct page **pagep, void **fsdata)
 {
 	struct orangefs_write_range *wr;
 	struct page *page;
@@ -442,8 +443,10 @@ int orangefs_write_begin(struct file *file, struct address_space *mapping,
 	return 0;
 }
 
-int orangefs_write_end(struct file *file, struct address_space *mapping,
-    loff_t pos, unsigned len, unsigned copied, struct page *page, void *fsdata)
+static int
+orangefs_write_end(struct file *file, struct address_space *mapping,
+		   loff_t pos, unsigned int len, unsigned int copied,
+		   struct page *page, void *fsdata)
 {
 	struct inode *inode = page->mapping->host;
 	loff_t last_pos = pos + copied;
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 48e0806..8fa30c1 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -152,7 +152,8 @@ static void orangefs_destroy_inode(struct inode *inode)
 	call_rcu(&inode->i_rcu, orangefs_i_callback);
 }
 
-int orangefs_write_inode(struct inode *inode, struct writeback_control *wbc)
+static int orangefs_write_inode(struct inode *inode,
+				struct writeback_control *wbc)
 {
 	gossip_debug(GOSSIP_SUPER_DEBUG, "orangefs_write_inode\n");
 	return orangefs_inode_setattr(inode);
-- 
2.7.4


