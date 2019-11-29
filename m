Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91E6C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0937921774
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 09:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfK2JaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:30:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7179 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbfK2JaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 04:30:10 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 229AA85642DF0D5D1CAA;
        Fri, 29 Nov 2019 17:30:09 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Fri, 29 Nov 2019 17:29:59 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH next 3/3] debugfs: introduce debugfs_create_seq[,_data]
Date:   Fri, 29 Nov 2019 17:27:52 +0800
Message-ID: <20191129092752.169902-4-wangkefeng.wang@huawei.com>
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

Like proc_create_seq[,_data] in procfs, introduce a similar
debugfs_create_seq[,_data] function, which could drastically
reduces the boilerplate code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/debugfs/file.c       | 62 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/debugfs.h | 16 +++++++++++
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 68f0c4b19bef..77522717c9fb 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1107,7 +1107,10 @@ EXPORT_SYMBOL_GPL(debugfs_create_regset32);
 #endif /* CONFIG_HAS_IOMEM */
 
 struct debugfs_entry {
-	int (*read)(struct seq_file *seq, void *data);
+	union {
+		const struct seq_operations *seq_ops;
+		int (*read)(struct seq_file *seq, void *data);
+	};
 	void *data;
 };
 
@@ -1196,3 +1199,60 @@ struct dentry *debugfs_create_single_data(const char *name, umode_t mode,
 				   &debugfs_entry_ops);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_single_data);
+
+static int debugfs_entry_seq_open(struct inode *inode, struct file *file)
+{
+	struct debugfs_entry *entry = inode->i_private;
+	int ret;
+
+	entry = debugfs_clear_lowest_bit(entry);
+
+	ret = seq_open(file, entry->seq_ops);
+	if (!ret && entry->data) {
+		struct seq_file *seq = file->private_data;
+		seq->private = entry->data;
+	}
+
+	return ret;
+}
+
+static const struct file_operations debugfs_seq_fops = {
+	.open		= debugfs_entry_seq_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+/**
+ * debugfs_create_seq_data - create a file in the debugfs filesystem
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @data: a pointer to something that the caller will want to get to later
+ *        on.  The inode.i_private pointer will point to this value on
+ *        the open() call.
+ * @seq_ops: seq_operations pointer of the seqfile.
+ *
+ * This function creates a file in debugfs with the extra data and a seq_ops.
+ */
+struct dentry *debugfs_create_seq_data(const char *name, umode_t mode,
+				       struct dentry *parent, void *data,
+				       const struct seq_operations *seq_ops)
+{
+	struct debugfs_entry *entry;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return ERR_PTR(-ENOMEM);
+
+	entry->seq_ops = seq_ops;
+	entry->data = data;
+
+	entry = debugfs_set_lowest_bit(entry);
+
+	return debugfs_create_file(name, mode, parent, entry,
+				   &debugfs_seq_fops);
+}
+EXPORT_SYMBOL_GPL(debugfs_create_seq_data);
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 82171f183e93..d32d49983547 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -147,6 +147,10 @@ struct dentry *debugfs_create_single_data(const char *name, umode_t mode,
 					  int (*read_fn)(struct seq_file *s,
 							 void *data));
 
+struct dentry *debugfs_create_seq_data(const char *name, umode_t mode,
+				       struct dentry *parent, void *data,
+				       const struct seq_operations *seq_ops);
+
 bool debugfs_initialized(void);
 
 ssize_t debugfs_read_file_bool(struct file *file, char __user *user_buf,
@@ -351,6 +355,15 @@ static inline struct dentry *debugfs_create_single_data(const char *name,
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct dentry *debugfs_create_seq_data(const char *name,
+						     umode_t mode,
+						     struct dentry *parent,
+						     void *data,
+				       const struct seq_operations *seq_ops)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline ssize_t debugfs_read_file_bool(struct file *file,
 					     char __user *user_buf,
 					     size_t count, loff_t *ppos)
@@ -370,6 +383,9 @@ static inline ssize_t debugfs_write_file_bool(struct file *file,
 #define debugfs_create_single(name, mode, parent, read) \
 	debugfs_create_single_data(name, mode, parent, NULL, read)
 
+#define debugfs_create_seq(name, mode, parent, ops) \
+	debugfs_create_seq_data(name, mode, parent, NULL, ops)
+
 /**
  * debugfs_create_xul - create a debugfs file that is used to read and write an
  * unsigned long value, formatted in hexadecimal
-- 
2.20.1

