Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AD7C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 22:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7532084D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 22:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fi6nj6EV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfK3W0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 17:26:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43634 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfK3W0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 17:26:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id n1so39345690wra.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 14:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bupTiDGvcydZYN2Rnj/bXhOvQ014P8Ct3uBt5NbJKS8=;
        b=fi6nj6EVbWIV/2fhXGOQgkkRptg3mNzbFfVm4h7Lx3k31Gd/rdMvatqedH2AHz+fTI
         JA/tugb+Ci5XR+WmopY5bNT3Kyc/wh4bp+rlLoxlfqmtdV7Pnnj5aaoixosAp7mmvaqy
         jippza5lpblGhOfDmzNUK+vsBOeBoY0cQoW5dTGXBO4cOrf5mlZ3yiMxbScXD0aLIWt5
         Aes9ebuA77Em4dDWQ+DshvhfptHrVRohoWlsTXL6zRv+W32H2/MH5XIFvTcKQeXuUTR2
         Aij4/EWbitIheNds46i9dsiG36YypcQcwmsV80mFsBv7rxHKQsOZ2ptDJ247SzPm9uYC
         WDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bupTiDGvcydZYN2Rnj/bXhOvQ014P8Ct3uBt5NbJKS8=;
        b=LVFLY5FfDJpvxiTVlliAFqgxg7NCvLOMPSxMX9eRBynAFWEQFsdlPfjkspoa2f+elW
         GV0C/uJ8fwtqS/mZSd/F6Dg0crkf8Q+3M1P9gz47yEZu7PjeOPtvC09LveO7t6CYRS58
         y7MpVFJ78iaJ4r94C8NtOw/aZZQYAJP4fLboG/synnVZ74+R3Xme9BxDSuPH0TnSVTeY
         JjDeQSDnERN4jnQ1wKMPddgU1MIfSZ+vPrlDy0Ky1LuuHGxtiD4fr3vGl8t88I+zxAAt
         WIG3dVYCmwGjmwHo5zmbQDlmSjnZbf5ISkZ4blqZviXiVsryJb3WY2oAWBFrJ61AhUWi
         ZZGw==
X-Gm-Message-State: APjAAAX7ltH8pPqdMe//6kLMZ2HA8OL5wHfbyDREER9OIxIHRbziTPZx
        9N4Mytii3DsYluDLMhlASx0=
X-Google-Smtp-Source: APXvYqwjN3lyPniHb9sLZ4uyBqG1FGZjCFKXKddgkyxV/pen1ugXXLKQtr2k6+big4hC461LRG5JBw==
X-Received: by 2002:adf:f5c2:: with SMTP id k2mr60867770wrp.118.1575152762350;
        Sat, 30 Nov 2019 14:26:02 -0800 (PST)
Received: from localhost.localdomain (p200300F1371CB100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371c:b100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id i71sm36265650wri.68.2019.11.30.14.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 14:26:01 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, narmstrong@baylibre.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] drm: meson: venc: cvbs: fix CVBS mode matching
Date:   Sat, 30 Nov 2019 23:25:55 +0100
Message-Id: <20191130222555.2005375-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the picture_aspect_ratio from the drm_display_modes which are valid
for the Amlogic Meson CVBS encoder. meson_venc_cvbs_encoder_atomic_check
and meson_venc_cvbs_encoder_mode_set only support two very specific
drm_display_modes.

With commit 222ec1618c3ace ("drm: Add aspect ratio parsing in DRM
layer") the drm core started honoring the picture_aspect_ratio field
when comparing two drm_display_modes. Prior to that it was ignored.
When the CVBS encoder driver was initially submitted there was no aspect
ratio check.

This patch fixes "kmscube" and X.org output using the CVBS connector
with the Amlogic Meson VPU driver. Prior to this patch kmscube reported:
  failed to set mode: Invalid argument
Additionally it makes the CVBS mode checking behave identical to the
sun4i (drivers/gpu/drm/sun4i/sun4i_tv.c sun4i_tv_mode_to_drm_mode) and
ZTE (drivers/gpu/drm/zte/zx_tvenc.c tvenc_mode_{pal,ntsc}) which are
both not setting "picture_aspect_ratio" either.

Fixes: 222ec1618c3ace ("drm: Add aspect ratio parsing in DRM layer")
Fixes: bbbe775ec5b5da ("drm: Add support for Amlogic Meson Graphic Controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/gpu/drm/meson/meson_venc_cvbs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_venc_cvbs.c b/drivers/gpu/drm/meson/meson_venc_cvbs.c
index 9ab27aecfcf3..2ddcda8fa5b0 100644
--- a/drivers/gpu/drm/meson/meson_venc_cvbs.c
+++ b/drivers/gpu/drm/meson/meson_venc_cvbs.c
@@ -49,7 +49,6 @@ struct meson_cvbs_mode meson_cvbs_modes[MESON_CVBS_MODES_COUNT] = {
 				 720, 732, 795, 864, 0, 576, 580, 586, 625, 0,
 				 DRM_MODE_FLAG_INTERLACE),
 			.vrefresh = 50,
-			.picture_aspect_ratio = HDMI_PICTURE_ASPECT_4_3,
 		},
 	},
 	{ /* NTSC */
@@ -59,7 +58,6 @@ struct meson_cvbs_mode meson_cvbs_modes[MESON_CVBS_MODES_COUNT] = {
 				720, 739, 801, 858, 0, 480, 488, 494, 525, 0,
 				DRM_MODE_FLAG_INTERLACE),
 			.vrefresh = 60,
-			.picture_aspect_ratio = HDMI_PICTURE_ASPECT_4_3,
 		},
 	},
 };
-- 
2.24.0

