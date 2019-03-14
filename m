Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAB0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1E42085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RAUy/ZE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbfCNGn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:43:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34311 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfCNGnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:43:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so3347240pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 23:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lorcbNHNRFiGuz7eBUCSVribuTSrEkumL8TszzbxjzE=;
        b=RAUy/ZE/2HUVSglg0pbU6Z/RrAdT63TPxc7bUux3usECJno//O90wuudOKDCcvBCtx
         xTAJIZqajAEKv1st0pog2fnZG47Mxm3N3NhF7H0TNIF8kvedGrvu//HObZRKeUMkXTHw
         V+jmHs/DlShzFtQvesKJdHHvm9SiMcg56285396HhWSDi9pFH2bwLcxjaYQCKHevb/r+
         NjAQS0v8ZaCje2Q6MUsVztwhgzGaKa2tmiqDpxW/5Q+lANxvrVLOZ/pyi3d4pIQEE/mJ
         OtCx9am3vcsp11RzES7y6vGGI9XQg7xAogBQiIm8p+SwrBW6POGBp+/pZzYimSv4dKa8
         90Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lorcbNHNRFiGuz7eBUCSVribuTSrEkumL8TszzbxjzE=;
        b=fLFXA85wHQR4CXamBJ7eBfma33wxJb3uWQx1iFvC6rNWQSODiDBH8lXQSXQu2USC72
         mFt7S4EqiETFt2cSrd+rYUWXaD8XLsC4qf10lhqBLeFYx1dgxkBCeE4gCkmMsNVeYNtx
         LPiPTsD5UvX8doyg3G+LUXbCabaPRZD7l5V6L6JOXldcH31xJ/WdTCd2/dyznxXFGukH
         LS+3GWb2f6ogTpG/kqyYBpD2hOnbQX7TRkGwMvZltweLKaf5kkKNXXeMKCrtYCHv3Ld9
         OK7671ZGTNqtu2SbOJXvR5NH43BUE49nN8aYUKp3Xs9Dg4TmrfNaDwYXS40+DTg/oQLi
         d44Q==
X-Gm-Message-State: APjAAAVm3ahpBbmd8z0O/WBbTJPogTn7S5iffhqbvXEq0vAgVUtnNDE+
        JtdpOmjabt2hoMLSUJ2aO1P0kQ==
X-Google-Smtp-Source: APXvYqwIIW6dzmk2JsSBenA1IcKwZgqTKG0LG6o6lVpVx4PDXhvngIw7tSCMXe22PloKIQkXeduD+Q==
X-Received: by 2002:a65:41ca:: with SMTP id b10mr43786224pgq.146.1552545802717;
        Wed, 13 Mar 2019 23:43:22 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id k125sm46777131pgc.51.2019.03.13.23.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:43:22 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Russell King <linux@armlinux.org.uk>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] ARM: smp: Update cpufreq transition notifier to handle multiple CPUs
Date:   Thu, 14 Mar 2019 12:12:48 +0530
Message-Id: <4bcc5e47e3b5959e9b1e21578323a84dc9a3c79a.1552545525.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1552545525.git.viresh.kumar@linaro.org>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpufreq core currently calls the cpufreq transition notifier
callback once for each affected CPU. This is going to change soon and
the cpufreq core will call the callback only once for each cpufreq
policy. The callback must look at the newly added field in struct
cpufreq_freqs, "cpus", which contains policy->related_cpus (both
online/offline CPUs) and perform per-cpu actions for them if any.

This patch updates cpufreq_callback() to use the new "cpus" field.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/kernel/smp.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 1d6f5ea522f4..59ee0f4db449 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -758,15 +758,19 @@ static int cpufreq_callback(struct notifier_block *nb,
 					unsigned long val, void *data)
 {
 	struct cpufreq_freqs *freq = data;
-	int cpu = freq->cpu;
+	int cpu, first = cpumask_first(freq->cpus);
+	unsigned int lpj;
 
 	if (freq->flags & CPUFREQ_CONST_LOOPS)
 		return NOTIFY_OK;
 
-	if (!per_cpu(l_p_j_ref, cpu)) {
-		per_cpu(l_p_j_ref, cpu) =
-			per_cpu(cpu_data, cpu).loops_per_jiffy;
-		per_cpu(l_p_j_ref_freq, cpu) = freq->old;
+	if (!per_cpu(l_p_j_ref, first)) {
+		for_each_cpu(cpu, freq->cpus) {
+			per_cpu(l_p_j_ref, cpu) =
+				per_cpu(cpu_data, cpu).loops_per_jiffy;
+			per_cpu(l_p_j_ref_freq, cpu) = freq->old;
+		}
+
 		if (!global_l_p_j_ref) {
 			global_l_p_j_ref = loops_per_jiffy;
 			global_l_p_j_ref_freq = freq->old;
@@ -778,10 +782,11 @@ static int cpufreq_callback(struct notifier_block *nb,
 		loops_per_jiffy = cpufreq_scale(global_l_p_j_ref,
 						global_l_p_j_ref_freq,
 						freq->new);
-		per_cpu(cpu_data, cpu).loops_per_jiffy =
-			cpufreq_scale(per_cpu(l_p_j_ref, cpu),
-					per_cpu(l_p_j_ref_freq, cpu),
-					freq->new);
+
+		lpj = cpufreq_scale(per_cpu(l_p_j_ref, first),
+				    per_cpu(l_p_j_ref_freq, first), freq->new);
+		for_each_cpu(cpu, freq->cpus)
+			per_cpu(cpu_data, cpu).loops_per_jiffy = lpj;
 	}
 	return NOTIFY_OK;
 }
-- 
2.21.0.rc0.269.g1a574e7a288b

