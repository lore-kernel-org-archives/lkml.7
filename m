Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9B6C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0336D21479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 11:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zVOW+9TL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbfFSLgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 07:36:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46403 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbfFSLgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 07:36:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id v9so9484509pgr.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 04:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e2RYmyEcM16uV8QAfPAD1VnbVzdNHH04eTPp0y1GpdE=;
        b=zVOW+9TLBbgrCy2ayvjj309DIcUy8Isl/jbni4YWmZwpa+P5KsEELYytIxnt+FC7lN
         dDsV4tWAtwZiyVyrcwibduuryY73DML3oL+dlnFKX+O2yiB7+uKgJUHzq7RV4o0MSLL+
         cfFGac3xplbC+SP8kybt1kOHadOCK3YHUuu26GtorIEgRQzgGrHiZrYimgKcRu26O9M5
         JykjfOtKMz31ughKph5Z5CLOp9fCVHt0gr2FUa7kaYmTFh9vXWEPmVWbuSJBE34GL15q
         d+YVPOmbAUrZM1jmDKiRuYvMxBgj2M/M72J/cSgtofN7h7Y2x0W6Lj35CdJcRtqjdOwV
         kBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e2RYmyEcM16uV8QAfPAD1VnbVzdNHH04eTPp0y1GpdE=;
        b=VVpaFpfmChrPMNwroi9QBpO+Y28MsGclEzMht0Kl21o6BEiaBqJI4WynJka1srHRoX
         CcgjmKjjRYaVF+vRa7+3zs/fYG/FajMtrNwVR+/3Dn7PoPn90b36ld71ukOonVY12ppN
         U+/GobWZK1qfjiBKxkD8mmR16DbYIYkccSKmrIb7b+twXM7d7K2Bs1EQuiLyLOuuVnQi
         NUQVhl7H4kJmsU8qnovmDo/kAMK2AxMhLEVwFlbE4IDV1JzwC3pUYhYpsHfODXZZFUYP
         2KWablcBpTI1EzoUGzuHL3JhDddDDbaf8CF7W/u/1eVqlelJgqVNdlmtL+LHW23Ce9WN
         djBA==
X-Gm-Message-State: APjAAAUrl8ysEWN9gDkh7Yw+6uWURKMiUzYRoEr4V09mk9SVM4USC5LA
        kBAoFMLYH7oFBrhHtfqQYKWlhg==
X-Google-Smtp-Source: APXvYqwMIZ2ELJdp1VAUQ1NsO+BtVwoWBK4MUjp3PHIw9C71RCmnjQGDll3rM61XQaeXGD57fwci0Q==
X-Received: by 2002:a63:1459:: with SMTP id 25mr7319713pgu.201.1560944164850;
        Wed, 19 Jun 2019 04:36:04 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id y22sm17954119pfm.70.2019.06.19.04.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 04:36:04 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] cpufreq: Avoid calling cpufreq_verify_current_freq() from handle_update()
Date:   Wed, 19 Jun 2019 17:05:42 +0530
Message-Id: <5068dd1b268d5beb1c074ca97a3e031dbd560999.1560944014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560944014.git.viresh.kumar@linaro.org>
References: <cover.1560944014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some occasions cpufreq_verify_current_freq() schedules a work whose
callback is handle_update(), which further calls cpufreq_update_policy()
which may end up calling cpufreq_verify_current_freq() again.

On the other hand, when cpufreq_update_policy() is called from
handle_update(), the pointer to the cpufreq policy is already available
but we still call cpufreq_cpu_acquire() to get it in
cpufreq_update_policy(), which should be avoided as well.

Fix both the issues by creating another helper
reeval_frequency_limits().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4556a53fc764..0a73de7aae54 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1115,13 +1115,25 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
 	return ret;
 }
 
+static void reeval_frequency_limits(struct cpufreq_policy *policy)
+{
+	struct cpufreq_policy new_policy = *policy;
+
+	pr_debug("updating policy for CPU %u\n", policy->cpu);
+
+	new_policy.min = policy->user_policy.min;
+	new_policy.max = policy->user_policy.max;
+
+	cpufreq_set_policy(policy, &new_policy);
+}
+
 static void handle_update(struct work_struct *work)
 {
 	struct cpufreq_policy *policy =
 		container_of(work, struct cpufreq_policy, update);
-	unsigned int cpu = policy->cpu;
-	pr_debug("handle_update for cpu %u called\n", cpu);
-	cpufreq_update_policy(cpu);
+
+	pr_debug("handle_update for cpu %u called\n", policy->cpu);
+	reeval_frequency_limits(policy);
 }
 
 static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
@@ -2378,7 +2390,6 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 void cpufreq_update_policy(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
-	struct cpufreq_policy new_policy;
 
 	if (!policy)
 		return;
@@ -2391,12 +2402,7 @@ void cpufreq_update_policy(unsigned int cpu)
 	    (cpufreq_suspended || WARN_ON(!cpufreq_verify_current_freq(policy, false))))
 		goto unlock;
 
-	pr_debug("updating policy for CPU %u\n", cpu);
-	memcpy(&new_policy, policy, sizeof(*policy));
-	new_policy.min = policy->user_policy.min;
-	new_policy.max = policy->user_policy.max;
-
-	cpufreq_set_policy(policy, &new_policy);
+	reeval_frequency_limits(policy);
 
 unlock:
 	cpufreq_cpu_release(policy);
-- 
2.21.0.rc0.269.g1a574e7a288b

