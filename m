Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5441C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 17:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AE720409
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 17:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HSeJVcOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfLHRTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 12:19:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32830 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfLHRTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 12:19:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id y23so13645501wma.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 09:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Af0AIrF2pn2WiljuwZLbgsnTz6mwhPcm7wLICRG7aXU=;
        b=HSeJVcOunCaBhrbYJRxC+JJuLUSzSb8dl6z/zdArFxVXJJsloVOq8463hSurjc+3TP
         wjIn7/G6dNRHl5p/UKKibhYd1Ua7uLmpkb/c0umZcPjJ9IRBF8eNRlRSByt0FpLCACF3
         sCjMP0xkROPJikNqBxmC5M945CXBFcQnF/FJ9N7/Dh3vDXMyYfGLRr9lZ8E1M6zW3aef
         Ril7fpN8dRm/tVbhlGd5n73y61PGYgG3FWsJ6eqJgCJasaCqv9e6AaTzmsFfBvKUh+vD
         DF617jh3WLGIzM82GuhNLbFmAtEgEHlXfpkYujDD7aKXPE99Bfbhnd/qvbFikkFPQvDd
         VjQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Af0AIrF2pn2WiljuwZLbgsnTz6mwhPcm7wLICRG7aXU=;
        b=EiOxCm83m5uhV1Pw2b8T5pWEreobQBgw/96YvqTSldY8J8YcRWAx9tzs2Pe7KeV9H5
         I7XOMr8GOIOvhsY5Dzh6hjZQTfB6y/OuAGKVjIvRbSHWnHb5GVF9yp6e6qXeuHXcImsQ
         J99u6cp8qBq6J9fKgTnab/fRE9uROk2crwbMdvjFEK72/yh3cty/xRhOyKW9tkg5J06P
         L3dJPnZRXBLf/eUwL+6sbLlWkHme8iAk17IDnhaR7MULijtpHqapRQ2DwOG9/O7Odr3r
         m/2rr6l3VS/6ymlpAx6B2XQJOmBWi1m8TWgOxnradvnT7+bXaAfMWI+gsZXpoU1bbKD4
         6sGg==
X-Gm-Message-State: APjAAAUGmQOtRpT82ezCvgwa+XM/Es7YDg+c3ii52cxiC7Q7MJIJKon2
        MgszP2cUPDQU+AWIFZlN2hs=
X-Google-Smtp-Source: APXvYqzKs5N7Q7VkfHt/A0pJeugUntAJWwWw96d/Y+AABbb6hRDfVkYvauPT6/LzxBSp7XZU8E51bw==
X-Received: by 2002:a7b:c190:: with SMTP id y16mr21086627wmi.107.1575825541855;
        Sun, 08 Dec 2019 09:19:01 -0800 (PST)
Received: from localhost.localdomain (p200300F1371AD700428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371a:d700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id g25sm11791383wmh.3.2019.12.08.09.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 09:19:01 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, narmstrong@baylibre.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/2] drm: meson: venc: cvbs: fix CVBS mode matching
Date:   Sun,  8 Dec 2019 18:18:32 +0100
Message-Id: <20191208171832.1064772-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191208171832.1064772-1-martin.blumenstingl@googlemail.com>
References: <20191208171832.1064772-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 222ec1618c3ace ("drm: Add aspect ratio parsing in DRM
layer") the drm core started honoring the picture_aspect_ratio field
when comparing two drm_display_modes. Prior to that it was ignored.
When the CVBS encoder driver was initially submitted there was no aspect
ratio check.

Switch from drm_mode_equal() to drm_mode_match() without
DRM_MODE_MATCH_ASPECT_RATIO to fix "kmscube" and X.org output using the
CVBS connector. When (for example) kmscube sets the output mode when
using the CVBS connector it passes HDMI_PICTURE_ASPECT_NONE, making the
drm_mode_equal() fail as it include the aspect ratio.

Prior to this patch kmscube reported:
  failed to set mode: Invalid argument

The CVBS mode checking in the sun4i (drivers/gpu/drm/sun4i/sun4i_tv.c
sun4i_tv_mode_to_drm_mode) and ZTE (drivers/gpu/drm/zte/zx_tvenc.c
tvenc_mode_{pal,ntsc}) drivers don't set the "picture_aspect_ratio" at
all. The Meson VPU driver does not rely on the aspect ratio for the CVBS
output so we can safely decouple it from the hdmi_picture_aspect
setting.

Fixes: 222ec1618c3ace ("drm: Add aspect ratio parsing in DRM layer")
Fixes: bbbe775ec5b5da ("drm: Add support for Amlogic Meson Graphic Controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/gpu/drm/meson/meson_venc_cvbs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_venc_cvbs.c b/drivers/gpu/drm/meson/meson_venc_cvbs.c
index 6b8a074e4ff4..1bd6b6d15ffb 100644
--- a/drivers/gpu/drm/meson/meson_venc_cvbs.c
+++ b/drivers/gpu/drm/meson/meson_venc_cvbs.c
@@ -72,7 +72,11 @@ meson_cvbs_get_mode(const struct drm_display_mode *req_mode)
 	for (i = 0; i < MESON_CVBS_MODES_COUNT; ++i) {
 		struct meson_cvbs_mode *meson_mode = &meson_cvbs_modes[i];
 
-		if (drm_mode_equal(req_mode, &meson_mode->mode))
+		if (drm_mode_match(req_mode, &meson_mode->mode,
+				   DRM_MODE_MATCH_TIMINGS |
+				   DRM_MODE_MATCH_CLOCK |
+				   DRM_MODE_MATCH_FLAGS |
+				   DRM_MODE_MATCH_3D_FLAGS))
 			return meson_mode;
 	}
 
-- 
2.24.0

