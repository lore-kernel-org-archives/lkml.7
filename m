Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FBCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A8C2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QQdDUz/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfCYOTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:19:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39045 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfCYOSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:18:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id t124so9256466wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UakGg7pFINmeFLlNMB831/77cfd9ndMBEIB1YBWHGhc=;
        b=QQdDUz/hynfYXaGL3Ko0DRhMpJQJwBuv9bgNshh7ja7IMkhdkDEpsc7gcoobUUMaf3
         2Cm8Z7KCYfpz8lvYM8RvBeUU0AhjVhhqHaN6uI2UfaXGEfSoXfOLjxESmBu7HwiAcgro
         t24uuyGP9FMSCx7JkT8f3eY2eNQ7HAfsiqQSeEwKePBg3eHip1OPKeKuwUBvKJDvGdFM
         o3MarFPqIiD03de7r/9jm23tQspRcRbf+nGAfSkj+4zmC6xDhbapdUGwEPkvS4BvRH5z
         AIXuE3kj/wqIJmgryLie3nksdvXcJVCMp2ppwrFYRLSjfQJmO3g505s+CJrV+Vp7aFlB
         J5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UakGg7pFINmeFLlNMB831/77cfd9ndMBEIB1YBWHGhc=;
        b=B+aumheLn/qRcacpcTwlz9GZfQb2iIb2VcGJ/qUHIc7NdIOgTtYwwCte0wpXzMxzDA
         WywdI75lRXqUch4ueOmLFS2X2ub/YTtMn1dYnfpsnghJW7gt9vF3kSjuAiyo09uBaSDG
         8zgpL7Az288ORIXOJvaj1H6//oVNQWQlkWa/Ws4Tdsq5GTJDHL/LsQwaoyHXmA6PERHR
         ZCoX38o4B/TrRThxy76XY7UAoW+v2pFO1DhpwfmexxMW8+1mO89On21oZ5DlGYRP/+Ce
         NZ2PSD0/qc3/TZMXNtEDwBzSLNPisxhURFtKjTvUWs03PdjyrKKPq34lxPw2Y1Y/YFDn
         T6Zw==
X-Gm-Message-State: APjAAAW+zv/1uuo8qRxnMMa7KtInJz+1vMSHuFHoRZlzLbd6OzEWNLdF
        vbSzQz4/7DstALwChMTzfcGOew==
X-Google-Smtp-Source: APXvYqzM4VcWDGeQXJKVYSJV2lhPRNdzzEFP02utOoGVpEFuCOSpGmR0y0I44/Qb9BOnnC5mfeAdwg==
X-Received: by 2002:a05:600c:2055:: with SMTP id p21mr6456775wmg.118.1553523513566;
        Mon, 25 Mar 2019 07:18:33 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id 132sm26976794wmd.30.2019.03.25.07.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 07:18:32 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] drm/meson: Add G12A support for OSD1 Plane
Date:   Mon, 25 Mar 2019 15:18:18 +0100
Message-Id: <20190325141824.21259-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325141824.21259-1-narmstrong@baylibre.com>
References: <20190325141824.21259-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic G12A SoC supports now up to 3 OSD planes (1 more than the
previous SoCs) and a brand new OSD plane blender module.

This patch uses the same OSD1 plane G12A, using the exact same scaler
and OSD1 setup registers, except using the new blender register to
disable the plane.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_plane.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_plane.c b/drivers/gpu/drm/meson/meson_plane.c
index b7786218cb10..bf8f1fab63aa 100644
--- a/drivers/gpu/drm/meson/meson_plane.c
+++ b/drivers/gpu/drm/meson/meson_plane.c
@@ -294,6 +294,13 @@ static void meson_plane_atomic_update(struct drm_plane *plane,
 	priv->viu.osd1_blk0_cfg[3] = ((dest.x2 - 1) << 16) | dest.x1;
 	priv->viu.osd1_blk0_cfg[4] = ((dest.y2 - 1) << 16) | dest.y1;
 
+	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
+		priv->viu.osd_blend_din0_scope_h = ((dest.x2 - 1) << 16) | dest.x1;
+		priv->viu.osd_blend_din0_scope_v = ((dest.y2 - 1) << 16) | dest.y1;
+		priv->viu.osb_blend0_size = dst_h << 16 | dst_w;
+		priv->viu.osb_blend1_size = dst_h << 16 | dst_w;
+	}
+
 	/* Update Canvas with buffer address */
 	gem = drm_fb_cma_get_gem_obj(fb, 0);
 
@@ -320,8 +327,12 @@ static void meson_plane_atomic_disable(struct drm_plane *plane,
 	struct meson_drm *priv = meson_plane->priv;
 
 	/* Disable OSD1 */
-	writel_bits_relaxed(VPP_OSD1_POSTBLEND, 0,
-			    priv->io_base + _REG(VPP_MISC));
+	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
+		writel_bits_relaxed(BIT(0) | BIT(21), 0,
+			priv->io_base + _REG(VIU_OSD1_CTRL_STAT));
+	else
+		writel_bits_relaxed(VPP_OSD1_POSTBLEND, 0,
+				    priv->io_base + _REG(VPP_MISC));
 
 	meson_plane->enabled = false;
 
-- 
2.21.0

