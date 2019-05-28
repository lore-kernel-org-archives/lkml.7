Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC01C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B8E208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Q2Q/sGFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfE1JGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:06:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:47074 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfE1JDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id f37so30562767edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jemw2QjWxU+UFHjYLKdEyQ9knTBj8Nqm3v5Mrc95+O8=;
        b=Q2Q/sGFS+3ztGuIG6HjyW4WqtF83a09htVuw4GKSsgH3cHm7dGKzhjvGuCPzzPDkgL
         E1/NRgZTaeTYcHOps+FhdcT1PbSFGvlgKFkIBRaH+zrG9UMsmLLURLcCTjDwxR0xLIN3
         KwwuXSGHz0AEiTSHK9LXqpPeWcu8jfLUGcaEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jemw2QjWxU+UFHjYLKdEyQ9knTBj8Nqm3v5Mrc95+O8=;
        b=rgeU529eemuJ9TYcRgP8Lx++LMZ3UcXe9qCzoK3SVQ5z3fwtAaahVvEsuZAsEWOppE
         vT6YMYDLN7k6RQq74LLkTDYtefjjoGcxHhttfxP4SoTq3vaPfEvZdQccSReTHD2EjVPV
         8w5DKZlpXxyImzV8fCHhVovjRxV6r0L9Pq/sRklJBwZoWi5LLgbMW0Oq1J6LKh4rtHQt
         UFrkuymJqDgqyXtgdN/lfItYu1F9zPA0mZF/XoxjH+pEbUi2uUYHpMlmTiAcr+ZqZ+gF
         mIR6NwBAEtkoRZIKSORB+/W47oGNXjFdWAIVmaCdp5/oJE1FWuYx8nVbpCWlTD1rKU5A
         AX3A==
X-Gm-Message-State: APjAAAXv1dOMYX2gAPSocIqWT/WJcaypExMViJ3XmIQAU9sV9Dr/JDYo
        5zUqZqrZi4HSwNt4gJSbKSQCM2ZbFVQ=
X-Google-Smtp-Source: APXvYqzRmMQx8hio/CkC+ykYBbXTDds6GiLnz4oTtSmCC0xHsSsFWfJG1JCAR/ZOcV6FU9c5NjgHVQ==
X-Received: by 2002:a50:ad2b:: with SMTP id y40mr126347451edc.237.1559034218893;
        Tue, 28 May 2019 02:03:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:38 -0700 (PDT)
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
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 19/33] fbdev: unify unlink_framebuffer paths
Date:   Tue, 28 May 2019 11:02:50 +0200
Message-Id: <20190528090304.9388-20-daniel.vetter@ffwll.ch>
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

For some reasons the pm_vt_switch_unregister call was missing from the
direct unregister_framebuffer path. Fix this.

v2: fbinfo->dev is used to decided whether unlink_framebuffer has been
called already. I botched that in v1. Make this all clearer by
inlining __unlink_framebuffer.

v3: Fix typoe in subject (Maarten).

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
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

