Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E109C48BDF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 03:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8C4214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 03:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZNUy2MON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbfFTDGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 23:06:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39117 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731484AbfFTDGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 23:06:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so759155pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 20:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TMflq8N+0gjwZQm7aaR4fEWjevpmJ2Km/I3/aGC/zcs=;
        b=ZNUy2MONhgLF1lafsmoV82IjMwCDRyO67e6vU6uxmW8r8mR9TMabEg8rxq+V2PPMoF
         BNhUteqN7mXp+M0efsJ5FV5HmzazwLknBYJZHwGjEeMWx/NgEuVSEM5e0UPMgTeZUdJI
         +trRM8DLhvF9TNqIB66tlgWzAvnPgpQ0R6RkP7C7Vi7FeuwBhop9Fzty0WCAIHZ7UeJd
         lY/kj4RpQ1LjllGKuzXvi8+8tmvjzLlabA7bEXcaEZPlaTQpSyfm1y1d1ydy026YP5Wi
         O1DSLajERamfdYeYivu9LH/caoZIbU0uvn+2/MaLe6ChED57WXGHaKDR+ycoT0JPLxHB
         AIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TMflq8N+0gjwZQm7aaR4fEWjevpmJ2Km/I3/aGC/zcs=;
        b=TXU6qUPWwtkaaryd2squaawQVHGQuA95urDmEFa1YpoR1gscR20vhm6mL8WVGIbU7n
         CRkpflyr1yoB5fvOPxFhhY3HSQ9m7lPPGYOlzciCtVeL4IyhZ1WtjqZ4ysZ7RZyj+5B4
         rAs4MjVB65irCtm1QfgH1u//UhLHA8BkaoK+bz15rbU/RKcmHdd5YaLiPLuo57UtCNaE
         2drSNVXu7HFBBICnqZMMXL92MbloyAdolFiXuZOVuzRdGOCoj0BRWdXuhnMwMds5mltM
         SUIlzzSVTidIJKsGbVQ9Sa/pZ3w1cMIzIhNkMIBOsHq+opT+PgNemh2V/KNVESs6gADS
         0P1Q==
X-Gm-Message-State: APjAAAX8w3WV6yyI0VQJf1jFxFdxIpQlWhgHrsRyPwSaR0oY1VLg+3Kg
        aQRDBQiPz1MDYaYL8/DznPAFlA==
X-Google-Smtp-Source: APXvYqzyolSilGn5mAiks5SpWxy27bF6gE3/LacDC38aiGw0cn3KR5TcrhZh5r96Dj41PBvC5QYvsQ==
X-Received: by 2002:a17:902:9689:: with SMTP id n9mr26502959plp.241.1560999992550;
        Wed, 19 Jun 2019 20:06:32 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id f14sm26149488pfn.53.2019.06.19.20.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 20:06:32 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/5] cpufreq: Reuse cpufreq_update_current_freq() in __cpufreq_get()
Date:   Thu, 20 Jun 2019 08:35:49 +0530
Message-Id: <ca50bfa4160ca26b2c6d9c4edf7aae1dcf3fae1e.1560999838.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560999838.git.viresh.kumar@linaro.org>
References: <cover.1560999838.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Their implementations are quite similar, lets modify
cpufreq_update_current_freq() a little and use it from __cpufreq_get().

Also rename cpufreq_update_current_freq() to
cpufreq_verify_current_freq(), as that's what it is doing.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 70 ++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 42 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 5f5c7a516c74..4556a53fc764 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1547,6 +1547,30 @@ static void cpufreq_out_of_sync(struct cpufreq_policy *policy,
 	cpufreq_freq_transition_end(policy, &freqs, 0);
 }
 
+static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, bool update)
+{
+	unsigned int new_freq;
+
+	new_freq = cpufreq_driver->get(policy->cpu);
+	if (!new_freq)
+		return 0;
+
+	/*
+	 * If fast frequency switching is used with the given policy, the check
+	 * against policy->cur is pointless, so skip it in that case.
+	 */
+	if (policy->fast_switch_enabled || !has_target())
+		return new_freq;
+
+	if (policy->cur != new_freq) {
+		cpufreq_out_of_sync(policy, new_freq);
+		if (update)
+			schedule_work(&policy->update);
+	}
+
+	return new_freq;
+}
+
 /**
  * cpufreq_quick_get - get the CPU frequency (in kHz) from policy->cur
  * @cpu: CPU number
@@ -1602,30 +1626,10 @@ EXPORT_SYMBOL(cpufreq_quick_get_max);
 
 static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
 {
-	unsigned int ret_freq = 0;
-
 	if (unlikely(policy_is_inactive(policy)))
-		return ret_freq;
-
-	ret_freq = cpufreq_driver->get(policy->cpu);
-
-	/*
-	 * If fast frequency switching is used with the given policy, the check
-	 * against policy->cur is pointless, so skip it in that case too.
-	 */
-	if (policy->fast_switch_enabled)
-		return ret_freq;
-
-	if (has_target() && ret_freq && policy->cur) {
-		/* verify no discrepancy between actual and
-					saved value exists */
-		if (unlikely(ret_freq != policy->cur)) {
-			cpufreq_out_of_sync(policy, ret_freq);
-			schedule_work(&policy->update);
-		}
-	}
+		return 0;
 
-	return ret_freq;
+	return cpufreq_verify_current_freq(policy, true);
 }
 
 /**
@@ -1652,24 +1656,6 @@ unsigned int cpufreq_get(unsigned int cpu)
 }
 EXPORT_SYMBOL(cpufreq_get);
 
-static unsigned int cpufreq_update_current_freq(struct cpufreq_policy *policy)
-{
-	unsigned int new_freq;
-
-	new_freq = cpufreq_driver->get(policy->cpu);
-	if (!new_freq)
-		return 0;
-
-	if (!policy->cur) {
-		pr_debug("cpufreq: Driver did not initialize current freq\n");
-		policy->cur = new_freq;
-	} else if (policy->cur != new_freq && has_target()) {
-		cpufreq_out_of_sync(policy, new_freq);
-	}
-
-	return new_freq;
-}
-
 static struct subsys_interface cpufreq_interface = {
 	.name		= "cpufreq",
 	.subsys		= &cpu_subsys,
@@ -2151,7 +2137,7 @@ static int cpufreq_start_governor(struct cpufreq_policy *policy)
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
 
 	if (cpufreq_driver->get)
-		cpufreq_update_current_freq(policy);
+		cpufreq_verify_current_freq(policy, false);
 
 	if (policy->governor->start) {
 		ret = policy->governor->start(policy);
@@ -2402,7 +2388,7 @@ void cpufreq_update_policy(unsigned int cpu)
 	 * -> ask driver for current freq and notify governors about a change
 	 */
 	if (cpufreq_driver->get && has_target() &&
-	    (cpufreq_suspended || WARN_ON(!cpufreq_update_current_freq(policy))))
+	    (cpufreq_suspended || WARN_ON(!cpufreq_verify_current_freq(policy, false))))
 		goto unlock;
 
 	pr_debug("updating policy for CPU %u\n", cpu);
-- 
2.21.0.rc0.269.g1a574e7a288b

