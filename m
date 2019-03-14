Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B05C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C844D21874
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e2f9gNBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfCNGnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:43:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42051 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfCNGnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:43:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id r15so419119pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 23:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0q7wZymeH6QqFsG9AA4K1Do0jtBWhLLOyNtabXc8k0o=;
        b=e2f9gNBlYEWuXa2CwsbFYUetQv65ml4yHtL/OudyWC3eKfR6m9REPWpKSmidhyfLyP
         xdfO0TAuS5/RMwRjsU+CKwOWhlz3uMd7cIgMnLKWk4BQFoKt/y54b2uW1cN/bYX1QeMc
         f3ys68X94sUjqTXUtczJ/S42k5n9Xc3CvksVDUpe8PurFeeusCVtjfXrPj8BeDCvQ70G
         KxzpSxLi2WPMpy16Xnp79kWyEjrj8y9HBnb8BpHW++Q220Qwal42TpNLLpuylCVxwf1+
         gIcOvrYpXTui55qhSGNRH/4IRmjYHjikksVtC64/Y/0yP9Zyw4F6aiqSFgKXjANoEF87
         z6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0q7wZymeH6QqFsG9AA4K1Do0jtBWhLLOyNtabXc8k0o=;
        b=G8EMYu7UcbSjD0bIIVV/oYzP5obOktnIqnNFnAxkOLPQvAGFQPXpSJ0ZN9m4I6flH0
         qKtmQAPkNK+HeV7J/RzoBhWD1190KCbdN1Mpp+DGXhi7tlLyljvosfS/4QMXMFUCcn5J
         lkTkS5tEADaNbXSIsXghlAc5EGbE52J76TiDVRoRquWd9CDmL0R8Deb6kzNPZYlThsyo
         lTMIJFLUKqs16iWQ7Idj00QcptGWXilYLAZGuztFwbMztwj9QV0IvPgLchI2U8Ge2DXX
         DOMA/K6Iz6iBSwBxuLLAzggWqLDG8R8ag5ItRcEwlevZJ6s2NuZ1DFV4ai1lwEHrNtOE
         mIdQ==
X-Gm-Message-State: APjAAAWo1kZepSzwCJOTztXksN2kh4v5HjQ6Y8m4qltx3qFHMz2zW222
        0V02FbA7WklLFvq/z2W5G7kuNA==
X-Google-Smtp-Source: APXvYqzdAtsOhCuAo7yAt25Up4IvAt/zRzaH/dcDugDWZ50C4E0HbvhfWGjwc/LMAAysnRzjcH2pCA==
X-Received: by 2002:a65:4547:: with SMTP id x7mr35330583pgr.350.1552545818634;
        Wed, 13 Mar 2019 23:43:38 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id g3sm17815930pgg.41.2019.03.13.23.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:43:37 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] cpufreq: Call transition notifiers only once for each policy
Date:   Thu, 14 Mar 2019 12:12:53 +0530
Message-Id: <f98b170e408ec425c8d23067514cf063c8025c6e.1552545525.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1552545525.git.viresh.kumar@linaro.org>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the transition notifier callbacks are updated to not rely
on freqs->cpu and perform actions for all CPUs in the freqs->cpus field,
it is time to get rid of freqs->cpu field and call the notifiers only
once for each cpufreq policy.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 18 +++++++++---------
 include/linux/cpufreq.h   |  1 -
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b1b012169f00..ecea73598956 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -306,6 +306,8 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 				      struct cpufreq_freqs *freqs,
 				      unsigned int state)
 {
+	int cpu;
+
 	BUG_ON(irqs_disabled());
 
 	if (cpufreq_disabled())
@@ -331,10 +333,8 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 			}
 		}
 
-		for_each_cpu(freqs->cpu, policy->cpus) {
-			srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
-						 CPUFREQ_PRECHANGE, freqs);
-		}
+		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
+					 CPUFREQ_PRECHANGE, freqs);
 
 		adjust_jiffies(CPUFREQ_PRECHANGE, freqs);
 		break;
@@ -344,11 +344,11 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 		pr_debug("FREQ: %u - CPUs: %*pbl\n", freqs->new,
 			 cpumask_pr_args(policy->cpus));
 
-		for_each_cpu(freqs->cpu, policy->cpus) {
-			trace_cpu_frequency(freqs->new, freqs->cpu);
-			srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
-						 CPUFREQ_POSTCHANGE, freqs);
-		}
+		for_each_cpu(cpu, policy->cpus)
+			trace_cpu_frequency(freqs->new, cpu);
+
+		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
+					 CPUFREQ_POSTCHANGE, freqs);
 
 		cpufreq_stats_record_transition(policy, freqs->new);
 		policy->cur = freqs->new;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index dd318363dfc2..1af7ecad30c1 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -44,7 +44,6 @@ enum cpufreq_table_sorting {
 
 struct cpufreq_freqs {
 	struct cpumask *cpus;
-	unsigned int cpu;	/* cpu nr */
 	unsigned int old;
 	unsigned int new;
 	u8 flags;		/* flags of cpufreq_driver, see below. */
-- 
2.21.0.rc0.269.g1a574e7a288b

