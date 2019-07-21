Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4523C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F7B2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 20:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AyehZSuG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfGUUUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 16:20:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42776 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfGUUUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 16:20:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id v15so38838628eds.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 13:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XRwj/hgNS14q+rvkCpix4vLLy7DZh4BLZEjg+qSfiZg=;
        b=AyehZSuGZCvBsaILvR/krcYsapjAPI1gVWmMmVd+jre9fcmOOPqhoywhyy47IXwENp
         tqNgZVjZgEkBNduUidPOAMhHOZ5b3JKmpwziOTwokGvDa2rRpYoTaJmGAyjBxRZbTaOy
         UvogFiqQ2RBg8fEs4X4YI880mcQdt1U0lNNIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XRwj/hgNS14q+rvkCpix4vLLy7DZh4BLZEjg+qSfiZg=;
        b=a/wgfWVDY8e8LHX33YghPndSslhwzhUYQw9AgoDzwBwGMKc1MQ1puwE9r94gwedxF0
         5HNH0SDMKN3pLo52naPYeQ3IDJ2VYdkWVvqqjSwnn/yQ3lmlvOz+/iGQbE/po1241Pk/
         v/CFxvo0GuZA9cAxaDerRmT8zgQ/Jqf6p96hW5ZGBUIWIFDRJPs0DQwF2nZMro4CtqVS
         J262W3CKiqPMapqELJwlzuqfbHTJSK/tHJmS7aqxX3SHN0LSpBP2q/VGDRgdIKWXLQ/6
         Y1WLfZ/MAQgkNKa61oOuNV1tWx7KFGb4oUwyS9mft8EvaRPnIihFgUPRoZXMSKHhI+U+
         qIwg==
X-Gm-Message-State: APjAAAXnN7JjvFS9UWJXH5nFauxUzfqwH7H+E6idiNW9MimMKc0xGUbc
        d1lpJCNZEDA7J83wBMji2eM=
X-Google-Smtp-Source: APXvYqxi2U8nESKiWK5L9snLfUB1kh5NY8KjkT4EGpbXWuhn4pGor8y7Xqg7LmeOA6xXbjUWkN2JRQ==
X-Received: by 2002:a17:906:802:: with SMTP id e2mr50030972ejd.59.1563740405438;
        Sun, 21 Jul 2019 13:20:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id m25sm7648677ejs.85.2019.07.21.13.20.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 13:20:04 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tavis Ormandy <taviso@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH] fbdev: Ditch fb_edid_add_monspecs
Date:   Sun, 21 Jul 2019 22:19:56 +0200
Message-Id: <20190721201956.941-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's dead code ever since

commit 34280340b1dc74c521e636f45cd728f9abf56ee2
Author: Geert Uytterhoeven <geert+renesas@glider.be>
Date:   Fri Dec 4 17:01:43 2015 +0100

    fbdev: Remove unused SH-Mobile HDMI driver

Also with this gone we can remove the cea_modes db. This entire thing
is massively incomplete anyway, compared to the CEA parsing that
drm_edid.c does.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tavis Ormandy <taviso@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/video/fbdev/core/fbmon.c  | 96 -------------------------------
 drivers/video/fbdev/core/modedb.c | 57 ------------------
 include/linux/fb.h                |  3 -
 3 files changed, 156 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 3558a70a6664..8e2e19f3bf44 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -999,98 +999,6 @@ void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 	DPRINTK("========================================\n");
 }
 
-/**
- * fb_edid_add_monspecs() - add monitor video modes from E-EDID data
- * @edid:	128 byte array with an E-EDID block
- * @spacs:	monitor specs to be extended
- */
-void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
-{
-	unsigned char *block;
-	struct fb_videomode *m;
-	int num = 0, i;
-	u8 svd[64], edt[(128 - 4) / DETAILED_TIMING_DESCRIPTION_SIZE];
-	u8 pos = 4, svd_n = 0;
-
-	if (!edid)
-		return;
-
-	if (!edid_checksum(edid))
-		return;
-
-	if (edid[0] != 0x2 ||
-	    edid[2] < 4 || edid[2] > 128 - DETAILED_TIMING_DESCRIPTION_SIZE)
-		return;
-
-	DPRINTK("  Short Video Descriptors\n");
-
-	while (pos < edid[2]) {
-		u8 len = edid[pos] & 0x1f, type = (edid[pos] >> 5) & 7;
-		pr_debug("Data block %u of %u bytes\n", type, len);
-		if (type == 2) {
-			for (i = pos; i < pos + len; i++) {
-				u8 idx = edid[pos + i] & 0x7f;
-				svd[svd_n++] = idx;
-				pr_debug("N%sative mode #%d\n",
-					 edid[pos + i] & 0x80 ? "" : "on-n", idx);
-			}
-		} else if (type == 3 && len >= 3) {
-			/* Check Vendor Specific Data Block.  For HDMI,
-			   it is always 00-0C-03 for HDMI Licensing, LLC. */
-			if (edid[pos + 1] == 3 && edid[pos + 2] == 0xc &&
-			    edid[pos + 3] == 0)
-				specs->misc |= FB_MISC_HDMI;
-		}
-		pos += len + 1;
-	}
-
-	block = edid + edid[2];
-
-	DPRINTK("  Extended Detailed Timings\n");
-
-	for (i = 0; i < (128 - edid[2]) / DETAILED_TIMING_DESCRIPTION_SIZE;
-	     i++, block += DETAILED_TIMING_DESCRIPTION_SIZE)
-		if (PIXEL_CLOCK != 0)
-			edt[num++] = block - edid;
-
-	/* Yikes, EDID data is totally useless */
-	if (!(num + svd_n))
-		return;
-
-	m = kcalloc(specs->modedb_len + num + svd_n,
-		    sizeof(struct fb_videomode),
-		    GFP_KERNEL);
-
-	if (!m)
-		return;
-
-	memcpy(m, specs->modedb, specs->modedb_len * sizeof(struct fb_videomode));
-
-	for (i = specs->modedb_len; i < specs->modedb_len + num; i++) {
-		get_detailed_timing(edid + edt[i - specs->modedb_len], &m[i]);
-		if (i == specs->modedb_len)
-			m[i].flag |= FB_MODE_IS_FIRST;
-		pr_debug("Adding %ux%u@%u\n", m[i].xres, m[i].yres, m[i].refresh);
-	}
-
-	for (i = specs->modedb_len + num; i < specs->modedb_len + num + svd_n; i++) {
-		int idx = svd[i - specs->modedb_len - num];
-		if (!idx || idx >= ARRAY_SIZE(cea_modes)) {
-			pr_warn("Reserved SVD code %d\n", idx);
-		} else if (!cea_modes[idx].xres) {
-			pr_warn("Unimplemented SVD code %d\n", idx);
-		} else {
-			memcpy(&m[i], cea_modes + idx, sizeof(m[i]));
-			pr_debug("Adding SVD #%d: %ux%u@%u\n", idx,
-				 m[i].xres, m[i].yres, m[i].refresh);
-		}
-	}
-
-	kfree(specs->modedb);
-	specs->modedb = m;
-	specs->modedb_len = specs->modedb_len + num + svd_n;
-}
-
 /*
  * VESA Generalized Timing Formula (GTF)
  */
@@ -1500,9 +1408,6 @@ int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
 void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 {
 }
-void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
-{
-}
 void fb_destroy_modedb(struct fb_videomode *modedb)
 {
 }
@@ -1610,7 +1515,6 @@ EXPORT_SYMBOL(fb_firmware_edid);
 
 EXPORT_SYMBOL(fb_parse_edid);
 EXPORT_SYMBOL(fb_edid_to_monspecs);
-EXPORT_SYMBOL(fb_edid_add_monspecs);
 EXPORT_SYMBOL(fb_get_mode);
 EXPORT_SYMBOL(fb_validate_mode);
 EXPORT_SYMBOL(fb_destroy_modedb);
diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index ac049871704d..6473e0dfe146 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -289,63 +289,6 @@ static const struct fb_videomode modedb[] = {
 };
 
 #ifdef CONFIG_FB_MODE_HELPERS
-const struct fb_videomode cea_modes[65] = {
-	/* #1: 640x480p@59.94/60Hz */
-	[1] = {
-		NULL, 60, 640, 480, 39722, 48, 16, 33, 10, 96, 2, 0,
-		FB_VMODE_NONINTERLACED, 0,
-	},
-	/* #3: 720x480p@59.94/60Hz */
-	[3] = {
-		NULL, 60, 720, 480, 37037, 60, 16, 30, 9, 62, 6, 0,
-		FB_VMODE_NONINTERLACED, 0,
-	},
-	/* #5: 1920x1080i@59.94/60Hz */
-	[5] = {
-		NULL, 60, 1920, 1080, 13763, 148, 88, 15, 2, 44, 5,
-		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		FB_VMODE_INTERLACED, 0,
-	},
-	/* #7: 720(1440)x480iH@59.94/60Hz */
-	[7] = {
-		NULL, 60, 1440, 480, 18554/*37108*/, 114, 38, 15, 4, 124, 3, 0,
-		FB_VMODE_INTERLACED, 0,
-	},
-	/* #9: 720(1440)x240pH@59.94/60Hz */
-	[9] = {
-		NULL, 60, 1440, 240, 18554, 114, 38, 16, 4, 124, 3, 0,
-		FB_VMODE_NONINTERLACED, 0,
-	},
-	/* #18: 720x576pH@50Hz */
-	[18] = {
-		NULL, 50, 720, 576, 37037, 68, 12, 39, 5, 64, 5, 0,
-		FB_VMODE_NONINTERLACED, 0,
-	},
-	/* #19: 1280x720p@50Hz */
-	[19] = {
-		NULL, 50, 1280, 720, 13468, 220, 440, 20, 5, 40, 5,
-		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		FB_VMODE_NONINTERLACED, 0,
-	},
-	/* #20: 1920x1080i@50Hz */
-	[20] = {
-		NULL, 50, 1920, 1080, 13480, 148, 528, 15, 5, 528, 5,
-		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		FB_VMODE_INTERLACED, 0,
-	},
-	/* #32: 1920x1080p@23.98/24Hz */
-	[32] = {
-		NULL, 24, 1920, 1080, 13468, 148, 638, 36, 4, 44, 5,
-		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-		FB_VMODE_NONINTERLACED, 0,
-	},
-	/* #35: (2880)x480p4x@59.94/60Hz */
-	[35] = {
-		NULL, 60, 2880, 480, 9250, 240, 64, 30, 9, 248, 6, 0,
-		FB_VMODE_NONINTERLACED, 0,
-	},
-};
-
 const struct fb_videomode vesa_modes[] = {
 	/* 0 640x350-85 VESA */
 	{ NULL, 85, 640, 350, 31746,  96, 32, 60, 32, 64, 3,
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 303771264644..50948e519897 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -721,8 +721,6 @@ extern int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var);
 extern const unsigned char *fb_firmware_edid(struct device *device);
 extern void fb_edid_to_monspecs(unsigned char *edid,
 				struct fb_monspecs *specs);
-extern void fb_edid_add_monspecs(unsigned char *edid,
-				 struct fb_monspecs *specs);
 extern void fb_destroy_modedb(struct fb_videomode *modedb);
 extern int fb_find_mode_cvt(struct fb_videomode *mode, int margins, int rb);
 extern unsigned char *fb_ddc_read(struct i2c_adapter *adapter);
@@ -796,7 +794,6 @@ struct dmt_videomode {
 
 extern const char *fb_mode_option;
 extern const struct fb_videomode vesa_modes[];
-extern const struct fb_videomode cea_modes[65];
 extern const struct dmt_videomode dmt_modes[];
 
 struct fb_modelist {
-- 
2.22.0

