Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D46C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E35E21855
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bRkx/z0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389636AbfEXIzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:55:46 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36633 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390073AbfEXIy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:29 -0400
Received: by mail-ed1-f65.google.com with SMTP id a8so13342506edx.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cm6Zk7GljL6jePfAIeGXLYQwMTWG8I+jBNPdQ08bAaA=;
        b=bRkx/z0EyYVtpBt/oj0ErHn1XAliHb9LCtrj5M5meP50p063vhmea6sd9/mf7IQiZz
         imaHmNxuAIW7JcxB2TRz7+ouZg/Qgzkry1168vXhgHsvyi2urrKimUEQAEQoTLV4Ney/
         u9++WAq/GqqyoMUXo87bavXa0VV8rwPCtdMpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cm6Zk7GljL6jePfAIeGXLYQwMTWG8I+jBNPdQ08bAaA=;
        b=Zhp6BhFvzfEMZtSJROyA4fMRabP4NnnyhNlwA9+/d+kf+ZZjAmp68r/wWH5EAuYhvr
         7Ymz4AuH42tZxhemHunINT/e+w1w6u/ylUN7V5u8MxQUCV6p4ZNn0Yt3zq2sQ0roYu0m
         NZMVs+T1IyzKpq+G1UhHplh1AmNmqz/5MZnkJ/POoVM1Qz8k5KHb/uiRf6NF6jorY/sn
         LwYu8hiGAB4X3D87ix8r2HG2lUkWmdTEbn7rSo38Kz3qPH9j7Kmqv5WuAwStAIeccnsG
         nAETOcQ9GrAGJf387hLW/ottzVXDjxztZn0Ufm9pLvPuF1o7f5wsPO6+N2IW3NdGBzHo
         5RXA==
X-Gm-Message-State: APjAAAVGqNqJWCYLR+ZyoD+363MKv0N7w1efmxpw3jYXhz/j7Twgppp4
        zKO6gfaq8lMXUEAVe6QbzzFUfcIoP84=
X-Google-Smtp-Source: APXvYqyVkgMZkhO9exZuZqDajdXFWZm65cyatM+vsxYx3gghMw1oBX7yhuzBrT0RXlVCw+gR5jtxJQ==
X-Received: by 2002:a17:906:4442:: with SMTP id i2mr12809671ejp.178.1558688066918;
        Fri, 24 May 2019 01:54:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:26 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Peter Rosin <peda@axentia.se>,
        Hans de Goede <hdegoede@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 19/33] fbdev: unify unlink_framebuffer paths
Date:   Fri, 24 May 2019 10:53:40 +0200
Message-Id: <20190524085354.27411-20-daniel.vetter@ffwll.ch>
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

For some reasons the pm_vt_switch_unregister call was missing from the
direct unregister_framebuffer path. Fix this.

v2: fbinfo->dev is used to decided whether unlink_framebuffer has been
called already. I botched that in v1. Make this all clearer by
inlining __unlink_framebuffer.

v3: Fix typoe in subject (Maarten).

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
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
index f3bcad30d3ba..bee45e9405b8 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1722,15 +1722,30 @@ static void unbind_console(struct fb_info *fb_info)
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
@@ -1753,28 +1768,6 @@ static void do_unregister_framebuffer(struct fb_info *fb_info)
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

