Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2A3C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67DA2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DSVzJebP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390933AbfFKACk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 20:02:40 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:48162 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390557AbfFKACi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 20:02:38 -0400
Received: by mail-qk1-f202.google.com with SMTP id w184so9509023qka.15
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 17:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mlxJDYZKh9wYq/WtDU7yH8cffd94xLXLnzUxx7frAqI=;
        b=DSVzJebP/vLyoVpVnjGehsQzsDmXk6k5JGjxmSOW78EvEfGKdAGciSQnSsEqjt98G4
         fDtsNDKxuUWrYDzCnv2yVI4mmQs4YQB8rMuuwytlWyF2hPDS4Sh75V5Qp7vrOaSKSyGP
         vDwcvOi9v/pOLD52tq3XQn4lL47UYSOL3cndZKzkIuEl+jPJejv4MVeNJGsFFnoKQ/9D
         dqt+tNrxc7uX5dqke4BtP0TAKxOkrVdaEvfUFjeWbqqo55qy2OabWMYXqlVMq8Gub8Na
         eBK4nkNUlKPzdRx7nOaUd6L4L1Tm9W597KhcIgqhWO92RLm+dBAYnLax0gr1WNcjgwrr
         Dzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mlxJDYZKh9wYq/WtDU7yH8cffd94xLXLnzUxx7frAqI=;
        b=TtKaPWwxLvvZJ97ibJw8Hbgx4NsxbKr1/aCGzN5orxzGyvIa9e7dITrVSoQ/BYkH9q
         3Sd5m4Q/Nei9HdvVDGG2iFqXgDFDQO63lTyqVsvP/1Pe8EQ+Zp/WHz44sGqmTwAMmAVx
         FQ8jtdeAMAMXu+hhHe9kF1WCr1qcKBYF0bbQXBFLDGPwaYKK2EyxInq6BNs0NBQ1WvEt
         uV5iWt4XJZmDjyon/AbTX3O9uUjGxcSGv4+mJmPtq6DXuIB/0bm3C2JnrviS3IyUd8EH
         8qsbpqRH2oFvGSDSpTAMvrTNpsgjbWRHyJ7TQuiSWkOrv8uighuJCxT0abDPIZ+jAtkc
         G+8g==
X-Gm-Message-State: APjAAAU7CUrFP71Ct2+jVidx3gJf1xQNj/fyuJ1NwdRJDhkucdj0/Hhj
        gJA9ohO6TZWA3RZSJzCfg21Fs8kglTa2gbIrHA64ej2MfpaDD5I7KZCjjoAB1sRgEszitTUqQtO
        SSDOR5rTHfjsDLQ4sV/CmDBV9Ko5f0xJMPv0eoP9Wuznk+UzB5YXzAJ8zJkLwt7SShlg=
X-Google-Smtp-Source: APXvYqx8oU5ARKfbxwzGq9NA/QKLfJZ7gEgtYhoiCa00x5zkdmjlKLXZIsJM/rux/B4dPG9gFzMFoaxgdA==
X-Received: by 2002:ad4:43c1:: with SMTP id o1mr44294136qvs.226.1560211357551;
 Mon, 10 Jun 2019 17:02:37 -0700 (PDT)
Date:   Mon, 10 Jun 2019 17:02:29 -0700
In-Reply-To: <20190611000230.152670-1-fengc@google.com>
Message-Id: <20190611000230.152670-3-fengc@google.com>
Mime-Version: 1.0
References: <20190611000230.152670-1-fengc@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [RESEND PATCH v3 2/3] dma-buf: add DMA_BUF_{GET,SET}_NAME ioctls
From:   Chenbo Feng <fengc@google.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sumit Semwal <sumit.semwal@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Hackmann <ghackmann@google.com>

This patch adds complimentary DMA_BUF_SET_NAME and DMA_BUF_GET_NAME
ioctls, which lets userspace processes attach a free-form name to each
buffer.

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
 drivers/dma-buf/dma-buf.c    | 49 +++++++++++++++++++++++++++++++++---
 include/linux/dma-buf.h      |  5 +++-
 include/uapi/linux/dma-buf.h |  3 +++
 3 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index ffd5a2ad7d6f..c1da5f9ce44d 100644
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
@@ -297,6 +313,27 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
 	return events;
 }
 
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
@@ -335,6 +372,10 @@ static long dma_buf_ioctl(struct file *file,
 			ret = dma_buf_begin_cpu_access(dmabuf, direction);
 
 		return ret;
+
+	case DMA_BUF_SET_NAME:
+		return dma_buf_set_name(dmabuf, (const char __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
@@ -376,6 +417,7 @@ static struct file *dma_buf_getfile(struct dma_buf *dmabuf, int flags)
 		goto err_alloc_file;
 	file->f_flags = flags & (O_ACCMODE | O_NONBLOCK);
 	file->private_data = dmabuf;
+	file->f_path.dentry->d_fsdata = dmabuf;
 
 	return file;
 
@@ -1082,12 +1124,13 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
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

