Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AF4C04E30
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27ECD24654
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 04:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="duEljXxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfLLEMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 23:12:05 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40240 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfLLEL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 23:11:59 -0500
Received: by mail-qk1-f194.google.com with SMTP id c17so521536qkg.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 20:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tpyt5iG8GvXOAcMS3lIsuWdgJqz7gi4VYr1fr05aHWQ=;
        b=duEljXxtpMvFC8/JZAIVfpc+2JH8fpg4gYIS7wciQah12QzxBYgX+rIgvHbC+UykXs
         J8HloSy//1JoycNnC91yQ455dOc9s2juG4F8NiqHfD47Ezh5vd/qtAYZlHY1nJlEhZBe
         5vde5fp+6ow/szA/F/T0XgFb+cGJkcOEMJdn5vY1KikPGe8/6Az5W1IzETfTU9YgLa7z
         XzTfEm2s3+8Aw0CA1jpGv7MnO6lDyfrDutxLEMT+1YektINANuhKCcOb3ivUAthfYQld
         UblqEm+fkmSEnDZABNePuCvzP8A06siJMZnS4drxiAVq6/Y5DUjIEyMsGMoaH8EFY606
         YaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tpyt5iG8GvXOAcMS3lIsuWdgJqz7gi4VYr1fr05aHWQ=;
        b=EX3cvIR178P/Hy1r9HfKQjD7jSlwkoSmceJr86AK12mjRUaNUWyaWXbMHgAoInIS/4
         bFwoboLGpfJZTKJuseUVF6lfKi+ffR6LeoH85qL9EIrh1eC/huEByWb/ilA2frq81NDU
         S4I0k2Q9xc3ap4tnMIEQEP0T6yh/+igMyqHVseEn3LilTsODdfbI7HmIBvEhDT0J5HBI
         4DOPq48Sk+r6nSzzcHgoDd72vJr4IWu1fjYKtlpqcpzD6DxzCAjCTrWEWmBXqjcpLi05
         /YFaxLdc0KZXgB4+8HpuAFtpRFYpV4Cz98afijEKJLGdOng0Ap1rOjoMhY48a+Vsvq5O
         oMKQ==
X-Gm-Message-State: APjAAAVIn+uQeEMGWDVGs0zjYT37yqfZcgKA2mq/hfnBpqaGeGCwYYZ9
        natx3W4o7WiDWluZ2L8zFEkQow==
X-Google-Smtp-Source: APXvYqykfq5nJTw7PbZ84SpWMBir+zF1f7/AUVNMJJEB6Cm4B9y1hci7PFQh2xjLcK/hDGYvDgXcLg==
X-Received: by 2002:ae9:e702:: with SMTP id m2mr6382951qka.208.1576123918930;
        Wed, 11 Dec 2019 20:11:58 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id s11sm1364126qkg.99.2019.12.11.20.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 20:11:58 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v6 6/7] thermal/cpu-cooling: Update thermal pressure in case of a maximum frequency capping
Date:   Wed, 11 Dec 2019 23:11:47 -0500
Message-Id: <1576123908-12105-7-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal governors can request for a cpu's maximum supported frequency to
be capped in case of an overheat event. This in turn means that the
maximum capacity available for tasks to run on the particular cpu is
reduced. Delta between the original maximum capacity and capped maximum
capacity is known as thermal pressure. Enable cpufreq cooling device to
update the thermal pressure in event of a capped maximum frequency.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v4->v5:
	- fixed issues in update_sched_max_capacity comment header.
	- Updated update_sched_max_capacity to calculate maximum available
	  capacity.
v5->v6:
	- Removed update_sched_max_capacity. Instead call directly into
	  arch_set_thermal_pressure to update thermal pressure.

 drivers/thermal/cpu_cooling.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 52569b2..c97c13e 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -430,6 +430,10 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long state)
 {
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+	struct cpumask *cpus;
+	unsigned int frequency;
+	unsigned long capacity;
+	int ret;
 
 	/* Request state should be less than max_level */
 	if (WARN_ON(state > cpufreq_cdev->max_level))
@@ -441,8 +445,19 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 
 	cpufreq_cdev->cpufreq_state = state;
 
-	return freq_qos_update_request(&cpufreq_cdev->qos_req,
-				get_state_freq(cpufreq_cdev, state));
+	frequency = get_state_freq(cpufreq_cdev, state);
+
+	ret = freq_qos_update_request(&cpufreq_cdev->qos_req, frequency);
+
+	if (ret > 0) {
+		cpus = cpufreq_cdev->policy->cpus;
+		capacity = frequency *
+				arch_scale_cpu_capacity(cpumask_first(cpus));
+		capacity /= cpufreq_cdev->policy->cpuinfo.max_freq;
+		arch_set_thermal_pressure(cpus, capacity);
+	}
+
+	return ret;
 }
 
 /* Bind cpufreq callbacks to thermal cooling device ops */
-- 
2.1.4

