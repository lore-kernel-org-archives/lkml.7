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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A8BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12232054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+w16A0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389992AbfCVMdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:33:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44134 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389259AbfCVMOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:14:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id i2so1393956pgj.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 05:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=e+Q6ymh8nE2cUHIAaKzDKoWB06PYHRB0lZuPNM3MsFo=;
        b=h+w16A0yy0ULcEJgOLJAS0P2Oq7mt3GAzP33EIF4Kvndu9f+TBHPmQ/I4Hus4X9rbT
         o7pMCiZtqd0b50Lpl1Pu7ifbJU3Cb4eBxwb/vbbpFDwN0vNojw5vgsHoxr9jDTdIZkVR
         yaNKJLLih0w4bJx3mrGsAZOtWYAF50Nav9uDDrqgzv3H5LsptjQ+0eObE3d3JuPtPcvc
         gYv0d5ZbEe3YlSzi19O3e2K46kWyDh2w6BI1mFdi/XcLDmMIqZnzi11YlsH9+asMULYz
         Z7CuVI8O8wlRyNNfp8oAy0ysEneunW2wRq4c13gEhvYa3nuRyBuL50xT+nL24xLVZJ1y
         51lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=e+Q6ymh8nE2cUHIAaKzDKoWB06PYHRB0lZuPNM3MsFo=;
        b=DMqfUoAVFX1jnlUlyGr+AmyA9QJ5JNg/Ny7k//e+POg1e+dKsK6kx+ybG4cr90BY6Q
         tpLXPy43v741OBCvjvDfCBcvnZMCt5t4bStyHVd+eUiHohJwCieVA6QZMK3CnIzcths8
         faTNIWxjnNszUEr5RsycXPDUPS40x2+SO4axNw0mjtzjf1/ssBEJrCcItpJP4O8EH2/i
         uiPn+aFVYf+/I+T1HuuU/LGX7nPReDqCtz1QKEez/gNDx2pBHZQojVZgzYhncbLTJPGf
         ERfXjhoAQ1NWFRPWo23Lxnv2LGNCwJjxAcr2M4FGXemUDU9tpn5KD6DX7k5yIIpKevZK
         utPQ==
X-Gm-Message-State: APjAAAWqtGZpZm5pEUkCoV01t5X5LwosX8imXiy3hoFFtpROoJQcf/qx
        0gtsSOzTAiVlSDx/2W6ZaT8=
X-Google-Smtp-Source: APXvYqx0YoGUPxq1XR+HJUn+4u43AktsBNN2oprUYVQpXoLcLV9+zxAfo7c17Dy6HWwUGKjKa1IZ9A==
X-Received: by 2002:a17:902:aa90:: with SMTP id d16mr8972652plr.250.1553256856389;
        Fri, 22 Mar 2019 05:14:16 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([117.198.99.29])
        by smtp.gmail.com with ESMTPSA id h87sm12481248pfj.20.2019.03.22.05.14.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 05:14:15 -0700 (PDT)
Date:   Fri, 22 Mar 2019 17:44:10 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     gregkh@linuxfoundation.org, christian@lkamp.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: ralink-gdma: Change uint32_t to u32
Message-ID: <20190322121410.GA3177@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change occurences of uint32_t to u32 to fix checkpatch.pl warning

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
Changes since v1:
	-Improved the changelog.
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

