Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B0FC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C969320815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VzX3I0qS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbfETIWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:22:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40893 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731362AbfETIWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:22:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id j12so22535558eds.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v/s+u+a3caCaHYMTdWy6ZkddtDAnAEvZ2jDDvaMGNYA=;
        b=VzX3I0qS4GrLLWfSpSSNrP7CAMGwoZGJKhcwchf7QZ7BvcXbuZZKJ5uSOyvS446dj4
         ZGaqCy84FOjRhoTTDad15AK3Q/HXp5EJIspUgGPRghZxCpoy0WCZ3D8cLngSRNv6Owtc
         WT7wxmgNirNNpJjN7KUjYDc04Q/lFSzz5jtMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v/s+u+a3caCaHYMTdWy6ZkddtDAnAEvZ2jDDvaMGNYA=;
        b=lmgyMZVge1w020dXnMxSfBm7Ou43mPjt/IpGqI+dalUwL5eZYz+2jf5PogNtdAvEWh
         GwXrqPNKy/XqZUPJELd/xT1KQyesIsN+1bveF9JUrxws5vChXsPT0Dm0BE+0Rr3KtqK4
         WOLPGd84ZeevZ7P9it4VCIT/7CJKOeuaaatKp7jgAVE97mIW7wLpq/0l0g1iRYj917lp
         8awYJmrRTiTMlGp8FEvfURj0X3IzIS1TpCaW2XRYqB4U3fnLQ7pUPIH4CpUn6iHoCC85
         P2hq1au0f4+gWmn+UyqFMiGP2HH42+wABXz7ftyBzBqbVx8MF5Qj9iPM28ya1Q7NqbD4
         o9Ww==
X-Gm-Message-State: APjAAAVPpHhwybLrWwtcJaRPFBgEvdnXb6VV+0AifikeO30ow3NeWdty
        l+vZmCwyffMNhhANoxIIyLJBEg==
X-Google-Smtp-Source: APXvYqzLhoVVwMu2GYEtxzLVHTjujPVhcPA2aHmpjPD5I+daHWOweaULw644XMo3J/NOdhuKNOJdqg==
X-Received: by 2002:a17:906:1315:: with SMTP id w21mr21608204ejb.193.1558340565855;
        Mon, 20 May 2019 01:22:45 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id t25sm3021263ejx.8.2019.05.20.01.22.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:22:45 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 20/33] fbdev/sh_mob: Remove fb notifier callback
Date:   Mon, 20 May 2019 10:22:03 +0200
Message-Id: <20190520082216.26273-21-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
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

