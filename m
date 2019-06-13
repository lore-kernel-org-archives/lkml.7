Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED28C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A4B20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hw4p2+hw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfFMWeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 18:34:17 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:48297 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfFMWeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 18:34:15 -0400
Received: by mail-qk1-f202.google.com with SMTP id w184so384223qka.15
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 15:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bTXgyZNUxsXl1UHTNfgfYerQzytLiAMKzAkrjSTl5FY=;
        b=hw4p2+hwbwvUjB7apP4jS30yLuUH1M2KW6nAYKebHuiw5MO3DXTLdkFO74bMAHYRx1
         L3wCI3TwAJfi6YXyptbJdrJ4ur49ITyqw4okaVOqFfR6nljOiyiL6etk4feIUhZsLPBH
         VPC0sYhFj61GMyZFnPOYiEpQxMCwbo/OwOX5m/n9HzM0d2XMgvZcR9eI8U3rLs4rGHUF
         +9sYiuANpizB27rfYaJaXkTsh/+UlbmEISPa+WEcGZ7nPeiyHNrJB6jL0/z5gbNj7lnu
         p+Ko7TNKrxu0iov7WqeIohTD1tDdH5KGrR97hlqJ+VgcIx5m7RCbn/JGe2EWLHoS9q3f
         /zGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bTXgyZNUxsXl1UHTNfgfYerQzytLiAMKzAkrjSTl5FY=;
        b=mgd8VWTJcy51X5u1ID0pJ04gaCR/nZv7OTPw0YAg2CpWVldrbThVNwdtBxdcNzFPWI
         pc8YiVGPZFxEN+FHKV20BkyNI+WUE+7LZcAZFvRIKtNPegwQd193+srlFQUhvbtPl+zu
         swxAj/tnzYXhunuw6lJvp7rAfOWOPze1IGcCGmu9jhKDq9tiDKSRwaoGqDhyrcqFjW20
         M4MQitGfPSY1Vv49VbNX1foeqbnsjgRQi0jNvnhzwrNwjzdvpa6p/044IJbfgt6ZdIKT
         kuNw4hxEEzFfdAjxnnSzI8dxzLf6CIaNgAvl38tjCpQm8T06cHPjtS6H5KuwVed1407Y
         g0OQ==
X-Gm-Message-State: APjAAAUf6J4t6VK03jeUbzMpO+5/vOp3otvqgWxjCnO3q/itNwc6EOmR
        6HH0G6q/+UTyM5lWxqf2+PJfFTTaR4samlkuFWjsuGCKP73M1HnzyXjSmC1FoaZaMvSeHEG2Wpe
        NIgnwOdjuztoeIGCt/A3EgLoPG+PCSBUHwelmCaGrOfD6/iDoZocFVA5LmoPKHCkw/7o=
X-Google-Smtp-Source: APXvYqwb1d3zhU7UhfoWoz0WJCfYAVywZTFfNhp4ZZmtxHSMRB3IA5OCssgARIcJbT3ijstJLcL8tBxETg==
X-Received: by 2002:ac8:849:: with SMTP id x9mr29041023qth.16.1560465254469;
 Thu, 13 Jun 2019 15:34:14 -0700 (PDT)
Date:   Thu, 13 Jun 2019 15:34:06 -0700
In-Reply-To: <20190613223408.139221-1-fengc@google.com>
Message-Id: <20190613223408.139221-2-fengc@google.com>
Mime-Version: 1.0
References: <20190613223408.139221-1-fengc@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 1/3] dma-buf: give each buffer a full-fledged inode
From:   Chenbo Feng <fengc@google.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sumit Semwal <sumit.semwal@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Hackmann <ghackmann@google.com>

By traversing /proc/*/fd and /proc/*/map_files, processes with CAP_ADMIN
can get a lot of fine-grained data about how shmem buffers are shared
among processes.  stat(2) on each entry gives the caller a unique
ID (st_ino), the buffer's size (st_size), and even the number of pages
currently charged to the buffer (st_blocks / 512).

In contrast, all dma-bufs share the same anonymous inode.  So while we
can count how many dma-buf fds or mappings a process has, we can't get
the size of the backing buffers or tell if two entries point to the same
dma-buf.  On systems with debugfs, we can get a per-buffer breakdown of
size and reference count, but can't tell which processes are actually
holding the references to each buffer.

Replace the singleton inode with full-fledged inodes allocated by
alloc_anon_inode().  This involves creating and mounting a
mini-pseudo-filesystem for dma-buf, following the example in fs/aio.c.

Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Chenbo Feng <fengc@google.com>
---
 drivers/dma-buf/dma-buf.c  | 63 ++++++++++++++++++++++++++++++++++----
 include/uapi/linux/magic.h |  1 +
 2 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 7c858020d14b..ffd5a2ad7d6f 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -34,8 +34,10 @@
 #include <linux/poll.h>
 #include <linux/reservation.h>
 #include <linux/mm.h>
+#include <linux/mount.h>
 
 #include <uapi/linux/dma-buf.h>
+#include <uapi/linux/magic.h>
 
 static inline int is_dma_buf_file(struct file *);
 
@@ -46,6 +48,25 @@ struct dma_buf_list {
 
 static struct dma_buf_list db_list;
 
+static const struct dentry_operations dma_buf_dentry_ops = {
+	.d_dname = simple_dname,
+};
+
+static struct vfsmount *dma_buf_mnt;
+
+static struct dentry *dma_buf_fs_mount(struct file_system_type *fs_type,
+		int flags, const char *name, void *data)
+{
+	return mount_pseudo(fs_type, "dmabuf:", NULL, &dma_buf_dentry_ops,
+			DMA_BUF_MAGIC);
+}
+
+static struct file_system_type dma_buf_fs_type = {
+	.name = "dmabuf",
+	.mount = dma_buf_fs_mount,
+	.kill_sb = kill_anon_super,
+};
+
 static int dma_buf_release(struct inode *inode, struct file *file)
 {
 	struct dma_buf *dmabuf;
@@ -338,6 +359,31 @@ static inline int is_dma_buf_file(struct file *file)
 	return file->f_op == &dma_buf_fops;
 }
 
+static struct file *dma_buf_getfile(struct dma_buf *dmabuf, int flags)
+{
+	struct file *file;
+	struct inode *inode = alloc_anon_inode(dma_buf_mnt->mnt_sb);
+
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
+	inode->i_size = dmabuf->size;
+	inode_set_bytes(inode, dmabuf->size);
+
+	file = alloc_file_pseudo(inode, dma_buf_mnt, "dmabuf",
+				 flags, &dma_buf_fops);
+	if (IS_ERR(file))
+		goto err_alloc_file;
+	file->f_flags = flags & (O_ACCMODE | O_NONBLOCK);
+	file->private_data = dmabuf;
+
+	return file;
+
+err_alloc_file:
+	iput(inode);
+	return file;
+}
+
 /**
  * DOC: dma buf device access
  *
@@ -433,8 +479,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 	}
 	dmabuf->resv = resv;
 
-	file = anon_inode_getfile("dmabuf", &dma_buf_fops, dmabuf,
-					exp_info->flags);
+	file = dma_buf_getfile(dmabuf, exp_info->flags);
 	if (IS_ERR(file)) {
 		ret = PTR_ERR(file);
 		goto err_dmabuf;
@@ -1025,8 +1070,8 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
 		return ret;
 
 	seq_puts(s, "\nDma-buf Objects:\n");
-	seq_printf(s, "%-8s\t%-8s\t%-8s\t%-8s\texp_name\n",
-		   "size", "flags", "mode", "count");
+	seq_printf(s, "%-8s\t%-8s\t%-8s\t%-8s\texp_name\t%-8s\n",
+		   "size", "flags", "mode", "count", "ino");
 
 	list_for_each_entry(buf_obj, &db_list.head, list_node) {
 		ret = mutex_lock_interruptible(&buf_obj->lock);
@@ -1037,11 +1082,12 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
 			continue;
 		}
 
-		seq_printf(s, "%08zu\t%08x\t%08x\t%08ld\t%s\n",
+		seq_printf(s, "%08zu\t%08x\t%08x\t%08ld\t%s\t%08lu\n",
 				buf_obj->size,
 				buf_obj->file->f_flags, buf_obj->file->f_mode,
 				file_count(buf_obj->file),
-				buf_obj->exp_name);
+				buf_obj->exp_name,
+				file_inode(buf_obj->file)->i_ino);
 
 		robj = buf_obj->resv;
 		while (true) {
@@ -1136,6 +1182,10 @@ static inline void dma_buf_uninit_debugfs(void)
 
 static int __init dma_buf_init(void)
 {
+	dma_buf_mnt = kern_mount(&dma_buf_fs_type);
+	if (IS_ERR(dma_buf_mnt))
+		return PTR_ERR(dma_buf_mnt);
+
 	mutex_init(&db_list.lock);
 	INIT_LIST_HEAD(&db_list.head);
 	dma_buf_init_debugfs();
@@ -1146,5 +1196,6 @@ subsys_initcall(dma_buf_init);
 static void __exit dma_buf_deinit(void)
 {
 	dma_buf_uninit_debugfs();
+	kern_unmount(dma_buf_mnt);
 }
 __exitcall(dma_buf_deinit);
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index f8c00045d537..665e18627f78 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -91,5 +91,6 @@
 #define UDF_SUPER_MAGIC		0x15013346
 #define BALLOON_KVM_MAGIC	0x13661366
 #define ZSMALLOC_MAGIC		0x58295829
+#define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
 
 #endif /* __LINUX_MAGIC_H__ */
-- 
2.22.0.410.gd8fdbe21b5-goog

