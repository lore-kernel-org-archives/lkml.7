Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D47C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7DA2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d2RA8XQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfJCInL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:43:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34134 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbfJCInL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:43:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id a11so2036344wrx.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 01:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PkzxXO0kBcxX7RILeE3FuUnuhQQatCZ5b0O6JmLXb1U=;
        b=d2RA8XQDgVDJJl9BkilqseaM9dtBxXTtwUEqFt77pIMNYH+ci1xYL3fa/Eq5QCmsfe
         xwa7z321VDwC4wqua7q2IMNbJ5gu00Vxy7VYEniqDQsQdK78Ldl22XUL/b4+WkKTx+V5
         YHgO6cuhZ0Ixpk71nzExsfCtT7R6Mo+Fg61eCo5NIKDpCmWt0hNnm9L/l4i+t/kaOM00
         P1bw/Z5pG7eZSAo7DprUaN+OrocugXDDxBUd1Z+x/1lAZipZULeVEGm/xOplnOsFM05S
         Nr5cy8pyZKntmP8IBmochESdb6Oz9EyDb3gRLEGnbENkBAQ1kxq6HIGXnVfzpsiO74Ml
         r1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PkzxXO0kBcxX7RILeE3FuUnuhQQatCZ5b0O6JmLXb1U=;
        b=TELj0FsSFfdd9REEAWUZcX5gejBEuNil9pIwbPmyUeNNrPcqvJ42ZzrRn208oOCd0x
         yAGTAzD/I1avxmcNDbGIVK/S7bmprykEJb9T5oOxnj9UlM3/7E5WYrAgOlIu9OoRFZkN
         hXaHeH757zhtkjEBgQmTvezchEBfGWoPheLPrw+zRxTFy7MmuyyfmUml9wMuD2jHNZ0U
         gl5eYwfTT1jLcCAjZyJ0Wpmgb41Qaez+me17ZnVAvjuowe0LWL5RC96nL2KAbvjmMsLy
         +vH1ywbdlEIfllxPiBa344LMKmJuZRfHznPXaI2/55RxAPNO8aQxHF+OMgezajw05XIu
         tYAA==
X-Gm-Message-State: APjAAAX8VApvRPU/E2Bym9JhCMM77vYWoD6We6zs/avcd9dYfB4duivU
        Pe5sFm4lZUN2r/LcDcTsPAytaw==
X-Google-Smtp-Source: APXvYqzE5OwymjJK0bpBwClxvhRY0Ut+yiiRkAfeROkCP4wFnHbr9D8o39+Xjz432vTFdmVwNnYE+g==
X-Received: by 2002:adf:e386:: with SMTP id e6mr3459292wrm.91.1570092188817;
        Thu, 03 Oct 2019 01:43:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:7990:8bfa:5771:282b])
        by smtp.gmail.com with ESMTPSA id z3sm1519702wmi.30.2019.10.03.01.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 01:43:08 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 2/3] cpuidle: play_idle: Specify play_idle with an idle state
Date:   Thu,  3 Oct 2019 10:42:40 +0200
Message-Id: <20191003084242.8655-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191003084242.8655-1-daniel.lezcano@linaro.org>
References: <20191003084242.8655-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the play_idle function does not allow to tell which idle
state we want to go. Improve this by passing the idle state as
parameter to the function.

There is no functional changes, the cpuidle state is the deepest one.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
index 17da9cb309e1..ead439dab2b5 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -311,7 +311,7 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void play_idle(unsigned long duration_us)
+void play_idle(unsigned long duration_us, int state)
 {
 	struct idle_timer it;
 
@@ -328,7 +328,7 @@ void play_idle(unsigned long duration_us)
 	rcu_sleep_check();
 	preempt_disable();
 	current->flags |= PF_IDLE;
-	cpuidle_use_state(cpuidle_find_deepest_state());
+	cpuidle_use_state(state);
 
 	it.done = 0;
 	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-- 
2.17.1

