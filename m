Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12F8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C05F21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OqNlY2d8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfCTILQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:11:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36940 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfCTILP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:11:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so10542680wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 01:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eFtdP05d2Yd7J7Kr65hCVTF0i81Ds1QiBjoleRYSdg4=;
        b=OqNlY2d8zJN+yt4ujTovEzqj1DCk9qg2euOx/Lyzn+sh05433TflHUP6VmiPx+csOE
         aWrhIEzdYnMqQeADMxEvbPvo97EsJSQSWkulxhsK45lDWTgOtDf03FLQ5kTL+LwFLuA+
         P1BHwnyK4Kc/8PqivblcrR9HQ5ivXCqggJTd/inIj9hDemRhx0lUjaar/g45i5GSA0vV
         2iwsaJSgNpRqS6cj/aGaSNvZWq0x7DYkAbw2zikY5W7wwJhlCr/nv8H3iyp/gBzjOchS
         7BuSjEiwjLqAKr9gZKGsl0i74iIzOwutoBqsNdrDbOquL+QEYO1wkzH8Ww8SUCkNkVJh
         xa0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eFtdP05d2Yd7J7Kr65hCVTF0i81Ds1QiBjoleRYSdg4=;
        b=fQ+8yZe+09mEvJXIy/RBKhMNHScHQWLv/hmiyDitSqIjD9JRYwM1bFg4JkWlvwrN2H
         UaVH5XEV3aNz1ziE5X5drnkHHku42oDdJ87qn8jZzlRHgli87q/FpjJyitGctxsu5wl6
         OjvhQ9BPfadq9aZIDscVVlRMZo4fThnVgfez3jHd4PpM70QC7AFniSfHYqOgI5bTuNFy
         9YunFtHrQN8KknZOZUkZJOq7eRK7pizVQcnKdVvnWpgRhd7EfuHetQ1zVlVesXInzHqG
         4gvrIceRFYlyfftuwp9Ppyvcjs/pMTbwIAth1V2DUL4/Kqm4Td4s2CYB3z6Lt6CugN8a
         nf6A==
X-Gm-Message-State: APjAAAW+Xb2GFYyNJSmfFL168ER1EpqGhio4uK3NdDDdxF3Lj+CF2nkR
        Uf2IGoOhj7PBrV+MjdzSDYVROg==
X-Google-Smtp-Source: APXvYqwtuUEVnsZxXKA7EBFNRqaDkSSEbJFykQuv8l1AVpJLIqATxrOaPDhf5tfS1n6BAtUIMwowGw==
X-Received: by 2002:a1c:7e51:: with SMTP id z78mr7111964wmc.82.1553069473794;
        Wed, 20 Mar 2019 01:11:13 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id 12sm3640670wme.25.2019.03.20.01.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Mar 2019 01:11:13 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Jourdan <mjourdan@baylibre.com>
Subject: [PATCH] drm/meson: fix TMDS clock filtering for DMT monitors
Date:   Wed, 20 Mar 2019 09:11:10 +0100
Message-Id: <20190320081110.1718-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMT monitors does not necessarely report a maximum TMDS clock
in a VSDB EDID extension.

In this case, all modes are wrongly rejected, including
the DRM fallback EDID.

This patch only rejects modes whith clock > max_tmds_clock if
the max_tmds_clock is specified. This will only reject
4:2:0 HDMI2.0 modes, who reports a clock > max_tmds_clock.

Reported-by: Maxime Jourdan <mjourdan@baylibre.com>
Fixes: d7d8fb7046b6 ("drm/meson: add HDMI div40 TMDS mode")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index e28814f4ea6c..563953ec6ad0 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -569,7 +569,8 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 	DRM_DEBUG_DRIVER("Modeline " DRM_MODE_FMT "\n", DRM_MODE_ARG(mode));
 
 	/* If sink max TMDS clock, we reject the mode */
-	if (mode->clock > connector->display_info.max_tmds_clock)
+	if (connector->display_info.max_tmds_clock &&
+	    mode->clock > connector->display_info.max_tmds_clock)
 		return MODE_BAD;
 
 	/* Check against non-VIC supported modes */
-- 
2.21.0

