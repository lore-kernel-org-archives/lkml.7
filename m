Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6427CC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3343820815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZfzZMaqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbfETIWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:22:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34382 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbfETIWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:46 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so22586205eda.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gJfGxf8U6KTF1RX+ypC9LJaMGcJl9tQj1nmEL+C/k0Y=;
        b=ZfzZMaqwxU5SpCglU4wJiqW//46esqj7/dt+xRvoqOyhLTaWabjwWc1CjWicENmY8B
         HH6xiUbHib3IGW/4+kNXHy+U7xRl+HEAgG0ERBbZcyL4J9CooATaEyNH4ZRKgIJaASV0
         dwpIzTuki0yVR0zlRC3U4sV+hjHGeBf3Vqy/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gJfGxf8U6KTF1RX+ypC9LJaMGcJl9tQj1nmEL+C/k0Y=;
        b=lEqta5jLyWlAmGke+jjYDPnE3G+mxO9/aLCafKkLsft3gmWnqV71hdVnnT6uwr1U2T
         +3P6uAwK/crIYgiMBsQ1FUlbUxTosagLx4qza9/ZXKcYPBl22w7RMAj8UIVQanUMkX3u
         fwO/4+zJzriFmuLhqrGqBCyy6qvH227j93c+Zw0aiUwDGetTbo4291mseqe3uZYJLFg7
         jAVbFIEmDzn8ddl3HxmCH8GXbpQYcjBpxGTewV8szB/kK6sz2RAZ19eQlVb3WpXBcD8d
         hKIbd5exsiTflIwRlRAU4U85rCg1guI1UtL5rSrt6Zv9TyijLizF9h9lRerwEvkrbvby
         V+zw==
X-Gm-Message-State: APjAAAWUMQdcFXSV70zdNQ79REHdsfcciVEm/OBd6K5llkqYexkxcRtT
        GPoD5CnedcCLYN6LCu36N5ONXw==
X-Google-Smtp-Source: APXvYqyxJI3lRgguCg2t5GLDmn3fTghiWGf9baTfAAVB0gGJLRcg+SLwvUdHlV6M58vH86eFdcH0+w==
X-Received: by 2002:a17:906:e9c7:: with SMTP id kb7mr21611372ejb.259.1558340564829;
        Mon, 20 May 2019 01:22:44 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:44 -0700 (PDT)
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
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 19/33] fbdev: unify unlink_framebufer paths
Date:   Mon, 20 May 2019 10:22:02 +0200
Message-Id: <20190520082216.26273-20-daniel.vetter@ffwll.ch>
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

For some reasons the pm_vt_switch_unregister call was missing from the
direct unregister_framebuffer path. Fix this.

v2: fbinfo->dev is used to decided whether unlink_framebuffer has been
called already. I botched that in v1. Make this all clearer by
inlining __unlink_framebuffer.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Cc: Peter Rosin <peda@axentia.se>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/video/fbdev/core/fbmem.c | 47 ++++++++++++++------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 032506576aa0..f059b0b1a030 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1714,15 +1714,30 @@ static void unbind_console(struct fb_info *fb_info)
 	console_unlock();
 }
 
-static void __unlink_framebuffer(struct fb_info *fb_info);
-
-static void do_unregister_framebuffer(struct fb_info *fb_info)
+void unlink_framebuffer(struct fb_info *fb_info)
 {
-	unbind_console(fb_info);
+	int i;
+
+	i = fb_info->node;
+	if (WARN_ON(i < 0 || i >= FB_MAX || registered_fb[i] != fb_info))
+		return;
+
+	if (!fb_info->dev)
+		return;
+
+	device_destroy(fb_class, MKDEV(FB_MAJOR, i));
 
 	pm_vt_switch_unregister(fb_info->dev);
 
-	__unlink_framebuffer(fb_info);
+	unbind_console(fb_info);
+
+	fb_info->dev = NULL;
+}
+EXPORT_SYMBOL(unlink_framebuffer);
+
+static void do_unregister_framebuffer(struct fb_info *fb_info)
+{
+	unlink_framebuffer(fb_info);
 	if (fb_info->pixmap.addr &&
 	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
 		kfree(fb_info->pixmap.addr);
@@ -1738,28 +1753,6 @@ static void do_unregister_framebuffer(struct fb_info *fb_info)
 	put_fb_info(fb_info);
 }
 
-static void __unlink_framebuffer(struct fb_info *fb_info)
-{
-	int i;
-
-	i = fb_info->node;
-	if (WARN_ON(i < 0 || i >= FB_MAX || registered_fb[i] != fb_info))
-		return;
-
-	if (fb_info->dev) {
-		device_destroy(fb_class, MKDEV(FB_MAJOR, i));
-		fb_info->dev = NULL;
-	}
-}
-
-void unlink_framebuffer(struct fb_info *fb_info)
-{
-	__unlink_framebuffer(fb_info);
-
-	unbind_console(fb_info);
-}
-EXPORT_SYMBOL(unlink_framebuffer);
-
 /**
  * remove_conflicting_framebuffers - remove firmware-configured framebuffers
  * @a: memory range, users of which are to be removed
-- 
2.20.1

