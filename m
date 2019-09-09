Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C29C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC10D21A4A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qh900W4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbfIIOup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:50:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52788 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfIIOup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:50:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id t17so14253346wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QWTOc9pzhOZfgZC7q4BsqP5nZGvuPUC3FrVHOgCj9sE=;
        b=Qh900W4WCA/saKFC7Jgj35zRRdwzkHDtcm8hsjyS3aBg7t/sfTw1+RJ85PhNMA8Pyg
         C4g4c6c70EmSjEGdswpILDeyJUb3qEOFGQCDFA7x0lcH650oB9E5BO1jEfcSf50seLv+
         3nW7oN2zl2PrP7aOaYHU/EZo7uVkA4FRlWCrAv43la1CTyj0KIkt/uGSDlnE5zBlbroO
         zraFW9eln2tSZqy0I0/VGKBgDv6VsqIZUZN4+9dYp6CPwpDk9h3uEJuZJ1sYrY+e2wZd
         aYj6RO3Z7liTmDZOHNGREw3Q0X5HSWXlnYa2l8O3dWrMO6eZNc2s5Adi+rMknTjSRzUc
         deGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QWTOc9pzhOZfgZC7q4BsqP5nZGvuPUC3FrVHOgCj9sE=;
        b=AB+U6od1ihYSCR9lexY2PYIhPJei2SbGsLI0E9JP3vOJ74z9SSUop9ZQoNmbUzF9VC
         Yc9jQ0sz48MHGduNTLVp0YMGSZH0dymrQ9eAVLVMuUMRNE7Kd4Bq+2Mc7yF4wM7dyDYD
         KtBN/0NkiH1VharpRWxgX5qfBDrtGTA5J0dR819KfzyFySw1LZTaAQPME1Ta3Whiqd9K
         L0DU7Kfd/+SE2Ia4hYCNk0uGYkRs/KrUvLHvsCKzsKUpuBq9FPZiPceD4QN9tdBLN6vG
         j1K6qulQstgYKFz17z6mvTVWWetZ209W8LZQbCfwEY6OTSAaFuA9eRJ1tjDtnHNH8vYm
         Gmaw==
X-Gm-Message-State: APjAAAWtUlDrMch98QKUHGnM0SDwXlcj8ay4WZafc59NNK1JpEpYlSHg
        +EkcycAQkyI3hibbXzbG6oaiQQ==
X-Google-Smtp-Source: APXvYqxVD4als1QedRaHkSvS6MV28kH4s34zPdMci9jFoOITuCOWZB9WaIZnfekab/kG46hMSwG4zw==
X-Received: by 2002:a05:600c:307:: with SMTP id q7mr13157988wmd.6.1568040643849;
        Mon, 09 Sep 2019 07:50:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:a060:80d2:1467:e511])
        by smtp.gmail.com with ESMTPSA id v2sm31921147wmf.18.2019.09.09.07.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:50:43 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/3] powercap/drivers/idle_inject: Specify the idle state to inject
Date:   Mon,  9 Sep 2019 16:50:15 +0200
Message-Id: <20190909145015.26317-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190909145015.26317-1-daniel.lezcano@linaro.org>
References: <20190909145015.26317-1-daniel.lezcano@linaro.org>
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

