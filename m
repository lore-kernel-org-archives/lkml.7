Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A48C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4472A2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570550632;
	bh=xp63xfZYYr/4fmyY0e7gVnsIupMIVgJn/wfEy+/uzo0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G0vYefuaL8yFE3LJFOQmc72uMwuSsWGSph8eHtNJC+jqc7vqMYRmUhx98vO/1k5jT
	 frcQbvXqwsL+ReEk3RfCA2GYXu38sKBU3JHM8m3ugnIpxDSm4XYqI8Nb8USpKcvOS3
	 nnxlpRWBYGtGDWy0+gZ9MhxdorUiSSi02RVKMGm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfJHQDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 12:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728798AbfJHQDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:03:51 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23C7220815;
        Tue,  8 Oct 2019 16:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570550630;
        bh=xp63xfZYYr/4fmyY0e7gVnsIupMIVgJn/wfEy+/uzo0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=srdp3UkqTynIKaJp97COCjhIllE2c/LfCKPCvMFPbsuk5oBalWqnBaGIobfVakVVO
         5YyZlg8mSQOxAvWueGwIZZCC10o3SjXBpfo7gwrhSPQvkISbc0WQlcpjcIekzSB6Re
         /rQXg9uOaxo0UKx+vu4azK9JwFnUZbjqxcjgoyos=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 2/2] ARM: multi_v7_defconfig: Enable Exynos bus and memory frequency scaling (devfreq)
Date:   Tue,  8 Oct 2019 18:02:34 +0200
Message-Id: <20191008160234.3106-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008160234.3106-1-krzk@kernel.org>
References: <20191008160234.3106-1-krzk@kernel.org>
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

Changes since v1:
None
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index d576845acd6f..55fcc53a677a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -978,11 +978,14 @@ CONFIG_ARCH_TEGRA_2x_SOC=y
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

