Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CD5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A8020693
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNGeQ5bF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbfCVNFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:05:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42166 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730841AbfCVNFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:05:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id r15so1501603pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=emEwYTeD9+5UIIkTRrtyGNRbNooY2qVJ6ggNRefBlnA=;
        b=CNGeQ5bFAwUqKziu1oheyLHqThpbA4b4+g7OuB0jKcS4DOGoFp8SUb3ki4N1ygmT/S
         eGO1c/wGIlT+xTeLeFc1E20cEQHGtR43dYlynU1/T1OQ9IvopH7RF7pnyfFUhgB5yRba
         ahQ0YG5C3qG/cy+lQBaJ+2CJjHz2l2siYKGzDwn6fQoRDzvCZaGF26RYkqHUfkYG52HM
         QWinYRpa9TRWLMHHXKAQbO+kb3uSliGAFaDTSzHhI9yjjBCdFoovvahy5lfw+SedIF/f
         RLmuhGRTFbNN+Gm1u02TFambekq+lCb4/Hvv7Nr3Q31cI8TALMuRA/h5pE/a0JVfs+g/
         2jCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=emEwYTeD9+5UIIkTRrtyGNRbNooY2qVJ6ggNRefBlnA=;
        b=PXcBazKtgf5R1wyKRfmXlZc0UsKS6TtojaNF3k+wps85vQNLSGyrmRs0onEoQ3MFeL
         WIP0AAJ0wld0mZ1ic1h4AMDzHnUUD6paT0CxU18XZx8IjTh6TH8tUFCUSX2SGUEtt32M
         YpTiOhL1Ieu578csR1krB6pqEvP9eldb6xIZJZQhTA5QsD3oHQe2m608WlAtvtUGEHmC
         YNqYQLrAuQ8nOLHASHDWi75UTzKBaewMGwZmocUNpdk0kYy6rK3hE325pXBouUWVdVgF
         i58J6siJYPfI24lhvaoricVwc7/OkHppfhrUmAfZ37u/LbOSbZv9cOKkPCdNXG0eiyIG
         m7zg==
X-Gm-Message-State: APjAAAUN7aWzzgxr2sarCG9TSbPq+MhZhGat67P3ayG2CS70K4pgziRC
        w2sN5rXbGUzInbL/Rpn5tic=
X-Google-Smtp-Source: APXvYqwLsehj4OHspfOj4Xe4Ov1oOlfarDAJti6keIoaEM+HK4u8pPP11w5O+K4szlVDEDXazJ+ODg==
X-Received: by 2002:a17:902:29ca:: with SMTP id h68mr9516165plb.297.1553259912248;
        Fri, 22 Mar 2019 06:05:12 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([117.198.99.29])
        by smtp.gmail.com with ESMTPSA id w68sm12429329pfb.176.2019.03.22.06.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 06:05:11 -0700 (PDT)
Date:   Fri, 22 Mar 2019 18:35:07 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     gregkh@linuxfoundation.org, christian@lkamp.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: ralink-gdma: Change uint32_t to u32
Message-ID: <20190322130507.GA4205@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change occurences of uint32_t to u32 to fix checkpatch.pl warnings.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
Changes since v1:
	- Improved changelog.
---
---
 drivers/staging/ralink-gdma/ralink-gdma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index 2c19287..7e824d3 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -157,14 +157,14 @@ static struct gdma_dma_desc *to_gdma_dma_desc(struct virt_dma_desc *vdesc)
 	return container_of(vdesc, struct gdma_dma_desc, vdesc);
 }
 
-static inline uint32_t gdma_dma_read(struct gdma_dma_dev *dma_dev,
+static inline u32 gdma_dma_read(struct gdma_dma_dev *dma_dev,
 				     unsigned int reg)
 {
 	return readl(dma_dev->base + reg);
 }
 
 static inline void gdma_dma_write(struct gdma_dma_dev *dma_dev,
-				  unsigned reg, uint32_t val)
+				  unsigned reg, u32 val)
 {
 	writel(val, dma_dev->base + reg);
 }
@@ -283,7 +283,7 @@ static int rt305x_gdma_start_transfer(struct gdma_dmaengine_chan *chan)
 	struct gdma_dma_dev *dma_dev = gdma_dma_chan_get_dev(chan);
 	dma_addr_t src_addr, dst_addr;
 	struct gdma_dma_sg *sg;
-	uint32_t ctrl0, ctrl1;
+	u32 ctrl0, ctrl1;
 
 	/* verify chan is already stopped */
 	ctrl0 = gdma_dma_read(dma_dev, GDMA_REG_CTRL0(chan->id));
@@ -753,7 +753,7 @@ static void gdma_dma_tasklet(unsigned long arg)
 
 static void rt305x_gdma_init(struct gdma_dma_dev *dma_dev)
 {
-	uint32_t gct;
+	u32 gct;
 
 	/* all chans round robin */
 	gdma_dma_write(dma_dev, GDMA_RT305X_GCT, GDMA_REG_GCT_ARBIT_RR);
@@ -767,7 +767,7 @@ static void rt305x_gdma_init(struct gdma_dma_dev *dma_dev)
 
 static void rt3883_gdma_init(struct gdma_dma_dev *dma_dev)
 {
-	uint32_t gct;
+	u32 gct;
 
 	/* all chans round robin */
 	gdma_dma_write(dma_dev, GDMA_REG_GCT, GDMA_REG_GCT_ARBIT_RR);
-- 
2.7.4

