Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD58DC48BD5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24EB204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 01:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwstq9SV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfFZBih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 21:38:37 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38361 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFZBih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 21:38:37 -0400
Received: by mail-qk1-f193.google.com with SMTP id a27so352735qkk.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 18:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VhvsA2mFJL5Xe5+RHkMF0VDR29nwFdCWp8jzkz78NKs=;
        b=rwstq9SV12XPNESW3bHDHzxMr1EbE9kLJvo0w/fufz8IIyTZmnFvZ5I0iflsdlXn1M
         EZ356wSG1KOO40stlTjAjI/D9Wm64ctkumXNZZIrSFfuyMpm68Xxn1/xGSpDuSxCfvyp
         nM81CeAOeXw3tiT6smx1EVrBpt08DuAqPWQyWS8yHQ7ZQrtZra7c+V5YSuk+Bm2da2O+
         8myyuA5/z5qJY4aB4EGlNih5NEihjgGWqddNIcPNnao0NReUTUpy8cLiiPq5DPM3haCa
         HpvJ6m7EtIhDXO9/mE+WUCaTmP/pWcHeGIStjWNU1VBab7O5vZ5c1WDOqx5g8OZ/fX+F
         40Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VhvsA2mFJL5Xe5+RHkMF0VDR29nwFdCWp8jzkz78NKs=;
        b=Qi+RSPyDV2e4FvNr8dpazLqodcwdE346XptY1FZ+tyDbugss/7JzwGbmAORtet3tYH
         KirrOzYrotnfn254EH+QDVtbPjN5P8Ht2t9aBq5weMYpqyVGqf5/3DqKfFwu8I3EcDUZ
         MZ5s+NDXJbonmOqvGu/e+V/VLPeOUSYXpJ7nCHc+aoRUtlVff8kZhEb36NnBEfPVF7wQ
         +3P3DiZO125A/kZhx4vbTWXvCsuSKMj/g0oN7qFU/ycUmrdp4YyfAEXtDEsBcMWVojax
         y+Q363RXvnFmbCMMwXrYG8PINgkwjRfNlOp+OwkZS00h5KcoDq4QMsHw+Jy8Y8RP8j3F
         Wy3w==
X-Gm-Message-State: APjAAAViB/y0YCIn22jX//uZH4hdLvTV4QietY9d0LsM96fEoPaawDED
        jiEOSZ1nfZnnpJjM7ogHzNfb1O96
X-Google-Smtp-Source: APXvYqxZZf0LF7ILRzNdTHyeclwzLjQ3OWXOXs+v+XxDfPqPWC8/3w4blmvuCJH391wQzNWiyx780A==
X-Received: by 2002:a37:668c:: with SMTP id a134mr1564017qkc.477.1561513116203;
        Tue, 25 Jun 2019 18:38:36 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.146])
        by smtp.gmail.com with ESMTPSA id h40sm9967150qth.4.2019.06.25.18.38.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 18:38:35 -0700 (PDT)
Date:   Tue, 25 Jun 2019 22:38:31 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/5] drm/vkms: Compute CRC without change input data
Message-ID: <ea7e3a0daa4ee502d8ec67a010120d53f88fa06b.1561491964.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1561491964.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1561491964.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compute_crc() function is responsible for calculating the
framebuffer CRC value; due to the XRGB format, this function has to
ignore the alpha channel during the CRC computation. Therefore,
compute_crc() set zero to the alpha channel directly in the input
framebuffer, which is not a problem since this function receives a copy
of the original buffer. However, if we want to use this function in a
context without a buffer copy, it will change the initial value. This
patch makes compute_crc() calculate the CRC value without modifying the
input framebuffer.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 31 +++++++++++++++++-----------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 51a270514219..8126aa0f968f 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -6,33 +6,40 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 
+static u32 get_pixel_from_buffer(int x, int y, const u8 *buffer,
+				 const struct vkms_composer *composer)
+{
+	int src_offset = composer->offset + (y * composer->pitch)
+					  + (x * composer->cpp);
+
+	return *(u32 *)&buffer[src_offset];
+}
+
 /**
  * compute_crc - Compute CRC value on output frame
  *
- * @vaddr_out: address to final framebuffer
+ * @vaddr: address to final framebuffer
  * @composer: framebuffer's metadata
  *
  * returns CRC value computed using crc32 on the visible portion of
  * the final framebuffer at vaddr_out
  */
-static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *composer)
+static uint32_t compute_crc(const u8 *vaddr,
+			    const struct vkms_composer *composer)
 {
-	int i, j, src_offset;
+	int x, y;
 	int x_src = composer->src.x1 >> 16;
 	int y_src = composer->src.y1 >> 16;
 	int h_src = drm_rect_height(&composer->src) >> 16;
 	int w_src = drm_rect_width(&composer->src) >> 16;
-	u32 crc = 0;
+	u32 crc = 0, pixel = 0;
 
-	for (i = y_src; i < y_src + h_src; ++i) {
-		for (j = x_src; j < x_src + w_src; ++j) {
-			src_offset = composer->offset
-				     + (i * composer->pitch)
-				     + (j * composer->cpp);
+	for (y = y_src; y < y_src + h_src; ++y) {
+		for (x = x_src; x < x_src + w_src; ++x) {
 			/* XRGB format ignores Alpha channel */
-			memset(vaddr_out + src_offset + 24, 0,  8);
-			crc = crc32_le(crc, vaddr_out + src_offset,
-				       sizeof(u32));
+			pixel = get_pixel_from_buffer(x, y, vaddr, composer);
+			bitmap_clear((void *)&pixel, 0, 8);
+			crc = crc32_le(crc, (void *)&pixel, sizeof(u32));
 		}
 	}
 
-- 
2.21.0
