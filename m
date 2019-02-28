Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB3BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB8C2184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3/FMtjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbfB1Qsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:48:37 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53459 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfB1Qsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:48:37 -0500
Received: by mail-it1-f194.google.com with SMTP id v2so15664522ith.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 08:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cV3QheQ/KTX1k6paCx3zmKRnyrqW71O0cAwXV4iKCKA=;
        b=A3/FMtjpNeOzMv3WXL057jHk3V8Sv9j8nFexHvedaqYtWWoBnuBefPkQWA3fIhMlEp
         brNl72H41EeqiC+i+2YyfY9UQZu+njbFPila7zoJdK1S7DWm2fxE4d6cAkAJAsL4lBp8
         B3DUPpLbNkmm5NU3eEHtlsZsXkP0RXB7ZeO5awWCYslqnIyXff4kEAdgD6XCbeEwn6qx
         9dXb708v7CBYKIAjJrvXfmi392gH6YN277jL3VlaB2PQBS9SAMKfX5+f67Ycp3B3wu4l
         StSI2eM8WnO63aqMidjHkAt7nLdjPN+8BGCsnUbt+Zs0fOn2Y9TR6Io9Vq1tcGbQvzPS
         v16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cV3QheQ/KTX1k6paCx3zmKRnyrqW71O0cAwXV4iKCKA=;
        b=D+t3G9GBVnORQ+9c8Xd0qGugxSO57YyT4RfRrsLWTY1qECvW2DQLV/Rp+TtlT33vwX
         UUepNVdG2629W2+uK8B13S/Vm2DiK3uY5o9x6Ht8IwhRt4PlhUl3WKyqn88rUHaGfhzS
         iQG9dQ7JngZS+1+6p+hYm1XiC5MNeivAeh9zfcpY5/OZrq5b572TrMxEliATimmalgBZ
         tn5NdwvCEIYYRiEmwopMMRgqghLm79rRslaGU2zoJp9pAxDoMCvGfaJUhgr0s/UXDVDg
         CUybNzHDvo6wymEjp+7SWwFanOP2AsNz2+FtvcNXHbF1U/+1GYmNkXwbzWKYEElwBxT5
         /Jog==
X-Gm-Message-State: APjAAAVZPl3azSK3Rn1hc/58SlFSA0M0ZzDNtFuxYnUSqdMDWtnoIPnP
        OPe337OlX88YosvbVPJ5Y6VBE63/
X-Google-Smtp-Source: AHgI3IYNq79lFFZPnKvKQtpgKESpZu95KND+wmz7pRUVatN4e9P+GxDD6jEDM0Oxrk5y32zEdScmJg==
X-Received: by 2002:a24:c486:: with SMTP id v128mr488030itf.138.1551372516462;
        Thu, 28 Feb 2019 08:48:36 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
        by smtp.gmail.com with ESMTPSA id p18sm3057534itp.10.2019.02.28.08.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 08:48:35 -0800 (PST)
From:   Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To:     dri-devel@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>
Cc:     Joshua Watt <JPEWhacker@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/virtio: Allow userspace to mmap() framebuffer
Date:   Thu, 28 Feb 2019 10:47:41 -0600
Message-Id: <20190228164741.15590-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reports the size of the virtgpu framebuffer to userspace and installs
the deferred I/O handlers so that userspace can mmap() and write to it.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_fb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index fb1cc8b2f119..9f44c8d27c64 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -266,11 +266,15 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	info->fbops = &virtio_gpufb_ops;
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
 
+	info->fix.smem_start = 0;
+	info->fix.smem_len = size;
+
 	info->screen_buffer = obj->vmap;
 	info->screen_size = obj->gem_base.size;
 	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
 	drm_fb_helper_fill_var(info, &vfbdev->helper,
 			       sizes->fb_width, sizes->fb_height);
+	drm_fb_helper_defio_init(helper);
 
 	info->fix.mmio_start = 0;
 	info->fix.mmio_len = 0;
-- 
2.20.1

