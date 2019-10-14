Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13EBC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 00:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788952067B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 00:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZ/nt3MJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbfJNA6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 20:58:39 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40835 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729782AbfJNA6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 20:58:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id y144so14443317qkb.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 17:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3R+KOjFcJxzEj7HZtzek49Os8qr1A4xe9Wtj+wmnLMI=;
        b=sZ/nt3MJoQit3t2N8Ldotj6GBgs9ydlNsOJbMhc+1LM4Iy2EdNza1RSiSgMwBP5TSO
         a7wWBSMFdqkhhwKX60P9vw4okYb6zD+TMHRDpFoi6O2RQa+xarKSYNPbwr7RNF2zaEKZ
         XDCkPoFe2wV8J4a7OUkQQfs0eDv/N+z97P+gSpUeS9vIn6BDGz0ok+0rCmTaw4mLRwZD
         u7ZpzH96c5wig2YXNr1zWnv7mMSD5tfc31dQkmVHSrGOuJXmFgCQqO42buhp7n/EDI/e
         pu550MJ/RDVRiZEZrETjkjQRr4kdV2bKn7cQdLz1boMQoIcWmvU8EFx0HWMbmpnGJdTR
         cvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3R+KOjFcJxzEj7HZtzek49Os8qr1A4xe9Wtj+wmnLMI=;
        b=GHj2VQAOEOnvWPDYmqHQZo/BsfAR2ht7VpaT/sif4DBF6rNrp+60rYIA5PRUe30Pht
         AbQpO9zJsdXFKmDQxpK5AuQEqUucD02KSfF+83TwCGoCZW4Tt5/jbeJirGaF+UV4ANRq
         F10j35H34QzQKaPvbwXaM6n+p12v1tC+daQfJTGlzHqGEesNmrD65sWmNpbtkE2bQYfd
         EtLJVh0mV95hiMT9AktqSVLorbiUfEDROzm8vgR3GyT6hKg3glTtDuCrUpintcwJiAQD
         +sLApqn6zN6hRLPvUgZVOBhIkqTLOTkid7711+i9skCwVJd0Y2YFNEqoTyJjRLkj7GOg
         o93A==
X-Gm-Message-State: APjAAAXB80ASOPUZ8GIZuO+OVt/kWT5S3mkD55j5ir3knK3q6DWEkFQ6
        E7zl6gQ7/LoBcEWQQo5GlGfWzw==
X-Google-Smtp-Source: APXvYqywcDqpUjcBGQubg3W+dQxkljZI+/6esgBtAOBmk5wu7lLZIUgeTcGMRNDHAZcUwmh2r9C/ag==
X-Received: by 2002:a05:620a:12f1:: with SMTP id f17mr27898774qkl.152.1571014715230;
        Sun, 13 Oct 2019 17:58:35 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id c185sm7663901qkf.122.2019.10.13.17.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Oct 2019 17:58:34 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v3 6/7] thermal/cpu-cooling: Update thermal pressure in case of a maximum frequency capping
Date:   Sun, 13 Oct 2019 20:58:24 -0400
Message-Id: <1571014705-19646-7-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
References: <1571014705-19646-1-git-send-email-thara.gopinath@linaro.org>
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
index 391f397..9e2764a 100644
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
+		update_maxcap_capacity(cpu, capacity);
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

