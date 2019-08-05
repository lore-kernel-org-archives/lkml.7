Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC48C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EF720651
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011824;
	bh=4ZLHD2TpGOEkDq8sE25lZdSIXZweCoMcXKT+jMzc7gY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wINlvBWQMguc3eQtk+MIay0Lgrf5YeGgz8KCLscAU0KRf4mWlQPj4x66z12VMZKs9
	 F7u0AuqJeJJ5/h5j54rKjChGA7VzgbbCICz3XwLvTZDskjfUtvSVkOocwQm+X5tTO7
	 AN1W9bWGgvXidkpH24+3+mQPM6zfUTJX8S08mLXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbfHENUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730336AbfHENUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:20:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 007C52173B;
        Mon,  5 Aug 2019 13:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011248;
        bh=4ZLHD2TpGOEkDq8sE25lZdSIXZweCoMcXKT+jMzc7gY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kBdx9bgcsL0FBbYVOsvFTO+CEGqbXrswmNZJXsgKaONpNco+eZblzvATFS6Jfm9XF
         qnCO7YTn3nqD9U23pYpqAcO6zZ9ficcQW9G2P2j9NBdt6KX/tQJPbJjnAHqpxEUOPO
         Z/M8/eSBCNm52eefag/18PJ2bJ5LB5o2pzYj2coY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 021/131] ARM: exynos: Only build MCPM support if used
Date:   Mon,  5 Aug 2019 15:01:48 +0200
Message-Id: <20190805124952.858280053@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124951.453337465@linuxfoundation.org>
References: <20190805124951.453337465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 24d2c73ff28bcda48607eacc4bc804002dbf78d9 ]

We get a link error for configurations that enable an Exynos
SoC that does not require MCPM, but then manually enable
MCPM anyway without also turning on the arm-cci:

arch/arm/mach-exynos/mcpm-exynos.o: In function `exynos_pm_power_up_setup':
mcpm-exynos.c:(.text+0x8): undefined reference to `cci_enable_port_for_self'

Change it back to only build the code we actually need, by
introducing a CONFIG_EXYNOS_MCPM that serves the same purpose
as the older CONFIG_EXYNOS5420_MCPM.

Fixes: 2997520c2d4e ("ARM: exynos: Set MCPM as mandatory for Exynos542x/5800 SoCs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-exynos/Kconfig   | 6 +++++-
 arch/arm/mach-exynos/Makefile  | 2 +-
 arch/arm/mach-exynos/suspend.c | 6 +++---
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 1c518b8ee520c..21a59efd1a2c4 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -106,7 +106,7 @@ config SOC_EXYNOS5420
 	bool "SAMSUNG EXYNOS5420"
 	default y
 	depends on ARCH_EXYNOS5
-	select MCPM if SMP
+	select EXYNOS_MCPM if SMP
 	select ARM_CCI400_PORT_CTRL
 	select ARM_CPU_SUSPEND
 
@@ -115,6 +115,10 @@ config SOC_EXYNOS5800
 	default y
 	depends on SOC_EXYNOS5420
 
+config EXYNOS_MCPM
+	bool
+	select MCPM
+
 config EXYNOS_CPU_SUSPEND
 	bool
 	select ARM_CPU_SUSPEND
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 264dbaa89c3db..5abf3db23912b 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -18,5 +18,5 @@ plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
 AFLAGS_sleep.o			:=-Wa,-march=armv7-a$(plus_sec)
 
-obj-$(CONFIG_MCPM)		+= mcpm-exynos.o
+obj-$(CONFIG_EXYNOS_MCPM)	+= mcpm-exynos.o
 CFLAGS_mcpm-exynos.o		+= -march=armv7-a
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index be122af0de8f8..8b1e6ab8504f0 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -268,7 +268,7 @@ static int exynos5420_cpu_suspend(unsigned long arg)
 	unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 	unsigned int cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 
-	if (IS_ENABLED(CONFIG_MCPM)) {
+	if (IS_ENABLED(CONFIG_EXYNOS_MCPM)) {
 		mcpm_set_entry_vector(cpu, cluster, exynos_cpu_resume);
 		mcpm_cpu_suspend();
 	}
@@ -351,7 +351,7 @@ static void exynos5420_pm_prepare(void)
 	exynos_pm_enter_sleep_mode();
 
 	/* ensure at least INFORM0 has the resume address */
-	if (IS_ENABLED(CONFIG_MCPM))
+	if (IS_ENABLED(CONFIG_EXYNOS_MCPM))
 		pmu_raw_writel(__pa_symbol(mcpm_entry_point), S5P_INFORM0);
 
 	tmp = pmu_raw_readl(EXYNOS_L2_OPTION(0));
@@ -455,7 +455,7 @@ static void exynos5420_prepare_pm_resume(void)
 	mpidr = read_cpuid_mpidr();
 	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 
-	if (IS_ENABLED(CONFIG_MCPM))
+	if (IS_ENABLED(CONFIG_EXYNOS_MCPM))
 		WARN_ON(mcpm_cpu_powered_up());
 
 	if (IS_ENABLED(CONFIG_HW_PERF_EVENTS) && cluster != 0) {
-- 
2.20.1



