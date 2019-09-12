Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3251C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 05:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A768920830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 05:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PYvX2Jjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfILFrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 01:47:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42179 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfILFrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 01:47:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id w22so15225521pfi.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 22:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FH3mQ5WAiHQBqx7gMhW2IlaC7Eov6CFwaWdgd/wFtP0=;
        b=PYvX2Jjybf3jSculUvceSAy/P291IbUmtLltNSdFEVC5AYj8qeTuf0g8XKlMS2wcFI
         JtcmmkEyaOZvDhY5hJ9Mw5GYsAJjxQl7ktGVSZTDMr9d4jmDAXazAxnXDXMarAsnfNfU
         so7YUkqKuZ0GXE6lw8rxrW+vkoVyLDMFian057P0TYQ7iw+OBfmkhofNnApRI98Yuz5T
         HnVGGeArV8Z9PyZO4jnyFyG2xQmbHAa88kLYXZL/HD7WidVbCdAk4SCcmp+UKgcZo1Gs
         oilRMXiMwKRfzwrpQmqKvuHqV+otT1JA37Dt2gNR6PLb4u1gK6m7hyOF1TlIVKp7v528
         Wk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FH3mQ5WAiHQBqx7gMhW2IlaC7Eov6CFwaWdgd/wFtP0=;
        b=gcsx9oYVzrn7TGogGUtR4w5OYPea4PbD6w2MeClCphv7DOCFejXmryBEj/WBYiLWkn
         I103NPqCMb4DCtkVBLLsLf6Hl0ifdqhVvLhrmfPazZMj64s60y+MhsIa8RidhzfGOeke
         EHadybMx7G4e5Oqy3H2rnxXgvSFN6AYzuWlSRyoflWBK00s9btkYKI01G4kdACBNj4jz
         puACOVrJFchx+rrJjcwBR2rzMjMipwYaw5RmLe2BFITcQU2CMJLqbteR/dMwwGBFzCaY
         08DiEh1cAWGHdrEcQZBdskxusdeAtNgccb6QrM6EAyFkzp2uJmBBM2nKrhpBo8cCh+Ue
         2u4Q==
X-Gm-Message-State: APjAAAWsgBi4iVEkJvQBpMamGfcPJ7nOoWUpjcTZW5taKceuVu2ORMk0
        ktorB4n6daIylDT8tHJObN8B6A==
X-Google-Smtp-Source: APXvYqzawCx7eqyzXmhV+Jo2ika+EmyDdJc35lAYkargw+zex++LvLDrzPw5U8tDy+o77DlgsHOQ0g==
X-Received: by 2002:a65:60d2:: with SMTP id r18mr35715713pgv.71.1568267259688;
        Wed, 11 Sep 2019 22:47:39 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id t14sm13228602pgb.33.2019.09.11.22.47.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Sep 2019 22:47:38 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     vkoul@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, eric.long@unisoc.com,
        zhenfang.wang@unisoc.com, baolin.wang@linaro.org
Subject: [PATCH] dmaengine: sprd: Fix the link-list pointer register configuration issue
Date:   Thu, 12 Sep 2019 13:47:18 +0800
Message-Id: <eadfe9295499efa003e1c344e67e2890f9d1d780.1568267061.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenfang Wang <zhenfang.wang@unisoc.com>

We will set the link-list pointer register point to next link-list
configuration's physical address, which can load DMA configuration
from the link-list node automatically.

But the link-list node's physical address can be larger than 32bits,
and now Spreadtrum DMA driver only supports 32bits physical address,
which may cause loading a incorrect DMA configuration when starting
the link-list transfer mode. According to the DMA datasheet, we can
use SRC_BLK_STEP register (bit28 - bit31) to save the high bits of the
link-list node's physical address to fix this issue.

Fixes: 4ac695464763 ("dmaengine: sprd: Support DMA link-list mode")
Signed-off-by: Zhenfang Wang <zhenfang.wang@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 525dc73..a4a91f2 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -134,6 +134,10 @@
 #define SPRD_DMA_SRC_TRSF_STEP_OFFSET	0
 #define SPRD_DMA_TRSF_STEP_MASK		GENMASK(15, 0)
 
+/* SPRD DMA_SRC_BLK_STEP register definition */
+#define SPRD_DMA_LLIST_HIGH_MASK	GENMASK(31, 28)
+#define SPRD_DMA_LLIST_HIGH_SHIFT	28
+
 /* define DMA channel mode & trigger mode mask */
 #define SPRD_DMA_CHN_MODE_MASK		GENMASK(7, 0)
 #define SPRD_DMA_TRG_MODE_MASK		GENMASK(7, 0)
@@ -717,6 +721,7 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
 	u32 int_mode = flags & SPRD_DMA_INT_MASK;
 	int src_datawidth, dst_datawidth, src_step, dst_step;
 	u32 temp, fix_mode = 0, fix_en = 0;
+	phys_addr_t llist_ptr;
 
 	if (dir == DMA_MEM_TO_DEV) {
 		src_step = sprd_dma_get_step(slave_cfg->src_addr_width);
@@ -814,13 +819,16 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
 		 * Set the link-list pointer point to next link-list
 		 * configuration's physical address.
 		 */
-		hw->llist_ptr = schan->linklist.phy_addr + temp;
+		llist_ptr = schan->linklist.phy_addr + temp;
+		hw->llist_ptr = lower_32_bits(llist_ptr);
+		hw->src_blk_step = (upper_32_bits(llist_ptr) << SPRD_DMA_LLIST_HIGH_SHIFT) &
+			SPRD_DMA_LLIST_HIGH_MASK;
 	} else {
 		hw->llist_ptr = 0;
+		hw->src_blk_step = 0;
 	}
 
 	hw->frg_step = 0;
-	hw->src_blk_step = 0;
 	hw->des_blk_step = 0;
 	return 0;
 }
-- 
1.7.9.5

