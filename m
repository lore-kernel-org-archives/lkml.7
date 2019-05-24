Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482C8C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAA9217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="N2a0XA0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389576AbfEXIzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:55:41 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45574 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390081AbfEXIya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id g57so13292037edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 01:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P7tIrgwU7eV/tnp6z+MGMTB4sNqCdN7ed69YxIOeB/8=;
        b=N2a0XA0p9Nzm5STKQj70ji0mhzkZ/xfxYB2PMpEu/BQLvb4CnU9DbBWMxTs8SwbL0b
         Ct9CB35ETqZsHmnRsddzqoZV0c7Xtr1YtcIieAN9fX/X0JrtOD7aSyaXAZWqDhu+/GyA
         9UtwtG2Q41IP1MqfY2yvDKhJ+880HBSlYdMeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P7tIrgwU7eV/tnp6z+MGMTB4sNqCdN7ed69YxIOeB/8=;
        b=qoLJI5TBV6BTKcV8UKQDA/vwubgXnhAwy/hkmhLbYNFg46q7Za0tmYUtEm20AJfcRa
         mzXAZki9LuYa+DJcn3lJOAXTITgPOOx9wopfc6Y02gJMLNpnyw4oURAas1PPdkYBHwnD
         STxoR+ZuyGLh3bHeXNiiQL3bA3ppnGeQ61AiQ2smAD2d35TPHHO+FeRFkwoIU/S0OXUS
         OCNruksxUwhm6zpDpJlzrxPxuUjwALanqwEzIekfKSn4MLS9NKZrj+2/QW5w/nVs208X
         lbL98iH6qYqPTI9bMcoAoRFTLHBACdseU/Px7+4vwoEWLgLA3cz8emgUmRk0up2jir0n
         0JGw==
X-Gm-Message-State: APjAAAWnVFtSj6e6y4Jcu0slxK41FXIRpaKqUpECopv9vwfc0z4ju5Ct
        BZqCxNfYkcNfXCnl7AqQ46E0RogPjEo=
X-Google-Smtp-Source: APXvYqxMDc+MB2GzcxdSQS+P6KkuwPYcQbSOHZxvH6/HgzRjYRaM+LEjDMKiT80Ym/ek6JxYO7XvZg==
X-Received: by 2002:a17:906:f194:: with SMTP id gs20mr47317746ejb.177.1558688068453;
        Fri, 24 May 2019 01:54:28 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 96sm567082edq.68.2019.05.24.01.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 01:54:27 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 20/33] fbdev/sh_mob: Remove fb notifier callback
Date:   Fri, 24 May 2019 10:53:41 +0200
Message-Id: <20190524085354.27411-21-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
References: <20190524085354.27411-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to be entirely defunct:

- The FB_EVEN_SUSPEND/RESUME events are only sent out by
  fb_set_suspend. Which is supposed to be called by drivers in their
  suspend/resume hooks, and not itself call into drivers. Luckily
  sh_mob doesn't call fb_set_suspend, so this seems to do nothing
  useful.

- The notify hook calls sh_mobile_fb_reconfig() which in turn can
  call into the fb notifier. Or attempt too, since that would
  deadlock.

So looks like leftover hacks from when this was originally introduced
in

commit 6011bdeaa6089d49c02de69f05980da7bad314ab
Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date:   Wed Jul 21 10:13:21 2010 +0000

    fbdev: sh-mobile: HDMI support for SH-Mobile SoCs

So let's just remove it.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Markus Elfring <elfring@users.sourceforge.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 38 --------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index c5924f5e98c6..0d7a044852d7 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -213,7 +213,6 @@ struct sh_mobile_lcdc_priv {
 	struct sh_mobile_lcdc_chan ch[2];
 	struct sh_mobile_lcdc_overlay overlays[4];
 
-	struct notifier_block notifier;
 	int started;
 	int forced_fourcc; /* 2 channel LCDC must share fourcc setting */
 };
@@ -2258,37 +2257,6 @@ static const struct dev_pm_ops sh_mobile_lcdc_dev_pm_ops = {
  * Framebuffer notifier
  */
 
-/* locking: called with info->lock held */
-static int sh_mobile_lcdc_notify(struct notifier_block *nb,
-				 unsigned long action, void *data)
-{
-	struct fb_event *event = data;
-	struct fb_info *info = event->info;
-	struct sh_mobile_lcdc_chan *ch = info->par;
-
-	if (&ch->lcdc->notifier != nb)
-		return NOTIFY_DONE;
-
-	dev_dbg(info->dev, "%s(): action = %lu, data = %p\n",
-		__func__, action, event->data);
-
-	switch(action) {
-	case FB_EVENT_SUSPEND:
-		sh_mobile_lcdc_display_off(ch);
-		sh_mobile_lcdc_stop(ch->lcdc);
-		break;
-	case FB_EVENT_RESUME:
-		mutex_lock(&ch->open_lock);
-		sh_mobile_fb_reconfig(info);
-		mutex_unlock(&ch->open_lock);
-
-		sh_mobile_lcdc_display_on(ch);
-		sh_mobile_lcdc_start(ch->lcdc);
-	}
-
-	return NOTIFY_OK;
-}
-
 /* -----------------------------------------------------------------------------
  * Probe/remove and driver init/exit
  */
@@ -2316,8 +2284,6 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
 	struct sh_mobile_lcdc_priv *priv = platform_get_drvdata(pdev);
 	unsigned int i;
 
-	fb_unregister_client(&priv->notifier);
-
 	for (i = 0; i < ARRAY_SIZE(priv->overlays); i++)
 		sh_mobile_lcdc_overlay_fb_unregister(&priv->overlays[i]);
 	for (i = 0; i < ARRAY_SIZE(priv->ch); i++)
@@ -2707,10 +2673,6 @@ static int sh_mobile_lcdc_probe(struct platform_device *pdev)
 			goto err1;
 	}
 
-	/* Failure ignored */
-	priv->notifier.notifier_call = sh_mobile_lcdc_notify;
-	fb_register_client(&priv->notifier);
-
 	return 0;
 err1:
 	sh_mobile_lcdc_remove(pdev);
-- 
2.20.1

