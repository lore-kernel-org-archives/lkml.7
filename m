Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C386C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1AE2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 13:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Uqh5RTPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfH1NXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 09:23:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38258 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfH1NXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 09:23:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id e16so2503192wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SMEwDnA8PK409z+Aw0DoKAxN3PbjiYfTei3jRL70xXE=;
        b=Uqh5RTPxsxlgO6fW+/GUp4PHz90/PXrd2mH3+ERhbCtOXr5thlsbr2p/LwY2qGqpwp
         VuHQen7EZmGCxAiXC1cfifEbYOaAC+p3+x/DJIs3P+8EgDXQ89qvHHqwqrG8nhBdxW+c
         tJwQqCHExOTpgBG9ImlyJxpAel/U4SnSMOwbYsPe88WLxu7Pmq5UYVC9duZEaD1GaLZo
         81vaNBLxSAlavlQjnWQ2ndvY1rZyH4+flemGFSIF98DM/qchwIzCXEG3n9t79jy2Y7TM
         jXnrU60lr0P44mWM3EoDT07kZ+I4m5LUEMwJfftMdDRo8EuKrXUMraB10G9aCyud/5+t
         tuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SMEwDnA8PK409z+Aw0DoKAxN3PbjiYfTei3jRL70xXE=;
        b=sbqq0Fj9j+UUg9l0Jhs97BgypeVTfY84dFq7xQScBptCvIOYauE3oyZm6xVE+A7hjE
         szbcocjSSgj1acUhgB8GvoWRG5qapcGCAeOqFUGV+B9EqsgcJAJ+x39wClfb5+yRNR9P
         ZhG43kNN3cPDs5zAyZWEPOrnvHvHRq5jjz5jLGQaSLK+U9XhUb/17y67WPbFd9JDAzyn
         get6xE32t03cBI7oaUAFFWlJIC1Thd/6PWMnEKNhpLPzBW8LmYY3X7PlTo5uIdQjL2Kn
         krtiyjrmdTtouGcpshEkQRWbA8dmV2udmZLWEsBDhSSR2rEThY9rYcY6mgORJdkkMZej
         tmyw==
X-Gm-Message-State: APjAAAWv8ErvB9K1MJCsB9PtNEyO3Iy7IZMFbKZmWu5c/Ir8k08f47ne
        IBHDfv4/zzIxMm2yMBhVhhUyog==
X-Google-Smtp-Source: APXvYqwSRs75Y6JmL0J+jZ9ePz6PFEOEGjCGu9Py7xJQeuRqpBpdE3NXmyi2gk1js3KzTuh8qnnuxw==
X-Received: by 2002:adf:ba4a:: with SMTP id t10mr4522910wrg.325.1566998595621;
        Wed, 28 Aug 2019 06:23:15 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z7sm2785505wrh.67.2019.08.28.06.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 06:23:15 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] drm/meson: vclk: use the correct G12A frac max value
Date:   Wed, 28 Aug 2019 15:23:11 +0200
Message-Id: <20190828132311.23881-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calculating the HDMI PLL settings for a DMT mode PHY frequency,
use the correct max fractional PLL value for G12A VPU.

With this fix, we can finally setup the 1024x768-60 mode.

Fixes: 202b9808f8ed ("drm/meson: Add G12A Video Clock setup")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Fixed typo in commit log, 1024x76 => 1024x768

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

