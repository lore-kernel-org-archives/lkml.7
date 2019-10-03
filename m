Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76D4C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE0C21783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rBmONC0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfJCInQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:43:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40199 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbfJCInQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:43:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id l3so1993178wru.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 01:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Trt8B0Ci9I5T6my9f4Ys/e4jgqsO0QhMPAq+wm6jZoE=;
        b=rBmONC0OMG067X9RLR1i4c7uxzZLb+zCjcCqb+aXuoyKhccH76Qd5ItSUyzb2v2mSN
         w3cy0/Or85QPmCjWuvfqpQo7hXpo2PTUDocbzbMv6pkIBkLix3XQ0GXzjisliwti6jTX
         2cXw8bnmYmWcoQsiUppZ0RECva/qcIGjebNQvCeEpecHreXgytksXdvKjVnjUmb5xBo9
         rJbRsZZqIhgMJAWLLC2ICuOsyd4Zbw8r6CTxRoyVFs5ZDLM+o9mcXTo6iOIJ02GcWOZ5
         K5WsAnXceL5j7xR91eRiWvsbIZN9m990BzMTItIWmJGji4aTBE9zIR6im97iADLNa1YG
         Ze1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Trt8B0Ci9I5T6my9f4Ys/e4jgqsO0QhMPAq+wm6jZoE=;
        b=qSyS2ChIkLCehMgk3WO6Hf/WtyzRrJrB7H5RNivQ0K1kSXnDr4xPPGJRRG6uSLNaH+
         TBWsNvyba7iJwzaCSnrb3pEpHoD3HqEMPywhG0NhaljiB1cuaA1BiN2S36czbk0QCTO8
         Ver98ZE5YiuI34k2jpmodB5hU6FRNcqY8fTF+44Chx9NQVFPrrmwSsOEn7uaappWFUaL
         hGbu9EBHlKjqBc5Hmaj+7k2+8F/uxVaNubneEGW0xEgLdYnzE3EY32T35x/P9EafozzI
         wAggVswQS71MwQr5ysdaB09t5EeL9WnYKpqgu1/Shq/46st6qVIRHCnGQv37jGPjvb1n
         WLLg==
X-Gm-Message-State: APjAAAWvsHOsPk9nxWomnfWhQ18Z46vdukCdEQ39CpsULZ8XW80S8vrJ
        IHEWPlP5t2CdzZ3cV6mNpN1VgQ==
X-Google-Smtp-Source: APXvYqx+etsjYqb6/Yi7gSL+hcjsMcNoG/WAIugIjV1FSPApDbGOxZ5Y2YJSpOzXEOONUlEmnhPNBA==
X-Received: by 2002:adf:fb11:: with SMTP id c17mr6528096wrr.0.1570092193745;
        Thu, 03 Oct 2019 01:43:13 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:7990:8bfa:5771:282b])
        by smtp.gmail.com with ESMTPSA id z3sm1519702wmi.30.2019.10.03.01.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 01:43:13 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 3/3] powercap/drivers/idle_inject: Specify the idle state to inject
Date:   Thu,  3 Oct 2019 10:42:41 +0200
Message-Id: <20191003084242.8655-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191003084242.8655-1-daniel.lezcano@linaro.org>
References: <20191003084242.8655-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the idle injection framework only allows to inject the
deepest idle state available on the system.

Give the opportunity to specify which idle state we want to inject by
adding a new function helper to set the state and use it when calling
play_idle().

There is no functional changes, the cpuidle state is the deepest one.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/powercap/idle_inject.c | 15 ++++++++++++++-
 include/linux/idle_inject.h    |  3 +++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 9b18667b9f26..a612c425d74c 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -38,6 +38,7 @@
 #define pr_fmt(fmt) "ii_dev: " fmt
 
 #include <linux/cpu.h>
+#include <linux/cpuidle.h>
 #include <linux/hrtimer.h>
 #include <linux/kthread.h>
 #include <linux/sched.h>
@@ -65,6 +66,7 @@ struct idle_inject_thread {
  */
 struct idle_inject_device {
 	struct hrtimer timer;
+	int state;
 	unsigned int idle_duration_us;
 	unsigned int run_duration_us;
 	unsigned long int cpumask[0];
@@ -139,7 +141,7 @@ static void idle_inject_fn(unsigned int cpu)
 	iit->should_run = 0;
 
 	play_idle(READ_ONCE(ii_dev->idle_duration_us),
-		  cpuidle_find_deepest_state());
+		  READ_ONCE(ii_dev->state));
 }
 
 /**
@@ -170,6 +172,16 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
 	*idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
 }
 
+/**
+ * idle_inject_set_state - set the idle state to inject
+ * @state: an integer for the idle state to inject
+ */
+void idle_inject_set_state(struct idle_inject_device *ii_dev, int state)
+{
+	if (state >= CPUIDLE_STATE_NOUSE && state < CPUIDLE_STATE_MAX)
+		WRITE_ONCE(ii_dev->state, state);
+}
+
 /**
  * idle_inject_start - start idle injections
  * @ii_dev: idle injection control device structure
@@ -298,6 +310,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
 	cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
 	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	ii_dev->timer.function = idle_inject_timer_fn;
+	ii_dev->state = cpuidle_find_deepest_state();
 
 	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
 
diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
index a445cd1a36c5..e2b26b9ccd34 100644
--- a/include/linux/idle_inject.h
+++ b/include/linux/idle_inject.h
@@ -26,4 +26,7 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
 void idle_inject_get_duration(struct idle_inject_device *ii_dev,
 				 unsigned int *run_duration_us,
 				 unsigned int *idle_duration_us);
+
+void idle_inject_set_state(struct idle_inject_device *ii_dev, int state);
+
 #endif /* __IDLE_INJECT_H__ */
-- 
2.17.1

