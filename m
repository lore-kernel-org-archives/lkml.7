Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C57C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B0720B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 22:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GyGnRENN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfFMWeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 18:34:19 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:53022 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfFMWeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 18:34:17 -0400
Received: by mail-pf1-f201.google.com with SMTP id i123so270608pfb.19
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 15:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J4ytIORJumhKYNTWmDAQGDRs76owE/74q5EjtD6QatM=;
        b=GyGnRENNTaMxLzAQjH4/+ZdxCxsNttqUtWOOkK/fp6u1D+yMeTJ3b53M6X5v+N1QEW
         uLoSo2HfSzD8bYvP+jGm5yxFgK6wLxsACFks0gaEGsCtz2Cj+8fbdwIwABRSrizsyQcY
         +Z2Y9DcEFlq/BVIMR0QkYzMd7Cb/o7rl8Yr+FrbdnlL5ge8/SEa7INdTI897Tk2fh8k3
         FlPx8ULwjP52SmTvBFfaOmpIPGzAk0Z/bZTl9ciedMVT78giq0KAT/RopF4FKCFrEl/Q
         /NFj5gJpKyLtK03T1lBZQiiXLL0ifH7tzbUSQY1ckYoMntkeEms2EOEEuEQSUTIUJurS
         eHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J4ytIORJumhKYNTWmDAQGDRs76owE/74q5EjtD6QatM=;
        b=fvb0HKZwhSTi226ezVGQ3SyP+XwrRW5LzRJSWfa3+ovMbt+rfEYm++9Eno3FYJunf+
         DRMrxeTc/Vnq+0Ry7TzKzV7hltaKqbElW6hZGQvjHCWvDoJMHJ39bUR4gcrEzyopQcYW
         HQyH5Bo5cXGjEtIvFnkqQXGIxJ7zAFM4U/APj9vbeEyDvvWnHVlr+IS6XTJIiLxfmiiI
         mssRsHkdn7RRIIP+Kj5V6QD7b25sTt8N2NMUv0mEa9XOf0Ys5c8Sm01Gum257noVHy0Q
         sl5LoR+AH96hQ01drZI/GxEeEEZAsyJBw1/Fc3C14y/IuHPwjyu7D80BQiFbOcxrmrs9
         H3dQ==
X-Gm-Message-State: APjAAAUomWwQ+wCg8n2+O0zRb4N3WDGzk/jJPsYfd60AT8USob7I9DZd
        xhbeAkdAAhnHbzbrB3YkRBkc5EZ9zVTI4bWf4DuUF7hsn6tok1A4XahAWOk5e1Ej8boMUVFWrW2
        IZbhpvAzbZwdF79WNo0kh8Tr4H0xX7/zrRUmyswJdOKlcxlrVB+qs2spqsMA37+NFczs=
X-Google-Smtp-Source: APXvYqxBcdRhXqURm+dQotoRgvI6FWvjI4ZZo/9XJgTnfdexpM2EvoVd83CzQQWG2yCVij+1p0PU6/umrw==
X-Received: by 2002:a63:5207:: with SMTP id g7mr31696554pgb.356.1560465256872;
 Thu, 13 Jun 2019 15:34:16 -0700 (PDT)
Date:   Thu, 13 Jun 2019 15:34:07 -0700
In-Reply-To: <20190613223408.139221-1-fengc@google.com>
Message-Id: <20190613223408.139221-3-fengc@google.com>
Mime-Version: 1.0
References: <20190613223408.139221-1-fengc@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 2/3] dma-buf: add DMA_BUF_SET_NAME ioctls
From:   Chenbo Feng <fengc@google.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sumit Semwal <sumit.semwal@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Hackmann <ghackmann@google.com>

This patch adds complimentary DMA_BUF_SET_NAME  ioctls, which lets
userspace processes attach a free-form name to each buffer.

This information can be extremely helpful for tracking and accounting
shared buffers.  For example, on Android, we know what each buffer will
be used for at allocation time: GL, multimedia, camera, etc.  The
userspace allocator can use DMA_BUF_SET_NAME to associate that
information with the buffer, so we can later give developers a
breakdown of how much memory they're allocating for graphics, camera,
etc.

Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Chenbo Feng <fengc@google.com>
---
 drivers/dma-buf/dma-buf.c    | 65 ++++++++++++++++++++++++++++++++++--
 include/linux/dma-buf.h      |  5 ++-
 include/uapi/linux/dma-buf.h |  3 ++
 3 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index ffd5a2ad7d6f..2c862e36c947 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -48,8 +48,24 @@ struct dma_buf_list {
 
 static struct dma_buf_list db_list;
 
+static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
+{
+	struct dma_buf *dmabuf;
+	char name[DMA_BUF_NAME_LEN];
+	size_t ret = 0;
+
+	dmabuf = dentry->d_fsdata;
+	mutex_lock(&dmabuf->lock);
+	if (dmabuf->name)
+		ret = strlcpy(name, dmabuf->name, DMA_BUF_NAME_LEN);
+	mutex_unlock(&dmabuf->lock);
+
+	return dynamic_dname(dentry, buffer, buflen, "/%s:%s",
+			     dentry->d_name.name, ret > 0 ? name : "");
+}
+
 static const struct dentry_operations dma_buf_dentry_ops = {
-	.d_dname = simple_dname,
+	.d_dname = dmabuffs_dname,
 };
 
 static struct vfsmount *dma_buf_mnt;
@@ -297,6 +313,43 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
 	return events;
 }
 
+/**
+ * dma_buf_set_name - Set a name to a specific dma_buf to track the usage.
+ * The name of the dma-buf buffer can only be set when the dma-buf is not
+ * attached to any devices. It could theoritically support changing the
+ * name of the dma-buf if the same piece of memory is used for multiple
+ * purpose between different devices.
+ *
+ * @dmabuf [in]     dmabuf buffer that will be renamed.
+ * @buf:   [in]     A piece of userspace memory that contains the name of
+ *                  the dma-buf.
+ *
+ * Returns 0 on success. If the dma-buf buffer is already attached to
+ * devices, return -EBUSY.
+ *
+ */
+static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
+{
+	char *name = strndup_user(buf, DMA_BUF_NAME_LEN);
+	long ret = 0;
+
+	if (IS_ERR(name))
+		return PTR_ERR(name);
+
+	mutex_lock(&dmabuf->lock);
+	if (!list_empty(&dmabuf->attachments)) {
+		ret = -EBUSY;
+		kfree(name);
+		goto out_unlock;
+	}
+	kfree(dmabuf->name);
+	dmabuf->name = name;
+
+out_unlock:
+	mutex_unlock(&dmabuf->lock);
+	return ret;
+}
+
 static long dma_buf_ioctl(struct file *file,
 			  unsigned int cmd, unsigned long arg)
 {
@@ -335,6 +388,10 @@ static long dma_buf_ioctl(struct file *file,
 			ret = dma_buf_begin_cpu_access(dmabuf, direction);
 
 		return ret;
+
+	case DMA_BUF_SET_NAME:
+		return dma_buf_set_name(dmabuf, (const char __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
@@ -376,6 +433,7 @@ static struct file *dma_buf_getfile(struct dma_buf *dmabuf, int flags)
 		goto err_alloc_file;
 	file->f_flags = flags & (O_ACCMODE | O_NONBLOCK);
 	file->private_data = dmabuf;
+	file->f_path.dentry->d_fsdata = dmabuf;
 
 	return file;
 
@@ -1082,12 +1140,13 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
 			continue;
 		}
 
-		seq_printf(s, "%08zu\t%08x\t%08x\t%08ld\t%s\t%08lu\n",
+		seq_printf(s, "%08zu\t%08x\t%08x\t%08ld\t%s\t%08lu\t%s\n",
 				buf_obj->size,
 				buf_obj->file->f_flags, buf_obj->file->f_mode,
 				file_count(buf_obj->file),
 				buf_obj->exp_name,
-				file_inode(buf_obj->file)->i_ino);
+				file_inode(buf_obj->file)->i_ino,
+				buf_obj->name ?: "");
 
 		robj = buf_obj->resv;
 		while (true) {
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 58725f890b5b..582998e19df6 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -255,10 +255,12 @@ struct dma_buf_ops {
  * @file: file pointer used for sharing buffers across, and for refcounting.
  * @attachments: list of dma_buf_attachment that denotes all devices attached.
  * @ops: dma_buf_ops associated with this buffer object.
- * @lock: used internally to serialize list manipulation, attach/detach and vmap/unmap
+ * @lock: used internally to serialize list manipulation, attach/detach and
+ *        vmap/unmap, and accesses to name
  * @vmapping_counter: used internally to refcnt the vmaps
  * @vmap_ptr: the current vmap ptr if vmapping_counter > 0
  * @exp_name: name of the exporter; useful for debugging.
+ * @name: userspace-provided name; useful for accounting and debugging.
  * @owner: pointer to exporter module; used for refcounting when exporter is a
  *         kernel module.
  * @list_node: node for dma_buf accounting and debugging.
@@ -286,6 +288,7 @@ struct dma_buf {
 	unsigned vmapping_counter;
 	void *vmap_ptr;
 	const char *exp_name;
+	const char *name;
 	struct module *owner;
 	struct list_head list_node;
 	void *priv;
diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
index d75df5210a4a..dbc7092e04b5 100644
--- a/include/uapi/linux/dma-buf.h
+++ b/include/uapi/linux/dma-buf.h
@@ -35,7 +35,10 @@ struct dma_buf_sync {
 #define DMA_BUF_SYNC_VALID_FLAGS_MASK \
 	(DMA_BUF_SYNC_RW | DMA_BUF_SYNC_END)
 
+#define DMA_BUF_NAME_LEN	32
+
 #define DMA_BUF_BASE		'b'
 #define DMA_BUF_IOCTL_SYNC	_IOW(DMA_BUF_BASE, 0, struct dma_buf_sync)
+#define DMA_BUF_SET_NAME	_IOW(DMA_BUF_BASE, 1, const char *)
 
 #endif
-- 
2.22.0.410.gd8fdbe21b5-goog

