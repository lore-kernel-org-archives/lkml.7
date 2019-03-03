Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C836C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6096D20818
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ett46jcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfCCRNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:13:40 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36842 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfCCRNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:13:40 -0500
Received: by mail-pg1-f195.google.com with SMTP id r124so1354038pgr.3;
        Sun, 03 Mar 2019 09:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nazjdaxsj9lmT9Vl6H8Rm89SYIfCC9VqRFy4LFo9W5w=;
        b=ett46jcBrstaPoGr+OcvcNG3g5Nqx3vsgVaTU45463dLWKaiPXYfxffSCLbACTusVx
         PS05tflZftj9Q5WBja0o29O4sYLfpeHjxGFIFwGyqm+VCHCwKcQno5Xge5L6f1s4Hb5T
         N5n4/yQWvKNQ9oa2lCfkIIBonYJ5fc39XvKwIRExFeiXeRwJxTyXsOByimLsxWJniVPh
         sPaL6DX06o+VHjxHD/7EzpWGi9iJGsj+AsL0CZWenBD5+9KLqAlza2iPXm/g5a1XxZCX
         Ll2BtVPm6Z1Ci1BtZeaTSkSTRYEONL+fdHQAJ4Q3pcbjg/jZhjT9tybii+cssFeW2yHW
         ZSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nazjdaxsj9lmT9Vl6H8Rm89SYIfCC9VqRFy4LFo9W5w=;
        b=rKikUJ1Y2FrKUB9fJZRlFwctsxaxarBvYuq9xEWf3rwTzQ+6YUTUDi/kOiPDRhP7RM
         ZYf+hJMJPQ3aHDqwfGmHJ76PxEf8OSnOCBMuWMVM8/7n40YxL+dOCHP7hIVpguuy+i64
         4JS0geWz0YjeylYdkizwO4vM4aw5CTm3L97d3KTExxqxMVwUqcwtOjcXJQmbi+OlERun
         uA0R5XLZo0y2tA8NlIfQ3pyFqApEz2xb5gdKkQYTbymcRhoxcds+MF2Hax6q3x8kbQ2W
         xddqWdeORAmHmBXa/YYIRZMbnYypAO7DqHaWuIKKFxvyWU26hNq+AmCnOAwH3TNrsWNM
         opUQ==
X-Gm-Message-State: APjAAAXjUb7HFRIL1Bx5tIxt+x4T2Tl5kFgA2Tu7X9OLPgnJTTaCW4Yn
        e/Ec2TsZ88po+64Jnz1Rus4=
X-Google-Smtp-Source: APXvYqxUgeWZMbINYs2QBq007Og5WRVCUI9Pm32mGYmR6jbN5jXkWaCvP1QqAXU8UWEfQ6RZSUKeAw==
X-Received: by 2002:a63:4c18:: with SMTP id z24mr14761857pga.62.1551633219084;
        Sun, 03 Mar 2019 09:13:39 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id e22sm5349412pfi.126.2019.03.03.09.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 09:13:37 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/7] ARM: trusted_foundations: Make prepare_idle call to take mode argument
Date:   Sun,  3 Mar 2019 20:12:09 +0300
Message-Id: <20190303171214.24821-3-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190303171214.24821-1-digetx@gmail.com>
References: <20190303171214.24821-1-digetx@gmail.com>
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
index d5d1b7efa02e..40445389ffe7 100644
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

