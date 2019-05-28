Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6829C072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7043721726
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jHDbHakQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfE1JDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:03:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38937 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfE1JDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:03:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id e24so30646785edq.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8PYij8neDId3ryticKg/a8o/KS0Lg5p8XO7y5/XF6o=;
        b=jHDbHakQeNwnznvXASvVWl7yvcYBqpw2pEJjIlODz4RNjgcrPAWF5fDWm+8CRW99mj
         +7xQ5CZDwyO//HITpeFemyBkOaJ0JKfiLJv+ZlmHcyvjUsvZpGih+aUcSqpRGHs/pn05
         cki+OyKVOY+239GGqpg6Av8ilLiYl6+XuyA2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8PYij8neDId3ryticKg/a8o/KS0Lg5p8XO7y5/XF6o=;
        b=raxsNUUjnS3qXdvaWx018sQynWzKEXBsf+AV/XonqFG06wHJP7kGA0aqo5JGOX10Vt
         UnjNl10DsPsb6N2iBtr1nkfVo+cg6hKZvP3bTpJ0Rgq1exOto8lKFOu0DpUeK42nO+78
         KJG6yfknhcpoffyVVyaJm5UqW72efyCVtE58X93hTuAhX9qmc6ry4wjaT2X5HmS3Fx0g
         zP7xBIwc8veJePVZKjXim+zzxe5J73EYY+blbdeoEnDjBB0w3pIK+WbxBmgoabNYUE8Y
         F0znp5Y18JEZiznPJRxnozn1lioN+HgJ/Zx3/QhJuK/slfqmEN3JxLalKmyQGjy54Qgb
         dxKQ==
X-Gm-Message-State: APjAAAVXgQ3Q5f/RP5ot2tenaxCgjzkBeLvje9+DJT/ZcYJl/I60k0bL
        5OINdh0Rw35JAMKdzAQ4AL6LLTiu7zw=
X-Google-Smtp-Source: APXvYqzumxJgc9HSaOSwBQskNq870ESW7zvYMn/AJyD4+7IHP8Wkq4KJBKohlJDANMT2w6DOnmCTrQ==
X-Received: by 2002:a50:8a46:: with SMTP id i64mr126933097edi.177.1559034220244;
        Tue, 28 May 2019 02:03:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x49sm4072656edm.25.2019.05.28.02.03.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 02:03:39 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 20/33] fbdev/sh_mob: Remove fb notifier callback
Date:   Tue, 28 May 2019 11:02:51 +0200
Message-Id: <20190528090304.9388-21-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Markus Elfring <elfring@users.sourceforge.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 38 --------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 1437695415c9..015a02a29d37 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -213,7 +213,6 @@ struct sh_mobile_lcdc_priv {
 	struct sh_mobile_lcdc_chan ch[2];
 	struct sh_mobile_lcdc_overlay overlays[4];
 
-	struct notifier_block notifier;
 	int started;
 	int forced_fourcc; /* 2 channel LCDC must share fourcc setting */
 };
@@ -2239,37 +2238,6 @@ static const struct dev_pm_ops sh_mobile_lcdc_dev_pm_ops = {
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
@@ -2297,8 +2265,6 @@ static int sh_mobile_lcdc_remove(struct platform_device *pdev)
 	struct sh_mobile_lcdc_priv *priv = platform_get_drvdata(pdev);
 	unsigned int i;
 
-	fb_unregister_client(&priv->notifier);
-
 	for (i = 0; i < ARRAY_SIZE(priv->overlays); i++)
 		sh_mobile_lcdc_overlay_fb_unregister(&priv->overlays[i]);
 	for (i = 0; i < ARRAY_SIZE(priv->ch); i++)
@@ -2688,10 +2654,6 @@ static int sh_mobile_lcdc_probe(struct platform_device *pdev)
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

