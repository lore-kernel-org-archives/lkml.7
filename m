Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946EFC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 03:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C14D21537
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 03:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZpCjpoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbfFTDGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 23:06:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42243 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731568AbfFTDGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 23:06:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so743644plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 20:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e2RYmyEcM16uV8QAfPAD1VnbVzdNHH04eTPp0y1GpdE=;
        b=DZpCjpoaZQW45P9CeX3cDnXJU8tmgG817TlOWAKnWM3+mxcgfgm3MwAPNIg9q4WlvV
         mxtLg3/edOddOGSsNdFJOoqaFkOTbcpVBLqWc2jSUjY4oQRgpg6KvzAKnEV+JWGRuC73
         OZ3oZSW5R8KBELMniexMbEYBACrBKo+9LhUcWFjJh9QdgMU9LnxJEAW8jFyse4XNhwdQ
         puK1HEQGkiyJ2onBQOeVMyTJniUw2w0lHWkbNeg5lHXSm+NdCw64T8mBHyJME0v1l889
         DgFB1MSOoZ0JINkcsQMd7q1v31Qw6rjZ3u6h1O3/JhzIXaDbFFaoRiX+Ddv995jaznf2
         CONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e2RYmyEcM16uV8QAfPAD1VnbVzdNHH04eTPp0y1GpdE=;
        b=e50+A+s7LCTgQey0k6AS6qCBboXBCYLsche4RRIykHVmiWHmlMFa5ByzIIfoQsYQpD
         SgDzGcywrXoLcHxgkw0UAhB7g0CCJxNNi64l89WpuyPSDnyfG7ZvI/jXgokwA0HDDRsF
         25hoUvnKVZGODiIhwJ2bZmU5f3akRBqkHEwGOjLNv3xGZAC6qSB7QHtliPmJ+Zb6B+RI
         lkFFfkEeinzTVvsFC53HQAFf5G2oeQpRAPVL1mPvO4bJYc4ycVCugL5zkTTN8SiAXGYQ
         ed3sz+nRxMcixAHam52VGaTBBt0QF5u70DXBr4MSJ/0ai5okYPbanGepHm/aZX80q7Hm
         ua3A==
X-Gm-Message-State: APjAAAW1Ajc6wIUM74jrXQYBp7FreW/TNwpqBb6J6xgGBDI91ugfvYVb
        yNILVmZthUw+EYrKwm/MYW4hPcMEBa4=
X-Google-Smtp-Source: APXvYqw3FncPDprKfdEYf7q4+OqbC8vh5kSAFntM0Xso4RIi81R/M+KB2gM8MIZO7WfCN0JX8cQd/A==
X-Received: by 2002:a17:902:27a8:: with SMTP id d37mr123268486plb.150.1560999995255;
        Wed, 19 Jun 2019 20:06:35 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id b135sm19459543pfb.44.2019.06.19.20.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 20:06:34 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/5] cpufreq: Avoid calling cpufreq_verify_current_freq() from handle_update()
Date:   Thu, 20 Jun 2019 08:35:50 +0530
Message-Id: <ea598384a9ba18e20b598863ce339a55093be5f6.1560999838.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560999838.git.viresh.kumar@linaro.org>
References: <cover.1560999838.git.viresh.kumar@linaro.org>
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

