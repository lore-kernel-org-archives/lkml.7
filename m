Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB1AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832E421902
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPFgIIFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfCWPq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 11:46:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35028 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCWPq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 11:46:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so3521204pfe.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 08:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HbhPhbLIVf5pBOuyL/DhIEkSg/RkUI1HDLQ686o01hs=;
        b=vPFgIIFWLotJk+HYP/LezUVIV1r7k2foi1ErvEPV079QPri/hrmJveiMOUtesCo8z+
         aYyDNEuLcINtf94O14+N2T8vdWaZWmZDO21oluXbqc42x8nWJsj6ou3TwOHy1Tbh06B7
         bz4AeAtP9ZSX9GcFL0j8M6ScajHrfh76zws+Kiccihb8dpmhvBRU7650CPTH9jEuSROK
         HrgZYnEsMN3A86jA0M6dMw+E0Xx5ibJnRhTyTII7GWtzeI19PR4YxsGXonbgQasb/qgh
         VbsfaGp7JSZX5tiPYj+V8WxppYDZ+8tIx4VP5LvcOFWBP4OpTNhlDcd2dD5usEbMUbAl
         VfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HbhPhbLIVf5pBOuyL/DhIEkSg/RkUI1HDLQ686o01hs=;
        b=DL6xgk+F1OSASPVtz5RZ/K0DDxNy9DVdQ4SC+84EnRVmjfHKd11HfimT1v1f8ZnQ4z
         3CMDKZhpsD/efB4VAXiTIR2PZCpZUTkHtnk58N8Cy5DjLS5Qr1T96z9C8J/lH9liPbGG
         fWJIuwIuXzU9P8nToHX+yQJhU9i/Jb/TQQ/0JK7F0L/0Y7WLx3lFgOcs1nzS4BfTZM81
         YC5pLbkewz7IcKnoVmgsS4nKHeQDjEbZDoN9P9lbzEhzDf3dm1VLTCkBRpcl/qO56ZD1
         uuOcxGuEdwweE/dae0w0CtM4Un8VzdNfm5K5NcFk12fyk+uTIdSq7qZ1FRBFaZkwmg23
         X/hw==
X-Gm-Message-State: APjAAAVffXrXAN1mbIWEpLseCOjCQr6O7Pe1QKT4IQWBrdSF+iYg5C7H
        MMJ29e3t/K+KdroaYCgug7E=
X-Google-Smtp-Source: APXvYqxjRO06/zsPr6Djb3C/qDydtkKK9MhvryPqta+rHa4nKYLzO4SYeO78/i3Py6T4v8KhOKOTTA==
X-Received: by 2002:a62:1ac3:: with SMTP id a186mr14922610pfa.48.1553356016666;
        Sat, 23 Mar 2019 08:46:56 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.35])
        by smtp.gmail.com with ESMTPSA id s16sm6909519pgo.69.2019.03.23.08.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 08:46:56 -0700 (PDT)
Date:   Sat, 23 Mar 2019 21:16:48 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     gregkh@linuxfoundation.org, philipp.panzer@fau.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: ralink-gdma: Use u32 over uint32_t
Message-ID: <20190323154648.GA10634@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the checkpatch.pl warning: "Prefer u32 over uint32_t"

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
Changes since v3
	- Fixed allignment issues.
	- Submitted a seperate patch to change unsigned
	to unsigned int.
	- One of the allignments crosses 80 characters in a line
	but I feel that we may loose readability if we try to reduce
	the characters in the line.
---
 drivers/staging/ralink-gdma/ralink-gdma.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index d78042e..0b831f8 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -157,14 +157,12 @@ static struct gdma_dma_desc *to_gdma_dma_desc(struct virt_dma_desc *vdesc)
 	return container_of(vdesc, struct gdma_dma_desc, vdesc);
 }
 
-static inline uint32_t gdma_dma_read(struct gdma_dma_dev *dma_dev,
-				     unsigned int reg)
+static inline u32 gdma_dma_read(struct gdma_dma_dev *dma_dev, unsigned int reg)
 {
 	return readl(dma_dev->base + reg);
 }
 
-static inline void gdma_dma_write(struct gdma_dma_dev *dma_dev,
-				  unsigned reg, uint32_t val)
+static inline void gdma_dma_write(struct gdma_dma_dev *dma_dev, unsigned reg, u32 val)
 {
 	writel(val, dma_dev->base + reg);
 }
@@ -283,7 +281,7 @@ static int rt305x_gdma_start_transfer(struct gdma_dmaengine_chan *chan)
 	struct gdma_dma_dev *dma_dev = gdma_dma_chan_get_dev(chan);
 	dma_addr_t src_addr, dst_addr;
 	struct gdma_dma_sg *sg;
-	uint32_t ctrl0, ctrl1;
+	u32 ctrl0, ctrl1;
 
 	/* verify chan is already stopped */
 	ctrl0 = gdma_dma_read(dma_dev, GDMA_REG_CTRL0(chan->id));
@@ -361,7 +359,7 @@ static int rt3883_gdma_start_transfer(struct gdma_dmaengine_chan *chan)
 	struct gdma_dma_dev *dma_dev = gdma_dma_chan_get_dev(chan);
 	dma_addr_t src_addr, dst_addr;
 	struct gdma_dma_sg *sg;
-	uint32_t ctrl0, ctrl1;
+	u32 ctrl0, ctrl1;
 
 	/* verify chan is already stopped */
 	ctrl0 = gdma_dma_read(dma_dev, GDMA_REG_CTRL0(chan->id));
@@ -753,7 +751,7 @@ static void gdma_dma_tasklet(unsigned long arg)
 
 static void rt305x_gdma_init(struct gdma_dma_dev *dma_dev)
 {
-	uint32_t gct;
+	u32 gct;
 
 	/* all chans round robin */
 	gdma_dma_write(dma_dev, GDMA_RT305X_GCT, GDMA_REG_GCT_ARBIT_RR);
@@ -767,7 +765,7 @@ static void rt305x_gdma_init(struct gdma_dma_dev *dma_dev)
 
 static void rt3883_gdma_init(struct gdma_dma_dev *dma_dev)
 {
-	uint32_t gct;
+	u32 gct;
 
 	/* all chans round robin */
 	gdma_dma_write(dma_dev, GDMA_REG_GCT, GDMA_REG_GCT_ARBIT_RR);
-- 
2.7.4

