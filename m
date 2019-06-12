Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB5EC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B552053B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mu7ieJ4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393666AbfFMRPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:15:34 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:48492 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfFLVsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 17:48:32 -0400
Received: by mail-yw1-f73.google.com with SMTP id t128so18860884ywd.15
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 14:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UTvLD/wD588ESHmoVIZCejau/hPfDwnsdJsCywqHwAA=;
        b=Mu7ieJ4dJr5A88meQ9qVtn/HkSV/004ezi4zuqk7cCe+YsOH9wCM4of1Oqhr2u8V98
         A7XEWbgP/tsh554OaRpnmXbSFFre7Jc+QrCaTmhJOqBSWnqBgBgTo9cBXLXVcmziWkS1
         UjQXUsPXhBsbOWxWOGA6PMqDywM9rQ8BfeZRifMf/pQPnIYQ7ECbI3tgKqvYJFI8Cj3h
         BIdUd4vPAPPZEIC14cPiFvZSxyRgoGgqjwM9FOZUONWn1COvjWof9/mLG+Xlg46zmROQ
         1o7LZTchCx0+tfw8XyQx8m7VHr1vBOnvbdMnFrCNcHpK4S1tnsPi2ptbqadwtHiHkbGT
         SJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UTvLD/wD588ESHmoVIZCejau/hPfDwnsdJsCywqHwAA=;
        b=lcvn2s2kaYvKaOKgPaB6vHH3o469uKgALCkFFAJoI44PX/vaaYQoQl/6/9TWQbbmH8
         Xb7E2LIiqgOybrPeHgDs7zDDEsaOC5XvdPsTdhyOiourLLpPkWPoHuqALbXjDw98bVvO
         uJpym4JuClQexG7hcbYwYrfuK+oogaeSIDRZlhxPkVUYBIRaUX1UE2T0a2JghFci7Dlv
         u5QmG/LJzeCkkIByT50xOWoXVFENK1Nft6TBLJakFIi6qt53eScflWTmvzYF7gz9tzGr
         1lQ/QTXn7yiPYpM09HpyG0Te4oAsfWIehjokGSQrINURSaSn5VMsE051bX9Tvc6nyqZI
         EVyw==
X-Gm-Message-State: APjAAAUK9Fz8fCgETh2cxMT63ruCsmA4E/q2Hn0TksIvUeKJ7bgihRG8
        Ui7jifSdsg73+ucmAddmfLCUL9dI+8Gq2XsdFvqUVW3cG6+B6QNnm6RmAoaz1LYq6L+Qsvthcdr
        c5QkemdFeIfm6bG+jeBsNJQdCZ3zUK30RqD2poRpXcsgOVuwZq1BAs8lB+Gf5WjQesO4=
X-Google-Smtp-Source: APXvYqxzVHSBLfhQspuBOmQnqTs3mkYhIaCZKmk5HFnMNN5m3v06aytJ4m926pXsuFtvTrJvWi1F8oKmwQ==
X-Received: by 2002:a81:5944:: with SMTP id n65mr25260743ywb.182.1560376111464;
 Wed, 12 Jun 2019 14:48:31 -0700 (PDT)
Date:   Wed, 12 Jun 2019 14:48:22 -0700
In-Reply-To: <20190612214823.251491-1-fengc@google.com>
Message-Id: <20190612214823.251491-3-fengc@google.com>
Mime-Version: 1.0
References: <20190612214823.251491-1-fengc@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v4 2/3] dma-buf: add DMA_BUF_SET_NAME ioctls
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
 drivers/dma-buf/dma-buf.c    | 64 ++++++++++++++++++++++++++++++++++--
 include/linux/dma-buf.h      |  5 ++-
 include/uapi/linux/dma-buf.h |  3 ++
 3 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index ffd5a2ad7d6f..87a928c93c1a 100644
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
@@ -297,6 +313,42 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
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
@@ -335,6 +387,10 @@ static long dma_buf_ioctl(struct file *file,
 			ret = dma_buf_begin_cpu_access(dmabuf, direction);
 
 		return ret;
+
+	case DMA_BUF_SET_NAME:
+		return dma_buf_set_name(dmabuf, (const char __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
@@ -376,6 +432,7 @@ static struct file *dma_buf_getfile(struct dma_buf *dmabuf, int flags)
 		goto err_alloc_file;
 	file->f_flags = flags & (O_ACCMODE | O_NONBLOCK);
 	file->private_data = dmabuf;
+	file->f_path.dentry->d_fsdata = dmabuf;
 
 	return file;
 
@@ -1082,12 +1139,13 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
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
2.22.0.rc2.383.gf4fbbf30c2-goog

