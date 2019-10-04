Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226CEC4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0B6215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LKCkmw+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbfJDV2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:28:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44264 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfJDV2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:28:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id q15so3696254pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ajF8BNvBTYWRihzw/y9VwrM/ZeW1oRTD6CKhvhiZBoI=;
        b=LKCkmw+R9/tP6lwUTjU7DVBKx4EDr+7i54ERWo6nrw8NjY9juOgQ0ARnIgIokM6tjf
         /rRBldUTEie6zXy0SlrpxdJG0N66DqeSVfK5vFOzopgyWA5ZYw6QUCOJBLgPTF6DuFhe
         GELw9mbEVpz1VLRxk3zdG4IVsx3whJ9FE4YbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ajF8BNvBTYWRihzw/y9VwrM/ZeW1oRTD6CKhvhiZBoI=;
        b=tLiaqjbRldOO49zOW9rnr6hZzhR1ToqZ7t6gb/3+rg38pjkYOy09KPlsg/mE3g5Lru
         SnZUJWFo47vBmGwTGMuewDO6D8J+s/rZaHLozjcIVuAbpYHcQSmqn1XuLEh2ljtrY0pP
         8BWoQAtnrW+KKhPkWRqzBwJxAV5GX+aNKBc4FMFP4xMvKHLz3zuGOBwxH3zXDgke98IL
         W84/ttC1VrIXXQu/yrXA3G/yVly1/oAPEetCDJDd03KNyfxFhMqnO1VSX3BYgwzEihu4
         C2vHzWGrRnsthNitVaTtjZovpZzPjV7EGqFqPcARHTuK5w7e8geXojGR3ca/30bvy8L0
         8g0A==
X-Gm-Message-State: APjAAAUbNSweD8qSOW8cSdr7nrt5AjK3WcrMYmtYpiwiggJQqEPTEoQq
        zbTbSEmJAciJR5Aa0Di1nQqHqQ==
X-Google-Smtp-Source: APXvYqwDlOrvI0afKJG2ACuljeKrA2U2VWMnuk9KBLbDCeKAaI50tWbsD8nVhCvFM30vjRdUUTt2Jg==
X-Received: by 2002:a17:902:8bca:: with SMTP id r10mr17398900plo.43.1570224498715;
        Fri, 04 Oct 2019 14:28:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z13sm7541296pfg.172.2019.10.04.14.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 14:28:17 -0700 (PDT)
Date:   Fri, 4 Oct 2019 14:28:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCH v2] dma-mapping: Move vmap address checks into
 dma_map_single()
Message-ID: <201910041420.F6E55D29A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we've seen from USB and other areas, we need to always do runtime
checks for DMA operating on memory regions that might be remapped. This
moves the existing checks from USB into dma_map_single(), but leaves
the slightly heavier checks as they are.

Suggested-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: Only add is_vmalloc_addr()
v1: https://lore.kernel.org/lkml/201910021341.7819A660@keescook
---
 drivers/usb/core/hcd.c      | 8 +-------
 include/linux/dma-mapping.h | 7 +++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index f225eaa98ff8..281568d464f9 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1410,10 +1410,7 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 		if (hcd->self.uses_pio_for_control)
 			return ret;
 		if (hcd_uses_dma(hcd)) {
-			if (is_vmalloc_addr(urb->setup_packet)) {
-				WARN_ONCE(1, "setup packet is not dma capable\n");
-				return -EAGAIN;
-			} else if (object_is_on_stack(urb->setup_packet)) {
+			if (object_is_on_stack(urb->setup_packet)) {
 				WARN_ONCE(1, "setup packet is on stack\n");
 				return -EAGAIN;
 			}
@@ -1479,9 +1476,6 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 					ret = -EAGAIN;
 				else
 					urb->transfer_flags |= URB_DMA_MAP_PAGE;
-			} else if (is_vmalloc_addr(urb->transfer_buffer)) {
-				WARN_ONCE(1, "transfer buffer not dma capable\n");
-				ret = -EAGAIN;
 			} else if (object_is_on_stack(urb->transfer_buffer)) {
 				WARN_ONCE(1, "transfer buffer is on stack\n");
 				ret = -EAGAIN;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 4a1c4fca475a..12dbd07f74f2 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -583,6 +583,13 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
+	/* DMA must never operate on areas that might be remapped. */
+	if (WARN_ONCE(is_vmalloc_addr(ptr),
+		      "%s %s: driver maps %lu bytes from vmalloc area\n",
+		      dev ? dev_driver_string(dev) : "unknown driver",
+		      dev ? dev_name(dev) : "unknown device", size))
+		return DMA_MAPPING_ERROR;
+
 	debug_dma_map_single(dev, ptr, size);
 	return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
 			size, dir, attrs);
-- 
2.17.1


-- 
Kees Cook
