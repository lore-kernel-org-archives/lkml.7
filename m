Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7672DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4641A20874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oOsWkVyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfHZOqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 10:46:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39772 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729105AbfHZOqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:46:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id t16so15608781wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 07:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lKqFlQ5uAweiWoy5Q0NBtlqDIxAoWdFqAZ3hE0aWMrA=;
        b=oOsWkVyy0OVNO3GEWtL9KUlBPcNQ8EXb5NCLaRrryxI86WLE7itY1IhCRJ//gMudtE
         MI6ag1jiTbVVcDqAqXe22G5Ebaq5BNPFjs6B3Wib8wz4iLstk/g8GUietWVUDOVMtFLD
         B72moJ69pMr5bro4U1czlxVb8JfS6SU1/pnwUeOux5P8jlS5AmQgmodOo1MfubsAtRFd
         6thkrxpAUURZh4j5Bx+8fONziNmU3yKSV12jDFNhld88vr6ZzSyAwVmUIXXrkmddsp89
         B3dw+IJyZkAPVaiO4vKQIwopRI6ZxW7dUD8oDdsLLhWbf2C5s+AV7/4TTATXNxBIP2Vf
         RzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lKqFlQ5uAweiWoy5Q0NBtlqDIxAoWdFqAZ3hE0aWMrA=;
        b=nTSLW29WWABVa9+061mh8oVMAkJxpb2R7Jvk/L8vi7RF65D1DwDYdiE5YwobjM08Xq
         xFiI2cgor74HqK8GZhYC6o4QxqYhlJ73C9h8BSVRZUP2MYrttAqw4pW7VTXmCQOzzmcX
         MaRpuu+YCxrTAuOtL7B+G5Qdds0b/QjgWsJv/9yfL4XN4u9K6c5C2Z1LkTqsU7usAQeb
         Ywlgo7seEEBBP7CAErXKJga71vHslC4Qwrxh3kiXdunj/FwzVIo/dcmkYsENpLtiH511
         uSGrIeGdEY6YoPyQVRreXyX+ZRkY0YHW5BKSlV6e/PQZaXLGtLxxjVzqeQv3xyVzlj7O
         AEmw==
X-Gm-Message-State: APjAAAXeycaS9NullarQ8yyl5r2CvdoNboz57ckSprQpbD2GzfPplJuM
        XF9gWAPqVgQyh3brj4mjtKKKbNio07alMw==
X-Google-Smtp-Source: APXvYqzj8GflBpfqyAQoqHVpAUfVZVDf2xgGir3LWPo8zTibAZW8llY0SCOEuBpqNLk+uWaJWp10ZQ==
X-Received: by 2002:a5d:408c:: with SMTP id o12mr21617046wrp.176.1566830811145;
        Mon, 26 Aug 2019 07:46:51 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e9sm12984595wrm.43.2019.08.26.07.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 07:46:50 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/meson: vclk: use the correct G12A frac max value
Date:   Mon, 26 Aug 2019 16:46:47 +0200
Message-Id: <20190826144647.17302-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calculating the HDMI PLL settings for a DMT mode PHY frequency,
use the correct max fractional PLL value for G12A VPU.

With this fix, we can finally setup the 1024x76-60 mode.

Fixes: 202b9808f8ed ("drm/meson: Add G12A Video Clock setup")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_vclk.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index ac491a781952..f690793ae2d5 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -638,13 +638,18 @@ static bool meson_hdmi_pll_validate_params(struct meson_drm *priv,
 		if (frac >= HDMI_FRAC_MAX_GXBB)
 			return false;
 	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXM) ||
-		   meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL) ||
-		   meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
+		   meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL)) {
 		/* Empiric supported min/max dividers */
 		if (m < 106 || m > 247)
 			return false;
 		if (frac >= HDMI_FRAC_MAX_GXL)
 			return false;
+	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
+		/* Empiric supported min/max dividers */
+		if (m < 106 || m > 247)
+			return false;
+		if (frac >= HDMI_FRAC_MAX_G12A)
+			return false;
 	}
 
 	return true;
-- 
2.22.0

