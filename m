Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D0ACA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4627221848
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aGkYnf6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389497AbfJVUeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:34:44 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36329 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389407AbfJVUeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:34:37 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so14264028qto.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UTw/C9YOFOt2girMz7/HTweAfnMneRk1SahAwoeEi/8=;
        b=aGkYnf6z5uRBHSkiivv6AM3qIXlIT5VCPXugOf2w1ms7hIEg+Uz/p4OQDtJ/C/avl2
         N40dP786qDXUTRM6eF2Xn6o0OQJjAV250vcfoAxxYLL2TS5k18TvLX5TdK8jxS0FoetW
         h11byvDgqKOwyVDvqkjFFxG3KQUpYzs0UcIwzD83t1lbOWMR8mGPRvTdfmeKHBsY9hsk
         ChyXQif9WtkMentpyNrEb4QJj2wHAYaOdzrkP550Kqr0182q+oc3tr08V8n/bm9HdKLs
         NGkdP7VtXme67OU/N6Qun1+Os1vvj0gu4bgzySU8Fnq9h0q9XiBR5sKLDAT0/C6/Ewm3
         W+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UTw/C9YOFOt2girMz7/HTweAfnMneRk1SahAwoeEi/8=;
        b=GKQC82juiz8IgpW4Xx6YSuL40x+PBvt6F2aANj+XSGN9Qm4qQaZ8mon7mhgYoMBlfy
         dThomJ/8HDftETHIy7kD74cxSMAbDIP4okpbhlBpex/ipmdwlRIYKjLZ3ctJSv613N5D
         uCZhazyMFSlpMy7qFocwy3lSdDTehF3n/2dV7Mgb6bdiQtpuROHFrD5QmZnrG2HMIXoX
         gbT4H90J1RoiWrEiewCV/mjIuFqpxqPjyg/67zwnX4BM5SJbEQJSasouAZFhmt9QJJPZ
         OBQDDE1RJIL+3x4KRxmiqkfrhJB2nCu2AelajvJ86b6o3t/nArZjahVTz06G7fhp0xq/
         y1TQ==
X-Gm-Message-State: APjAAAUQOUAEMLogIBkU1VAJx5VKcY2A6M3G8VgNczeTxVSfcHTGgw9e
        FUVVDvefCTZCRP21f0IYh39gXA==
X-Google-Smtp-Source: APXvYqwYMAtRE9EftUJJd2GrfOHrpZzFeCSNibUZXKvtjRPPVOMbJKVKX6Tq9tKu40aVZk1KfnMr9g==
X-Received: by 2002:a0c:efcd:: with SMTP id a13mr5135070qvt.94.1571776475947;
        Tue, 22 Oct 2019 13:34:35 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id r126sm8895038qke.98.2019.10.22.13.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Oct 2019 13:34:34 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v4 5/6] thermal/cpu-cooling: Update thermal pressure in case of a maximum frequency capping
Date:   Tue, 22 Oct 2019 16:34:24 -0400
Message-Id: <1571776465-29763-6-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
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
 drivers/thermal/cpu_cooling.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 391f397..2e6a979 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -218,6 +218,23 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 }
 
 /**
+ * update_sched_max_capacity - update scheduler about change in cpu
+ *					max frequency.
+ * @policy - cpufreq policy whose max frequency is capped.
+ */
+static void update_sched_max_capacity(struct cpumask *cpus,
+				      unsigned int cur_max_freq,
+				      unsigned int max_freq)
+{
+	int cpu;
+	unsigned long capacity = (cur_max_freq << SCHED_CAPACITY_SHIFT) /
+				  max_freq;
+
+	for_each_cpu(cpu, cpus)
+		update_thermal_pressure(cpu, capacity);
+}
+
+/**
  * get_load() - get load for a cpu since last updated
  * @cpufreq_cdev:	&struct cpufreq_cooling_device for this cpu
  * @cpu:	cpu number
@@ -320,6 +337,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long state)
 {
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+	int ret;
 
 	/* Request state should be less than max_level */
 	if (WARN_ON(state > cpufreq_cdev->max_level))
@@ -331,8 +349,17 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 
 	cpufreq_cdev->cpufreq_state = state;
 
-	return dev_pm_qos_update_request(&cpufreq_cdev->qos_req,
-				cpufreq_cdev->freq_table[state].frequency);
+	ret = dev_pm_qos_update_request
+				(&cpufreq_cdev->qos_req,
+				 cpufreq_cdev->freq_table[state].frequency);
+
+	if (ret > 0)
+		update_sched_max_capacity
+				(cpufreq_cdev->policy->cpus,
+				 cpufreq_cdev->freq_table[state].frequency,
+				 cpufreq_cdev->policy->cpuinfo.max_freq);
+
+	return ret;
 }
 
 /**
-- 
2.1.4

