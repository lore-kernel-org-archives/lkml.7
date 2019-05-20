Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072DBC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB46213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="F8LgFcDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbfETIW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:22:58 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35647 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731448AbfETIWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id p26so22582058edr.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DjcLsPlsjE209Q795HkarLAUj4qVY5QZ6l/8BCYUlrU=;
        b=F8LgFcDyNEbgtqr09gmvby+A70IlXFhvdKJQGuQU76/bnBUMWD33WhmzV8anIfkPi0
         mD3mM5zUjNuB3gBIUmxNtzHTrHn1ZPQphxPlYuP0ARRH9XNaNMlrnJClFCLSGQcOWL0g
         Q7q+eBvuuOnPjNkfowVtPdLB0l/WbtympM+P0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DjcLsPlsjE209Q795HkarLAUj4qVY5QZ6l/8BCYUlrU=;
        b=NGk6CTUeyevaVb8LIAbFKctXGQj6iwryyt4F1HwjeK1RDaZ8ZURe1cZHFOc6Bh3gd1
         xErznk3mooMnfjnXPqBKFbXbgW4mkcyJgRobX6h4gU9O6/95FGIAwpw+S5XHtU3NwRfx
         CFqnQoJ287Yj0sK95p2v6hlHICXJrTVe62Nb0McKGw5NpKrV0rbW4Ur9KxrYw1OI9yk3
         Fx2Gf9erQm54J8WuBTlhMtODvUs3XhVFSNF3+wG+QB5U3xtZMzPj3/ErtgoSgp+1ef4p
         Q8q4cnWkF7Bm+A4r+Fe5g4jV4+WR1ZtN1MLaxNsV/awHi3Yu81XE5kiLeEgIR5K0FW0h
         MMMQ==
X-Gm-Message-State: APjAAAW1o22MrmzRnPAjnOI53o6wKzN1esY+uhhLmQex3FvCy8mf8E0F
        EvLMwojRNcdameSpf04UwX0FDA==
X-Google-Smtp-Source: APXvYqz6gMGaKw7InNRAYh/FfyGrrZIJCiKRyHBCsxnsADOp8agSMiMyM3ffksqbZU0sp3KMCISA6Q==
X-Received: by 2002:a50:a485:: with SMTP id w5mr28701154edb.78.1558340573984;
        Mon, 20 May 2019 01:22:53 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:53 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH 27/33] fbdev: remove FBINFO_MISC_USEREVENT around fb_blank
Date:   Mon, 20 May 2019 10:22:10 +0200
Message-Id: <20190520082216.26273-28-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the recursion broken in the previous patch we can drop the
FBINFO_MISC_USEREVENT flag around calls to fb_blank - recursion
prevention was it's only job.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Yisheng Xie <ysxie@foxmail.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Rob Clark <robdclark@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c   | 5 ++---
 drivers/video/fbdev/core/fbmem.c   | 3 ---
 drivers/video/fbdev/core/fbsysfs.c | 2 --
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index f85d794a3bee..c1a7476e980f 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2382,9 +2382,8 @@ static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
 			fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
 			ops->cursor_flash = (!blank);
 
-			if (!(info->flags & FBINFO_MISC_USEREVENT))
-				if (fb_blank(info, blank))
-					fbcon_generic_blank(vc, info, blank);
+			if (fb_blank(info, blank))
+				fbcon_generic_blank(vc, info, blank);
 		}
 
 		if (!blank)
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 7f95c7e80155..65a075ccac4a 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1194,10 +1194,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	case FBIOBLANK:
 		console_lock();
 		lock_fb_info(info);
-		info->flags |= FBINFO_MISC_USEREVENT;
 		ret = fb_blank(info, arg);
-		info->flags &= ~FBINFO_MISC_USEREVENT;
-
 		/* might again call into fb_blank */
 		fbcon_fb_blanked(info, arg);
 		unlock_fb_info(info);
diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 252d4f52d2a5..882b471d619e 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -310,9 +310,7 @@ static ssize_t store_blank(struct device *device,
 
 	arg = simple_strtoul(buf, &last, 0);
 	console_lock();
-	fb_info->flags |= FBINFO_MISC_USEREVENT;
 	err = fb_blank(fb_info, arg);
-	fb_info->flags &= ~FBINFO_MISC_USEREVENT;
 	/* might again call into fb_blank */
 	fbcon_fb_blanked(fb_info, arg);
 	console_unlock();
-- 
2.20.1

