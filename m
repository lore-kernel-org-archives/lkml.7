Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB652C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDD1216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127939;
	bh=ZKAkj2PBDzbgmpcPQyxVaFn971P85QAkn1irCUYBn+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rRUrgKV2uyY6ELLWqv0lJyzMz9WqmGHBG4vw7yJZ/xWqg2EfifJBQcG6GnMpM1fAA
	 gvTIGkPXgeg7JTpwds7CFZrHovtuYH2tFYGjQdu1/1vS7lSvu56RGPvrHcY/oyctaK
	 0YBvaSP7CBH6qFGJY24RwOcGEtChvYZ94JJXDI0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfHFVpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbfHFVeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:34:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C6A0216F4;
        Tue,  6 Aug 2019 21:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127239;
        bh=ZKAkj2PBDzbgmpcPQyxVaFn971P85QAkn1irCUYBn+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xe81UfOuf9SmJXbSoYGQBNXKpSTSERsLAVJ5hxUzqK3xSVXzl8e/WaHWJW2U0GPFL
         BqJZMx/BMwBF/P8d8+D0ywAL2XAKP5cVNh4aaL3yUh8yA5qhf5gPA9jbGHWzl23oVy
         987y68+/Qg194VWwTO8TgBEODQx2kpM6JWJa2Zvo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 22/59] drm/bridge: lvds-encoder: Fix build error while CONFIG_DRM_KMS_HELPER=m
Date:   Tue,  6 Aug 2019 17:32:42 -0400
Message-Id: <20190806213319.19203-22-sashal@kernel.org>
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

[ Upstream commit f4cc743a98136df3c3763050a0e8223b52d9a960 ]

If DRM_LVDS_ENCODER=y but CONFIG_DRM_KMS_HELPER=m,
build fails:

drivers/gpu/drm/bridge/lvds-encoder.o: In function `lvds_encoder_probe':
lvds-encoder.c:(.text+0x155): undefined reference to `devm_drm_panel_bridge_add'

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: dbb58bfd9ae6 ("drm/bridge: Fix lvds-encoder since the panel_bridge rework.")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190729071216.27488-1-yuehaibing@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index ee777469293a4..cc62603b87c59 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -48,6 +48,7 @@ config DRM_DUMB_VGA_DAC
 config DRM_LVDS_ENCODER
 	tristate "Transparent parallel to LVDS encoder support"
 	depends on OF
+	select DRM_KMS_HELPER
 	select DRM_PANEL_BRIDGE
 	help
 	  Support for transparent parallel to LVDS encoders that don't require
-- 
2.20.1

