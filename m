Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AB1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2359B20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370026;
	bh=8cxvyUW1oH7AEVOve6H9pqx5tNCWe76PYQ9jHcD3YUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NgThWPSdEyd1CPiAgRSiqhv9jqpu64OmSelSxlpiiGhONO01QivrsmIt9Wj9SGRtO
	 qteqeXdJSljctAmydLDh3mG5nDDO+/g5a/Rj37NHnT+8dVAPdd3C+CQB9Y0NReDN4k
	 PHxMUlBTpx0OTYO8+kGnQN51G9gmCNzNcNilUGxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbfDDJ1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:27:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387454AbfDDJMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:12:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC38120820;
        Thu,  4 Apr 2019 09:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369167;
        bh=8cxvyUW1oH7AEVOve6H9pqx5tNCWe76PYQ9jHcD3YUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bs7Vb++OfRZxMcm0eYDXwdYY2Th4AqRO7siGAwUBY+VzSXC15CPo1DbSYuHCU6w/h
         Sbwyux6jADgrkd/ZUdwH2FX3krUlhkjHQu4tlt36kIqhQtKURPf/E0OUqTbhKGAaSG
         g9yqpQmSl70rDn9Twon2Y71umX1/Qy/ztind5q/I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 122/246] xen/gntdev: Do not destroy context while dma-bufs are in use
Date:   Thu,  4 Apr 2019 10:47:02 +0200
Message-Id: <20190404084623.427787398@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



