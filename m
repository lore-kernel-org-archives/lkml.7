Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D923DC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8F82075B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 17:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQ0cEdMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfHERCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 13:02:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53840 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729439AbfHERCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:02:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so75470555wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 10:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wTiqcN9ans0X8+b6FfQH+5cUMosgyj2ws3IXTgtGmS8=;
        b=KQ0cEdMQ7CsmbkTG8v83WQ8idHQcpy1o6EqRpdVIr6T/mKjdwyQyFobXC7ej0BsWmz
         +4hk4IBZlp0q6fwXr+b2VG5jG7xI0/JO6MYkxepVK2S2dq2oNl7TDkGiCmjj9MgvEC8X
         gwhZn8+PbYoEeNTEMBT1XyqAx2ikdgyZLf+Vwbu7v8duiat9g1olSU/E5sSpTY+7hbZP
         wIEd6ysvglzS9f7w5BG4LGuvZRZyIJD8lowKn0tEuhP7xX3s2S885dyADWLPbUCfTGSs
         3u66m7CFthV0uuXWVDUCRjvx/9eixE0/bFzMvfTJMJK4iHjFL6zSUEDqeglbj86zW8r7
         RhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wTiqcN9ans0X8+b6FfQH+5cUMosgyj2ws3IXTgtGmS8=;
        b=UTbvJTA/RAZBgNh1KA7H4qvn1bN9wgZHVFhA5mmtiXgZHyUqbIYyCt6zoRwmwBzcGM
         J19feoeIS003nfzvmImI4uL4+nm1sWM93BY8mdqisjEKqow7XROUdsKCLUkvwJoPP7Ku
         /kZwPTIJKWEV6/aYXo8kppSQ3xnYAl8vtnJPjqsezj7kwLsbKAUw0j3HQmJxgi+WCKqt
         bzITvoH3Q2IAAaE+1i/RWDy09ud4/1XiGcNubAlljOmzKWR7vulOsRnWSx4keX13Fj8U
         oDwTj7v9AeQSeRJLforZ+AnpRATRDssyh2Sbp5Senxr5+dTeH6GcnsgljPc1zN2QsabX
         Xlew==
X-Gm-Message-State: APjAAAVHFQJSx2lec+NSx8XUi3LU01ZjXbMC7/UADpVavLGvOzEpeS3d
        CaKtCFM5FlY3vSy/Hdfn6X1UvQ==
X-Google-Smtp-Source: APXvYqwsGaz1BOvp3kYprODq82cWSaGikSyiwtR6lbRCKmQF5G0TU8NEWUwCMNRTwnJNficS0uI/AQ==
X-Received: by 2002:a05:600c:c4:: with SMTP id u4mr19728181wmm.96.1565024558987;
        Mon, 05 Aug 2019 10:02:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:e5cb:2287:9bbb:b7eb])
        by smtp.gmail.com with ESMTPSA id v29sm28893685wrv.74.2019.08.05.10.02.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 10:02:38 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] cpuidle: play_idle: Specify play_idle with an idle state
Date:   Mon,  5 Aug 2019 19:02:07 +0200
Message-Id: <20190805170208.26873-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190805170208.26873-1-daniel.lezcano@linaro.org>
References: <20190805170208.26873-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the play_idle function does not allow to tell which idle
state we want to go. Improve this by passing the idle state as
parameter to the function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/idle_inject.c           | 3 ++-
 drivers/thermal/intel/intel_powerclamp.c | 4 +++-
 include/linux/cpu.h                      | 2 +-
 kernel/sched/idle.c                      | 4 ++--
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index cd1270614cc6..9b18667b9f26 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -138,7 +138,8 @@ static void idle_inject_fn(unsigned int cpu)
 	 */
 	iit->should_run = 0;
 
-	play_idle(READ_ONCE(ii_dev->idle_duration_us));
+	play_idle(READ_ONCE(ii_dev->idle_duration_us),
+		  cpuidle_find_deepest_state());
 }
 
 /**
diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 53216dcbe173..b55786c169ae 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/cpu.h>
+#include <linux/cpuidle.h>
 #include <linux/thermal.h>
 #include <linux/slab.h>
 #include <linux/tick.h>
@@ -430,7 +431,8 @@ static void clamp_idle_injection_func(struct kthread_work *work)
 	if (should_skip)
 		goto balance;
 
-	play_idle(jiffies_to_usecs(w_data->duration_jiffies));
+	play_idle(jiffies_to_usecs(w_data->duration_jiffies),
+		  cpuidle_find_deepest_state());
 
 balance:
 	if (clamping && w_data->clamping && cpu_online(w_data->cpu))
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 88dc0c653925..76e3038b63ce 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -179,7 +179,7 @@ void arch_cpu_idle_dead(void);
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
-void play_idle(unsigned long duration_us);
+void play_idle(unsigned long duration_us, int state);
 
 #ifdef CONFIG_HOTPLUG_CPU
 bool cpu_wait_death(unsigned int cpu, int seconds);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c102e03dee6e..f9773dd55ab9 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -310,7 +310,7 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void play_idle(unsigned long duration_us)
+void play_idle(unsigned long duration_us, int state)
 {
 	struct idle_timer it;
 
@@ -327,7 +327,7 @@ void play_idle(unsigned long duration_us)
 	rcu_sleep_check();
 	preempt_disable();
 	current->flags |= PF_IDLE;
-	cpuidle_use_state(cpuidle_find_deepest_state());
+	cpuidle_use_state(state);
 
 	it.done = 0;
 	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-- 
2.17.1

