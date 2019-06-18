Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8BBC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796D121655
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560884797;
	bh=tKuxna/c/tPIwWl1WEp9bAthDvfo4BrsL1N8qcs17h4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VnyBr1ihHR6INWxXHHGUGbBjKT/EMZDbDBIh8/HvJgX8hoYYoGTq2oNxiMXDEMe9l
	 IE+daAEeIOokFGSgfjyGumFHu8t+6CNW3Qdb5kcKNpT4mOD2UiCq5Zg2B4cnBiCplQ
	 eRSxhPxjda0eQ+vprOPRQtzxSuLiMzPOGH1PE/gM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbfFRTGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 15:06:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730196AbfFRTGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 15:06:35 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5AA521530;
        Tue, 18 Jun 2019 19:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560884794;
        bh=tKuxna/c/tPIwWl1WEp9bAthDvfo4BrsL1N8qcs17h4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4uMAxQv22mXkzeQdF8lt4/9t4lWbHJD4LXhNOCdcCsbDuW1PDrvBxMWrPrNwRE4c
         jPdhEkVBWANBLW7n/II52Scd5EQVKsFMZ3ZzvHIUQaqL14nbTFWGLuXetPCaXmmkTl
         BuebAaWOYZIC/6f2+FmBKxd0j+OIjBRn4ShWoD2M=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Olof Johansson <olof@lixom.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Joseph Kogut <joseph.kogut@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RFT 09/10] ARM: exynos_defconfig: Enable Panfrost and LIMA drivers
Date:   Tue, 18 Jun 2019 21:05:33 +0200
Message-Id: <20190618190534.4951-10-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618190534.4951-1-krzk@kernel.org>
References: <20190618190534.4951-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for Mali GPU with Panfrost and LIMA drivers.  Most of
Exynos chipsets come with Mali GPUs:
1. Mali 400 (Exynos3250, Exynos4210, Exynos4412),
2. Mali T7xx (Exynos542x).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/exynos_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 8d08eed99aa1..f140532ddca7 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -212,6 +212,8 @@ CONFIG_DRM_NXP_PTN3460=y
 CONFIG_DRM_PARADE_PS8622=y
 CONFIG_DRM_SII9234=y
 CONFIG_DRM_TOSHIBA_TC358764=y
+CONFIG_DRM_LIMA=y
+CONFIG_DRM_PANFROST=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=y
 CONFIG_BACKLIGHT_PWM=y
@@ -284,7 +286,6 @@ CONFIG_CROS_EC_SPI=y
 CONFIG_COMMON_CLK_MAX77686=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_EXYNOS_IOMMU=y
-CONFIG_PM_DEVFREQ=y
 CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
 CONFIG_DEVFREQ_GOV_USERSPACE=y
-- 
2.17.1

