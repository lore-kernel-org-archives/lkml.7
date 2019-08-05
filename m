Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9614C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED502075B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZuWM93z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbfHERCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:02:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53851 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729999AbfHERCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:02:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so75470818wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 10:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8seUtniCWRwFTJq4JInJW6atX1NHBdkEw579O8M2U9c=;
        b=rZuWM93zis34ydR/ncwm9ywfu2puMq373eHZDdgwqmtjXJXB1PEM9wVVrN1dGDB+Ey
         VV2wbneQrvNNZxmOELIEn9K+wnBS6lcBwOldd8Ic/DHqfynnRkVfUsKNa4KOKnetFmsS
         ZFYK5/OmE6emlTxZZ/UJkEjx6X1LwwrAhN+Eoss6ERTPRQ78FTgRpf3jCWG+R7dG2hay
         CbfdNRQanY9NIos3Zo17BWvTT8pmxSTIK7LMpKEa6FuMbCZtFj7iKiYQ2MoSAx1QM4LH
         oK1DzgT1Xm1vrsCLu7rfRFb/hZGZeCd+OAZMvD0K+14jUH4vIefXM50yCm35Q2lR92Ok
         RAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8seUtniCWRwFTJq4JInJW6atX1NHBdkEw579O8M2U9c=;
        b=TLi7OJ0tCSD/zf7yTyFgHxe/wpYECE62t8ZwhYa+6okVzp7hxdDAUIeslqfWlM3Z7K
         5xWuSbb1F5tjfPl+Sx6XCPBbMcRBqk/xuabIlEl5Q9oStbD4ta/FmWprwrjIbcb/Yvi4
         27cKj/xS/Rhj2VS15WODPDg6k0iO7d7VEE9ddFgxoCVp28V3hdO/EBQL5OjnyMyJ/Tiw
         E+LtN5hu6NsSEUZdTmJgRB7kqWjN+8LcBpDEi9CWv8AaAU75Z6KCqvxQgCRE4ZsF4iCd
         yofk0GrpYm9aWmJs3PDDVhB4wsufrobtJKW/UJJjfbHrTcNp5Hv95O70vq7t0b28gwl3
         I40w==
X-Gm-Message-State: APjAAAVp+uL69OaR142AmMpm5sQVCK8yGGrgVlY63Ni+8eY/ifm3SMyx
        sf8X4X/J/p5j1YyVzzWE+efalA==
X-Google-Smtp-Source: APXvYqwNMG6nkRMSEbp8tcPVmOdfLttrjljhraM67lgOekaFbI3CEyHmigGc/TLZS7gq3QrWAxIbgA==
X-Received: by 2002:a1c:a8c9:: with SMTP id r192mr20084425wme.43.1565024564444;
        Mon, 05 Aug 2019 10:02:44 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:e5cb:2287:9bbb:b7eb])
        by smtp.gmail.com with ESMTPSA id v29sm28893685wrv.74.2019.08.05.10.02.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 10:02:44 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] powercap/drivers/idle_inject: Specify the idle state to inject
Date:   Mon,  5 Aug 2019 19:02:08 +0200
Message-Id: <20190805170208.26873-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190805170208.26873-1-daniel.lezcano@linaro.org>
References: <20190805170208.26873-1-daniel.lezcano@linaro.org>
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
---
 drivers/powercap/idle_inject.c | 15 ++++++++++++++-
 include/linux/idle_inject.h    |  3 +++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 9b18667b9f26..a94ebab9ee21 100644
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
+	if (state >= -1 && state < CPUIDLE_STATE_MAX)
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

