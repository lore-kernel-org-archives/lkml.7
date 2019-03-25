Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED11C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF3B2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="r5HIdwck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbfCYOTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:19:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35304 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbfCYOSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:18:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so9308515wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9NjvvI6xxrMvbgreZkI/znNtsX+wD5ky2vWfW/YYRc4=;
        b=r5HIdwckPHedjpTgqQ/mk55L3fBP8SbOrjd+A/cfm+BK4jT7uX3yUGFY+g713wzBuU
         62ZwbLnQ8knAxGrfa9hFMrQa8qQO/FP8Cdn4Tzkd6PG8eLQ7oZ/RTKb7Te+AOVxxKz6B
         0EcTNB30UgPqQQacQ1NLoed/ijDJUnlLxAQSoLvsQ0iqai/dSXwLom794jjSwX8PE24P
         6hod2cQQ+IVlNcPUlK4+o60ewaxUYtF5X2nilbv3Cvfi3tyc0YH/oA1mNfhF1P50slDa
         9RES3t39mTlVCnP7ZEGvbnKU44A6czHASOfpjRhT3xN8u/KwzcMjt5kr1aJ8BU3diItx
         I6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9NjvvI6xxrMvbgreZkI/znNtsX+wD5ky2vWfW/YYRc4=;
        b=b/3JhtftSVoXJgiKjXl/FyLlz8uF/5WTDV9Ho5rmTvYIo1VZyroj+sDIAUKw4qCvVJ
         mnK8X/vj73pSOqX9P+yMSqxC7a04x9pjWKatIgEKj77+wZckM6GcpCPSlnTWdZdxKKh9
         SRoFrWUftdPOk44p3EDbpwVH0xVDWLB82CrCC96h5JmjtsYNoJZUy79tRbJYkddlIdax
         50l3WlR9P7yFv1Ym5vrQb/rkrVgY8uz8a3iHPG7vjOCVGe7RvtQjCreWrxmTyxZsGv2Z
         YD/lauA8JLB0I+6kQ8hKE7V4U2KTOKlknR6tK2+eFpu45eEdwd6AIzFUPL2B+rt2nwRG
         BfQQ==
X-Gm-Message-State: APjAAAXc25ZsidrrsyUtchJv0s/wHZTMxmJaP/A5LzcNW0FoF08yGHwJ
        47gJEaazPqcl5MzTa3C5ivAcZw==
X-Google-Smtp-Source: APXvYqycLSLO6xaeAbRCJdfz7W+lVg6wVYIQTncbJK27nigm5eGkdADSWULi+QLlHfecFQ0lEwasdg==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr11386367wmc.76.1553523515408;
        Mon, 25 Mar 2019 07:18:35 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id 132sm26976794wmd.30.2019.03.25.07.18.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 07:18:33 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] drm/meson: Add G12A Support for the Overlay video plane
Date:   Mon, 25 Mar 2019 15:18:19 +0100
Message-Id: <20190325141824.21259-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325141824.21259-1-narmstrong@baylibre.com>
References: <20190325141824.21259-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic G12A SoC supports the same set of Video Planes, but now
are handled by the new OSD plane blender module.

This patch uses the same VD1 plane for G12A, using the exact same scaler
and VD11 setup registers, except using the new blender register to
disable the plane.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_overlay.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
index b54a22e483b9..bdbf925ff3e8 100644
--- a/drivers/gpu/drm/meson/meson_overlay.c
+++ b/drivers/gpu/drm/meson/meson_overlay.c
@@ -516,8 +516,14 @@ static void meson_overlay_atomic_disable(struct drm_plane *plane,
 	priv->viu.vd1_enabled = false;
 
 	/* Disable VD1 */
-	writel_bits_relaxed(VPP_VD1_POSTBLEND | VPP_VD1_PREBLEND, 0,
-			    priv->io_base + _REG(VPP_MISC));
+	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
+		writel_relaxed(0, priv->io_base + _REG(VD1_BLEND_SRC_CTRL));
+		writel_relaxed(0, priv->io_base + _REG(VD2_BLEND_SRC_CTRL));
+		writel_relaxed(0, priv->io_base + _REG(VD1_IF0_GEN_REG + 0x17b0));
+		writel_relaxed(0, priv->io_base + _REG(VD2_IF0_GEN_REG + 0x17b0));
+	} else
+		writel_bits_relaxed(VPP_VD1_POSTBLEND | VPP_VD1_PREBLEND, 0,
+				    priv->io_base + _REG(VPP_MISC));
 
 }
 
-- 
2.21.0

