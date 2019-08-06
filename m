Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCEDC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45C2216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127245;
	bh=tX3+3B/kq+FNOebC/0HT2A+XLEXbQHn4wNEEh5n8x30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EMGBzWUYdLdDcIWCgHe/P2EkW4YjWefVsqeXidfanlfT+5D0/RRHn7cOZighmPAQS
	 LZKNwQuBL4+apiBLsuTChRUFzwiiGbwWpa/iKKGG1IG9sTl4bS/BTQRB21MfiseIRn
	 wGwhRfjmDFgffs2r6+ZwRtmSW7HyVN94WDmm9acA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfHFVeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:34:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbfHFVeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:34:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1AA7217D7;
        Tue,  6 Aug 2019 21:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127240;
        bh=tX3+3B/kq+FNOebC/0HT2A+XLEXbQHn4wNEEh5n8x30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gX4cHNQyMNSy1yXOlXBcHXLLueFK7M45r7mY4ePUlzB2rpr/yrTC8m4gX5gawm08J
         3PsaNHFFyAHRIReKJHavKlO6twagKP6MGASauxSO4rT4hi2nFLl9XJ5hYnPA/tJjNz
         Aa/ZEtnfnheu+zagDCMTAs9fPJcJI95VJxMKEMEg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 23/59] drm/bridge: tc358764: Fix build error
Date:   Tue,  6 Aug 2019 17:32:43 -0400
Message-Id: <20190806213319.19203-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213319.19203-1-sashal@kernel.org>
References: <20190806213319.19203-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit e1ae72a21e5f0d1846e26e3f5963930664702071 ]

If CONFIG_DRM_TOSHIBA_TC358764=y but CONFIG_DRM_KMS_HELPER=m,
building fails:

drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x228): undefined reference to `drm_atomic_helper_connector_reset'
drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x240): undefined reference to `drm_helper_probe_single_connector_modes'
drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x268): undefined reference to `drm_atomic_helper_connector_duplicate_state'
drivers/gpu/drm/bridge/tc358764.o:(.rodata+0x270): undefined reference to `drm_atomic_helper_connector_destroy_state'

Like TC358767, select DRM_KMS_HELPER to fix this, and
change to select DRM_PANEL to avoid recursive dependency.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: f38b7cca6d0e ("drm/bridge: tc358764: Add DSI to LVDS bridge driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190729090520.25968-1-yuehaibing@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index cc62603b87c59..e4e22bbae2a7c 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -117,9 +117,10 @@ config DRM_THINE_THC63LVD1024
 
 config DRM_TOSHIBA_TC358764
 	tristate "TC358764 DSI/LVDS bridge"
-	depends on DRM && DRM_PANEL
 	depends on OF
 	select DRM_MIPI_DSI
+	select DRM_KMS_HELPER
+	select DRM_PANEL
 	help
 	  Toshiba TC358764 DSI/LVDS bridge driver.
 
-- 
2.20.1

