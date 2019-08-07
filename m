Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94FDC19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E4721E6A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uGWRV7RE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfHGHGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:06:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42308 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfHGHGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:06:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so39358273plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 00:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qZIcf8cwa9igDXcslC8hIzH7Ja/YvdjdJITOrrBaFhM=;
        b=uGWRV7REDU+/UifJJKwmcUdbbfC4+kwOlu/L+nhcItsXbS9UPMcFi7KVOdRDWbGf1q
         dRx1FjrW5TtVAPn5B7HMX1/W5eDB7o/iEVGTwe3yxgl4WRZVORhNkGMWxpZfqnlErHMb
         hji3OIQC0rxu9lxBbQnzsjqSwv2EsvVrEBLBxSYg5/cf0pLOrl96k/FannaVJcaklLjc
         HYf5DtgdzxJZbnA/z8yBce20TryrnPvNlAVrvFTRkGMkHRv2RAeqbSZ6gcq6/18qUt1Z
         316qtvwaOJAwd/k0dSY0XSCLu4CtLuKCCUIb59IcZgwHPgdnF09QRh7sOw8W6tEheyEA
         pBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qZIcf8cwa9igDXcslC8hIzH7Ja/YvdjdJITOrrBaFhM=;
        b=jP3n7nAO/16cd3J4G3/oLWeWBwuKdU9fRV0N6zkBKT9OjagBT47LpKJ2RjXHZAiJbg
         MjFn32EMX7OYeuhAYPhL78ATkxJKQk7IvHyN8Q6XwAI+cWuBKa0Qy233T77YgKaZFywH
         d1vtMQm5urLBJdx8YcauB9U5d3Ut/sjnipgTFLp1w6AmcUM4X9X5gZWxTWcLcYSecEVj
         Ok776V/qK2bpODZVNLwL7EMBqcWy62AL02l+13AsW4yMErWQDjO5BCpkBWqg16sei0NV
         ysgc1f/NfD0H7em4iV7b48hRgTS0LO68W+z9QMVyYQjS8WbZFxEGNxDXfoJP/KeNySDA
         7svA==
X-Gm-Message-State: APjAAAVts2JCNUVHLxA+0ylYQONiicBkmtzEctFJWuIxF3dfL3XnbtoF
        4ABOrOiYbh4d1CGYgbh/WBCC4w==
X-Google-Smtp-Source: APXvYqxsGH/vkO58EVKD1Ayh4k2OV+dF9TGQ3bVrsoL4AlH+dQDYEfCMyEC/Imc3tg8DFDt/Myxq0A==
X-Received: by 2002:a62:3347:: with SMTP id z68mr8065751pfz.174.1565161569245;
        Wed, 07 Aug 2019 00:06:09 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id c98sm25633299pje.1.2019.08.07.00.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 00:06:08 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "v4 . 18+" <stable@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/2] cpufreq: schedutil: Don't skip freq update when limits change
Date:   Wed,  7 Aug 2019 12:36:01 +0530
Message-Id: <70fce19e43bb825c3b2546e1211d262a59ae7378.1565161495.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid reducing the frequency of a CPU prematurely, we skip reducing
the frequency if the CPU had been busy recently.

This should not be done when the limits of the policy are changed, for
example due to thermal throttling. We should always get the frequency
within the new limits as soon as possible.

Trying to fix this by using only one flag, i.e. need_freq_update, can
lead to a race condition where the flag gets cleared without forcing us
to change the frequency at least once. And so this patch introduces
another flag to avoid that race condition.

Fixes: ecd288429126 ("cpufreq: schedutil: Don't set next_freq to UINT_MAX")
Cc: v4.18+ <stable@vger.kernel.org> # v4.18+
Reported-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V3->V4:
- Rewrite "if" block to avoid setting variable to false at
  initialization.
- Added Tested-by from Doug.

 kernel/sched/cpufreq_schedutil.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 636ca6f88c8e..867b4bb6d4be 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -40,6 +40,7 @@ struct sugov_policy {
 	struct task_struct	*thread;
 	bool			work_in_progress;
 
+	bool			limits_changed;
 	bool			need_freq_update;
 };
 
@@ -89,8 +90,11 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 	    !cpufreq_this_cpu_can_update(sg_policy->policy))
 		return false;
 
-	if (unlikely(sg_policy->need_freq_update))
+	if (unlikely(sg_policy->limits_changed)) {
+		sg_policy->limits_changed = false;
+		sg_policy->need_freq_update = true;
 		return true;
+	}
 
 	delta_ns = time - sg_policy->last_freq_update_time;
 
@@ -437,7 +441,7 @@ static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
 static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu, struct sugov_policy *sg_policy)
 {
 	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
-		sg_policy->need_freq_update = true;
+		sg_policy->limits_changed = true;
 }
 
 static void sugov_update_single(struct update_util_data *hook, u64 time,
@@ -457,7 +461,8 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	if (!sugov_should_update_freq(sg_policy, time))
 		return;
 
-	busy = sugov_cpu_is_busy(sg_cpu);
+	/* Limits may have changed, don't skip frequency update */
+	busy = !sg_policy->need_freq_update && sugov_cpu_is_busy(sg_cpu);
 
 	util = sugov_get_util(sg_cpu);
 	max = sg_cpu->max;
@@ -831,6 +836,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 	sg_policy->last_freq_update_time	= 0;
 	sg_policy->next_freq			= 0;
 	sg_policy->work_in_progress		= false;
+	sg_policy->limits_changed		= false;
 	sg_policy->need_freq_update		= false;
 	sg_policy->cached_raw_freq		= 0;
 
@@ -879,7 +885,7 @@ static void sugov_limits(struct cpufreq_policy *policy)
 		mutex_unlock(&sg_policy->work_lock);
 	}
 
-	sg_policy->need_freq_update = true;
+	sg_policy->limits_changed = true;
 }
 
 struct cpufreq_governor schedutil_gov = {
-- 
2.21.0.rc0.269.g1a574e7a288b

