Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E2FC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD5B208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ot/iReF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfE1JDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:03:52 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34622 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfE1JDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:50 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so30688153eda.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DzlOvTHyKR8X8+iBqAU0JNunUmi7G22ipv63hi4doZE=;
        b=Ot/iReF0+zGL2ux5khVmaDK70Uagz7In4B2rbxJXjuNP8F6SbXFIAjSqOfAdZolZb2
         Y/CAyNTVeJp3rkNo2d/NWhBV91roYEwu0xRWSDB8Tr7Uh5l7hmQ2p8f0CK2uPx6NBg4H
         dEd9pUT5bwd3PM1mf54qS2N1sUJMXiZ1VAf6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DzlOvTHyKR8X8+iBqAU0JNunUmi7G22ipv63hi4doZE=;
        b=NXvsvoJIPg4Md+tCLJ3sbwA1N4c9aEzI+lZyPdXXxgledHL9iIQOZ9yqmdY9pgR5ti
         gAreQppwnFvVc9AyMTNfKZyvuS1j1hsvBgQfck4wTBeMOt1k5e15hPGI+6atn3D63G16
         l5jxNsvp1qOgnYrc+aeYXHdPfw0H4G8dIyngn4gFPmmGwrC+tN7nR3JgJHbmd+IaaygB
         IUThPJtvsnq/SkhjLHrzfQTTqjKaO/DgD3Ydax3lDLZLTjCwNzLnHDAI4fLQelYc0WlB
         5bLBNjI9rJYgqdnVTjlYkm2QEuP9l3rDvLJU5UOvEClkLdxBgj2tTfDKOo25oeOiWRDH
         jkSQ==
X-Gm-Message-State: APjAAAXrs2qbce/Q5vAkTnLLgXHsr3TVwjdSmzNEyzU9gSEoo8WmtdeE
        EOW4pFwuzwjfEGy91xNIsRdVYuVtYZk=
X-Google-Smtp-Source: APXvYqxR9rzUeVIfHotbm5CmrJdDR2kkb2EUOxTpdDMxUJEdxcWzu6TDjgW9oBowUrDB8sqrB+FIDw==
X-Received: by 2002:a50:a5f1:: with SMTP id b46mr126780110edc.167.1559034227646;
        Tue, 28 May 2019 02:03:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:47 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Hans de Goede <hdegoede@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Rob Clark <robdclark@gmail.com>
Subject: [PATCH 25/33] fbmem: pull fbcon_fb_blanked out of fb_blank
Date:   Tue, 28 May 2019 11:02:56 +0200
Message-Id: <20190528090304.9388-26-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a callchain of:

fbcon_fb_blanked -> do_(un)blank_screen -> consw->con_blank
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

v3: Fix typo in callchain in the commmit message (Sam).

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
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

