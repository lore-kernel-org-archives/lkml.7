Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0E5C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A445120675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eW6FDJOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfEGGKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:10:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45767 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfEGGKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:10:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so8060564pfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 23:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ocbAuIAf3IKqxmrD8BDylPcrWXIwDT9EtJL2aoTkWT0=;
        b=eW6FDJOcTD20PObfZpdVGKkaItn9WQ1hYpVO8EGcNkYkpbdcbslbka9dSSdhBu5/us
         6m45eQR1VUr0hYBR8zTdkwc7je4Tm5t4GqvYRJYBo0PChRyyqW9tCMQSWgFzI3dX7VsQ
         FwBRCKZZcjZOhGApZPk48kNN24KkN6bXZ0GZ3N3RiLw5WOSQPiDCaTTvmxvt61LC4bxB
         FhvTbk6UNAE7dYiUZA8Wh2/YcDjgNCunpItqcjs/Str0If/TlRH7iOdCUPPabQRLeWXo
         jHa4ds3cktME2Ke6Do2jhx/oYHMVsK/6G4qQBQriJAmke3d62HFFWHJnVc+/TLFbwfpr
         lovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ocbAuIAf3IKqxmrD8BDylPcrWXIwDT9EtJL2aoTkWT0=;
        b=UDxdRCeugXu+WIZiOF7uz3BlMaq6v48cUU4rW3vsHVFw1P+I9gjjm+RksmJFp7pSXC
         Aujs5Bbp44bxjXs9esn/6s7N4O+Kf6IaFkWCx+fN6IAvQpIurgA5eRVWRawQiGzWSoqB
         au2h0PpdqLWjLKpU72w6meO4Sx1NKdFPLx4nktm4RhQGWL3Axrw0xIxyEPiE5GKg0vPu
         rmDOI/ib1H2vIHR7AmF982odOQTprCFU8fkPmoIb5SjOc+KbAXRhrPm7RaseT355+xEQ
         bKPtIcBOytFpYEJ48aT521fgx187pI0j9GaVFMHIu68H2HDSJo6Jkkh3DDLK2/3ewDsB
         qEOw==
X-Gm-Message-State: APjAAAUwf2TAhoH0KGjggJgZksykHpWtPOKsis7wuvDmXtmdfllRgjOO
        s2dc+RGH5p+Dl0E4q095H6jfTw==
X-Google-Smtp-Source: APXvYqxKPo0qOh1P/ydBlkUZtj0v54YJ0oLi3CXxSzI1jQdpcFRZqvq/mvfJH7rjLXKntTXZ9qadKA==
X-Received: by 2002:a63:1706:: with SMTP id x6mr4601020pgl.280.1557209411899;
        Mon, 06 May 2019 23:10:11 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e184sm30786325pfc.102.2019.05.06.23.10.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 May 2019 23:10:11 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Zubair.Kakakhel@imgtec.com,
        wsa+renesas@sang-engineering.com, jroedel@suse.de,
        vincent.guittot@linaro.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/8] dmaengine: Add matching device node validation in __dma_request_channel()
Date:   Tue,  7 May 2019 14:09:38 +0800
Message-Id: <17a22052fdb759ae6129e30f9bd8862f23a03ad9.1557206859.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1557206859.git.baolin.wang@linaro.org>
References: <cover.1557206859.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When user try to request one DMA channel by __dma_request_channel(), it won't
validate if it is the correct DMA device to request, that will lead each DMA
engine driver to validate the correct device node in their filter function
if it is necessary.

Thus we can add the matching device node validation in the DMA engine core,
to remove all of device node validation in the drivers.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/dmaengine.c   |   10 ++++++++--
 drivers/dma/of-dma.c      |    4 ++--
 include/linux/dmaengine.h |   12 ++++++++----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 3a11b10..610080c 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -641,11 +641,13 @@ struct dma_chan *dma_get_any_slave_channel(struct dma_device *device)
  * @mask: capabilities that the channel must satisfy
  * @fn: optional callback to disposition available channels
  * @fn_param: opaque parameter to pass to dma_filter_fn
+ * @np: device node to look for DMA channels
  *
  * Returns pointer to appropriate DMA channel on success or NULL.
  */
 struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
-				       dma_filter_fn fn, void *fn_param)
+				       dma_filter_fn fn, void *fn_param,
+				       struct device_node *np)
 {
 	struct dma_device *device, *_d;
 	struct dma_chan *chan = NULL;
@@ -653,6 +655,10 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 	/* Find a channel */
 	mutex_lock(&dma_list_mutex);
 	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
+		/* Finds a DMA controller with matching device node */
+		if (np && device->dev->of_node && np != device->dev->of_node)
+			continue;
+
 		chan = find_candidate(device, mask, fn, fn_param);
 		if (!IS_ERR(chan))
 			break;
@@ -769,7 +775,7 @@ struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask)
 	if (!mask)
 		return ERR_PTR(-ENODEV);
 
-	chan = __dma_request_channel(mask, NULL, NULL);
+	chan = __dma_request_channel(mask, NULL, NULL, NULL);
 	if (!chan) {
 		mutex_lock(&dma_list_mutex);
 		if (list_empty(&dma_device_list))
diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index 91fd395..6b43d04 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -316,8 +316,8 @@ struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
 	if (count != 1)
 		return NULL;
 
-	return dma_request_channel(info->dma_cap, info->filter_fn,
-			&dma_spec->args[0]);
+	return __dma_request_channel(&info->dma_cap, info->filter_fn,
+				     &dma_spec->args[0], dma_spec->np);
 }
 EXPORT_SYMBOL_GPL(of_dma_simple_xlate);
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index d49ec5c..504085b 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1314,7 +1314,8 @@ static inline enum dma_status dma_async_is_complete(dma_cookie_t cookie,
 enum dma_status dma_wait_for_async_tx(struct dma_async_tx_descriptor *tx);
 void dma_issue_pending_all(void);
 struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
-					dma_filter_fn fn, void *fn_param);
+				       dma_filter_fn fn, void *fn_param,
+				       struct device_node *np);
 struct dma_chan *dma_request_slave_channel(struct device *dev, const char *name);
 
 struct dma_chan *dma_request_chan(struct device *dev, const char *name);
@@ -1339,7 +1340,9 @@ static inline void dma_issue_pending_all(void)
 {
 }
 static inline struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
-					      dma_filter_fn fn, void *fn_param)
+						     dma_filter_fn fn,
+						     void *fn_param,
+						     struct device_node *np)
 {
 	return NULL;
 }
@@ -1411,7 +1414,8 @@ static inline int dmaengine_desc_free(struct dma_async_tx_descriptor *desc)
 void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
 struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
 struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
-#define dma_request_channel(mask, x, y) __dma_request_channel(&(mask), x, y)
+#define dma_request_channel(mask, x, y) \
+	__dma_request_channel(&(mask), x, y, NULL)
 #define dma_request_slave_channel_compat(mask, x, y, dev, name) \
 	__dma_request_slave_channel_compat(&(mask), x, y, dev, name)
 
@@ -1429,6 +1433,6 @@ static inline int dmaengine_desc_free(struct dma_async_tx_descriptor *desc)
 	if (!fn || !fn_param)
 		return NULL;
 
-	return __dma_request_channel(mask, fn, fn_param);
+	return __dma_request_channel(mask, fn, fn_param, NULL);
 }
 #endif /* DMAENGINE_H */
-- 
1.7.9.5

