Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763F4C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5266206F3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eg+szh1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfKMSyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:54:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37238 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfKMSyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:54:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so3231556wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 10:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zn3z/ohxCZiMEpAOhI2pz3odCG7wV2XPFA28iErwpL0=;
        b=eg+szh1mA8xKUV7Uc2u6zplCS83M0epV5sOJ1ElLmuQk8iLAJG64JM63oPGXrwcUNv
         ZzfkqjN0Aa1V568LRe1nBtPAmUK3eOMcxda/eXV3TjHhvGfhZvqWCcil4DAXeSnBzIgv
         OZ4X1Pbmv01rE3XRIdbxNa7Uf0KZmc9SrUgiISMv6NlDDQrjxRssnlMVgdIACFsN6iUB
         asJ+n6EUkSxx5jmmWwV+x2H2OS5is4rgxmVWvPF047Pi27O5r99yRGWqxDvtFlyg4qEc
         MgPEr7KxjFrtr1vS//IMXBkK2LcClSMSFaMZ1i1+hKkDtGjxheiLnW4r2DVcp6db71jO
         gnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zn3z/ohxCZiMEpAOhI2pz3odCG7wV2XPFA28iErwpL0=;
        b=HX6jvxVDU+Us7AOA2HpdnTKi/5DO2ZwSk6UW/E3l5YaaYAtBHKxc1dzxmdmzNcOiCo
         OWkso58IvhTuhyApriuyw2BKROQT2BUOTs3aOr+R+6zwpWW6dpvz1p1O+1lBkyV59ZTf
         eTEzYPb0RTxDJ7HPbKuqYLhw6q/X0FLASSi0M9CfsQACnQRFhYEUSUD9v2b5xvnoJYrp
         7+m5d9Z3ZbpsqHmQgt0l1iqd38WG+l4CCzDrjnnuzeiVkUVtdxLpjJmzoEjhTmWCP4hA
         A0Oj1LOr4pGk7Vc1WCKh0qBZxyiQOz+4O6VEpOtes84rgmpETSrbVaGE3/c1sDfQ9R7u
         rZog==
X-Gm-Message-State: APjAAAVa9k0Lgy+7c9FvLCLOdBB9x1heb+F16vuD0C9HGGFrN6F2tVLf
        sPBvZjZI1VbzSwdCEnZRCyPEDw==
X-Google-Smtp-Source: APXvYqyOkVmRLFlc95H5iDJQKuaiccJXVPUo0y3gJsmyXXObH3xQOTg7VR3u9y/5WCF/ZTwJbunsLA==
X-Received: by 2002:a1c:2dd0:: with SMTP id t199mr4027766wmt.58.1573671272661;
        Wed, 13 Nov 2019 10:54:32 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:ec92:781d:6592:837])
        by smtp.gmail.com with ESMTPSA id 17sm2652848wmg.19.2019.11.13.10.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:54:32 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: [PATCH RFC 2/3] sched: idle: Add a latency parameter to the play_idle function
Date:   Wed, 13 Nov 2019 19:54:18 +0100
Message-Id: <20191113185419.13305-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113185419.13305-1-daniel.lezcano@linaro.org>
References: <20191113185419.13305-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default the play_idle() function leads to the deepest idle state
selection which is not necessarily the state we are interested in when
forcing the CPU to go to idle.

Add a latency parameter to the play_idle() function, so the caller can
use the constraint to allow a shallower state.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/idle_inject.c           | 2 +-
 drivers/thermal/intel/intel_powerclamp.c | 2 +-
 include/linux/cpu.h                      | 2 +-
 kernel/sched/idle.c                      | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index cd1270614cc6..6f2bfb172e61 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -138,7 +138,7 @@ static void idle_inject_fn(unsigned int cpu)
 	 */
 	iit->should_run = 0;
 
-	play_idle(READ_ONCE(ii_dev->idle_duration_us));
+	play_idle(READ_ONCE(ii_dev->idle_duration_us), UINT_MAX);
 }
 
 /**
diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 53216dcbe173..dd1330d59176 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -430,7 +430,7 @@ static void clamp_idle_injection_func(struct kthread_work *work)
 	if (should_skip)
 		goto balance;
 
-	play_idle(jiffies_to_usecs(w_data->duration_jiffies));
+	play_idle(jiffies_to_usecs(w_data->duration_jiffies), UINT_MAX);
 
 balance:
 	if (clamping && w_data->clamping && cpu_online(w_data->cpu))
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index d0633ebdaa9c..241f558af17a 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -179,7 +179,7 @@ void arch_cpu_idle_dead(void);
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
-void play_idle(unsigned long duration_us);
+void play_idle(unsigned long duration_us, unsigned int latency);
 
 #ifdef CONFIG_HOTPLUG_CPU
 bool cpu_wait_death(unsigned int cpu, int seconds);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 00e064d3dfe1..56a8b9d35cb9 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -311,7 +311,7 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void play_idle(unsigned long duration_us)
+void play_idle(unsigned long duration_us, unsigned int latency)
 {
 	struct idle_timer it;
 
@@ -328,7 +328,7 @@ void play_idle(unsigned long duration_us)
 	rcu_sleep_check();
 	preempt_disable();
 	current->flags |= PF_IDLE;
-	cpuidle_use_latency(1);
+	cpuidle_use_latency(latency);
 
 	it.done = 0;
 	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-- 
2.17.1

