Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D5EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8754216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127730;
	bh=8I7S6yTtwobncyGta3F3FwqpMCUGh9F1btmxAa4dioA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eq7yBWXqdZbQbT7+0vtF4cGtm9JWUBNxhlK/ENIbCcCTm0I59m0vLqwfacrkzxPDk
	 weJr75LUKaIJfd2ZZsqXsTjslN2U79wYDVfBB/3BxShPT9TaPO+jkkaN4Ezsc7fN+A
	 eKJiv5pQfbyFag+S2QWEb8/GUAuO/rTFLTW99qr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfHFVmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728672AbfHFVfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:35:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4358E217D9;
        Tue,  6 Aug 2019 21:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127344;
        bh=8I7S6yTtwobncyGta3F3FwqpMCUGh9F1btmxAa4dioA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qII7Dhub55ts4Td3QvXGDOwjYThvf/IYAHePKC+hCJcQ25spugVQKIj/zuv83JWMQ
         Dz09HS+hl80UFGkseXJ7nT0NOkZdMoT8V0E1haG4SWNxYQrJ6b0jWqyu+BV6m5/Oni
         rfJ0gkbP03XRkZ9+syr9vd/aLpQ2V47aR08OxjCw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 11/32] drm/bridge: lvds-encoder: Fix build error while CONFIG_DRM_KMS_HELPER=m
Date:   Tue,  6 Aug 2019 17:34:59 -0400
Message-Id: <20190806213522.19859-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213522.19859-1-sashal@kernel.org>
References: <20190806213522.19859-1-sashal@kernel.org>
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
index bf6cad6c9178b..7a3e5a8f6439b 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -46,6 +46,7 @@ config DRM_DUMB_VGA_DAC
 config DRM_LVDS_ENCODER
 	tristate "Transparent parallel to LVDS encoder support"
 	depends on OF
+	select DRM_KMS_HELPER
 	select DRM_PANEL_BRIDGE
 	help
 	  Support for transparent parallel to LVDS encoders that don't require
-- 
2.20.1

