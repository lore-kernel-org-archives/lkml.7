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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77A1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990FF21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSPIUbHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfCVRNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:13:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34018 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfCVRNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:13:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so1967564pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 10:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=I50p//vhpQDBwqjd66qrwtpLp6XzkYdrA3fvDwtkU4o=;
        b=VSPIUbHqwOA6w/7zyKcBsR/BB940oo+9Zg2MM7OWIZEFQCpBOy3hPu0I9qGQhE32Jt
         Gan2M3e0EY3t4UHACT6eyNt0Skh/m3qcABWnlmG3UrIrkIOA0DcABFkkDJFEb9y2WHmu
         l/n3VvHOodcnL6y7fQJmm4elhBn9qHu8YDLOMj1zIbj1kXsKwRTiceYSMtUfevAyPsqA
         Ov70XJDbqTHZW6aLnJPdtq8j5cALGdqDsq9X0t6ERg74A8YShR4WhN4IrrejE5kEJWWF
         fnkevpxWwRv4ORTXql3Lwnodf70Y08QSsELwSvhGpu0joyN4Rp94+odMVW95KocLOxhg
         T83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=I50p//vhpQDBwqjd66qrwtpLp6XzkYdrA3fvDwtkU4o=;
        b=mp4v6dlN9FHUfNsXwV+Kv3W93K1TR8g2FoxoRP072+3CzsNPyhfV2egCm7jfOc4ugm
         8/uXggf1J56KdVTd6rNp7oFFtl1+81oi/s9WUhMldt5vt9es24laKPlySiSyur0Tvebx
         pO24aXQBqRc67NRlRvTWa/7um+3S8Zshf5C7FKCjHOrKxGYCzaUO7brQqJQD2GeGU0Tm
         Zr+kfxvj7GeHSUvGImgGLmjWskHT45I05SjIOwvDGI8oQWFVLjHisXpo+Z2Jdrrn4R+w
         KPHwqMDqHX42CGGer6CsIFb6LBdYailFI+J2W41wI94gHuF4+po/OVqDmObRb8sQz6En
         +KZQ==
X-Gm-Message-State: APjAAAV4yt7/YeA3/HChafsuChmkCV+Q8jlF05UfkjFq0bEYgF+3zuj0
        onA/MxvQ2bV7N4hH6r5d29U=
X-Google-Smtp-Source: APXvYqyN8MH0lry/35VJ5m0uOMZwM+kzRWWSTg05l40NtM/qw01RY8mgfeaftT+H9KflCLvg4jesFg==
X-Received: by 2002:a62:6ec3:: with SMTP id j186mr10535065pfc.89.1553274817123;
        Fri, 22 Mar 2019 10:13:37 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id z77sm15862091pfi.155.2019.03.22.10.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 10:13:36 -0700 (PDT)
Date:   Fri, 22 Mar 2019 22:43:30 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     gregkh@linuxfoundation.org, christian@lkamp.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: ralink-gdma: Use u32 over uint32_t
Message-ID: <20190322171330.GA13658@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the checkpatch.pl warning: "Prefer u32 over uint32_t"

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
Changes since v2
	- Improved changelog
	- Thanks for the good feedback. I am a beginner. I will learn
	  and grow. :)
---
 drivers/staging/ralink-gdma/ralink-gdma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index d78042e..7e824d3 100644
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
@@ -361,7 +361,7 @@ static int rt3883_gdma_start_transfer(struct gdma_dmaengine_chan *chan)
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

