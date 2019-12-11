Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061D4C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CEC20836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 22:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0n4QzR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfLKWoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:44:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34949 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfLKWoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 17:44:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so483651wro.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 14:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sBcrCTViVT+buUkazP6ndZ+R56LFcmai8/NG1/x431U=;
        b=B0n4QzR+8Dn/PNjTG+BqYKuWbD7QPHneTDLFVbLSZ2vbKcCA8M0sPy1gbo7O2ooZPv
         81yQDTKkSE5CACbD71h/ZRug72pThiHj68475hZLEbnQS4D9qYhGm+/+4ZcAJ224d03+
         sKe+LTGrbqsqKUtyjtfLVzngNo65pmDx4kPQS+Lb2Fe+zBeNyVBerBw/1PfAuy9ksv/9
         WCGhsGUoDHWvVSR52Y3IHoie5IVwAp9RyMAUVJmdiJ9/DxUtqKA8eBduUWskwkbWM1oN
         i2g0qGyQ/wkpVeRmfQZAlmlccmsYXUH/jmHpllykYndBPlcoup6xnCznmwTe9zkhPGJC
         duuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sBcrCTViVT+buUkazP6ndZ+R56LFcmai8/NG1/x431U=;
        b=bcT68drDY/duermakVj5FVmt5gEvOfB3L7pYxtfJpExWshFm/d/rUKo0vJAs1tPdvR
         FoeHkMBwjLeGkJHbw+ZESz8PT9c4KvHrcf14dpUIG+OScJ3ldPhsYAb00NUDJ1IG03Z7
         mEHSdUp5O11aIecdpoipuThLQvEpb5h4vHukRM9ZUCHVycMrYNWGNHdVMVZiHiFGKlA5
         DbJz1585NHXKs1JbaUuDfllKERIcZ0JrbZzw7exUVAW1jY/JgAbh2cIFYCpNI+BGfOmt
         HLYhK/elBH98fDn0LNS9KHP+94YqporruHXwYKDuBzRaP2qeyHCKVfgcMcmlxXN6y5g0
         el9g==
X-Gm-Message-State: APjAAAXotGoVA0osjEUQ7qEpctzWwWJToiImiw5or4WWvT3VaaUsjGzr
        W9k7ZlT9JvwfwD3z6sQyZaDw7g==
X-Google-Smtp-Source: APXvYqz4GwmnjA7mmxVpsbblUSVVcWN4dL2VXX9f+0XX77fYyTKNWiKW4FuKn2UvcmWm6MdGH0hMKA==
X-Received: by 2002:adf:9144:: with SMTP id j62mr2300204wrj.168.1576104243820;
        Wed, 11 Dec 2019 14:44:03 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:48f7:48fb:71cb:f13a])
        by smtp.gmail.com with ESMTPSA id s16sm3798809wrn.78.2019.12.11.14.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 14:44:03 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org, martin.kepplinger@puri.sm
Subject: [PATCH V5 3/3] thermal/drivers/cpu_cooling: Rename to cpufreq_cooling
Date:   Wed, 11 Dec 2019 23:43:47 +0100
Message-Id: <20191211224347.1001-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211224347.1001-1-daniel.lezcano@linaro.org>
References: <20191211224347.1001-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we introduced the idle injection cooling device called
cpuidle_cooling, let's be consistent and rename the cpu_cooling to
cpufreq_cooling as this one mitigates with OPPs changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
---
  V4:
    - Added Acked-by and Reviewed-by
  V3:
    - Fix missing name conversion (Viresh Kumar)
---
 Documentation/driver-api/thermal/exynos_thermal.rst  | 2 +-
 MAINTAINERS                                          | 2 +-
 drivers/thermal/Makefile                             | 2 +-
 drivers/thermal/clock_cooling.c                      | 2 +-
 drivers/thermal/{cpu_cooling.c => cpufreq_cooling.c} | 6 +++---
 include/linux/clock_cooling.h                        | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)
 rename drivers/thermal/{cpu_cooling.c => cpufreq_cooling.c} (99%)

diff --git a/Documentation/driver-api/thermal/exynos_thermal.rst b/Documentation/driver-api/thermal/exynos_thermal.rst
index 5bd556566c70..d4e4a5b75805 100644
--- a/Documentation/driver-api/thermal/exynos_thermal.rst
+++ b/Documentation/driver-api/thermal/exynos_thermal.rst
@@ -67,7 +67,7 @@ TMU driver description:
 The exynos thermal driver is structured as::
 
 					Kernel Core thermal framework
-				(thermal_core.c, step_wise.c, cpu_cooling.c)
+				(thermal_core.c, step_wise.c, cpufreq_cooling.c)
 								^
 								|
 								|
diff --git a/MAINTAINERS b/MAINTAINERS
index d92e9eb14131..0d658a628296 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16337,7 +16337,7 @@ L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/driver-api/thermal/cpu-cooling-api.rst
 F:	Documentation/driver-api/thermal/cpu-idle-cooling.rst
-F:	drivers/thermal/cpu_cooling.c
+F:	drivers/thermal/cpufreq_cooling.c
 F:	drivers/thermal/cpuidle_cooling.c
 F:	include/linux/cpu_cooling.h
 
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 6929e6fad1ac..d502a597a717 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -19,7 +19,7 @@ thermal_sys-$(CONFIG_THERMAL_GOV_USER_SPACE)	+= user_space.o
 thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)	+= power_allocator.o
 
 # cpufreq cooling
-thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpu_cooling.o
+thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpufreq_cooling.o
 thermal_sys-$(CONFIG_CPU_IDLE_THERMAL)	+= cpuidle_cooling.o
 
 # clock cooling
diff --git a/drivers/thermal/clock_cooling.c b/drivers/thermal/clock_cooling.c
index 3ad3256c48fd..7cb3ae4b44ee 100644
--- a/drivers/thermal/clock_cooling.c
+++ b/drivers/thermal/clock_cooling.c
@@ -7,7 +7,7 @@
  *  Copyright (C) 2013	Texas Instruments Inc.
  *  Contact:  Eduardo Valentin <eduardo.valentin@ti.com>
  *
- *  Highly based on cpu_cooling.c.
+ *  Highly based on cpufreq_cooling.c.
  *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
  *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
  */
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpufreq_cooling.c
similarity index 99%
rename from drivers/thermal/cpu_cooling.c
rename to drivers/thermal/cpufreq_cooling.c
index 52569b27b426..1dcba6bcaf7b 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  linux/drivers/thermal/cpu_cooling.c
+ *  linux/drivers/thermal/cpufreq_cooling.c
  *
  *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
  *
@@ -620,7 +620,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 	struct thermal_cooling_device *cdev = NULL;
 
 	if (!np) {
-		pr_err("cpu_cooling: OF node not available for cpu%d\n",
+		pr_err("cpufreq_cooling: OF node not available for cpu%d\n",
 		       policy->cpu);
 		return NULL;
 	}
@@ -630,7 +630,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 
 		cdev = __cpufreq_cooling_register(np, policy, em);
 		if (IS_ERR(cdev)) {
-			pr_err("cpu_cooling: cpu%d failed to register as cooling device: %ld\n",
+			pr_err("cpufreq_cooling: cpu%d failed to register as cooling device: %ld\n",
 			       policy->cpu, PTR_ERR(cdev));
 			cdev = NULL;
 		}
diff --git a/include/linux/clock_cooling.h b/include/linux/clock_cooling.h
index b5cebf766e02..4b0a69863656 100644
--- a/include/linux/clock_cooling.h
+++ b/include/linux/clock_cooling.h
@@ -7,7 +7,7 @@
  *  Copyright (C) 2013	Texas Instruments Inc.
  *  Contact:  Eduardo Valentin <eduardo.valentin@ti.com>
  *
- *  Highly based on cpu_cooling.c.
+ *  Highly based on cpufreq_cooling.c.
  *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
  *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
  */
-- 
2.17.1

