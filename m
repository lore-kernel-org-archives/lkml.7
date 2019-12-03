Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508A0C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E4620661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UO5bhFxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfLCJhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:37:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44352 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfLCJhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:37:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so2710867wrm.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 01:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=v9aPs/wpi2L5/d1FqkD06cZ03HNvyIimtXPANJEaaic=;
        b=UO5bhFxtDW+Yhtt76FWIlSYlZjTVcz3TshtsNuRV/UPdlkYfWUpmJjmE9LchizUrZU
         wCdGmXa/c4WBeOrnh0ueMXSGy11K8bDqCYzH82FJgOzU/+xwDKU6+3aGexyCVbTyPGvm
         MjAOko08FJyTVOXFEnRG2vLiTcNIVYMhy6t1mfJeatE66cVYBhp73AjBOtLbRGBuGhWk
         kUqt51i6SfdlrIDmGX3khX6/Owm/uhw0zA3lMAJ4nr4y5xUeAJNzPLZMHE5xSvuGQdel
         4/9lqadTADcsVtVAzqmM5Usco+DUDuQA5eU+XxItYOot0U3e8pWz3OyimG6G0PthVkmR
         7/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v9aPs/wpi2L5/d1FqkD06cZ03HNvyIimtXPANJEaaic=;
        b=WUX8Y9r7KipzVEtTMHMI4L33xwQZjv5SChrqpMScHZx0larLKC2vYE/qC9kxpweLCx
         F6+aSGIIo5mLpsG6vSP5oOMV2hqaa40Vbx8unbwyYRgCRRKkqXDfszAk01efjNY3Zm1T
         Ux7kFvrdJq8MlHv2kptSU6HXGuL/ydrcsbXIwo1mQS1Qely939Ce6bk6ceXKOD5RfATt
         wOcXqIpIHXdSpSi3KMt47lKGvI0z75BkwnG8AdQFLRQJIkVQO4J/znKOX/EZ+NTJecNp
         F/gBmB1/CIQAm0IWFQgDgcwbnk6jckeKEzKyXKGsC55Cq1svSVNCvGpocJs1tO9Ut0nv
         kzCw==
X-Gm-Message-State: APjAAAU/rB99O8BJZEZ8+GVM4Qsu7juOE2wTfNDRkwojwpIA1cekaa+X
        mWEu8zsfyOsGgVIOq/VN51X5XQ==
X-Google-Smtp-Source: APXvYqyciia4aYAIG8fMfAHSsdXZfaxnHQ0iL6ucE1f1unnBidOhAr0gju8Fey54UdXU/ImqbbyLTQ==
X-Received: by 2002:adf:f1d0:: with SMTP id z16mr3903327wro.209.1575365831350;
        Tue, 03 Dec 2019 01:37:11 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:8196:cbcc:fb2c:4975])
        by smtp.gmail.com with ESMTPSA id w13sm2935751wru.38.2019.12.03.01.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 01:37:10 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org, rui.zhang@intel.com
Cc:     rjw@rjwysocki.net, edubezval@gmail.com, linux-pm@vger.kernel.org,
        amit.kucheria@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/4] thermal/drivers/Kconfig: Convert the CPU cooling device to a choice
Date:   Tue,  3 Dec 2019 10:37:01 +0100
Message-Id: <20191203093704.7037-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next changes will add a new way to cool down a CPU by injecting
idle cycles. With the current configuration, a CPU cooling device is
the cpufreq cooling device. As we want to add a new CPU cooling
device, let's convert the CPU cooling to a choice giving a list of CPU
cooling devices. At this point, there is obviously only one CPU
cooling device.

There is no functional changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
  V2:
    - Default CPU_FREQ_COOLING when CPU_THERMAL is set (Viresh Kumar)
---
 drivers/thermal/Kconfig     | 14 ++++++++++++--
 drivers/thermal/Makefile    |  2 +-
 include/linux/cpu_cooling.h |  6 +++---
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 001a21abcc28..4e3ee036938b 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -150,8 +150,18 @@ config THERMAL_GOV_POWER_ALLOCATOR
 
 config CPU_THERMAL
 	bool "Generic cpu cooling support"
-	depends on CPU_FREQ
 	depends on THERMAL_OF
+	help
+	  Enable the CPU cooling features. If the system has no active
+	  cooling device available, this option allows to use the CPU
+	  as a cooling device.
+
+if CPU_THERMAL
+
+config CPU_FREQ_THERMAL
+	bool "CPU frequency cooling device"
+	depends on CPU_FREQ
+	default y
 	help
 	  This implements the generic cpu cooling mechanism through frequency
 	  reduction. An ACPI version of this already exists
@@ -159,7 +169,7 @@ config CPU_THERMAL
 	  This will be useful for platforms using the generic thermal interface
 	  and not the ACPI interface.
 
-	  If you want this support, you should say Y here.
+endif
 
 config CLOCK_THERMAL
 	bool "Generic clock cooling support"
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 74a37c7f847a..d3b01cc96981 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -19,7 +19,7 @@ thermal_sys-$(CONFIG_THERMAL_GOV_USER_SPACE)	+= user_space.o
 thermal_sys-$(CONFIG_THERMAL_GOV_POWER_ALLOCATOR)	+= power_allocator.o
 
 # cpufreq cooling
-thermal_sys-$(CONFIG_CPU_THERMAL)	+= cpu_cooling.o
+thermal_sys-$(CONFIG_CPU_FREQ_THERMAL)	+= cpu_cooling.o
 
 # clock cooling
 thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index b74732535e4b..3cdd85f987d7 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -19,7 +19,7 @@
 
 struct cpufreq_policy;
 
-#ifdef CONFIG_CPU_THERMAL
+#ifdef CONFIG_CPU_FREQ_THERMAL
 /**
  * cpufreq_cooling_register - function to create cpufreq cooling device.
  * @policy: cpufreq policy.
@@ -40,7 +40,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
 struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct cpufreq_policy *policy);
 
-#else /* !CONFIG_CPU_THERMAL */
+#else /* !CONFIG_CPU_FREQ_THERMAL */
 static inline struct thermal_cooling_device *
 cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
@@ -58,6 +58,6 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
 	return NULL;
 }
-#endif /* CONFIG_CPU_THERMAL */
+#endif /* CONFIG_CPU_FREQ_THERMAL */
 
 #endif /* __CPU_COOLING_H__ */
-- 
2.17.1

