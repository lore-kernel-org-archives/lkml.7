Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7184C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E25F21783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gUdxq5Ui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfJCMqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:46:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55886 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbfJCMqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:46:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id a6so2154108wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 05:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kEN8tPAT2fA9Rfc8gxL4d7nyWjikV+WP3V/1RcMXwQA=;
        b=gUdxq5Ui65bKot0+EettEbDhNJnplDnQFK83G8i4nEsaazLAQHywqPF3RghfOWxMta
         xeW2S8ahkc/PkzIe8SIDjYRuBcIeiCjQhS9lS01FDmd3LZyWaOrSx4icjDOGQjqfLpa+
         /KQSD/Kg2Aa7Fe2r80CHuCkgxpY0ycC0QZQPjS31aV/ob9Rzu/cpmC4q/cJd2ym6KKWk
         znMIMYmkr3kbThk62JWk4ZNv3Q60asjysUEYb6uFuubSdO0rVu5c3qkCXSJ/ZOz57eht
         4nGi+jRaE9uN7YMPEHl5aJWQ2tkDPCcu5Np9QcuhPlZsX8vCBIM+KxzhuUKp7H8M2puJ
         nS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kEN8tPAT2fA9Rfc8gxL4d7nyWjikV+WP3V/1RcMXwQA=;
        b=XK1aWZ2vE+rhH4IyOuP3//hq0LLYhQV2POdTSlNVyE58qWML37xJ+5zMud1HaNay4v
         E2MKkAVSBfbUdEzEIT+T1VwELcieUwkOmA+FNA/EkrRMhDmxmHtYbjr02GLw7HO+WsTh
         JX6v99sc0cnwGmlxI79sTARK5n9umBg5Vwf/f7G8X+fG/y5ygnoz91wDjfeyPJP8FMBW
         Did7xYu9lC6zJ68KUc5mL+cfmc9ghGSlo4AGNLYPvyVqt5vFXhpyNTOjXtKSNsbv6ldI
         OHZTLZvLrvPRUIDx/E1J6ospq6FoQgVWIaW21tRXkxx2zFCwnj/N7f7RS+hkUvPopZEJ
         B5XA==
X-Gm-Message-State: APjAAAU29vkLROi5guCcMxiKiF/z3O3yE6yaXRQL8rWWVTMrGNA37n6f
        p5kE6dNxKESdY6/0+vKOF9reLQ==
X-Google-Smtp-Source: APXvYqzGy79bVY30Yzr1ZreRudssA7NJ2/YfLeHNOYDDrlatXn46Oz137GrPLoyk1bDBrYCz4oDxcQ==
X-Received: by 2002:a1c:6a0f:: with SMTP id f15mr6241489wmc.159.1570106767667;
        Thu, 03 Oct 2019 05:46:07 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:7990:8bfa:5771:282b])
        by smtp.gmail.com with ESMTPSA id m62sm2453586wmm.35.2019.10.03.05.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 05:46:07 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V3 3/3] powercap/drivers/idle_inject: Specify the idle state to inject
Date:   Thu,  3 Oct 2019 14:45:41 +0200
Message-Id: <20191003124541.27147-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191003124541.27147-1-daniel.lezcano@linaro.org>
References: <20191003124541.27147-1-daniel.lezcano@linaro.org>
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

