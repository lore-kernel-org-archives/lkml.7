Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573D2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6AF218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4we0yQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfCUTZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:25:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38555 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfCUTZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 15:25:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so4944135pfo.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 12:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2WOolLiv1ry/R9+0EaQPsnVX95KhfduEstvxxDe2V/Q=;
        b=b4we0yQeq2QOSe2vyumWMIiNMl3paXa2YtfiwfErbnBIDYS389NIanE7/M1xHEt+r0
         KseD23lmWARuC2XFe8PfyONtA5G2ipY5lpi8mUnf/XbgWgXQg5OMSFH0B0P1ap2mwU8D
         /aJNLUCY7IpLallV6LTYZEKWSTUUmVBunLAGcgLtpVwOfJDDgnThsEVtNz5Co2qiSf3o
         ZkLIoN13mz6nf6z25XlswEOoD+C6lkSfMo0oLvF5Y3pZQ5s4d0NtTa2dsz4oKGDYAk+A
         Kdzt4AuwuRQEnO7i8I+MlGjmgSxlp2pPefWDfr/WSL4ZDzd/MYLXY3McS3norx81Ra6f
         3vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2WOolLiv1ry/R9+0EaQPsnVX95KhfduEstvxxDe2V/Q=;
        b=n+iof70tpBe247L1Cl3OfCnDa8hZfok+oAD3GhI1jq7PiGmMrXEZFXAhoNS8CbSORL
         xMVLyBItqEyjd6sCq/hUyYj39TVY6opmCltgq+Ss7sog8MRiI47hJ0jg6nR13F/mCGOT
         jfFH+QfbIjcm12rx1X81XzXNRQV7yN9tem+M+HQ/RCuWoT9pDt/j7RIo3o+IPFz7HJjB
         0iZ9G34XZ9L6B6FdqIhDzyuc2xbYH4k44qhPwGjlWlWfQhY18UoCj/sXcmfPtdaFezii
         QKpN1gOxJVE8yQC8VlikjprB0lchxSNrKo0B3obyJcE997ahg1eLKx0TD9iksrrBatm2
         kEIA==
X-Gm-Message-State: APjAAAU6W8964xRI2DEekWp6L2qJWX1C941E+7DUO894QrrpVqatNtDC
        6MsWMsjPt9mWFBO0gnPeE6M=
X-Google-Smtp-Source: APXvYqy6p/SGgNhRQDtBt8gii2TN2ILGyfLXDLJTUyhbWsblky4A/VnkZimAzxpEphPSPhkxSCY7Ig==
X-Received: by 2002:a62:b608:: with SMTP id j8mr5118278pff.183.1553196308482;
        Thu, 21 Mar 2019 12:25:08 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id i126sm8726948pfc.101.2019.03.21.12.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 12:25:07 -0700 (PDT)
Date:   Fri, 22 Mar 2019 00:55:02 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     gregkh@linuxfoundation.org, christian@lkamp.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: ralink-gdma: Change uint32_t to u32
Message-ID: <20190321192502.GA11144@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up on my previous patch. Change occurences of the
stdint type uint32_t to its shortened type u32. This fixed the checkpatch.pl warning: "Prefer u32 over uint32_t".

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
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

