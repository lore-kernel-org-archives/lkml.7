Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95443C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5A621882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 18:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgKe8F71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390848AbfKESuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 13:50:02 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44881 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390827AbfKESt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 13:49:56 -0500
Received: by mail-qk1-f195.google.com with SMTP id m16so21790562qki.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 10:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CG7OyLBYjzLCAG4H5jKpLvvKWoPx2TvWNE2pLKqlhn0=;
        b=hgKe8F71HOeu6/wF3M0ARl/hvxLi5HrtK8or4YBExUXSTvdLLvtOAh05PUb8C1dedy
         eeuIG9u2ICb//KPinErDIy/g4ZueCX6OiIJE9VQfLO+tiZXXV7sGiu0mb96wRO/4Q1Sj
         +3V91qEqItS3wkCi8gVNXz5CUTK9t+yWcrUbKQ5O4/pGgVrM9gduZpaQDOThrDixS0BN
         CDm6npYX2Cr03ox8aqEOzpQQgt3sXiI/vdHLiC35dq2kfbR0VAP5h2kTBFPe2pr/v5CQ
         9pq6Lg5B6IUu/mTfqWEsPFHY0cOWvEwDowTMrcHnmwxv3XO4frTHhJ+aIDlj0nAS6CDp
         hRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CG7OyLBYjzLCAG4H5jKpLvvKWoPx2TvWNE2pLKqlhn0=;
        b=nlqjBx5p7aE87LWDgLdp1NPa0ml9SoZWn7X5KnPONI6NYA+7Kk2A8Y4xhXzhraAyfu
         q4sCdq4b6j++FgYpGW5XZ21irvu7WR3j/3CfvxN0FZXXYwNQEYbInuhNwXNt4MSWrcLj
         KsbowpMCwtTe3GgJaByrS4lcWVdZtfwLsPrB43eY3McNEPs70qNLOXVxIOOkdI8+pkUA
         SKMsV/+mK0NGh6rpIHbC9JQ0e52Q1dUHHL7q7wr7zvylY88nVUDo9jWW8NziwSffZFWp
         QqOXkJajtpxyBhypWwUyCL2wn575sU59fBJjLzqqeW3AYOp5RPxwLQO1VZWakTBgX5hG
         bgsw==
X-Gm-Message-State: APjAAAXNslJSilynUALFzwDrPBgDDkq7MvUoF3pppIFeCeJ2tBW1c8cX
        cXgfa+r24MS76Y48bCiKxAhxBA==
X-Google-Smtp-Source: APXvYqw2dO4+5wZOWHCAI5fpNneII7GTpieahTJ1txP4WOmqCtDgmFw4VaEoHHJGDeTXldpqECC1og==
X-Received: by 2002:a37:4f4e:: with SMTP id d75mr8315091qkb.490.1572979794552;
        Tue, 05 Nov 2019 10:49:54 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id j7sm6832565qkd.46.2019.11.05.10.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Nov 2019 10:49:53 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v5 5/6] thermal/cpu-cooling: Update thermal pressure in case of a maximum frequency capping
Date:   Tue,  5 Nov 2019 13:49:45 -0500
Message-Id: <1572979786-20361-6-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal governors can request for a cpu's maximum supported frequency
to be capped in case of an overheat event. This in turn means that the
maximum capacity available for tasks to run on the particular cpu is
reduced. Delta between the original maximum capacity and capped
maximum capacity is known as thermal pressure. Enable cpufreq cooling
device to update the thermal pressure in event of a capped
maximum frequency.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v4->v5:
	- fixed issues in update_sched_max_capacity comment header.
	- Updated update_sched_max_capacity to calculate maximum available
	  capacity.

 drivers/thermal/cpu_cooling.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 391f397..c65b7c4 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -218,6 +218,27 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 }
 
 /**
+ * update_sched_max_capacity - update scheduler about change in cpu
+ *				max frequency.
+ * @cpus: list of cpus whose max capacity needs udating in scheduler.
+ * @cur_max_freq: current maximum frequency.
+ * @max_freq: highest possible frequency.
+ */
+static void update_sched_max_capacity(struct cpumask *cpus,
+				      unsigned int cur_max_freq,
+				      unsigned int max_freq)
+{
+	int cpu;
+	unsigned long capacity;
+
+	for_each_cpu(cpu, cpus) {
+		capacity = cur_max_freq * arch_scale_cpu_capacity(cpu);
+		capacity /= max_freq;
+		update_thermal_pressure(cpu, capacity);
+	}
+}
+
+/**
  * get_load() - get load for a cpu since last updated
  * @cpufreq_cdev:	&struct cpufreq_cooling_device for this cpu
  * @cpu:	cpu number
@@ -320,6 +341,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long state)
 {
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+	int ret;
 
 	/* Request state should be less than max_level */
 	if (WARN_ON(state > cpufreq_cdev->max_level))
@@ -331,8 +353,18 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 
 	cpufreq_cdev->cpufreq_state = state;
 
-	return dev_pm_qos_update_request(&cpufreq_cdev->qos_req,
-				cpufreq_cdev->freq_table[state].frequency);
+	ret = dev_pm_qos_update_request
+				(&cpufreq_cdev->qos_req,
+				 cpufreq_cdev->freq_table[state].frequency);
+
+	if (ret > 0) {
+		update_sched_max_capacity
+				(cpufreq_cdev->policy->cpus,
+				 cpufreq_cdev->freq_table[state].frequency,
+				 cpufreq_cdev->policy->cpuinfo.max_freq);
+	}
+
+	return ret;
 }
 
 /**
-- 
2.1.4

