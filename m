Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D09FC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCAB42075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714611;
	bh=pejRGIFl0fvX682w+mOfpHyAqMv3Hn7iUSvhvv3Sefo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MkBa9tQjorWb59FwReDqQKrsdW7J4VwD3uJFVqwIOFXtJZl1+NQiDgi7zzUewtcXE
	 YYmxGbDPFHqmDEVuHD32Ae5OKgGq0dAono54Z/a6vqcG8Vr+2uu9KPw5WEm013sHTO
	 xx2aJvmFqLkMskB7Y06TrgE+FTBJjRVahRt0vUoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbfC0SGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:06:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387809AbfC0SF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:05:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5EBB21734;
        Wed, 27 Mar 2019 18:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709955;
        bh=pejRGIFl0fvX682w+mOfpHyAqMv3Hn7iUSvhvv3Sefo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=reQfrQypKL1KEuPpYhV9U7BPSmudpdH7rbqCjbmTp325F+awWvhasLzI/vlwaQGu2
         oYgbhlISx6b5CfQLSHS8uXVFWokCViUoTw6HqBjATow6TDheVuqSnjvkOIyto9ezST
         +TIIFIQtySneI+VD2G5D8/C9GqQq6Pwmw5HeMgM8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 130/262] xen/gntdev: Do not destroy context while dma-bufs are in use
Date:   Wed, 27 Mar 2019 13:59:45 -0400
Message-Id: <20190327180158.10245-130-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

[ Upstream commit fa13e665e02874c0a5f4d06d6967ae34a6cb3d6a ]

If there are exported DMA buffers which are still in use and
grant device is closed by either normal user-space close or by
a signal this leads to the grant device context to be destroyed,
thus making it not possible to correctly destroy those exported
buffers when they are returned back to gntdev and makes the module
crash:

[  339.617540] [<ffff00000854c0d8>] dmabuf_exp_ops_release+0x40/0xa8
[  339.617560] [<ffff00000867a6e8>] dma_buf_release+0x60/0x190
[  339.617577] [<ffff0000082211f0>] __fput+0x88/0x1d0
[  339.617589] [<ffff000008221394>] ____fput+0xc/0x18
[  339.617607] [<ffff0000080ed4e4>] task_work_run+0x9c/0xc0
[  339.617622] [<ffff000008089714>] do_notify_resume+0xfc/0x108

Fix this by referencing gntdev on each DMA buffer export and
unreferencing on buffer release.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Reviewed-by: Boris Ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/gntdev-dmabuf.c | 12 +++++++++++-
 drivers/xen/gntdev-dmabuf.h |  2 +-
 drivers/xen/gntdev.c        |  2 +-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/gntdev-dmabuf.c b/drivers/xen/gntdev-dmabuf.c
index cba6b586bfbd..d97fcfc5e558 100644
--- a/drivers/xen/gntdev-dmabuf.c
+++ b/drivers/xen/gntdev-dmabuf.c
@@ -80,6 +80,12 @@ struct gntdev_dmabuf_priv {
 	struct list_head imp_list;
 	/* This is the lock which protects dma_buf_xxx lists. */
 	struct mutex lock;
+	/*
+	 * We reference this file while exporting dma-bufs, so
+	 * the grant device context is not destroyed while there are
+	 * external users alive.
+	 */
+	struct file *filp;
 };
 
 /* DMA buffer export support. */
@@ -311,6 +317,7 @@ static void dmabuf_exp_release(struct kref *kref)
 
 	dmabuf_exp_wait_obj_signal(gntdev_dmabuf->priv, gntdev_dmabuf);
 	list_del(&gntdev_dmabuf->next);
+	fput(gntdev_dmabuf->priv->filp);
 	kfree(gntdev_dmabuf);
 }
 
@@ -423,6 +430,7 @@ static int dmabuf_exp_from_pages(struct gntdev_dmabuf_export_args *args)
 	mutex_lock(&args->dmabuf_priv->lock);
 	list_add(&gntdev_dmabuf->next, &args->dmabuf_priv->exp_list);
 	mutex_unlock(&args->dmabuf_priv->lock);
+	get_file(gntdev_dmabuf->priv->filp);
 	return 0;
 
 fail:
@@ -834,7 +842,7 @@ long gntdev_ioctl_dmabuf_imp_release(struct gntdev_priv *priv,
 	return dmabuf_imp_release(priv->dmabuf_priv, op.fd);
 }
 
-struct gntdev_dmabuf_priv *gntdev_dmabuf_init(void)
+struct gntdev_dmabuf_priv *gntdev_dmabuf_init(struct file *filp)
 {
 	struct gntdev_dmabuf_priv *priv;
 
@@ -847,6 +855,8 @@ struct gntdev_dmabuf_priv *gntdev_dmabuf_init(void)
 	INIT_LIST_HEAD(&priv->exp_wait_list);
 	INIT_LIST_HEAD(&priv->imp_list);
 
+	priv->filp = filp;
+
 	return priv;
 }
 
diff --git a/drivers/xen/gntdev-dmabuf.h b/drivers/xen/gntdev-dmabuf.h
index 7220a53d0fc5..3d9b9cf9d5a1 100644
--- a/drivers/xen/gntdev-dmabuf.h
+++ b/drivers/xen/gntdev-dmabuf.h
@@ -14,7 +14,7 @@
 struct gntdev_dmabuf_priv;
 struct gntdev_priv;
 
-struct gntdev_dmabuf_priv *gntdev_dmabuf_init(void);
+struct gntdev_dmabuf_priv *gntdev_dmabuf_init(struct file *filp);
 
 void gntdev_dmabuf_fini(struct gntdev_dmabuf_priv *priv);
 
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 5efc5eee9544..7cf9c51318aa 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -600,7 +600,7 @@ static int gntdev_open(struct inode *inode, struct file *flip)
 	mutex_init(&priv->lock);
 
 #ifdef CONFIG_XEN_GNTDEV_DMABUF
-	priv->dmabuf_priv = gntdev_dmabuf_init();
+	priv->dmabuf_priv = gntdev_dmabuf_init(flip);
 	if (IS_ERR(priv->dmabuf_priv)) {
 		ret = PTR_ERR(priv->dmabuf_priv);
 		kfree(priv);
-- 
2.19.1

