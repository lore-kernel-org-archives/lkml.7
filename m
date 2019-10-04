Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD9CC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C82215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 08:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVFmdVVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbfJDIcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:32:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36888 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730710AbfJDIct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 04:32:49 -0400
Received: by mail-wm1-f66.google.com with SMTP id f22so4910312wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 01:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kEN8tPAT2fA9Rfc8gxL4d7nyWjikV+WP3V/1RcMXwQA=;
        b=oVFmdVVIc11Zlr4x2tuAKbzp/HjGfsCcy3KvaDNrBP3pQyFmahO5cujD6Dgz/X+32V
         0AfGj9c9G9TKU7Rl18LwQ/fxFmX/eHgsWxH7xZ2s316BEkEiFDm5WY+NptQv+4UU6Xf3
         fw8BOki+utT0NRmQbzptfCED2+w9XG5eeJTVNKnQFI22ZOgBB5STQIUHEyJQdqwK05uV
         14XAqphVXRycHew3AAUXuU/sQGkdEOxBEEDAu4BgoN6GhnQZkN3MiGmZEPJwUYNdIZB6
         ajCsQCjQ5tsUz9iSyLvQSwFtK9KdT/tv1O9HUg+UB+ezyG9LeaD4F5J2ULOKrQFrfs9B
         JvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kEN8tPAT2fA9Rfc8gxL4d7nyWjikV+WP3V/1RcMXwQA=;
        b=INOqQAfJ1rrqs7NYqcWODIgm663nDg6Dd6Aqo4X0NhogoFU9vddufV2GSP++8iRavR
         SsGpkqnczRaEYFTMQns58srYsqf5pZ+mkjlJzngviDtbpr1yNRjQdA8Y0eX82ry4pZvY
         7p+o9zm+UI6/aZdPA9AmS5Ceu4mRIHWhgQ4j+9nIqYhFMIdCZmlPC8Q0fQUP4rHbS7eb
         7rePtLTYDykx2mV4VXH5sawKeBvaKgcU9Rf936mkzfCT/agegdiPAhXskIA68FkVUY3M
         YXN62U0QPNVbFk783C0OL/+JYgDnMPQEIKEYqBhJqo5jzJHr9wh7zjcU6gwepFtxthvq
         /yGQ==
X-Gm-Message-State: APjAAAWrjDNRq0wIxOz8xCF5ogLNbh8VG6EgyT9HM3iEwAOS5MHzjexP
        t13pryBuDRQUids5OpaBLvsmSw==
X-Google-Smtp-Source: APXvYqzJFIWMoTzEnQVH74TDRAD+YRGy7EoLnrDhnaHEaPkYov+ye/FVp+PtuZejfYxQPWbE6476Yw==
X-Received: by 2002:a1c:29c4:: with SMTP id p187mr10545862wmp.28.1570177967088;
        Fri, 04 Oct 2019 01:32:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:15f7:68ed:c037:86e6])
        by smtp.gmail.com with ESMTPSA id 59sm6488304wrc.23.2019.10.04.01.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 01:32:46 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V4 3/3] powercap/drivers/idle_inject: Specify the idle state to inject
Date:   Fri,  4 Oct 2019 10:32:05 +0200
Message-Id: <20191004083205.29302-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004083205.29302-1-daniel.lezcano@linaro.org>
References: <20191004083205.29302-1-daniel.lezcano@linaro.org>
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
 drivers/powercap/idle_inject.c | 14 +++++++++++++-
 include/linux/idle_inject.h    |  3 +++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 233c878cbf46..a612c425d74c 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -66,6 +66,7 @@ struct idle_inject_thread {
  */
 struct idle_inject_device {
 	struct hrtimer timer;
+	int state;
 	unsigned int idle_duration_us;
 	unsigned int run_duration_us;
 	unsigned long int cpumask[0];
@@ -140,7 +141,7 @@ static void idle_inject_fn(unsigned int cpu)
 	iit->should_run = 0;
 
 	play_idle(READ_ONCE(ii_dev->idle_duration_us),
-		  cpuidle_find_deepest_state());
+		  READ_ONCE(ii_dev->state));
 }
 
 /**
@@ -171,6 +172,16 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
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
@@ -299,6 +310,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
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

