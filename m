Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AA2C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25193216B7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561140164;
	bh=2wnQ8i3NYcQ9J1JMVR+A7WUBA/fd4Zl0nFfrCWSgsPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IS6E0hj0r5q6uZuYVmmubPb3oC7gB9S7ZSLidQuYB+9rYFd+4+5wt+H2iUV3FqMEv
	 K9vqD6z31caGeXQ4WiyCInhI9wjmMviQNtGVjOqlKwFxb9bwUOFExJEjfFwxDKxY3G
	 3W+ZuuYuZgPZYKvURih9GtCBJ9CoMeAeCu5/6mQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfFUSCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfFUSCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 14:02:41 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAFA52070B;
        Fri, 21 Jun 2019 18:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561140160;
        bh=2wnQ8i3NYcQ9J1JMVR+A7WUBA/fd4Zl0nFfrCWSgsPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rC/7v63lLOEnueDwA6BIwyHF2CGHH4Xu6ZOriH+Nfe+TYod7v9wZvqult8LveTxRJ
         P/+ss3fHbO5LMEPTjSILKDobSo4jMXs4nZZweANshxNR5ewcGw2MXPRXL3Hb+s8JRQ
         e6p0aUtcQTSN7w9RkB7xeTMzjnsrgJh4HBorIUbg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joseph Kogut <joseph.kogut@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: [PATCH v2 5/7] ARM: multi_v7_defconfig: Enable Panfrost and LIMA drivers
Date:   Fri, 21 Jun 2019 20:02:06 +0200
Message-Id: <20190621180208.25361-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621180208.25361-1-krzk@kernel.org>
References: <20190621180208.25361-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for Mali GPU with Panfrost and LIMA drivers.  Most of
Exynos chipsets come with Mali GPUs:
1. Mali 400 (Exynos3250, Exynos4210, Exynos4412),
2. Mali T628 (Exynos542x).

As Mali GPU is quite popular among ARM vendors, other platforms will
benefit as well.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/multi_v7_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6b748f214eae..268161911fc9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -656,6 +656,8 @@ CONFIG_DRM_VC4=m
 CONFIG_DRM_ETNAVIV=m
 CONFIG_DRM_MXSFB=m
 CONFIG_DRM_PL111=m
+CONFIG_DRM_LIMA=m
+CONFIG_DRM_PANFROST=m
 CONFIG_FB_EFI=y
 CONFIG_FB_WM8505=y
 CONFIG_FB_SH_MOBILE_LCDC=y
@@ -940,7 +942,6 @@ CONFIG_ARCH_TEGRA_2x_SOC=y
 CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_ARCH_TEGRA_114_SOC=y
 CONFIG_ARCH_TEGRA_124_SOC=y
-CONFIG_PM_DEVFREQ=y
 CONFIG_ARM_TEGRA_DEVFREQ=m
 CONFIG_TI_AEMIF=y
 CONFIG_IIO=y
-- 
2.17.1

