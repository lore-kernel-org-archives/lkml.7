Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31733C282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD192184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GkrIhBzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389951AbfEXIyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:54:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38520 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389903AbfEXIyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:12 -0400
Received: by mail-ed1-f68.google.com with SMTP id w11so13355956edl.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Yi2X1g2LDOK5pARSqfDRbgYny8Ht12DRNhi7B8kudE=;
        b=GkrIhBzsh/dyuD46FibJNsj3ybR3VHCP3KMldWUxoAiVPhGVdmmraO0zxu6IxhhDNq
         Eel9xHlhqJDoe6vmwJhhE44ljVs0hEaQQD61JlN3jcg3fK1R7mU/jaHe5GZYZa6TBacb
         k2irmLg9K/PU9JgwqmUO69TUDy7f3qRh6xXok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Yi2X1g2LDOK5pARSqfDRbgYny8Ht12DRNhi7B8kudE=;
        b=ciOgipLrTpn+lUxxgvCGwEXCGjgEJiAsvf73x/CfLzoDj/F5VLjONdZaHDXxhl525x
         tuhfSgJtynbEw0QwjuZD6yQSLNEU/hjcEQJ/bYj1SXoNscAwJL6ZfzUzEWy5tZdsTqL3
         TxMABGJceK/CfJMWEkhhIqVZEJdWi+P552cGQP/LK5BdVFn78fhHWq34GTZW+Q2uHUCc
         Z0WCPHvbf4bljxrOqm75BotK4voYuHN4c6z9OM1fQKajtStdt7jv7IQVReWwjnwX4jfG
         k2YXfiyK4ZtA8Tr32N1ufcfVlUhR656Y/OTmA+FsrS13jyrWQj0/6VXfYW7ErFpO85/8
         BmYQ==
X-Gm-Message-State: APjAAAXl+WpW7IjeaNyqpkah0tWYxOW08dRQHtX0IgXZEmwJ6Iu8bZDV
        VL3tufWat6L92gbe8RqRdHXy24JCxoo=
X-Google-Smtp-Source: APXvYqzIsHwiYa7JjXSPsUVWeZmTbiIsMsT3LlqQoxO/rJ0fEq2oC/v4Vu1Zx20CdrP5EIG5vFj0Og==
X-Received: by 2002:a50:e79b:: with SMTP id b27mr105217459edn.281.1558688050852;
        Fri, 24 May 2019 01:54:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:10 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Paul Mackerras <paulus@samba.org>, linux-fbdev@vger.kernel.org
Subject: [PATCH 07/33] fbdev/aty128fb: Remove dead code
Date:   Fri, 24 May 2019 10:53:28 +0200
Message-Id: <20190524085354.27411-8-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
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

