Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4634C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F7ED20449
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAsCHbJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfDPSiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:38:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43703 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbfDPSit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:38:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so23794423wrx.10;
        Tue, 16 Apr 2019 11:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FQjGrY5BOcl8yYSAGB0H12JRjT7ZcBW9E7af5GsHYPk=;
        b=GAsCHbJLbkAY2QKeOH6xG7dbIdOQF8roD0mkA+N5KbhfZfOE7d13/I1tSthup4EHq+
         uKGQs8YoK/PsJDmTmdhwG2uLXf9Hkrk2KB2Jc3cF9vfneK3FzsF1KPffq2TgtJb/V/AT
         e3fWZ1+ckhxtl/maSPZVK3CTZcwTv4wMB20zAuPLj393Z7v8nCdjOQL9a9UN4dL9M0sA
         fsbAyZnKD9yGZxMXXBxGGwOHTA+HzarYlbHHc5Cm8Buqfvkcf+uXVufUIZLLDvAOYTEM
         OFk+ZXMab6A8b7B7bnSpD6CAqh2OHklloPSif6HYgRjlGjN+b2BcUWjo67BGW8TNOBof
         m6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FQjGrY5BOcl8yYSAGB0H12JRjT7ZcBW9E7af5GsHYPk=;
        b=Ddb05fRSTpPZlHlLA1mUPqiqLaVZ4XXClGRefukIPkpkBqdJuC7cUGbXaSIBmMyGyO
         qaRABxOG3Wq8hJzo8Y+VE7SRlXSsFjTjKD8rWorioos35pQ61loatTdJR7fEiQuA0by1
         9lZ4TSvPMbquIlBBUp6htoYq1nEOxIrMm4tGpBlrDU6ibruW7hgqAtIkj/aaAQmYhaFu
         XbXQe4fbXrkkHV8lz7xplBTx6gy80Q6aWBUlMFW4SITxXLleBJI4mw5ktki+AMuVAoYt
         rE80GCoyXiAvLG28vm9XYKFZuVLlXvtApQXej9EnKFoGfZ8GjDJ5z6U5+D3Wq5PZZeDo
         6LIw==
X-Gm-Message-State: APjAAAXAYDW28+F8hbFz+/9RV9jrWkXeCVUxd/SumPN4esN2wnMxz2Rg
        cnG09x72nRS4VkT15objE3w=
X-Google-Smtp-Source: APXvYqz9bGkrKovIQjBoaiEcUvlwH8O2iiEPhRcRzRKJ+bK5KogrUdwYMoNwoy0d5uWpMmxL3BzDxA==
X-Received: by 2002:adf:e547:: with SMTP id z7mr56995337wrm.295.1555439927536;
        Tue, 16 Apr 2019 11:38:47 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:fcfa:e34f:82c0:3f66])
        by smtp.gmail.com with ESMTPSA id m13sm128823wmg.42.2019.04.16.11.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:38:47 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/12] dma-buf: add dynamic caching of sg_table
Date:   Tue, 16 Apr 2019 20:38:30 +0200
Message-Id: <20190416183841.1577-2-christian.koenig@amd.com>
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

To allow a smooth transition from pinning buffer objects to dynamic
invalidation we first start to cache the sg_table for an attachment
unless the driver explicitly says to not do so.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-buf.c | 24 ++++++++++++++++++++++++
 include/linux/dma-buf.h   | 11 +++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 7c858020d14b..65161a82d4d5 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -573,6 +573,20 @@ struct dma_buf_attachment *dma_buf_attach(struct dma_buf *dmabuf,
 	list_add(&attach->node, &dmabuf->attachments);
 
 	mutex_unlock(&dmabuf->lock);
+
+	if (!dmabuf->ops->dynamic_sgt_mapping) {
+		struct sg_table *sgt;
+
+		sgt = dmabuf->ops->map_dma_buf(attach, DMA_BIDIRECTIONAL);
+		if (!sgt)
+			sgt = ERR_PTR(-ENOMEM);
+		if (IS_ERR(sgt)) {
+			dma_buf_detach(dmabuf, attach);
+			return ERR_CAST(sgt);
+		}
+		attach->sgt = sgt;
+	}
+
 	return attach;
 
 err_attach:
@@ -595,6 +609,10 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
 	if (WARN_ON(!dmabuf || !attach))
 		return;
 
+	if (attach->sgt)
+		dmabuf->ops->unmap_dma_buf(attach, attach->sgt,
+					   DMA_BIDIRECTIONAL);
+
 	mutex_lock(&dmabuf->lock);
 	list_del(&attach->node);
 	if (dmabuf->ops->detach)
@@ -630,6 +648,9 @@ struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
 	if (WARN_ON(!attach || !attach->dmabuf))
 		return ERR_PTR(-EINVAL);
 
+	if (attach->sgt)
+		return attach->sgt;
+
 	sg_table = attach->dmabuf->ops->map_dma_buf(attach, direction);
 	if (!sg_table)
 		sg_table = ERR_PTR(-ENOMEM);
@@ -657,6 +678,9 @@ void dma_buf_unmap_attachment(struct dma_buf_attachment *attach,
 	if (WARN_ON(!attach || !attach->dmabuf || !sg_table))
 		return;
 
+	if (attach->sgt == sg_table)
+		return;
+
 	attach->dmabuf->ops->unmap_dma_buf(attach, sg_table,
 						direction);
 }
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 58725f890b5b..0d9c3c13c9fb 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -51,6 +51,16 @@ struct dma_buf_attachment;
  * @vunmap: [optional] unmaps a vmap from the buffer
  */
 struct dma_buf_ops {
+	/**
+	 * @dynamic_sgt_mapping:
+	 *
+	 * Flag controlling the caching of the sg_table in the DMA-buf helpers.
+	 * If not set the sg_table is created during device attaching, if set
+	 * the sg_table is created dynamically when dma_buf_map_attachment() is
+	 * called.
+	 */
+	bool dynamic_sgt_mapping;
+
 	/**
 	 * @attach:
 	 *
@@ -323,6 +333,7 @@ struct dma_buf_attachment {
 	struct device *dev;
 	struct list_head node;
 	void *priv;
+	struct sg_table *sgt;
 };
 
 /**
-- 
2.17.1

