Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFCBC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BAA20856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="G0YJ7vs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbfETIWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:22:34 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34340 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731299AbfETIWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id p27so22585162eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Yi2X1g2LDOK5pARSqfDRbgYny8Ht12DRNhi7B8kudE=;
        b=G0YJ7vs27y+V7OdMp+ENPD1lSgTa7pNGdeswUFxkTwXtbtAumSLGCgWrIYQVT55Q9W
         1QcmoAdHvvy0lrdBljaNzs8QH2Pl1vBp/eZd4v9sjDPKQ3L6aCcyxlfACZbPsj5X2VZr
         s61clzBKGrQItY414cJdscFjWMzl/7+tRX4ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Yi2X1g2LDOK5pARSqfDRbgYny8Ht12DRNhi7B8kudE=;
        b=FSEh7AjKvr2kOuyIg9RCbv1NDG+cCPpm+1s6dhr1jt6nAglElBYPU368ZKOBaRFbJE
         s3Ws/OVeIVvlzgKGDFWGmL/GggcER3F5eOwXpwTkiued6VZw5DnkVPBojyMh0MRDLi21
         9oT+EBdwmC7YOAjc+KbjEL/rmnYLQtaZooSwSEzaCcmx5lcSmRxr/ocOKWNACvRFnqns
         KQW1Ak4eKgV8mYJPiP5/KZgwYvlWhvNcRP/rgnvOA2CGDJExTOYSRD6FW0CjS3UaiQY6
         1Gl5LiRo647LHbOnNDU8EyvVe5DayrgQ6QJPHXDAMhm6IY8DPM2eufugKsWXpA+CEyIk
         LeMw==
X-Gm-Message-State: APjAAAV9Z8tZdDe4+Q3JzlqxVoiiGxI4fBPwanI+TvL/Rp/CP6EQcbPZ
        rc74HUxBA72cd+4U+wMoVfkxBQ==
X-Google-Smtp-Source: APXvYqx1KMcrcgpQkz4bO2jVYqWxeEYutnIUAq9EK8LkqC8rGjLsuq/dv8waUJ8jpDkNsjUkAr/k7w==
X-Received: by 2002:a17:906:2cd1:: with SMTP id r17mr57422258ejr.101.1558340550757;
        Mon, 20 May 2019 01:22:30 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:30 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Paul Mackerras <paulus@samba.org>, linux-fbdev@vger.kernel.org
Subject: [PATCH 07/33] fbdev/aty128fb: Remove dead code
Date:   Mon, 20 May 2019 10:21:50 +0200
Message-Id: <20190520082216.26273-8-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Motivated because it contains a struct display, which is a fbcon
internal data structure that I want to rename. It seems to have been
formerly used in drivers, but that's very long time ago.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/aty/aty128fb.c | 64 ------------------------------
 1 file changed, 64 deletions(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index 6cc46867ff57..c022ad7a49c2 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -2349,70 +2349,6 @@ static int aty128fb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 	return -EINVAL;
 }
 
-#if 0
-    /*
-     *  Accelerated functions
-     */
-
-static inline void aty128_rectcopy(int srcx, int srcy, int dstx, int dsty,
-				   u_int width, u_int height,
-				   struct fb_info_aty128 *par)
-{
-	u32 save_dp_datatype, save_dp_cntl, dstval;
-
-	if (!width || !height)
-		return;
-
-	dstval = depth_to_dst(par->current_par.crtc.depth);
-	if (dstval == DST_24BPP) {
-		srcx *= 3;
-		dstx *= 3;
-		width *= 3;
-	} else if (dstval == -EINVAL) {
-		printk("aty128fb: invalid depth or RGBA\n");
-		return;
-	}
-
-	wait_for_fifo(2, par);
-	save_dp_datatype = aty_ld_le32(DP_DATATYPE);
-	save_dp_cntl     = aty_ld_le32(DP_CNTL);
-
-	wait_for_fifo(6, par);
-	aty_st_le32(SRC_Y_X, (srcy << 16) | srcx);
-	aty_st_le32(DP_MIX, ROP3_SRCCOPY | DP_SRC_RECT);
-	aty_st_le32(DP_CNTL, DST_X_LEFT_TO_RIGHT | DST_Y_TOP_TO_BOTTOM);
-	aty_st_le32(DP_DATATYPE, save_dp_datatype | dstval | SRC_DSTCOLOR);
-
-	aty_st_le32(DST_Y_X, (dsty << 16) | dstx);
-	aty_st_le32(DST_HEIGHT_WIDTH, (height << 16) | width);
-
-	par->blitter_may_be_busy = 1;
-
-	wait_for_fifo(2, par);
-	aty_st_le32(DP_DATATYPE, save_dp_datatype);
-	aty_st_le32(DP_CNTL, save_dp_cntl);
-}
-
-
-    /*
-     * Text mode accelerated functions
-     */
-
-static void fbcon_aty128_bmove(struct display *p, int sy, int sx, int dy,
-			       int dx, int height, int width)
-{
-	sx     *= fontwidth(p);
-	sy     *= fontheight(p);
-	dx     *= fontwidth(p);
-	dy     *= fontheight(p);
-	width  *= fontwidth(p);
-	height *= fontheight(p);
-
-	aty128_rectcopy(sx, sy, dx, dy, width, height,
-			(struct fb_info_aty128 *)p->fb_info);
-}
-#endif /* 0 */
-
 static void aty128_set_suspend(struct aty128fb_par *par, int suspend)
 {
 	u32	pmgt;
-- 
2.20.1

