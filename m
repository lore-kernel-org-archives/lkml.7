Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B91C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAB021774
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfK2JaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:30:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726215AbfK2JaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 04:30:11 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1E7589738DB22E99C505;
        Fri, 29 Nov 2019 17:30:09 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Fri, 29 Nov 2019 17:29:58 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH next 2/3] debugfs: introduce debugfs_create_single[,_data]
Date:   Fri, 29 Nov 2019 17:27:51 +0800
Message-ID: <20191129092752.169902-3-wangkefeng.wang@huawei.com>
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

Like proc_create_single[,_data] in procfs, introduce a similar
debugfs_create_single[,_data] function, which could drastically
reduces the boilerplate code.

Rename debugfs_devm_entry to debugfs_entry, and reuse debugfs_entry_ops
code. The struct debugfs_entry instance is dynamically allocated
and taken as data in debugfs_create_single_data, which need to be
freed when calling debugfs_remove, using lowest bit of inode->i_private
to distinguish it.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/debugfs/file.c       | 58 ++++++++++++++++++++++++++++++++++-------
 fs/debugfs/inode.c      |  4 +++
 include/linux/debugfs.h | 18 +++++++++++++
 3 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 38c17a99eb17..68f0c4b19bef 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1106,21 +1106,24 @@ EXPORT_SYMBOL_GPL(debugfs_create_regset32);
 
 #endif /* CONFIG_HAS_IOMEM */
 
-struct debugfs_devm_entry {
+struct debugfs_entry {
 	int (*read)(struct seq_file *seq, void *data);
-	struct device *dev;
+	void *data;
 };
 
-static int debugfs_devm_entry_open(struct inode *inode, struct file *f)
+static int debugfs_entry_open(struct inode *inode, struct file *f)
 {
-	struct debugfs_devm_entry *entry = inode->i_private;
+	struct debugfs_entry *entry = inode->i_private;
 
-	return single_open(f, entry->read, entry->dev);
+	if (debugfs_test_lowest_bit(entry))
+		entry = debugfs_clear_lowest_bit(entry);
+
+	return single_open(f, entry->read, entry->data);
 }
 
-static const struct file_operations debugfs_devm_entry_ops = {
+static const struct file_operations debugfs_entry_ops = {
 	.owner = THIS_MODULE,
-	.open = debugfs_devm_entry_open,
+	.open = debugfs_entry_open,
 	.release = single_release,
 	.read = seq_read,
 	.llseek = seq_lseek
@@ -1141,7 +1144,7 @@ struct dentry *debugfs_create_devm_seqfile(struct device *dev, const char *name,
 					   int (*read_fn)(struct seq_file *s,
 							  void *data))
 {
-	struct debugfs_devm_entry *entry;
+	struct debugfs_entry *entry;
 
 	if (IS_ERR(parent))
 		return ERR_PTR(-ENOENT);
@@ -1151,10 +1154,45 @@ struct dentry *debugfs_create_devm_seqfile(struct device *dev, const char *name,
 		return ERR_PTR(-ENOMEM);
 
 	entry->read = read_fn;
-	entry->dev = dev;
+	entry->data = dev;
 
 	return debugfs_create_file(name, S_IRUGO, parent, entry,
-				   &debugfs_devm_entry_ops);
+				   &debugfs_entry_ops);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_devm_seqfile);
 
+/**
+ * debugfs_create_single_data - create a file in the debugfs filesystem
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @data: a pointer to something that the caller will want to get to later
+ *        on.  The inode.i_private pointer will point to this value on
+ *        the open() call.
+ * @read_fn: function pointer called to print the seq_file content.
+ *
+ * This function creates a file in debugfs with the extra data and a seq_file
+ * show callback.
+ */
+struct dentry *debugfs_create_single_data(const char *name, umode_t mode,
+					  struct dentry *parent, void *data,
+					  int (*read_fn)(struct seq_file *s,
+							 void *data))
+{
+	struct debugfs_entry *entry;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return ERR_PTR(-ENOMEM);
+
+	entry->read = read_fn;
+	entry->data = data;
+
+	entry = debugfs_set_lowest_bit(entry);
+
+	return debugfs_create_file(name, mode, parent, entry,
+				   &debugfs_entry_ops);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_single_data);
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index cc24e97686d0..58cbb7af2a55 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -197,6 +197,10 @@ static void debugfs_free_inode(struct inode *inode)
 {
 	if (S_ISLNK(inode->i_mode))
 		kfree(inode->i_link);
+
+	if (debugfs_test_lowest_bit(inode->i_private))
+		kfree(debugfs_clear_lowest_bit(inode->i_private));
+
 	free_inode_nonrcu(inode);
 }
 
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index bf9b6cafa4c2..82171f183e93 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -142,6 +142,11 @@ struct dentry *debugfs_create_devm_seqfile(struct device *dev, const char *name,
 					   int (*read_fn)(struct seq_file *s,
 							  void *data));
 
+struct dentry *debugfs_create_single_data(const char *name, umode_t mode,
+					  struct dentry *parent, void *data,
+					  int (*read_fn)(struct seq_file *s,
+							 void *data));
+
 bool debugfs_initialized(void);
 
 ssize_t debugfs_read_file_bool(struct file *file, char __user *user_buf,
@@ -336,6 +341,16 @@ static inline struct dentry *debugfs_create_devm_seqfile(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct dentry *debugfs_create_single_data(const char *name,
+							umode_t mode,
+							struct dentry *parent,
+							void *data,
+					 int (*read_fn)(struct seq_file *s,
+							void *data))
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline ssize_t debugfs_read_file_bool(struct file *file,
 					     char __user *user_buf,
 					     size_t count, loff_t *ppos)
@@ -352,6 +367,9 @@ static inline ssize_t debugfs_write_file_bool(struct file *file,
 
 #endif
 
+#define debugfs_create_single(name, mode, parent, read) \
+	debugfs_create_single_data(name, mode, parent, NULL, read)
+
 /**
  * debugfs_create_xul - create a debugfs file that is used to read and write an
  * unsigned long value, formatted in hexadecimal
-- 
2.20.1

