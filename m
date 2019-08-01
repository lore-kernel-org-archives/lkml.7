Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A26C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F832087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 11:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cMBE9seZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfHALS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:18:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41091 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730593AbfHALS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:18:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so69935496wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 04:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LeVi3M3rABqtJE3t2RPfqLsPOq3zZyV/m8kt+qnj1zQ=;
        b=cMBE9seZV2rlWrwD2KSNK2iWozGJLstP/lvQ+YuIn90t6OWhU12fBOEveO6RbxX9aL
         RMm9jrco/0XpmcQmpbqsEjqHIW7hrZYavnobjlr+r0u81MoRD7JcNL0o7RT40C4uCFr3
         SpUhON10c6PLS13qVPaUoTIPpxcc/CrnNpASxtihabzo0fcrkp4FrISwWzBhlVLYJO6S
         SDT9V5OeGeyKMNHBgviitf5enbpmM51k/73Rfbz8Rd734Uq8HnkMA/ZncJ29p4bXqhts
         Xog6k+u/97wt5HmBnP1cmlRrsWLDbKCq3Oh3xcKOcssc0iK0VHZwHS0KW4HZb3IeMt33
         TP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LeVi3M3rABqtJE3t2RPfqLsPOq3zZyV/m8kt+qnj1zQ=;
        b=pTsLnLvyLpVLJDjDXpKfHVrFJZJQn5Rv6mOxNIwwsFT7fNkN3GJ50gCTPlN0akcnn5
         3SxnKxN/U0eZ4IEgxos/2KzFOsVUKtO9G19U2RFcK2biEoFsQp5abyOVXBdcWOakVZH5
         LXdDvsPNRNdv8qwN015Zx01l7qu7GsM+VVs6TAr7T2WrCwvZNtbZyZ66IfYdVtdDDRJ/
         r40lv6Kij6fVM9gqwqoRKGezsblGbq6MNHGMsNZyu/4cVldRURrX7VPkACsKDWhZgAS/
         gf9haPLdQio91YdlPX+hirXT7twmyE73sGdUnrd4qeLgKqlV03NNtEgO4BnK7c4WqDAX
         oRfA==
X-Gm-Message-State: APjAAAUJCQ0Nf/lAjovsNBk0B/MHBmLZHLO5wXs5M67PpULtJ8zXR8QY
        O2vlE2Yzn9O1iA0wCyQJPPc=
X-Google-Smtp-Source: APXvYqzkBr+Wu2cLABxcKSHKUUQ0ibXMKozvJEjKAQG4ccxFTxDQ1e/E7TFcA1iSTj9mjHfYdmRdag==
X-Received: by 2002:adf:cd81:: with SMTP id q1mr138879876wrj.16.1564658336375;
        Thu, 01 Aug 2019 04:18:56 -0700 (PDT)
Received: from villeb-dev (mail.bytesnap.co.uk. [94.198.185.106])
        by smtp.gmail.com with ESMTPSA id v29sm138629wrv.74.2019.08.01.04.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Aug 2019 04:18:55 -0700 (PDT)
From:   Ville Baillie <vmbaillie@googlemail.com>
X-Google-Original-From: Ville Baillie <villeb@bytesnap.co.uk>
Date:   Thu, 1 Aug 2019 11:18:53 +0000
To:     marex@denx.de, stefan@agner.ch, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mxsfb: allow attachment of display bridges
Message-ID: <20190801111853.GA24574@villeb-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 20 ++++++++++++++++----
 drivers/gpu/drm/mxsfb/mxsfb_drv.h |  1 +
 drivers/gpu/drm/mxsfb/mxsfb_out.c | 14 +++++++++++---
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 6fafc90da4ec..c19a7b7aa3a6 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -229,10 +229,22 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
 		goto err_vblank;
 	}
 
-	ret = drm_panel_attach(mxsfb->panel, &mxsfb->connector);
-	if (ret) {
-		dev_err(drm->dev, "Cannot connect panel\n");
-		goto err_vblank;
+	if (mxsfb->panel) {
+		ret = drm_panel_attach(mxsfb->panel, &mxsfb->connector);
+		if (ret) {
+			dev_err(drm->dev, "Cannot connect panel\n");
+			goto err_vblank;
+		}
+	} else if (mxsfb->bridge) {
+		ret = drm_bridge_attach(&mxsfb->pipe.encoder, mxsfb->bridge,
+				NULL);
+		if (ret) {
+			dev_err(drm->dev, "Cannot connect bridge\n");
+			goto err_vblank;
+		}
+	} else {
+		dev_err(drm->dev, "No panel or bridge\n");
+		return -EINVAL;
 	}
 
 	drm->mode_config.min_width	= MXSFB_MIN_XRES;
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
index d975300dca05..436fe4bbb47a 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
@@ -29,6 +29,7 @@ struct mxsfb_drm_private {
 	struct drm_simple_display_pipe	pipe;
 	struct drm_connector		connector;
 	struct drm_panel		*panel;
+	struct drm_bridge		*bridge;
 };
 
 int mxsfb_setup_crtc(struct drm_device *dev);
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_out.c b/drivers/gpu/drm/mxsfb/mxsfb_out.c
index 91e76f9cead6..77e03eb0fca6 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_out.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_out.c
@@ -78,9 +78,11 @@ int mxsfb_create_output(struct drm_device *drm)
 {
 	struct mxsfb_drm_private *mxsfb = drm->dev_private;
 	struct drm_panel *panel;
+	struct drm_bridge *bridge;
 	int ret;
 
-	ret = drm_of_find_panel_or_bridge(drm->dev->of_node, 0, 0, &panel, NULL);
+	ret = drm_of_find_panel_or_bridge(drm->dev->of_node, 0, 0, &panel,
+			&bridge);
 	if (ret)
 		return ret;
 
@@ -91,8 +93,14 @@ int mxsfb_create_output(struct drm_device *drm)
 	ret = drm_connector_init(drm, &mxsfb->connector,
 				 &mxsfb_panel_connector_funcs,
 				 DRM_MODE_CONNECTOR_Unknown);
-	if (!ret)
-		mxsfb->panel = panel;
+	if (!ret) {
+		if (panel)
+			mxsfb->panel = panel;
+		else if (bridge)
+			mxsfb->bridge = bridge;
+		else
+			return -EINVAL;
+	}
 
 	return ret;
 }
-- 
2.17.1

