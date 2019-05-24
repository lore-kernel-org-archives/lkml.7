Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2674C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE452184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ebWf7hY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390207AbfEXIyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:54:41 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35122 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390167AbfEXIyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id p26so13358415edr.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6wlvzPyopdMS/Vqi7fihj+Pgrsm5UtYg+GKB7zvM9Ww=;
        b=ebWf7hY9yJ6blUgMPShPsTw3/gxUhMPZxFy9KfHVvDIZ8jSIsvpx6Y8UEZ55sMqgu4
         WLg3Wix9vBZNuo7A4sGMPRSTsB0XR+rVBgxHhIGSCkqYfRtEtonlaYbqDNlnZfV43v3k
         1TCuNVlRlrlT/gzj/oIjC+5tKw2iW9+WcRFBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6wlvzPyopdMS/Vqi7fihj+Pgrsm5UtYg+GKB7zvM9Ww=;
        b=M+uu7Vme9LIrbrzfRX0meUomj305TmX8EBNh55lSxr92xZHblaVf+iw/+1i+dAISdg
         7uJvFwtQ757d4emv7iv1Q3bOXnQhz1cplNE8k4QWJWQgMLxJsaypvlDx0alF821yo+tv
         /CU0BIW6C9Y0UHLs1h3tRqsrb/lHTx47OMro4ccAUIkwmWQ/6n4WgDFCTDQVcMz6KIm2
         Vvoo27w6r7DpZ14wkkLblAB3v4R4shhyR3YjmW2/gioEHWLl/kw6qGwtgAq6cpqy7/5e
         eFJyqs1Fbq6LMV5lOTHXlWZNUjWm399q6xNbtQdqLkmZTe2TAaj1Y77JUMf3W6odATAB
         LqGw==
X-Gm-Message-State: APjAAAVgLocS+PoB6BOgOpcHhwYqLcFjOp0SfxISCuEPc3sg1ZE0PbAX
        h+MdwxyG41CIT67LR/ZShx1o3MOZFSg=
X-Google-Smtp-Source: APXvYqw2aq2VDkx0vVgS+ThS5od8hiF+BIlIE1kSz2PY3WHsyf90xuR/T5niYrFxJJEPwniXENLz/w==
X-Received: by 2002:a50:c31a:: with SMTP id a26mr103918601edb.289.1558688076259;
        Fri, 24 May 2019 01:54:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:35 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Yisheng Xie <ysxie@foxmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH 26/33] fbdev: remove FBINFO_MISC_USEREVENT around fb_blank
Date:   Fri, 24 May 2019 10:53:47 +0200
Message-Id: <20190524085354.27411-27-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
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
index d9f545f1a81b..8a67505167ae 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2386,9 +2386,8 @@ static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
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
index d6713dce9e31..25ae466ba593 100644
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

