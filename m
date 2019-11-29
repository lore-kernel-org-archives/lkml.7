Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BC3C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C219F217C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfK2JaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:30:13 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7181 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbfK2JaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 04:30:11 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 26B19E138209BD213821;
        Fri, 29 Nov 2019 17:30:09 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Fri, 29 Nov 2019 17:29:58 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH next 1/3] debugfs: Provide debugfs_[set|clear|test]_lowest_bit()
Date:   Fri, 29 Nov 2019 17:27:50 +0800
Message-ID: <20191129092752.169902-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191129092752.169902-1-wangkefeng.wang@huawei.com>
References: <20191129092752.169902-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide debugfs_[set|clear|test]_lowest_bit() helper, which
could test, set and clear the lowest bit of a pointer, and
will be used in the subsequent patches.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/debugfs/file.c     | 7 +++----
 fs/debugfs/inode.c    | 7 +++----
 fs/debugfs/internal.h | 5 ++++-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index dede25247b81..38c17a99eb17 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -50,7 +50,7 @@ const struct file_operations *debugfs_real_fops(const struct file *filp)
 {
 	struct debugfs_fsdata *fsd = F_DENTRY(filp)->d_fsdata;
 
-	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT) {
+	if (debugfs_test_lowest_bit(fsd)) {
 		/*
 		 * Urgh, we've been called w/o a protecting
 		 * debugfs_file_get().
@@ -84,15 +84,14 @@ int debugfs_file_get(struct dentry *dentry)
 	void *d_fsd;
 
 	d_fsd = READ_ONCE(dentry->d_fsdata);
-	if (!((unsigned long)d_fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)) {
+	if (!debugfs_test_lowest_bit(d_fsd)) {
 		fsd = d_fsd;
 	} else {
 		fsd = kmalloc(sizeof(*fsd), GFP_KERNEL);
 		if (!fsd)
 			return -ENOMEM;
 
-		fsd->real_fops = (void *)((unsigned long)d_fsd &
-					~DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
+		fsd->real_fops = debugfs_clear_lowest_bit(d_fsd);
 		refcount_set(&fsd->active_users, 1);
 		init_completion(&fsd->active_users_drained);
 		if (cmpxchg(&dentry->d_fsdata, d_fsd, fsd) != d_fsd) {
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 7b975dbb2bb4..cc24e97686d0 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -211,7 +211,7 @@ static void debugfs_release_dentry(struct dentry *dentry)
 {
 	void *fsd = dentry->d_fsdata;
 
-	if (!((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT))
+	if (!debugfs_test_lowest_bit(fsd))
 		kfree(dentry->d_fsdata);
 }
 
@@ -398,8 +398,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 
 	inode->i_op = &debugfs_file_inode_operations;
 	inode->i_fop = proxy_fops;
-	dentry->d_fsdata = (void *)((unsigned long)real_fops |
-				DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
+	dentry->d_fsdata = debugfs_set_lowest_bit(real_fops);
 
 	d_instantiate(dentry, inode);
 	fsnotify_create(d_inode(dentry->d_parent), dentry);
@@ -679,7 +678,7 @@ static void __debugfs_file_removed(struct dentry *dentry)
 	 */
 	smp_mb();
 	fsd = READ_ONCE(dentry->d_fsdata);
-	if ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)
+	if (debugfs_test_lowest_bit(fsd))
 		return;
 	if (!refcount_dec_and_test(&fsd->active_users))
 		wait_for_completion(&fsd->active_users_drained);
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index f0d73d86cc1a..4dd6df4bc172 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -27,6 +27,9 @@ struct debugfs_fsdata {
  * In order to distinguish between these two cases, a real fops
  * pointer gets its lowest bit set.
  */
-#define DEBUGFS_FSDATA_IS_REAL_FOPS_BIT BIT(0)
+
+#define debugfs_set_lowest_bit(ptr)	((void *)((unsigned long)(ptr) | BIT(0)))
+#define debugfs_clear_lowest_bit(ptr)	((void *)((unsigned long)(ptr) & ~BIT(0)))
+#define debugfs_test_lowest_bit(ptr)	((unsigned long)(ptr) & BIT(0))
 
 #endif /* _DEBUGFS_INTERNAL_H_ */
-- 
2.20.1

