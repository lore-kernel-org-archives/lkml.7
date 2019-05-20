Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDCAC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399D120863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BiYU87eY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbfETIX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:23:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45692 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731396AbfETIWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id g57so22487884edc.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CumxJ2NtVSEP5RNMzgMskkfGKnWkqYH9OWapQsg3Ykk=;
        b=BiYU87eY751NVue2WirSevA+JtWzXlDUBKxpdvOCuE9SFAZutDfx84Zsh7QinEw1+x
         /YP4ChXJX2Hz4luhn5VXlZYJ8A5mSJGredVJzSCu87xqgKtLxkmTzP1VmxfyzsBTNq8N
         ff45HA03UxQVhL9TWuRtiTxSXr2xq30e/D90Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CumxJ2NtVSEP5RNMzgMskkfGKnWkqYH9OWapQsg3Ykk=;
        b=gxqvZJY8QvBZmhSZZMu2ndCEn/WpmeFE55TQNsm63iBPGGWrrHuhW4XgS8HJB7IjfL
         T3RHFz1QXkVR8U5W+AW+62iTqoWxtO3pkbfzlR1O6zjX5N66Ux3sK0hbemhu/J+SHMtt
         wYY0OCvt+e/qm5nPcXvYlYQj1qKUbIId23wgdfAixUWPYi28TxulLkQJgelNjEhlp7Ul
         pNw7lP+2bBzqWAZYk7yzWQs2a5J4ZBw9FP7NMr0kjXv3QwH2Rw1Y9u4U2RmtPZ7AzAYU
         QRtSkMcrmsU7F/bBptq0JgUvzDKAlWLXLtq4zgCd+bM3Si15ZszD3ieE8kXwlLqVkkXs
         U25w==
X-Gm-Message-State: APjAAAUKnO0C5xPbEIH/EmvbJNFIEMpNJv6H/rPNANTPYKmTF4yEJO4r
        JG5WJg2VjQHaJXsPeeuJgHWR8Q==
X-Google-Smtp-Source: APXvYqzKocCCpdIn3BgvIXkZbMH0Ck4pkHA663Xdj8pJGjwyoQ9kIknubmApc8RiuGcyohuJzMWALQ==
X-Received: by 2002:a17:906:af57:: with SMTP id ly23mr26150862ejb.98.1558340572842;
        Mon, 20 May 2019 01:22:52 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:52 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Hans de Goede <hdegoede@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH 26/33] fbmem: pull fbcon_fb_blanked out of fb_blank
Date:   Mon, 20 May 2019 10:22:09 +0200
Message-Id: <20190520082216.26273-27-daniel.vetter@ffwll.ch>
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
index 9932130bf728..7f95c7e80155 100644
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

