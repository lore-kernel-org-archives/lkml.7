Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C569C10F05
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 22:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D612214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 22:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sv+rK1y5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfCQWzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 18:55:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45140 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfCQWzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 18:55:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so801095pgk.12;
        Sun, 17 Mar 2019 15:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GW0CJWrCEGpuTDu8JaGzJeC7YDvChX9uFBrKnKEZVBA=;
        b=sv+rK1y5xzW9mhrWvbgSjlJEXgHP20APMLfab+9HoNTt53IOXTXU2LpTsgzocI8r38
         4f6H3BvW+B9BBfLrhZorTU6EiUjuDozASo9sdNH/cvKqQjRDRZPBFzL8xBQTAlMUCXLF
         TiyPz5zOt/iPgfA1Onz7vR4BAdpfTDRhrs9FydZsUuR2jnUvR3AdtDd2rAsdXNXPlOV9
         4D6fjxwWlAg5rBAtMoZamrpCkWaMn8kASvyBsLmgi5sfzaCf8KUkdTPwBzr7MVfj4M1v
         vD0hzAx3Jkt8KkkHpfeToXStUzTbbzhmP0GQBps1LFpnDJS9xFgM5Os2CmRAA8RBNiAO
         Wpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GW0CJWrCEGpuTDu8JaGzJeC7YDvChX9uFBrKnKEZVBA=;
        b=umc4EmtYOAalF5JyzC+PbJv8wdt/Joto1SDvmrDoOmaRmWz5w4wAsmnM81uGp06MHJ
         6Hq5x/NupWsNrtXQNTF0v+Os/y3xRPN0xOlabZTthjfG6PhcJEECl9FS4Jt9WnMAIT4U
         3jcm9hb1aISIDFak6HU9omEa/aQzxDqA24mQRjUVFoeFoSYfkyKmxmvbII14afvKdKzV
         Gb4LrvvmkA4xVwnUmNxeVmqYNiYoS5DZvPE4tDDmNqK/6aktYDhTFsD5sL9Lp+IDKFAL
         fjKvmnm4W86SC+uYTeGPUoCJfRIuPLpMAvgfxyhewOhSlailJ0cYxzzM7zgFlR/baHEm
         P+Ig==
X-Gm-Message-State: APjAAAWAcz0ch4maycdhFDPK5+ukmgR+bGSBAZbOAihEGQN5ABblS672
        VfrW6GtSDdZBCMwpGQIFHxU=
X-Google-Smtp-Source: APXvYqzqktU5qj7d4vKKC7/iiSYG/lgW+0X+5nLieaLzGJ8atcp2XBicOQfYf9eDAZg4LSnzcgly1Q==
X-Received: by 2002:a17:902:bd87:: with SMTP id q7mr16420755pls.227.1552863342532;
        Sun, 17 Mar 2019 15:55:42 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-37-86.pppoe.spdop.ru. [94.29.37.86])
        by smtp.gmail.com with ESMTPSA id v2sm13738838pfg.118.2019.03.17.15.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 15:55:41 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/7] ARM: trusted_foundations: Make prepare_idle call to take mode argument
Date:   Mon, 18 Mar 2019 01:52:05 +0300
Message-Id: <20190317225211.23091-3-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190317225211.23091-1-digetx@gmail.com>
References: <20190317225211.23091-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Trusted Foundations firmware call varies depending on the required
suspend-mode. Make the firmware API to take the mode argument in order
to expose all of the modes to firmware user.

Tested-by: Robert Yang <decatf@gmail.com>
Tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/firmware/trusted_foundations.c    | 29 ++++++++++++++++++++--
 arch/arm/include/asm/firmware.h            |  2 +-
 arch/arm/include/asm/trusted_foundations.h |  6 +++++
 arch/arm/mach-tegra/cpuidle-tegra114.c     |  3 ++-
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index d7ac05103a52..720904a43c00 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -67,9 +67,34 @@ static int tf_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
 	return 0;
 }
 
-static int tf_prepare_idle(void)
+static int tf_prepare_idle(unsigned long mode)
 {
-	tf_generic_smc(TF_CPU_PM, TF_CPU_PM_S1_NOFLUSH_L2, cpu_boot_addr);
+	switch (mode) {
+	case TF_PM_MODE_LP0:
+		tf_generic_smc(TF_CPU_PM, TF_CPU_PM_S3, cpu_boot_addr);
+		break;
+
+	case TF_PM_MODE_LP1:
+		tf_generic_smc(TF_CPU_PM, TF_CPU_PM_S2, cpu_boot_addr);
+		break;
+
+	case TF_PM_MODE_LP1_NO_MC_CLK:
+		tf_generic_smc(TF_CPU_PM, TF_CPU_PM_S2_NO_MC_CLK,
+			       cpu_boot_addr);
+		break;
+
+	case TF_PM_MODE_LP2:
+		tf_generic_smc(TF_CPU_PM, TF_CPU_PM_S1, cpu_boot_addr);
+		break;
+
+	case TF_PM_MODE_LP2_NOFLUSH_L2:
+		tf_generic_smc(TF_CPU_PM, TF_CPU_PM_S1_NOFLUSH_L2,
+			       cpu_boot_addr);
+		break;
+
+	default:
+		return -EINVAL;
+	}
 
 	return 0;
 }
diff --git a/arch/arm/include/asm/firmware.h b/arch/arm/include/asm/firmware.h
index 34c1d96ef46d..6698272bbcbf 100644
--- a/arch/arm/include/asm/firmware.h
+++ b/arch/arm/include/asm/firmware.h
@@ -24,7 +24,7 @@ struct firmware_ops {
 	/*
 	 * Inform the firmware we intend to enter CPU idle mode
 	 */
-	int (*prepare_idle)(void);
+	int (*prepare_idle)(unsigned long mode);
 	/*
 	 * Enters CPU idle mode
 	 */
diff --git a/arch/arm/include/asm/trusted_foundations.h b/arch/arm/include/asm/trusted_foundations.h
index 9e6a41e9215e..201ceb259e71 100644
--- a/arch/arm/include/asm/trusted_foundations.h
+++ b/arch/arm/include/asm/trusted_foundations.h
@@ -35,6 +35,12 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/outercache.h>
 
+#define TF_PM_MODE_LP0			0
+#define TF_PM_MODE_LP1			1
+#define TF_PM_MODE_LP1_NO_MC_CLK	2
+#define TF_PM_MODE_LP2			3
+#define TF_PM_MODE_LP2_NOFLUSH_L2	4
+
 struct trusted_foundations_platform_data {
 	unsigned int version_major;
 	unsigned int version_minor;
diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
index e3fbcfedf845..3b9af4766cdf 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -24,6 +24,7 @@
 #include <asm/cpuidle.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
+#include <asm/trusted_foundations.h>
 #include <asm/psci.h>
 
 #include "cpuidle.h"
@@ -46,7 +47,7 @@ static int tegra114_idle_power_down(struct cpuidle_device *dev,
 	tegra_set_cpu_in_lp2();
 	cpu_pm_enter();
 
-	call_firmware_op(prepare_idle);
+	call_firmware_op(prepare_idle, TF_PM_MODE_LP2_NOFLUSH_L2);
 
 	/* Do suspend by ourselves if the firmware does not implement it */
 	if (call_firmware_op(do_idle, 0) == -ENOSYS)
-- 
2.20.1

