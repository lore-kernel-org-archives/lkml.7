Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C94FC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55B42075E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 21:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XVUwEFJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfF0VC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 17:02:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54046 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfF0VC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 17:02:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so7035430wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 14:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Jb+mp+rDj9DLSvOVTi217/rhPZn5ckg46P7fvQWw8bI=;
        b=XVUwEFJc76EMd/mccv9X0ByGbh5iraSJs6Fk0OV4yyos19CgBVM6X+EZu2DTrk15MH
         QFIul6likq8ngMyjhWhD9ZKaSzO4OGFTtnzLfQ0BMr5m9PKCKS3ebXdYFnehLUzI/vyY
         x7rQ0QPKjDy+HN1XV6GX0gyAJSE71tT1JY7wmarTtdJaZqq6oQZlHF5cxGpNCuU3Rgsd
         cT7Raw8bQg9MRKwBjIppz0fN/3MDThple+CpwnWebHEDxHeiX1R+WFtwt40jZSPqwN5t
         ca7dvDZq2t09/d5KGzLjFVfxZIqoed/K9rK7QxYmOnkoPfKtfgcrPu6PvAfe8kSROxG4
         6hKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jb+mp+rDj9DLSvOVTi217/rhPZn5ckg46P7fvQWw8bI=;
        b=a0R4MTpoVaW1TgBIi5lnqqTuPlvb9dje1VUiBJdo9RIXmogiwuqDALUM2B0EBXOwFh
         odtPxM668xOVSX+ZLj8NqQODfHrNqwi5WXmytABQuOfcaLEjPEknysRmvbnFTSP5BmZ1
         mpuksyLrvs5mj7P6kPUHlFfRkdGGe/SF+KMfMxgmgCNMJvvK7sWSDraQnmUa/SDgF9FK
         rbWx+hzHaPR8ISPrKzMd6NOHUaWOduFR4mfPu8WRCcSk0FTltkZMYvGlcXiE42frBYfj
         UOb6dM4YoXsvDrkCa+FyStjqlD9C9KizsK6oqicl4zl1sVQKob30RA7UfI73lUw88Iwm
         Rk7g==
X-Gm-Message-State: APjAAAWew9TTWoA0Bpw45IlMdsPNy1dL8oW0KmqX4OzSfs/Jqns2hAqh
        pNgAknPInSWEXzimFwT+RH4MmQ==
X-Google-Smtp-Source: APXvYqyrj/iZC3kZ7z894nXVISBlMWw73nZBsxww36F61Aq8e7U8q9H/QeFlnCqmkuA/vwgozMvSWw==
X-Received: by 2002:a1c:7008:: with SMTP id l8mr4221000wmc.64.1561669345669;
        Thu, 27 Jun 2019 14:02:25 -0700 (PDT)
Received: from clegane.local (11.117.130.77.rev.sfr.net. [77.130.117.11])
        by smtp.gmail.com with ESMTPSA id k82sm107902wma.15.2019.06.27.14.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:02:25 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org
Cc:     rjw@rjwysocki.net, edubezval@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCH V4 1/3] cpufreq: Move the IS_ENABLED(CPU_THERMAL) macro in a stub
Date:   Thu, 27 Jun 2019 23:02:06 +0200
Message-Id: <20190627210209.32600-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpufreq_online and the cpufreq_offline [un]register the driver as
a cooling device. This is done if the driver is flagged as a cooling
device in addition with a IS_ENABLED macro to compile out the branching
code.

Group this test in a stub function added in the cpufreq header instead
of having the IS_ENABLED in the code path.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 6 ++----
 include/linux/cpufreq.h   | 6 ++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 85ff958e01f1..aee024e42618 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1378,8 +1378,7 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
-	if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
-	    cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
+	if (cpufreq_thermal_control_enabled(cpufreq_driver))
 		policy->cdev = of_cpufreq_cooling_register(policy);
 
 	pr_debug("initialization complete\n");
@@ -1469,8 +1468,7 @@ static int cpufreq_offline(unsigned int cpu)
 		goto unlock;
 	}
 
-	if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
-	    cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV) {
+	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
 		cpufreq_cooling_unregister(policy->cdev);
 		policy->cdev = NULL;
 	}
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d01a74fbc4db..a1467aa7f58b 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -409,6 +409,12 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 const char *cpufreq_get_current_driver(void);
 void *cpufreq_get_driver_data(void);
 
+static inline int cpufreq_thermal_control_enabled(struct cpufreq_driver *drv)
+{
+	return IS_ENABLED(CONFIG_CPU_THERMAL) &&
+		(drv->flags & CPUFREQ_IS_COOLING_DEV);
+}
+
 static inline void cpufreq_verify_within_limits(struct cpufreq_policy *policy,
 		unsigned int min, unsigned int max)
 {
-- 
2.17.1

