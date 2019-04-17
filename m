Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D78C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A932064B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wrF2JBXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbfDQRue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:50:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33689 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733152AbfDQRuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:50:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id f23so1867000ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 10:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l/8RWz1sFCy2pYyWFCkyCF9aMFvlsg0DvtWaIJqPbpo=;
        b=wrF2JBXu9XGL9wJ/iPCe8UgDfd03WKnhdro+OjS7M6pxd/614QE+kWjqqq8Zcz1VUS
         9xF2dFudI0pd2bfPeLbyuILW5twC+Or+O+C7TeQu9zvWXnsrJZz0YPz9ezUI6vykHaqr
         Yj7ypQgKtpoIjv5seyBOSzdmBG0YGxU0H/cHuEbPWSUf34s5YwaocsYUAq6WJdtkBEQE
         TXFEu/87+GRuJkxS4eI/+7zJpYrIkgHRPUGC+M13ewbYltCV9LUhIjTVi73nLYOwOLWQ
         QdsvUgdsXCd3oo6GCzWTOX3kpjMEJtEwjIjrjC52WYhXRSKaVD/S5DjF+Cb60U6qCB/q
         qZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l/8RWz1sFCy2pYyWFCkyCF9aMFvlsg0DvtWaIJqPbpo=;
        b=KoMLVgoCpKAU1zHV8hMLr5xbM/JbgWJbss97zQAhS1DDVqRRcupjuX7M8H3LGHRgov
         nbLWdKrt3pQ6cuxKLYxVfFqy2D3N2oKGkP60LqNKd0xM+GNAP4FPCcnnrQ16+kXVd/aq
         gWNzTloJgGrvvvreQSRwK7msUgI2HhgWu5ikZ/nLW3zpL1bhSwNGRLiJTIh6WS8CFaK9
         1w2aosLgrY0tBoVPQ5mBSDxNRotGGAwiNIW/a22bD9Eoy33GRSco2kw8rfi80t/RsCUG
         LFbUfmTEfuwRd7tQSuqCXE34qipshOMK9N2/Todq82P5SgG0xlmbU6QeKaiGaLjqahKN
         yWdg==
X-Gm-Message-State: APjAAAXmI5tmIAxIwGC1tDkc8t82NgcPTaGVdzOjhoKO7MuXhCkBK/VV
        QylXHVVvTE2ZnoN65Ky8CDqLXw==
X-Google-Smtp-Source: APXvYqwnX5Xr5levDcetJKe3/zYcg6G+k0lNts31W7yoEEoAhrWA164pOaFPnMEXD2JHTsBUumKrSw==
X-Received: by 2002:a2e:204e:: with SMTP id g75mr14249387ljg.92.1555523407854;
        Wed, 17 Apr 2019 10:50:07 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id f4sm11197173ljg.37.2019.04.17.10.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:50:07 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ilias.apalodimas@linaro.org,
        hawk@kernel.org, xdp-newbies@vger.kernel.org, ast@kernel.org,
        aniel@iogearbox.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [RFC PATCH 1/3] net: ethernet: ti: davinci_cpdma: add dma mapped submit
Date:   Wed, 17 Apr 2019 20:49:40 +0300
Message-Id: <20190417174942.11811-2-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190417174942.11811-1-ivan.khoronzhuk@linaro.org>
References: <20190417174942.11811-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case if dma mapped packet needs to be sent, like with XDP
page pool, the "mapped" submit can be used. This patch adds dma
mapped submit based on regular one.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/davinci_cpdma.c | 84 ++++++++++++++++++++-----
 drivers/net/ethernet/ti/davinci_cpdma.h |  2 +
 2 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
index 4236dcdd5634..96ec1d9d8f47 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.c
+++ b/drivers/net/ethernet/ti/davinci_cpdma.c
@@ -132,6 +132,15 @@ struct cpdma_chan {
 	u32				rate;
 };
 
+struct submit_info {
+	struct cpdma_chan *chan;
+	int directed;
+	void *token;
+	void *data;
+	int flags;
+	int len;
+};
+
 struct cpdma_control_info {
 	u32		reg;
 	u32		shift, mask;
@@ -183,6 +192,8 @@ static struct cpdma_control_info controls[] = {
 				 (directed << CPDMA_TO_PORT_SHIFT));	\
 	} while (0)
 
+#define CPDMA_DMA_EXT_MAP		BIT(16)
+
 static void cpdma_desc_pool_destroy(struct cpdma_ctlr *ctlr)
 {
 	struct cpdma_desc_pool *pool = ctlr->pool;
@@ -1026,10 +1037,11 @@ static void __cpdma_chan_submit(struct cpdma_chan *chan,
 	}
 }
 
-int cpdma_chan_submit(struct cpdma_chan *chan, void *token, void *data,
-		      int len, int directed)
+static int cpdma_chan_submit_si(struct submit_info *si)
 {
+	struct cpdma_chan		*chan = si->chan;
 	struct cpdma_ctlr		*ctlr = chan->ctlr;
+	int				len = si->len;
 	struct cpdma_desc __iomem	*desc;
 	dma_addr_t			buffer;
 	unsigned long			flags;
@@ -1061,16 +1073,22 @@ int cpdma_chan_submit(struct cpdma_chan *chan, void *token, void *data,
 		chan->stats.runt_transmit_buff++;
 	}
 
-	buffer = dma_map_single(ctlr->dev, data, len, chan->dir);
-	ret = dma_mapping_error(ctlr->dev, buffer);
-	if (ret) {
-		cpdma_desc_free(ctlr->pool, desc, 1);
-		ret = -EINVAL;
-		goto unlock_ret;
-	}
-
 	mode = CPDMA_DESC_OWNER | CPDMA_DESC_SOP | CPDMA_DESC_EOP;
-	cpdma_desc_to_port(chan, mode, directed);
+	cpdma_desc_to_port(chan, mode, si->directed);
+
+	if (si->flags & CPDMA_DMA_EXT_MAP) {
+		buffer = (dma_addr_t)si->data;
+		dma_sync_single_for_device(ctlr->dev, buffer, len, chan->dir);
+		len |= CPDMA_DMA_EXT_MAP;
+	} else {
+		buffer = dma_map_single(ctlr->dev, si->data, len, chan->dir);
+		ret = dma_mapping_error(ctlr->dev, buffer);
+		if (ret) {
+			cpdma_desc_free(ctlr->pool, desc, 1);
+			ret = -EINVAL;
+			goto unlock_ret;
+		}
+	}
 
 	/* Relaxed IO accessors can be used here as there is read barrier
 	 * at the end of write sequence.
@@ -1079,7 +1097,7 @@ int cpdma_chan_submit(struct cpdma_chan *chan, void *token, void *data,
 	writel_relaxed(buffer, &desc->hw_buffer);
 	writel_relaxed(len, &desc->hw_len);
 	writel_relaxed(mode | len, &desc->hw_mode);
-	writel_relaxed((uintptr_t)token, &desc->sw_token);
+	writel_relaxed((uintptr_t)si->token, &desc->sw_token);
 	writel_relaxed(buffer, &desc->sw_buffer);
 	writel_relaxed(len, &desc->sw_len);
 	desc_read(desc, sw_len);
@@ -1095,8 +1113,39 @@ int cpdma_chan_submit(struct cpdma_chan *chan, void *token, void *data,
 	spin_unlock_irqrestore(&chan->lock, flags);
 	return ret;
 }
+
+int cpdma_chan_submit(struct cpdma_chan *chan, void *token, void *data, int len,
+		      int directed)
+{
+	struct submit_info si;
+
+	si.chan = chan;
+	si.token = token;
+	si.data = data;
+	si.len = len;
+	si.directed = directed;
+	si.flags = 0;
+
+	return cpdma_chan_submit_si(&si);
+}
 EXPORT_SYMBOL_GPL(cpdma_chan_submit);
 
+int cpdma_chan_submit_mapped(struct cpdma_chan *chan, void *token, void *data,
+			     int len, int directed)
+{
+	struct submit_info si;
+
+	si.chan = chan;
+	si.token = token;
+	si.data = data;
+	si.len = len;
+	si.directed = directed;
+	si.flags = CPDMA_DMA_EXT_MAP;
+
+	return cpdma_chan_submit_si(&si);
+}
+EXPORT_SYMBOL_GPL(cpdma_chan_submit_mapped);
+
 bool cpdma_check_free_tx_desc(struct cpdma_chan *chan)
 {
 	struct cpdma_ctlr	*ctlr = chan->ctlr;
@@ -1123,10 +1172,17 @@ static void __cpdma_chan_free(struct cpdma_chan *chan,
 	uintptr_t			token;
 
 	token      = desc_read(desc, sw_token);
-	buff_dma   = desc_read(desc, sw_buffer);
 	origlen    = desc_read(desc, sw_len);
 
-	dma_unmap_single(ctlr->dev, buff_dma, origlen, chan->dir);
+	buff_dma   = desc_read(desc, sw_buffer);
+	if (origlen & CPDMA_DMA_EXT_MAP) {
+		origlen &= ~CPDMA_DMA_EXT_MAP;
+		dma_sync_single_for_cpu(ctlr->dev, buff_dma, origlen,
+					chan->dir);
+	} else {
+		dma_unmap_single(ctlr->dev, buff_dma, origlen, chan->dir);
+	}
+
 	cpdma_desc_free(pool, desc, 1);
 	(*chan->handler)((void *)token, outlen, status);
 }
diff --git a/drivers/net/ethernet/ti/davinci_cpdma.h b/drivers/net/ethernet/ti/davinci_cpdma.h
index d399af5389b8..20e4d43df6d1 100644
--- a/drivers/net/ethernet/ti/davinci_cpdma.h
+++ b/drivers/net/ethernet/ti/davinci_cpdma.h
@@ -84,6 +84,8 @@ int cpdma_chan_stop(struct cpdma_chan *chan);
 
 int cpdma_chan_get_stats(struct cpdma_chan *chan,
 			 struct cpdma_chan_stats *stats);
+int cpdma_chan_submit_mapped(struct cpdma_chan *chan, void *token, void *data,
+			     int len, int directed);
 int cpdma_chan_submit(struct cpdma_chan *chan, void *token, void *data,
 		      int len, int directed);
 int cpdma_chan_process(struct cpdma_chan *chan, int quota);
-- 
2.17.1

