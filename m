Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3712DC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018562084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570201259;
	bh=oHpPukB6B9nYWBy+UwEt06VVM0sOiP39yRkduK0FfyA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gWekvFJoPmbtQmgh+4t4BIr3Bg2ZaBXCId7tHi8I9pYbScKTmgt6TO43LcMzJauWb
	 LcJawZNr0i7+AmR5uwuHvczjRenLb68PhZwtm36WJ/CN1v8HY1iWD09Ir5DFm1lOJU
	 9ZdgvwFEAofq2Dfh/n4ZPCYxjlYNsSmjxzkwizpA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389667AbfJDPA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389651AbfJDPA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:00:57 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99E922133F;
        Fri,  4 Oct 2019 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570201256;
        bh=oHpPukB6B9nYWBy+UwEt06VVM0sOiP39yRkduK0FfyA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=naYVCKVE90MUi+D8gWav2uNsSkNjDc0xvWVMLN7bjXO+gK8ChM6YuTL+HGl5EVEH0
         QoVuGX2eldJVcAoBIHR0FVq6zoEFeFy4draMwTSwOO7226+ecAVEmhII3Q1JUu6nm7
         E4Hc2XpBajKHsK+ihIQxxY4vbt30kI2Ln0BlspP4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable Exynos bus and memory frequency scaling (devfreq)
Date:   Fri,  4 Oct 2019 17:00:40 +0200
Message-Id: <20191004150040.5833-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004150040.5833-1-krzk@kernel.org>
References: <20191004150040.5833-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable devfreq events along with drivers for scaling frequency and
voltages of Exynos buses and Dynamic Memory Controller (DMC).  This
usually brings energy saving benefits.

So far devfreq was disabled because it was causing hangs during system
reboot (voltage not matching reset frequency). This was already fixed.

Occasionally, devfreq might negatively impact performance of certain SoC
blocks, e.g. when a bus is scaled down but some block (like Mixer with
two Full HD windows) wants to perform high-throughput DMA operations.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 7f7978dba8ab..1296e7aaa801 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -977,11 +977,14 @@ CONFIG_ARCH_TEGRA_2x_SOC=y
 CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_ARCH_TEGRA_114_SOC=y
 CONFIG_ARCH_TEGRA_124_SOC=y
+CONFIG_ARM_EXYNOS_BUS_DEVFREQ=m
 CONFIG_ARM_TEGRA_DEVFREQ=m
+CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=m
 CONFIG_EXTCON_MAX14577=m
 CONFIG_EXTCON_MAX77693=m
 CONFIG_EXTCON_MAX8997=m
 CONFIG_TI_AEMIF=y
+CONFIG_EXYNOS5422_DMC=m
 CONFIG_IIO=y
 CONFIG_IIO_SW_TRIGGER=y
 CONFIG_ASPEED_ADC=m
-- 
2.17.1

