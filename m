Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B4CC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8574F214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbfFSM4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:56:05 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:38119 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfFSM4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:56:04 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mna0x-1iN3th1WTd-00jb2X; Wed, 19 Jun 2019 14:55:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: exynos: only build mcpm support if used
Date:   Wed, 19 Jun 2019 14:55:29 +0200
Message-Id: <20190619125545.1087023-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8lSv7z+Az3irPtD3mBB1X3CyVNiokLNe5prcDUQOA+DJCgdNyTg
 5HSfU0ojjXGl3H8v+ZOW1BF3QjWfGmLd45HQYerFQo1hF6TOJzjmg6CkfWrDRye+Rzi8qBH
 /T/44D9/lYapFuhEwutzgfKwYjiA+hdiwTmPO8CETObOh3B+m5z9ouWT/F2LMF72K5FF4RV
 3C2EoYdsB4fpZ7kUqHWHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rtxPUz4OOkQ=:fDfYCbeOzs7Zzr9OmJxvjt
 yyB51ipVi9MfHI95lXT3mMbcckRT44/OfhgO/r8f/AiyrzQyXzaQn44vC3PeuNqLnrz+zKklE
 2mp4HStkOI0sZZ3PZqkzHIkRDMvKaR+RW7SRv/CrzoPRnh9R8I5MFA8G7ZV8cuXegPXp+z3i4
 80rK0Q1MT1RGT2oFiP7i7JB0ntt4u9x7hO55iWlSChLooK3AbPpbX52fngBz7xBELYhz11Dox
 tZFYgHdvr/YIR92bEYwobWpOGYoFjjXnJyRyC++Wmz3qhbmAaxoSnxhDVbA83VxrlWbwplf80
 tC0EFzKa/8MWTQqI6YwZEDwPB15n32VZtxHyfLPfG9nKKpMRaTDM032HVXWjgYB0fpkeoVBc5
 7BGwvvwsNNhKDCwzLmW5gg8hlsxqpwsKE09Ayv8jpixGgyKx9PWTu4KLMs8QdiCi4CzCtbKjw
 xOtIJjw8LelXoTVhPJUW77gWUsB3DV1pDXnbRjPSew3jxOmvaYqNS/ZEkG2dYGVwFDPWg9QEP
 T67FlDy2N9tapg8l7NA2nKo5VX4JydvE94f9TwFTVl36Yij/JggC3q6Qy2c7Zil139XbUI6gT
 0NZNubaTFeDdIqeji6In7y/qj/j+kpCpvKqrQKvjwpDITPUmuuxjnTA7Q2ExUu6jwyc8wsR6o
 do/Cl7vDEhdSHQU5IXkcA+/wqOofmQLi+6H28GTyxykr1XNboFaj/MZIGBXWbUo95zs82n0+O
 5z1/97vGrraG7S9A6ibHFYEdxNQmrzy5K4aFnw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a link error for configurations that enable an exynos
SoC that does not require mcpm, but then manually enable
mcpm anyway wihtout also turning on the arm-cci:

arch/arm/mach-exynos/mcpm-exynos.o: In function `exynos_pm_power_up_setup':
mcpm-exynos.c:(.text+0x8): undefined reference to `cci_enable_port_for_self'

Change it back to only build the code we actually need, by
introducing a CONFIG_EXYNOS_MCPM that serves the same purpose
as the older CONFIG_EXYNOS5420_MCPM.

Fixes: 2997520c2d4e ("ARM: exynos: Set MCPM as mandatory for Exynos542x/5800 SoCs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-exynos/Kconfig   | 6 +++++-
 arch/arm/mach-exynos/Makefile  | 2 +-
 arch/arm/mach-exynos/suspend.c | 6 +++---
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 21ad78d79d8d..d7422233a130 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -107,7 +107,7 @@ config SOC_EXYNOS5420
 	bool "SAMSUNG EXYNOS5420"
 	default y
 	depends on ARCH_EXYNOS5
-	select MCPM if SMP
+	select EXYNOS_MCPM if SMP
 	select ARM_CCI400_PORT_CTRL
 	select ARM_CPU_SUSPEND
 
@@ -116,6 +116,10 @@ config SOC_EXYNOS5800
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
index 264dbaa89c3d..5abf3db23912 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -18,5 +18,5 @@ plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
 AFLAGS_sleep.o			:=-Wa,-march=armv7-a$(plus_sec)
 
-obj-$(CONFIG_MCPM)		+= mcpm-exynos.o
+obj-$(CONFIG_EXYNOS_MCPM)	+= mcpm-exynos.o
 CFLAGS_mcpm-exynos.o		+= -march=armv7-a
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index be122af0de8f..8b1e6ab8504f 100644
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
2.20.0

