Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CABCC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AEF20833
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yv73NxI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfLDPjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:39:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33908 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbfLDPjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:39:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id f4so5122163wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=v9aPs/wpi2L5/d1FqkD06cZ03HNvyIimtXPANJEaaic=;
        b=Yv73NxI2i/49vDu9InO7rsocVrEzs/pBK32Etx2/SRVL8T0kjo8vJhE68rp0tiWbhR
         TN8smksr1qo5jOSXE0ktqPNSd1/1dRMfTE8+SS8Bpi6KTZiRYN30m4WydmYSJamc2lRa
         h7Q72QkNuo+V1taaUC0pltB9ygR1YXD9vcnVa9DsgK+5AkoSGpjoBUSSSb4Msde00w3r
         9bLseDoQ7cRk3pYamuekA9GBoLgpn/1m+9JfY5RTnzalwp7L5fRiSrOQyjsz0lt0Kv/a
         29yZVw5lyWcz+KydY3Bj9fo5ANJKePNhagEJ4ZKA5elxZfZU8tNWzwcQNWbRfazvixSJ
         P2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v9aPs/wpi2L5/d1FqkD06cZ03HNvyIimtXPANJEaaic=;
        b=cDJRGHbNrsKlyu9vtwrqFeHSPaU2DhJowdLTfQ9DNYsWcHXH+0bS4wj5OP7gScRpaV
         bai0MAoi0hbjju2tAKKmw4gk9yaBlZzzTaQhF9jiFsMWQgl8rTAgRRfuHRfhhs+opNod
         5dRxvmnKwXMKl6QKP89hi9gCBxob9byoAdTJSIEDJZjPbRJyqshCAvnSdCWbWyDHcWwu
         38lYcnIJbAqTLI0KXVNIkZ7B886uh1oEUEhKe+p4c5d8EXFU+y4qAxrTgoJqEYTAvvZG
         jTuQhj3+NEprPA+ajfxdla1CFRuS+xLf1sz77ayNcXoYx8OGxBFiaPn4OBVrms6RYOzE
         ujiQ==
X-Gm-Message-State: APjAAAVCCarTgDOBgYRRIUWDLkealPZF+7dBBn/44pZd2XdXTzMQWiR/
        n7MOexzUr8UnVbaVmlCRmKWOqw==
X-Google-Smtp-Source: APXvYqyzXzSi1Dz2RNTWyd9doTVH9IyNsDx+aJ7PDILfFl6RXuMp6CpgceH65/s/1y3foQ3tHpn8xg==
X-Received: by 2002:a1c:a98e:: with SMTP id s136mr112577wme.140.1575473981990;
        Wed, 04 Dec 2019 07:39:41 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:a551:321a:c21f:1f92])
        by smtp.gmail.com with ESMTPSA id f1sm8631311wrp.93.2019.12.04.07.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:39:41 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/4] thermal/drivers/Kconfig: Convert the CPU cooling device to a choice
Date:   Wed,  4 Dec 2019 16:39:27 +0100
Message-Id: <20191204153930.9128-1-daniel.lezcano@linaro.org>
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

