Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C32C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1C920733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BmJCSnph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfKOWfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:35:08 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38404 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfKOWeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:34:02 -0500
Received: by mail-pl1-f195.google.com with SMTP id q18so1926213pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CfdEn/VOoyCYVCEhBtRjG/LrGez0kXMzdfAuimisWqo=;
        b=BmJCSnphEJxB/SJaEZ55rWx8UacuDIrgu3GGuKP9hxL0m0pDhN7q9J+QXmeNHU3a9S
         KcLpI35v0bQ7VN2vpFI89zIEmufoawp/UX+aj0AEhPZY1Ca6qiVHFhjEj/1Q6qpfeLYh
         gjoYQxSbf630RaEl3OM/6BIGdyMcJhAgPgaITE7CHkkMSKWyVALpX3aHE/rIyZ+534CU
         kKKAtB/FXySeSR4aPKIGgqnJPLZz5ZmoX7PLhvXCyZfRhjY/WwB2qknR22z51CDufEry
         KwJioKJ8hKDwJTr64gk0X3402S8pXsOhEqAEl6DeZUZcNxfDi9jgwWcFrfWjMc4Hltu1
         UKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CfdEn/VOoyCYVCEhBtRjG/LrGez0kXMzdfAuimisWqo=;
        b=qM88xGiu9RluA0Q5JQSMxTrkZZLQQtGqNQaz4nhEfq4ynqB3ujePqfJGFf1YWbWwwo
         Gj3Uq6p6loonu1FgXNrs640NhdR6+9Kg9zxho8ZB9wQSesJ11QV+m7wApGv7f7dlwTyO
         AX+Rg8naYvrFMCH4WxXkgtPwMD3s5iCZfu7eVFRxC5vX/NnKeqsZMnsO/8Re50zXbr3s
         AHIW8E6cRt5tZc5YSbz1M8dVXb3WBqy4q/ynbhJW/Dlz97UxGmNhYZmVA/OGtuopL07B
         zsCUthMAc4kGCXA12JU8U1/Y0EziobBxnMyWeYzBYiWYItBZ9S5YXKzv2VBb64bzWeLY
         V/Jg==
X-Gm-Message-State: APjAAAWRsvNEfiMPF30lQpvZPW0cuymG4+SFYYJziMYu0bDcQJ2Af+Xc
        QEj5pfvebvjWe0AA/wzPbWmOCan37AM=
X-Google-Smtp-Source: APXvYqxV4R6yv1yepbFn8bEoumDLXUwUoXHiD99iisQY+WW8LBhAQo0WSyIWj7l+f8Q8W16cGA2Gsg==
X-Received: by 2002:a17:90a:ca04:: with SMTP id x4mr23087371pjt.103.1573857241601;
        Fri, 15 Nov 2019 14:34:01 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m15sm11699724pfh.19.2019.11.15.14.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:34:01 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19+][PATCH 05/20] media: stm32-dcmi: fix DMA corruption when stopping streaming
Date:   Fri, 15 Nov 2019 15:33:41 -0700
Message-Id: <20191115223356.27675-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115223356.27675-1-mathieu.poirier@linaro.org>
References: <20191115223356.27675-1-mathieu.poirier@linaro.org>
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
Cc: stable <stable@vger.kernel.org> # 4.19+
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

