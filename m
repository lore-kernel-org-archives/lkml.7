Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC618C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35562184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="A810gJ8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390336AbfEXIzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:55:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41667 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390046AbfEXIyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id m4so13313760edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P4e/xA+I/fhaekwevrCcRa/WCV1s4I3VGahknPkyNJ8=;
        b=A810gJ8GWO9JLhgelYpMe4TFBMIXycWgLfaVkfbkrCaTrhQyLYDXyGKqEYi8kAoorq
         cem9TmtMm1kAJpudc2v48wVUDX0URGUmSrceRicZ6S5+lhwS3NmeqM6dW/CWgqaYzVl+
         rrdaVd8vNUpg0Dm2LN9ltsyau6kQbSdhChOFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P4e/xA+I/fhaekwevrCcRa/WCV1s4I3VGahknPkyNJ8=;
        b=AzsCTrySe3mfod9Ucfmsj2PnfE9HX0FVu4BVqwf6sDQn04aC2KEiANnxzKxCI29KRr
         CLMk2dvfrwIrZZiYNsytjU1Re4i2Nd+mbdYdyMC8mu06AvGKEXHAyMsinhd1751JSOoj
         eoXDG2g927RCS7pkspvT5fucHGXinSF+JAKTZ5WVdMGuuRuRvipaOvR1SNZ5gnI6Osx0
         u/ylif4nMPlywfdXNvjF6mDb4wtG+f9X6ciq3/36FZcpc7qshVqSw7SZh9UxKqCbHGJs
         4pv/oBKeEscSQ9F4txHBwnbrJJs9HjPjLSkZSIJBaZkQhZ3sP70VqIse4+nblx78Wf2m
         iYlw==
X-Gm-Message-State: APjAAAXbmpb6qi2TKwhjdjJai9/6RVIQ7bDw22/Cnn/vL9c5nujDjkkK
        /Ccf6fqFp8omL2ohvM9/fV+o5v4Snlk=
X-Google-Smtp-Source: APXvYqztLw67egkehMcTC0D7aOOl7kCrsaIONdyJQbJTsWM2Ee6cU0j3VtnNtoIBnwoKKiPK9mYc7Q==
X-Received: by 2002:a17:906:118b:: with SMTP id n11mr36452581eja.291.1558688074794;
        Fri, 24 May 2019 01:54:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:34 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Hans de Goede <hdegoede@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH 25/33] fbmem: pull fbcon_fb_blanked out of fb_blank
Date:   Fri, 24 May 2019 10:53:46 +0200
Message-Id: <20190524085354.27411-26-daniel.vetter@ffwll.ch>
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

There's a callchain of:

fbcon_fb_blaned -> do_(un)blank_screen -> consw->con_blank
	-> fbcon_blank -> fb_blank

Things don't go horribly wrong because the BKL console_lock safes the
day, but that's about it. And the seeming recursion is broken in 2
ways:
- Starting from the fbdev ioctl we set FBINFO_MISC_USEREVENT, which
  tells the fbcon_blank code to not call fb_blank. This was required
  to not deadlock when recursing on the fb_notifier_chain mutex.
- Starting from the con_blank hook we're getting saved by the
  console_blanked checks in do_blank/unblank_screen. Or at least
  that's my theory.

Anyway, recursion isn't awesome, so let's stop it. Breaking the
recursion avoids the need to be in the FBINFO_MISC_USEREVENT critical
section, so lets move it out of that too.

The astute reader will notice that fb_blank seems to require
lock_fb_info(), which the fbcon code seems to ignore. I have no idea
how to fix that problem, so let's keep ignoring it.

v2: I forgot the sysfs blanking code.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Rob Clark <robdclark@gmail.com>
---
 drivers/video/fbdev/core/fbmem.c   | 4 +++-
 drivers/video/fbdev/core/fbsysfs.c | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 9366fbe99a58..d6713dce9e31 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1068,7 +1068,6 @@ fb_blank(struct fb_info *info, int blank)
 	event.data = &blank;
 
 	early_ret = fb_notifier_call_chain(FB_EARLY_EVENT_BLANK, &event);
-	fbcon_fb_blanked(info, blank);
 
 	if (info->fbops->fb_blank)
  		ret = info->fbops->fb_blank(blank, info);
@@ -1198,6 +1197,9 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		info->flags |= FBINFO_MISC_USEREVENT;
 		ret = fb_blank(info, arg);
 		info->flags &= ~FBINFO_MISC_USEREVENT;
+
+		/* might again call into fb_blank */
+		fbcon_fb_blanked(info, arg);
 		unlock_fb_info(info);
 		console_unlock();
 		break;
diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 5f329278e55f..252d4f52d2a5 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/fb.h>
+#include <linux/fbcon.h>
 #include <linux/console.h>
 #include <linux/module.h>
 
@@ -305,12 +306,15 @@ static ssize_t store_blank(struct device *device,
 {
 	struct fb_info *fb_info = dev_get_drvdata(device);
 	char *last = NULL;
-	int err;
+	int err, arg;
 
+	arg = simple_strtoul(buf, &last, 0);
 	console_lock();
 	fb_info->flags |= FBINFO_MISC_USEREVENT;
-	err = fb_blank(fb_info, simple_strtoul(buf, &last, 0));
+	err = fb_blank(fb_info, arg);
 	fb_info->flags &= ~FBINFO_MISC_USEREVENT;
+	/* might again call into fb_blank */
+	fbcon_fb_blanked(fb_info, arg);
 	console_unlock();
 	if (err < 0)
 		return err;
-- 
2.20.1

