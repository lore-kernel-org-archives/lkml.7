Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1E6C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 16:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2DA207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 16:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="WW0qXOjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfL2Q2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 11:28:42 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46962 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfL2Q2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 11:28:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id m26so28776571ljc.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 08:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n90E4FPbMEYNKi4XaN29BLl296r+dCfTfT/Y1plIRok=;
        b=WW0qXOjPWCCJFurZE+x1rZ4Omj+HQ93co+Hqeg7TS5QvnDaDmimiWR7WWaHTd475hq
         cj3uAGa8nL/uWp+f1KjSTbieIZSLGWYvYX0/WmVeCRoGoZWQyo4scDBAaV8w5c5IuV1c
         qQbZqQBE6pDQtPM74btaJmaWhJGo/N2jBY1Gw+qYuPL+xMSe9a2vJLszaVcbn9Tb+Vfl
         6nwG5Y6JbfZPQJFYcrdkZq9Pn3CwMq2E8LDeBMH0i+0IYZmn/OycZcxkuhyp+ioFWiIL
         cj0Tt0O1JAGbrnHYH+vqG5fEkDl+TpKoBjOKVipHxuRwBmO7mQZM3RCDFHfPAW4QNU1p
         fYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n90E4FPbMEYNKi4XaN29BLl296r+dCfTfT/Y1plIRok=;
        b=MNo9ZcrqQ8deJSfZvMvbpkMN+c0oAHumRovDeV40rtPOGOguT36yykAy6c9wynb3ga
         VCBCFs3GgToMhiptwpr0qbMFLXgotANQKXa6LJuTo5DePOUc5bZpUjsoifBgp1KK+vdo
         yUijz9TyhW3hNMq94OLiRtCMsrQOy2g2b1ZJMhLPv253q/7uWYTC3TgoBSxY83D3Toq3
         HrHE0nnRBFMkMLyDICBrLnS3NE2x1hRlBr1Yp/jPdcfub1AupXRKWsh98WkwwfX5V0yU
         Pg9WGWmjVENd+sWNOKG/4nAcqxCxaZsGw2S53U1IcXE40R7mEKLN/oZGIM3+HDLIaTtR
         9ZnQ==
X-Gm-Message-State: APjAAAXVi33jsoN95pxiJwFEu+sCG2eYRpML8HGYX8bPWQnT8dFy3anh
        fAOOa5NtHczOYzujWLpNuchgZg==
X-Google-Smtp-Source: APXvYqxbn4rVVr9RPZY6bZ86mkyDYpAjqj5/2yMqaK0Sq0geQzws1uE/LI+k0Yoh1YydtyDzAJDWew==
X-Received: by 2002:a2e:94d5:: with SMTP id r21mr36217156ljh.33.1577636919083;
        Sun, 29 Dec 2019 08:28:39 -0800 (PST)
Received: from virtualhost-PowerEdge-R810.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id u13sm17284858lfq.19.2019.12.29.08.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 08:28:38 -0800 (PST)
From:   roman.stratiienko@globallogic.com
To:     mripard@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@siol.net
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [PATCH v2 2/4] drm/sun4i: Add mode_set callback to the engine
Date:   Sun, 29 Dec 2019 18:28:26 +0200
Message-Id: <20191229162828.3326-2-roman.stratiienko@globallogic.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191229162828.3326-1-roman.stratiienko@globallogic.com>
References: <20191229162828.3326-1-roman.stratiienko@globallogic.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

Create callback to update engine's registers on mode change.

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
v2:
- Split commit in 2 parts.
- Add description to mode_set callback
- Dropped 1 line from sun4i_crtc_mode_set_nofb()
- Add struct drm_display_mode declaration (fix build warning)
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
index 548710a936d5..44102783ee3c 100644
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
+	 * responsible for display frame size other mode attributes.
+	 *
+	 * This function is optional.
+	 */
+	void (*mode_set)(struct sunxi_engine *engine,
+			 struct drm_display_mode *mode);
 };
 
 /**
-- 
2.17.1

