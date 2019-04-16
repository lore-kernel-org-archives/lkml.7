Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DADC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D139F206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3e1Nm3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfDPSjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:39:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37966 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730348AbfDPSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:38:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so290951wmc.3;
        Tue, 16 Apr 2019 11:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TLleK0VtrURc8NakouQBGkqZbPDHg07f9BvqliSxF70=;
        b=h3e1Nm3R3xsbD+PYUqSpNvsqvv25b71V1k+JePPL/XPpDetWnd7J/zs42/KuJEfJGF
         S9MVNlIxKBIr/pxNEFOa7GVi+5nYrR3xQQgIRMCBdti8z6/C2FkP5W1ZhONqzIGoXd/p
         joJoIrnNevNZVJuInDW7FJNIlEtpaHygBfUS/dFzlUCrAHNTdQlVprBu+rtP8RR6/yUr
         ByNbE8HMarmtuTKhwQhx9TG1Ukycwhdhgb76FVzBL9wRYQhWF3ZLB7wapcE1sIXCfUpM
         hXkRscYpsz9Zbl4yBd2ABW0K5gbKn3MNDCTGJ+E39/cU69vsf09kV5AxUfsOEFCPWRZV
         UO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TLleK0VtrURc8NakouQBGkqZbPDHg07f9BvqliSxF70=;
        b=TFMEIalIJRUTUAj7XZFZDWvWdfVQmgnbvi0kb0xmCmHp5oRFA2/GmXBICgeBYChwXO
         Q44TxoQEFf5/aqDBsWvLl97BzmPegW08KkZ8LprFlI08cMVgfh2z59un2zjzeykzlNAv
         J7poMM/oB9PdlQ5mP+wmNZgC/PfKoHhPnuTOwss3QNa/X4N3I2fn7W3j7Bi9NxcNVeqg
         v2EIQmNEMApzyO8Si6kBnXwpuaiwf8S8hjV4jqq3pWH3IjsNPWvUpgKYYkwjZvHicHQF
         a1fkaHejipVStYMONBebrLaL3ppKUh0SYyfjYgx/VWQ/dlYaiV+AXfVTfwMwLpLY2nVW
         iQnw==
X-Gm-Message-State: APjAAAUGPHFzim33sz87Stx/lteDFnzmVh1DQ2zrTm90apTu0zIY/Pu1
        RTdhUHZFjBKr5RaeGbGXtn61a0ZZ
X-Google-Smtp-Source: APXvYqz07VW+fNme+N9AqBbL6HOJCdOJCyAxD2ZszHK1Hf1dhl/j/yKTr8NoWJMd6oM74U0ThWkt2w==
X-Received: by 2002:a1c:eb07:: with SMTP id j7mr26684391wmh.138.1555439931201;
        Tue, 16 Apr 2019 11:38:51 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:fcfa:e34f:82c0:3f66])
        by smtp.gmail.com with ESMTPSA id m13sm128823wmg.42.2019.04.16.11.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:38:50 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/12] dma-buf: add explicit buffer pinning
Date:   Tue, 16 Apr 2019 20:38:34 +0200
Message-Id: <20190416183841.1577-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190416183841.1577-1-christian.koenig@amd.com>
References: <20190416183841.1577-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional explicit pinning callbacks instead of implicitly assume the
exporter pins the buffer when a mapping is created.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-buf.c | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/dma-buf.h   | 37 +++++++++++++++++++++++++++++++------
 2 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index a3738fab3927..f23ff8355505 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -630,6 +630,41 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
 }
 EXPORT_SYMBOL_GPL(dma_buf_detach);
 
+/**
+ * dma_buf_pin - Lock down the DMA-buf
+ *
+ * @dmabuf:	[in]	DMA-buf to lock down.
+ *
+ * Returns:
+ * 0 on success, negative error code on failure.
+ */
+int dma_buf_pin(struct dma_buf *dmabuf)
+{
+	int ret = 0;
+
+	reservation_object_assert_held(dmabuf->resv);
+
+	if (dmabuf->ops->pin)
+		ret = dmabuf->ops->pin(dmabuf);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dma_buf_pin);
+
+/**
+ * dma_buf_unpin - Remove lock from DMA-buf
+ *
+ * @dmabuf:	[in]	DMA-buf to unlock.
+ */
+void dma_buf_unpin(struct dma_buf *dmabuf)
+{
+	reservation_object_assert_held(dmabuf->resv);
+
+	if (dmabuf->ops->unpin)
+		dmabuf->ops->unpin(dmabuf);
+}
+EXPORT_SYMBOL_GPL(dma_buf_unpin);
+
 /**
  * dma_buf_map_attachment_locked - Maps the buffer into _device_ address space
  * with the reservation lock held. Is a wrapper for map_dma_buf() of the
@@ -666,6 +701,8 @@ dma_buf_map_attachment_locked(struct dma_buf_attachment *attach,
 	 */
 	if (attach->invalidate)
 		list_del(&attach->node);
+	else
+		dma_buf_pin(attach->dmabuf);
 	sg_table = attach->dmabuf->ops->map_dma_buf(attach, direction);
 	if (attach->invalidate)
 		list_add(&attach->node, &attach->dmabuf->attachments);
@@ -735,6 +772,8 @@ void dma_buf_unmap_attachment_locked(struct dma_buf_attachment *attach,
 
 	attach->dmabuf->ops->unmap_dma_buf(attach, sg_table,
 						direction);
+	if (!attach->invalidate)
+		dma_buf_unpin(attach->dmabuf);
 }
 EXPORT_SYMBOL_GPL(dma_buf_unmap_attachment_locked);
 
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index ece4638359a8..a615b74e5894 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -100,14 +100,40 @@ struct dma_buf_ops {
 	 */
 	void (*detach)(struct dma_buf *, struct dma_buf_attachment *);
 
+	/**
+	 * @pin_dma_buf:
+	 *
+	 * This is called by dma_buf_pin and lets the exporter know that an
+	 * importer assumes that the DMA-buf can't be invalidated any more.
+	 *
+	 * This is called with the dmabuf->resv object locked.
+	 *
+	 * This callback is optional.
+	 *
+	 * Returns:
+	 *
+	 * 0 on success, negative error code on failure.
+	 */
+	int (*pin)(struct dma_buf *);
+
+	/**
+	 * @unpin_dma_buf:
+	 *
+	 * This is called by dma_buf_unpin and lets the exporter know that an
+	 * importer doesn't need to the DMA-buf to stay were it is any more.
+	 *
+	 * This is called with the dmabuf->resv object locked.
+	 *
+	 * This callback is optional.
+	 */
+	void (*unpin)(struct dma_buf *);
+
 	/**
 	 * @map_dma_buf:
 	 *
 	 * This is called by dma_buf_map_attachment() and is used to map a
 	 * shared &dma_buf into device address space, and it is mandatory. It
-	 * can only be called if @attach has been called successfully. This
-	 * essentially pins the DMA buffer into place, and it cannot be moved
-	 * any more
+	 * can only be called if @attach has been called successfully.
 	 *
 	 * This call may sleep, e.g. when the backing storage first needs to be
 	 * allocated, or moved to a location suitable for all currently attached
@@ -148,9 +174,6 @@ struct dma_buf_ops {
 	 *
 	 * This is called by dma_buf_unmap_attachment() and should unmap and
 	 * release the &sg_table allocated in @map_dma_buf, and it is mandatory.
-	 * It should also unpin the backing storage if this is the last mapping
-	 * of the DMA buffer, it the exporter supports backing storage
-	 * migration.
 	 *
 	 * This is always called with the dmabuf->resv object locked when
 	 * no_sgt_cache is true.
@@ -442,6 +465,8 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags);
 struct dma_buf *dma_buf_get(int fd);
 void dma_buf_put(struct dma_buf *dmabuf);
 
+int dma_buf_pin(struct dma_buf *dmabuf);
+void dma_buf_unpin(struct dma_buf *dmabuf);
 struct sg_table *dma_buf_map_attachment_locked(struct dma_buf_attachment *,
 					       enum dma_data_direction);
 struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
-- 
2.17.1

