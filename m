Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE496C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7CF20848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxn/ScnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfDOLEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:04:08 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44591 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfDOLEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:04:06 -0400
Received: by mail-lf1-f65.google.com with SMTP id h18so12702171lfj.11;
        Mon, 15 Apr 2019 04:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AfqQj4LosvrBs0t9V4YR9zRcAViPll1FJwLBmr/ALnA=;
        b=uxn/ScnPYelou5esbVJGv+JHvuD4O1Uc8qV1Y4WBvrGykwbgboahB1kTadkQ1DRXuS
         cYU9zJq5ihiau3UbcddvFUhG/uUWc60m7jb8gka8qEuLCE7WqRj+mkaii/+67JWlNvd/
         Bp2La+s3SYUGwIsm2JCbIzi1aXjqRjdQ+bprCdxj/my9Iz1hXIX/3MY9BRx0M3j3zvSh
         jhS6yIk+Tn92w84yepdPUPjrlaQeFSYcZmJF+w1xdxQOpBGj3fmiztsCj9Ucu8M0MVeb
         xZp+N9i4gDK/+JYGkad0gye1vab9WdQVTIMTVxJfDnZPzB1OnemPZS8bAGNt2j3wxgM3
         5OKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AfqQj4LosvrBs0t9V4YR9zRcAViPll1FJwLBmr/ALnA=;
        b=YEAZyUejKudiWZBzc4lyon2hqbY152wMquwWD+X/1y6BN1fUP+bZqfFLiWTKTNk8An
         qwj7w/QOBg5KgaYJlZgIp2ZslyWS2wUyPUOZzGWbZJNVOoz4/rooG26fNDu5571YrTA3
         eIJo927MOFnZ2dVkg6YhbzCm+pQTDcW8TnqmMHv98moCYXQoJ0fy16wkI5jLDYyPvNy6
         REMYTv1i97Tzl4iAQGA6BO8hJRUoEgkZtIZCBb00+j34y7BkI1eyzVH21qmlPvjwr6ql
         F5ekhCteXrHp05IJhm1/UyDefMXY5xS0bCKVvn+eiyJbWa6jcsUfkMT7dSCHO5jxbCLP
         k7Nw==
X-Gm-Message-State: APjAAAXbmwSUi7l4HSi1jTbNdhQrUFltPtT0GxFe/EVediB8ip70YV5k
        Khb38zlyeJHQawXhf9fgPgM=
X-Google-Smtp-Source: APXvYqxkn7jjEgtJIyqaIIoDdGKT6PlVDtdZgOP59ibRHI4utoVZnKLJkU/h/K3r/+hRKd5zZly5zQ==
X-Received: by 2002:a19:c51a:: with SMTP id w26mr37611738lfe.59.1555326244733;
        Mon, 15 Apr 2019 04:04:04 -0700 (PDT)
Received: from localhost.localdomain (46-243-146.internethome.cytanet.com.cy. [46.199.243.146])
        by smtp.gmail.com with ESMTPSA id v10sm9822345lfe.3.2019.04.15.04.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 04:04:03 -0700 (PDT)
From:   Mohan Kumar <mohankumar718@gmail.com>
To:     rjw@rjwysocki.net
Cc:     viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND] drivers/cpufreq/acpi-cpufreq.c: This fixes the following  checkpatch warning
Date:   Mon, 15 Apr 2019 14:03:58 +0300
Message-Id: <1555326238-3612-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Prefer using '"%s...", __func__' to using function's name, in a
string

Switch hardcoded function name with a reference to __func__ making the
code more maintainable

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index c72258a..73bb2aa 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -366,7 +366,7 @@ static u32 get_cur_val(const struct cpumask *mask, struct acpi_cpufreq_data *dat
 
 	val = drv_read(data, mask);
 
-	pr_debug("get_cur_val = %u\n", val);
+	pr_debug("%s = %u\n", __func__, val);
 
 	return val;
 }
@@ -378,7 +378,7 @@ static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
 	unsigned int freq;
 	unsigned int cached_freq;
 
-	pr_debug("get_cur_freq_on_cpu (%d)\n", cpu);
+	pr_debug("%s (%d)\n", __func__, cpu);
 
 	policy = cpufreq_cpu_get_raw(cpu);
 	if (unlikely(!policy))
@@ -458,8 +458,7 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
 	if (acpi_pstate_strict) {
 		if (!check_freqs(policy, mask,
 				 policy->freq_table[index].frequency)) {
-			pr_debug("acpi_cpufreq_target failed (%d)\n",
-				policy->cpu);
+			pr_debug("%s (%d)\n", __func__, policy->cpu);
 			result = -EAGAIN;
 		}
 	}
@@ -573,7 +572,7 @@ static int cpufreq_boost_down_prep(unsigned int cpu)
 static int __init acpi_cpufreq_early_init(void)
 {
 	unsigned int i;
-	pr_debug("acpi_cpufreq_early_init\n");
+	pr_debug("%s\n", __func__);
 
 	acpi_perf_data = alloc_percpu(struct acpi_processor_performance);
 	if (!acpi_perf_data) {
@@ -657,7 +656,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	static int blacklisted;
 #endif
 
-	pr_debug("acpi_cpufreq_cpu_init\n");
+	pr_debug("%s\n", __func__);
 
 #ifdef CONFIG_SMP
 	if (blacklisted)
@@ -856,7 +855,7 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct acpi_cpufreq_data *data = policy->driver_data;
 
-	pr_debug("acpi_cpufreq_cpu_exit\n");
+	pr_debug("%s\n", __func__);
 
 	policy->fast_switch_possible = false;
 	policy->driver_data = NULL;
@@ -881,7 +880,7 @@ static int acpi_cpufreq_resume(struct cpufreq_policy *policy)
 {
 	struct acpi_cpufreq_data *data = policy->driver_data;
 
-	pr_debug("acpi_cpufreq_resume\n");
+	pr_debug("%s\n", __func__);
 
 	data->resume = 1;
 
@@ -954,7 +953,7 @@ static int __init acpi_cpufreq_init(void)
 	if (cpufreq_get_current_driver())
 		return -EEXIST;
 
-	pr_debug("acpi_cpufreq_init\n");
+	pr_debug("%s\n", __func__);
 
 	ret = acpi_cpufreq_early_init();
 	if (ret)
@@ -991,7 +990,7 @@ static int __init acpi_cpufreq_init(void)
 
 static void __exit acpi_cpufreq_exit(void)
 {
-	pr_debug("acpi_cpufreq_exit\n");
+	pr_debug("%s\n", __func__);
 
 	acpi_cpufreq_boost_exit();
 
-- 
2.7.4

