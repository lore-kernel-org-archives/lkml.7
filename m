Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A7DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEADE21739
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JPbZoZDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfK1QvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:51:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37400 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfK1QuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:50:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id p24so13384599pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 08:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xgizS2ja8jWfUkSpIbZzCHqhCFBCkrH3reNwP/GggE4=;
        b=JPbZoZDaha09542iyB4HlV5SyQ6DTAJpv5Q3TJmdEp9BmETD/i1XTVIb+ywiCIN1nv
         iFSi5EaDWDVgT3cZefU2WyI90kZhp90IrppihlsCrB90kyAgihmTrdzb79Q6Cs6n2Zt4
         64131Dc5KvTzv5O5U/OhW/L8pOVodKVM/9rKcPwZIemHMV2F+g1PsoWpF272QtSYPVIA
         S1f4qXA2nSYcxs3e955yT1TqqkBPAWHx5BA46tf7JYW9Nbl6jMOgMVxzalEVIIiT57Gt
         cCnrHd+k9IRVvJnBIPFwv46A1hORlLXKt+xT0ppDT3MlKk1FeZJ12TMXbtME2jcSQW+w
         CUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xgizS2ja8jWfUkSpIbZzCHqhCFBCkrH3reNwP/GggE4=;
        b=KadVQXIha071HSzr3ES/3wHipllcPkrPzbywBmt8zw1gA9Q8QNpkInUOkMiACAYezV
         STqJglyQNRvQ6eL/CaOvwVK9u0bJqJnwLeHyfOMq6IzmYVEEzV1neRCZqWxQJ10Z1pTf
         hKHLTp/UxACjERtsDGTSSNeoG6/KNsFh6aov6JNYNoIvd2XkqVZs8DfGmGRZqtW128wU
         mhppCkrV9qqeXY1UsDFo8Df/pfZD2m8sizlsMKdC7Bz0XCrfI2Zl312i7keNkELYPUmg
         tW14ZAH23DC25OUpPyA/jusWdBgjr1uGF3s9q0ucSVyjdCeeee/e1nRkxd4sUIJmAAri
         b6KA==
X-Gm-Message-State: APjAAAU7ACnUu7vDsXfMHSrDs6aXQpMY9f04P2Yu1bh653qcirCwJ1RM
        RkjVcmnqHYV7EJkOZOR5coQqBIyi4XU=
X-Google-Smtp-Source: APXvYqyrDO9jQHqib3oqT9BAbQOeWFk5IjUh08VvarLRNXbKvMR2SUbyJX7YPgSzvjWKOAAcE8nJGw==
X-Received: by 2002:a62:888c:: with SMTP id l134mr36436770pfd.216.1574959807222;
        Thu, 28 Nov 2019 08:50:07 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a15sm2450343pfh.169.2019.11.28.08.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:50:06 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 03/17] media: stm32-dcmi: fix DMA corruption when stopping streaming
Date:   Thu, 28 Nov 2019 09:49:48 -0700
Message-Id: <20191128165002.6234-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128165002.6234-1-mathieu.poirier@linaro.org>
References: <20191128165002.6234-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugues Fruchet <hugues.fruchet@st.com>

commit b3ce6f6ff3c260ee53b0f2236e5fd950d46957da upstream

Avoid call of dmaengine_terminate_all() between
dmaengine_prep_slave_single() and dmaengine_submit() by locking
the whole DMA submission sequence.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 1d9c028e52cb..d86944109cbf 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -164,6 +164,9 @@ struct stm32_dcmi {
 	int				errors_count;
 	int				overrun_count;
 	int				buffers_count;
+
+	/* Ensure DMA operations atomicity */
+	struct mutex			dma_lock;
 };
 
 static inline struct stm32_dcmi *notifier_to_dcmi(struct v4l2_async_notifier *n)
@@ -314,6 +317,13 @@ static int dcmi_start_dma(struct stm32_dcmi *dcmi,
 		return ret;
 	}
 
+	/*
+	 * Avoid call of dmaengine_terminate_all() between
+	 * dmaengine_prep_slave_single() and dmaengine_submit()
+	 * by locking the whole DMA submission sequence
+	 */
+	mutex_lock(&dcmi->dma_lock);
+
 	/* Prepare a DMA transaction */
 	desc = dmaengine_prep_slave_single(dcmi->dma_chan, buf->paddr,
 					   buf->size,
@@ -322,6 +332,7 @@ static int dcmi_start_dma(struct stm32_dcmi *dcmi,
 	if (!desc) {
 		dev_err(dcmi->dev, "%s: DMA dmaengine_prep_slave_single failed for buffer phy=%pad size=%zu\n",
 			__func__, &buf->paddr, buf->size);
+		mutex_unlock(&dcmi->dma_lock);
 		return -EINVAL;
 	}
 
@@ -333,9 +344,12 @@ static int dcmi_start_dma(struct stm32_dcmi *dcmi,
 	dcmi->dma_cookie = dmaengine_submit(desc);
 	if (dma_submit_error(dcmi->dma_cookie)) {
 		dev_err(dcmi->dev, "%s: DMA submission failed\n", __func__);
+		mutex_unlock(&dcmi->dma_lock);
 		return -ENXIO;
 	}
 
+	mutex_unlock(&dcmi->dma_lock);
+
 	dma_async_issue_pending(dcmi->dma_chan);
 
 	return 0;
@@ -717,7 +731,9 @@ static void dcmi_stop_streaming(struct vb2_queue *vq)
 	spin_unlock_irq(&dcmi->irqlock);
 
 	/* Stop all pending DMA operations */
+	mutex_lock(&dcmi->dma_lock);
 	dmaengine_terminate_all(dcmi->dma_chan);
+	mutex_unlock(&dcmi->dma_lock);
 
 	pm_runtime_put(dcmi->dev);
 
@@ -1719,6 +1735,7 @@ static int dcmi_probe(struct platform_device *pdev)
 
 	spin_lock_init(&dcmi->irqlock);
 	mutex_init(&dcmi->lock);
+	mutex_init(&dcmi->dma_lock);
 	init_completion(&dcmi->complete);
 	INIT_LIST_HEAD(&dcmi->buffers);
 
-- 
2.17.1

