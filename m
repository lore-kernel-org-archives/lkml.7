Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39F2C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 19:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E41B206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 19:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561231156;
	bh=bQV8QrWO6dxnGr7QlKGtsMX1k98htmmmCH69v0k+zmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GJ7SJQpBSmlQLb1ePzFDgV76YSYdeW4Yvsd75+2+LmIOE4FOOzCulvaaFdA7OTOAs
	 CDyxgK3Kn7GAUjXtetdNsojsxExne/U7KjAfEzrZHjzPGJUQRt4DgyxvH9Ma1dnZCG
	 9D8fFhVNhN6N+m+CvjPDnC0bZf9ZjbkMKKuFwqEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfFVTTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 15:19:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVTTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 15:19:12 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02ACD206B7;
        Sat, 22 Jun 2019 19:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561231150;
        bh=bQV8QrWO6dxnGr7QlKGtsMX1k98htmmmCH69v0k+zmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nVPXuPuOxymKodf9KSrozYvY7ndqFJIdi4WXf81r1bDSyYAXOPz9X/pGWUj1bH7qb
         KxQENpY6NFmUVHMHKCJV5ptdRwmWYpgv2xr7CXcaYTlqvmgcrNu9FpfeKLwIcpOngY
         NW215jnPbV8/CPSS3uvSA5kkG5Kt/F3Gg+6q6sao=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Olof Johansson <olof@lixom.net>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3] arm64: defconfig: Enable Panfrost and Lima drivers
Date:   Sat, 22 Jun 2019 21:18:38 +0200
Message-Id: <20190622191838.29850-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621180208.25361-7-krzk@kernel.org>
References: <20190621180208.25361-7-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for Mali GPU with Panfrost and Lima drivers for:
1. Samsung Exynos5433 and Exynos7 (having Mali T760),
2. Allwiner A64 and H5 (Mali 400/450).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Enable Lima driver
---
 arch/arm64/configs/defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fbbc065415d4..3d31611368af 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -518,6 +518,8 @@ CONFIG_DRM_HISI_HIBMC=m
 CONFIG_DRM_HISI_KIRIN=m
 CONFIG_DRM_MESON=m
 CONFIG_DRM_PL111=m
+CONFIG_DRM_LIMA=m
+CONFIG_DRM_PANFROST=m
 CONFIG_FB=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_BACKLIGHT_GENERIC=m
@@ -718,7 +720,6 @@ CONFIG_ARCH_TEGRA_194_SOC=y
 CONFIG_ARCH_K3_AM6_SOC=y
 CONFIG_SOC_TI=y
 CONFIG_TI_SCI_PM_DOMAINS=y
-CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_EXTCON_USBC_CROS_EC=y
 CONFIG_MEMORY=y
-- 
2.17.1

