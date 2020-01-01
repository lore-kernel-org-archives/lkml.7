Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917EEC2D0DE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 20:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6F9208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 20:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="hsxj+yEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgAAUsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 15:48:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34912 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgAAUsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 15:48:08 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so17077306plt.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 12:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XbMrezaMD0p4i3SGBGMVhsDuOIGR0bDHjQFGAvfTghk=;
        b=hsxj+yEFbN25j8L+Ydo66FZwz/eE6FmsuE4JZo+LvmE5pQ8fQosViIyOHOBi8CVVhO
         J6PmU80Y9MwsX7+e3BYqKc7PGfwmhiDToIO5DX35mP9M+TQDCubpt9qKAs/4MNeweXoZ
         Bv6xRTj2HxpouULBCdd+x1lMSF0JipscIeEeIFUdkUY6a1x9uZWOo9dPD3TuGEY5pze+
         J78pfzvMFsGfwns6f7LzQDsw86xyvDuWohvx9BS/cNuNurpOgd3Zt6UHO+tsQAoQnLto
         r4fFJ9duEn5NufTJ+YN/GWbC8WjCGZWwU54J/UkwlCIN4bgJ4qHr16atUn5+Ve0zUfy1
         Oziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XbMrezaMD0p4i3SGBGMVhsDuOIGR0bDHjQFGAvfTghk=;
        b=Veq9CbliawIYQij2TRw3yrROTLAGn+ItuZwhCPDj6f5vW7ddmtBi9sdTzAQsEXmaf8
         s83xnjBS/ZW2eDKRf6phVOEiZrlE0Z02UJGMR2s/uKyGUp1dA7XP4AEE8y/d5xF+5FMq
         I0Hax4ikqi74GFAbwmlpuxd33wGbouY4Nv0YsXuPJrdyjintww1xtn1IBbD2r91K7xo3
         Zc9vnEL0erfBaqIG0STaJdRMV45CTecrhf1XQJanbOrPWqpPnHBJ46WWl4gf16j85n06
         oo3HZk/yIV7KEW56w72KnTmGdKPcY+p2WotP+KN6LRnKO39O+3aRrrfIj4+RI1rwKru4
         S53Q==
X-Gm-Message-State: APjAAAWGB1EGJet2g/Gq8tcSv7FqM18qL3mUVFlDeRzHSz/X5CVd5Og/
        TuJfWoq2uaFy/8lEA4d6d0mukA==
X-Google-Smtp-Source: APXvYqyklN6NYwHRBsqIUREWmoa0yWoQfE/+harC1DHagj85KGzfIxcsQ2V6jYhzLlxNgQ/ergDlug==
X-Received: by 2002:a17:902:74c5:: with SMTP id f5mr78136579plt.229.1577911688023;
        Wed, 01 Jan 2020 12:48:08 -0800 (PST)
Received: from virtualhost-PowerEdge-R810.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id z22sm53774752pfr.83.2020.01.01.12.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 12:48:07 -0800 (PST)
From:   roman.stratiienko@globallogic.com
To:     mripard@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@siol.net
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [PATCH v3 1/2] drm/sun4i: Add mode_set callback to the engine
Date:   Wed,  1 Jan 2020 22:47:49 +0200
Message-Id: <20200101204750.50541-1-roman.stratiienko@globallogic.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

Create callback to update engine's registers on mode change.

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
v2:
- Split commit in 2 parts.
- Add description to mode_set callback
- Dropped 1 line from sun4i_crtc_mode_set_nofb()
- Add struct drm_display_mode declaration (fix build warning)

v3:
- Pick reviewed-by line
- Add missing 'and' word to the mode_set callback description.
---
 drivers/gpu/drm/sun4i/sun4i_crtc.c   |  3 +++
 drivers/gpu/drm/sun4i/sunxi_engine.h | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index 3a153648b369..f9c627d601c3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -141,6 +141,9 @@ static void sun4i_crtc_mode_set_nofb(struct drm_crtc *crtc)
 	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
 
 	sun4i_tcon_mode_set(scrtc->tcon, encoder, mode);
+
+	if (scrtc->engine->ops->mode_set)
+		scrtc->engine->ops->mode_set(scrtc->engine, mode);
 }
 
 static const struct drm_crtc_helper_funcs sun4i_crtc_helper_funcs = {
diff --git a/drivers/gpu/drm/sun4i/sunxi_engine.h b/drivers/gpu/drm/sun4i/sunxi_engine.h
index 548710a936d5..7faa844646ff 100644
--- a/drivers/gpu/drm/sun4i/sunxi_engine.h
+++ b/drivers/gpu/drm/sun4i/sunxi_engine.h
@@ -9,6 +9,7 @@
 struct drm_plane;
 struct drm_device;
 struct drm_crtc_state;
+struct drm_display_mode;
 
 struct sunxi_engine;
 
@@ -108,6 +109,17 @@ struct sunxi_engine_ops {
 	 * This function is optional.
 	 */
 	void (*vblank_quirk)(struct sunxi_engine *engine);
+
+	/**
+	 * @mode_set:
+	 *
+	 * This callback is used to update engine registers that
+	 * responsible for display frame size and other mode attributes.
+	 *
+	 * This function is optional.
+	 */
+	void (*mode_set)(struct sunxi_engine *engine,
+			 struct drm_display_mode *mode);
 };
 
 /**
-- 
2.17.1

