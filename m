Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AA2C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E7F21738
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfGVQwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:52:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728752AbfGVQwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:52:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7376E3083363;
        Mon, 22 Jul 2019 16:52:02 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-45.ams2.redhat.com [10.36.116.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21C775D721;
        Mon, 22 Jul 2019 16:51:54 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dma-mapping: Use dma_get_mask in dma_addressing_limited
Date:   Mon, 22 Jul 2019 18:51:49 +0200
Message-Id: <20190722165149.3763-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 22 Jul 2019 16:52:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently have cases where the dma_addressing_limited() gets
called with dma_mask unset. This causes a NULL pointer dereference.

Use dma_get_mask() accessor to prevent the crash.

Fixes: b866455423e0 ("dma-mapping: add a dma_addressing_limited helper")
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- was [PATCH 1/2] dma-mapping: Protect dma_addressing_limited
  against NULL dma_mask
- Use dma_get_mask
---
 include/linux/dma-mapping.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index e11b115dd0e4..f7d1eea32c78 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -689,8 +689,8 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
  */
 static inline bool dma_addressing_limited(struct device *dev)
 {
-	return min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
-		dma_get_required_mask(dev);
+	return min_not_zero(dma_get_mask(dev), dev->bus_dma_mask) <
+			    dma_get_required_mask(dev);
 }
 
 #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
-- 
2.20.1

