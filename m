Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB71ECA9EC4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 07:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C171C20663
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 07:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mwjrt6aT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfJ3Hv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 03:51:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44521 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfJ3Hvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 03:51:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so1091365wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 00:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SOlAXQwY6HSBzz+49x3YKRvdsvjSPYyd9t/VUL7Sm7I=;
        b=Mwjrt6aT79QE65NzwTdFB425qwP+EQeE3I3yelYdNaqhngfedaIz18+aJHlqYXj8dn
         vz9zZjona3aDwbRk5A6RrcZTAmcJ9qrBhuliqmc8Th2wmdC4tTEltpAi2r1CJgywWmgR
         SGqcHpfqHxmRokw2lM6I7hzqddEoB4xN91Rn7JvaIOGR4tF0DixCKQbhgCjsOC2FpV9x
         JKTM18/W0DSz7qx/yAczRQgyatHNrkv2l+lRElje2ZyUkUl7fKGx/6mdr15WLstIwln2
         dr7VF0gjL/q2vhMJidvQMp5V/yNxeAMCLRgX5U1NGGWc5uLX5HGbYX7PtA/cueLpnPO4
         +YoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SOlAXQwY6HSBzz+49x3YKRvdsvjSPYyd9t/VUL7Sm7I=;
        b=qGS4o8mJkuX5z2rA0cqg3yCbJ/Dhfv8iZp90lNWIpqrZz5gnWdyU1H6EPEk7unoAeC
         8aNjlvXbTobSUzmNuqtEQ1hbms4ypg7ui/QmrRGv+MG/v/Gu0OmtyYw6caJ+4+RGfzuB
         nmrybDU3pTRwsrehBIzfCD/S6VVykKAgPRD/oafwdBwJoUAph2cjBIoJ0NNXWbkN8YUJ
         BVjyVAKfNFqWKOLF+5IPd6JUz6/4n3LRL2JQDbAe4itX1vfESbFOvFAHdyWNaU3asP0p
         BK9XkfvtgNQrYnvnFodcoeuxyvSWRE3jhSqlwXYzqNG1lN2snR6JQNcfg+uURlQ1g6TL
         6OBg==
X-Gm-Message-State: APjAAAUFdjzHZ+b18jJpS00a4E6K6LvaOI4N9jEaQrnDkUT8QIIfLLED
        IiKigla5uRDNKDxdgE+L9kg8Sg==
X-Google-Smtp-Source: APXvYqw9AMwLfWTFG6RqKgk4L/ax+3b+3JHKQ59fZbAtV35gkAxrJCYY73B4LtShkKb5C+k6m+WWXg==
X-Received: by 2002:adf:e9c7:: with SMTP id l7mr7084881wrn.57.1572421910196;
        Wed, 30 Oct 2019 00:51:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:2c7f:2fc:5551:ee55])
        by smtp.gmail.com with ESMTPSA id q11sm1114387wmq.21.2019.10.30.00.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 00:51:49 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     mathieu.poirier@linaro.org, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: [PATCH V6 3/3] powercap/drivers/idle_inject: Specify the idle state to inject
Date:   Wed, 30 Oct 2019 08:51:41 +0100
Message-Id: <20191030075141.1039-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030075141.1039-1-daniel.lezcano@linaro.org>
References: <20191030075141.1039-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the idle injection framework only allows to inject the
deepest idle state available on the system.

Give the opportunity to specify which idle state we want to inject by
adding a new function helper to set the state and use it when calling
play_idle().

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
  V6:
   - Rename variable name 'state' -> 'state_idx':
     https://lkml.org/lkml/2019/10/28/874
---
 drivers/powercap/idle_inject.c | 14 +++++++++++++-
 include/linux/idle_inject.h    |  3 +++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 233c878cbf46..2607d3e9afc5 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -66,6 +66,7 @@ struct idle_inject_thread {
  */
 struct idle_inject_device {
 	struct hrtimer timer;
+	int state_idx;
 	unsigned int idle_duration_us;
 	unsigned int run_duration_us;
 	unsigned long int cpumask[0];
@@ -140,7 +141,7 @@ static void idle_inject_fn(unsigned int cpu)
 	iit->should_run = 0;
 
 	play_idle(READ_ONCE(ii_dev->idle_duration_us),
-		  cpuidle_find_deepest_state());
+		  READ_ONCE(ii_dev->state_idx));
 }
 
 /**
@@ -171,6 +172,16 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
 	*idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
 }
 
+/**
+ * idle_inject_set_state - set the idle state to inject
+ * @state: an integer for the idle state to inject
+ */
+void idle_inject_set_state(struct idle_inject_device *ii_dev, int index)
+{
+	if (index >= CPUIDLE_STATE_NOUSE && index < CPUIDLE_STATE_MAX)
+		WRITE_ONCE(ii_dev->state_idx, index);
+}
+
 /**
  * idle_inject_start - start idle injections
  * @ii_dev: idle injection control device structure
@@ -299,6 +310,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
 	cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
 	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	ii_dev->timer.function = idle_inject_timer_fn;
+	ii_dev->state_idx = 0;
 
 	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
 
diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
index a445cd1a36c5..2efc60252d7b 100644
--- a/include/linux/idle_inject.h
+++ b/include/linux/idle_inject.h
@@ -26,4 +26,7 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
 void idle_inject_get_duration(struct idle_inject_device *ii_dev,
 				 unsigned int *run_duration_us,
 				 unsigned int *idle_duration_us);
+
+void idle_inject_set_state(struct idle_inject_device *ii_dev, int index);
+
 #endif /* __IDLE_INJECT_H__ */
-- 
2.17.1

