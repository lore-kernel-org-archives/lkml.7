Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F6AC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1853221873
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mf6Qz/NR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393034AbfHBNMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:12:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38479 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390177AbfHBNMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:12:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so36046546pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mmAbNiMuUrnYmjhqGRk2m36n0oJmscNLYfD+LuhNWEg=;
        b=Mf6Qz/NRsdy7FxdetXRLH1aeEa+euA0/tzh5+RSn5Jmkn6RsQ1XcWmEIx2LmDzOZOb
         fGW++Bqb6PHjkw2dtqRLjFEbKakJ9pFUKxEUG7KsOAxoO4lKu7yj1hq2KQq6q+Cxd6CC
         +K/XTAh2gjOQXXmZazgAE3/z8pLQsigG+pzPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mmAbNiMuUrnYmjhqGRk2m36n0oJmscNLYfD+LuhNWEg=;
        b=gV7a9txwmUf26chAhYYvN5unGKq7AtUJZdHsw2hGvMWpBNb8BAaiDCaCSBQ+SHEngu
         M89/QHTIYkbbEcxBYRVq0sxEOmKcghXUYvXzH2JJ1Li7Egd3KwvI8wBDuwMf2QCYfBrI
         x7jJEFCUOko4W4c/G8mPz4GIN8xhtjSRMW1yb06SnQZEglnXI1POxZWLeCJFYRFAK0sa
         n8Qe3yhKQsi1uR3XVGOdcEhfhyqVk/D6qL3Nkr2Oq3S1JeN9eqVnML2vy7gIIIyA/GkO
         A5ySNRDXaNBKPXOpeNQNyVteQ5ysb2WWVJqixHT/uEJAcA8QPBpc2sACs4MVXvCqW+Cx
         Pr5w==
X-Gm-Message-State: APjAAAWzXmVKhAtN15EFXhETJJs65GTGEpg04lAHe9SAfOkI2uduBLMC
        7exRxoCkukl/VA62bNCpr2CE/g==
X-Google-Smtp-Source: APXvYqzIZfUozrpQcbkhTjt7M/syg9J73XeXVWZL94XpJG1j2uYOo56p+5zAc9qh/PR0O8A6V/Retg==
X-Received: by 2002:a62:ab18:: with SMTP id p24mr59936365pff.113.1564751550984;
        Fri, 02 Aug 2019 06:12:30 -0700 (PDT)
Received: from shik-z840.tpe.corp.google.com ([2401:fa00:1:10:a6b1:952b:1029:d63b])
        by smtp.gmail.com with ESMTPSA id 195sm120151066pfu.75.2019.08.02.06.12.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 06:12:30 -0700 (PDT)
From:   Shik Chen <shik@chromium.org>
To:     linux-media@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>, notify@kernel.org,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Ricky Liang <jcliang@chromium.org>,
        Shik Chen <shik@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: uvcvideo: Use streaming DMA APIs to transfer buffers
Date:   Fri,  2 Aug 2019 21:12:26 +0800
Message-Id: <20190802131226.123800-1-shik@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the commit 1161db6776bd ("media: usb: pwc: Don't use coherent
DMA buffers for ISO transfer") [1] for the pwc driver. Use streaming DMA
APIs to transfer buffers and sync them explicitly, because accessing
buffers allocated by usb_alloc_coherent() is slow on platforms without
hardware coherent DMA.

Tested on x86-64 (Intel Celeron 4305U) and armv7l (Rockchip RK3288) with
Logitech Brio 4K camera at 1920x1080 using the WebRTC sample site [3].

|                  |  URB (us)  | Decode (Gbps) | CPU (%) |
|------------------|------------|---------------|---------|
| x86-64 coherent  |  53 +-  20 |          50.6 |    0.24 |
| x86-64 streaming |  55 +-  19 |          50.1 |    0.25 |
| armv7l coherent  | 342 +- 379 |           1.8 |    2.16 |
| armv7l streaming |  99 +-  98 |          11.0 |    0.36 |

The performance characteristics are improved a lot on armv7l, and
remained (almost) unchanged on x86-64. The code used for measurement can
be found at [2].

[1] https://git.kernel.org/torvalds/c/1161db6776bd
[2] https://crrev.com/c/1729133
[3] https://webrtc.github.io/samples/src/content/getusermedia/resolution/

Signed-off-by: Shik Chen <shik@chromium.org>
---
The allocated buffer could be as large as 768K when streaming 4K video.
Ideally we should use some generic helper to allocate non-coherent
memory in a more efficient way, such as https://lwn.net/Articles/774429/
("make the non-consistent DMA allocator more userful").

But I cannot find any existing helper so a simple kzalloc() is used in
this patch. The logic to figure out the DMA addressable GFP flags is
similar to __dma_direct_alloc_pages() without the optimistic retries:
https://elixir.bootlin.com/linux/v5.2.5/source/kernel/dma/direct.c#L96

 drivers/media/usb/uvc/uvc_video.c | 65 +++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 8fa77a81dd7f2c..962c35478896c4 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1539,6 +1539,8 @@ static void uvc_video_complete(struct urb *urb)
 	 * Process the URB headers, and optionally queue expensive memcpy tasks
 	 * to be deferred to a work queue.
 	 */
+	dma_sync_single_for_cpu(&urb->dev->dev, urb->transfer_dma,
+				urb->transfer_buffer_length, DMA_FROM_DEVICE);
 	stream->decode(uvc_urb, buf, buf_meta);
 
 	/* If no async work is needed, resubmit the URB immediately. */
@@ -1565,18 +1567,51 @@ static void uvc_free_urb_buffers(struct uvc_streaming *stream)
 		if (!uvc_urb->buffer)
 			continue;
 
-#ifndef CONFIG_DMA_NONCOHERENT
-		usb_free_coherent(stream->dev->udev, stream->urb_size,
-				  uvc_urb->buffer, uvc_urb->dma);
-#else
+		dma_unmap_single(&stream->dev->udev->dev, uvc_urb->dma,
+				 stream->urb_size, DMA_FROM_DEVICE);
 		kfree(uvc_urb->buffer);
-#endif
-		uvc_urb->buffer = NULL;
 	}
 
 	stream->urb_size = 0;
 }
 
+static gfp_t uvc_alloc_gfp_flags(struct device *dev)
+{
+	u64 mask = dma_get_mask(dev);
+
+	if (dev->bus_dma_mask)
+		mask &= dev->bus_dma_mask;
+
+	if (mask < DMA_BIT_MASK(32) && IS_ENABLED(CONFIG_ZONE_DMA))
+		return GFP_DMA;
+
+	if (mask < DMA_BIT_MASK(64)) {
+		if (IS_ENABLED(CONFIG_ZONE_DMA32))
+			return GFP_DMA32;
+		if (IS_ENABLED(CONFIG_ZONE_DMA))
+			return GFP_DMA;
+	}
+
+	return 0;
+}
+
+static char *uvc_alloc_urb_buffer(struct device *dev, size_t size,
+				  gfp_t gfp_flags, dma_addr_t *dma_handle)
+{
+	void *buffer = kzalloc(size, gfp_flags | uvc_alloc_gfp_flags(dev));
+
+	if (!buffer)
+		return NULL;
+
+	*dma_handle = dma_map_single(dev, buffer, size, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dev, *dma_handle)) {
+		kfree(buffer);
+		return NULL;
+	}
+
+	return buffer;
+}
+
 /*
  * Allocate transfer buffers. This function can be called with buffers
  * already allocated when resuming from suspend, in which case it will
@@ -1607,18 +1642,14 @@ static int uvc_alloc_urb_buffers(struct uvc_streaming *stream,
 
 	/* Retry allocations until one succeed. */
 	for (; npackets > 1; npackets /= 2) {
+		stream->urb_size = psize * npackets;
+
 		for (i = 0; i < UVC_URBS; ++i) {
 			struct uvc_urb *uvc_urb = &stream->uvc_urb[i];
 
-			stream->urb_size = psize * npackets;
-#ifndef CONFIG_DMA_NONCOHERENT
-			uvc_urb->buffer = usb_alloc_coherent(
-				stream->dev->udev, stream->urb_size,
+			uvc_urb->buffer = uvc_alloc_urb_buffer(
+				&stream->dev->udev->dev, stream->urb_size,
 				gfp_flags | __GFP_NOWARN, &uvc_urb->dma);
-#else
-			uvc_urb->buffer =
-			    kmalloc(stream->urb_size, gfp_flags | __GFP_NOWARN);
-#endif
 			if (!uvc_urb->buffer) {
 				uvc_free_urb_buffers(stream);
 				break;
@@ -1728,12 +1759,8 @@ static int uvc_init_video_isoc(struct uvc_streaming *stream,
 		urb->context = uvc_urb;
 		urb->pipe = usb_rcvisocpipe(stream->dev->udev,
 				ep->desc.bEndpointAddress);
-#ifndef CONFIG_DMA_NONCOHERENT
 		urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
 		urb->transfer_dma = uvc_urb->dma;
-#else
-		urb->transfer_flags = URB_ISO_ASAP;
-#endif
 		urb->interval = ep->desc.bInterval;
 		urb->transfer_buffer = uvc_urb->buffer;
 		urb->complete = uvc_video_complete;
@@ -1793,10 +1820,8 @@ static int uvc_init_video_bulk(struct uvc_streaming *stream,
 
 		usb_fill_bulk_urb(urb, stream->dev->udev, pipe,	uvc_urb->buffer,
 				  size, uvc_video_complete, uvc_urb);
-#ifndef CONFIG_DMA_NONCOHERENT
 		urb->transfer_flags = URB_NO_TRANSFER_DMA_MAP;
 		urb->transfer_dma = uvc_urb->dma;
-#endif
 
 		uvc_urb->urb = urb;
 	}
-- 
2.22.0.770.g0f2c4a37fd-goog

