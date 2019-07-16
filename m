Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0233C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B7F20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1uaGUoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733279AbfGPJz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:55:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45116 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733241AbfGPJzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:55:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so9163222pgp.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 02:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=igbw8Lq9b0TFNBWb47jJMKCAo+bPsNo96FEJcJLrXVc=;
        b=H1uaGUoAeqRk6S2i3GDT8ntkwDm5cC2Flj+OsmfRqTVZQOoqEeOTDCKsdr3QFfWCQA
         jIPdgK/siD6VGKOf89ZSbHQ+j1jPeChgW95ao4XWPlukec3p7kpdOUigGHiApEVT7fAi
         EafM7d2Qy7MqOBAe6k5q7qDDPhMD7AdzffO+i9yl3vvgOzpHm4gVd5lgQ58XayNvMuhh
         4UHcVXOZ220ePO6/sNBsel0AOBBiS4C4rr5kGcrP7M+qOUm5wTvGLrYjEKbctD6LwlTU
         SwW+LMRxd/hv3ImIN9xUrJOoCbpaTxkwlDmUIlUNaY9z8ypRk3RqDmqs5LVX7Tr8mz87
         okiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igbw8Lq9b0TFNBWb47jJMKCAo+bPsNo96FEJcJLrXVc=;
        b=Nuz2a63I76ukqpUYhHn1dd47zBuoYL0UHctIpBrH+r2WC2GuuYLRQW2XUVwENjNhU3
         EmOGp+Bo6tO2MkEKU8xzIYPlaI/ii5BQkYcNyL6z8ne9Kbc0HR/t9+URmDWzv+yDIKgi
         ZWppTqoVZFLU92BeLEzfC/5vYJTETvTdRnOw+vtyySmyMPY12Y9LiToDn1lLSeuwXwke
         wOPqV05g1lSXpXw6ZeU5Kd80iqAB1l3JnDKoY9gUDQO0nJFlJP+epz/vQB5rtPL3ZATM
         cZvuUxReYP9WVVT/uOFdjshAEMrSCVkrAc4xOomp/TGEKQzpf9yaX39EMb4iFt0fJf+j
         UVEw==
X-Gm-Message-State: APjAAAX1N+X//Kzo04s1FQj1b6ghMejhr5g2iQrJv9zIHmu5iJfMAIzD
        P+znxj80LpAAP0jgFQ9GtE6oTQ==
X-Google-Smtp-Source: APXvYqyE+7Bc3mdRY/8YtnwTZaQfSALWQTjULeSe8UmU3bSLLn/OuNURlj4XozcnY0IUCtzfztxAaA==
X-Received: by 2002:a17:90a:d14b:: with SMTP id t11mr34976911pjw.79.1563270923963;
        Tue, 16 Jul 2019 02:55:23 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id d14sm27038469pfo.154.2019.07.16.02.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 02:55:23 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] cpufreq: Remove CPUFREQ_ADJUST and CPUFREQ_NOTIFY policy notifier events
Date:   Tue, 16 Jul 2019 15:24:53 +0530
Message-Id: <77857b9eadc26c57de2637fcca014239a93551e4.1563270828.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563270828.git.viresh.kumar@linaro.org>
References: <cover.1563270828.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No driver makes reference to these events now, remove them and the code
related to them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 36 +++++++-----------------------------
 include/linux/cpufreq.h   |  6 ++----
 2 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8a7eff2a3771..bd91091ed6b8 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2362,15 +2362,13 @@ EXPORT_SYMBOL(cpufreq_get_policy);
  * @policy: Policy object to modify.
  * @new_policy: New policy data.
  *
- * Pass @new_policy to the cpufreq driver's ->verify() callback, run the
- * installed policy notifiers for it with the CPUFREQ_ADJUST value, pass it to
- * the driver's ->verify() callback again and run the notifiers for it again
- * with the CPUFREQ_NOTIFY value.  Next, copy the min and max parameters
- * of @new_policy to @policy and either invoke the driver's ->setpolicy()
- * callback (if present) or carry out a governor update for @policy.  That is,
- * run the current governor's ->limits() callback (if the governor field in
- * @new_policy points to the same object as the one in @policy) or replace the
- * governor for @policy with the new one stored in @new_policy.
+ * Pass @new_policy to the cpufreq driver's ->verify() callback. Next, copy the
+ * min and max parameters of @new_policy to @policy and either invoke the
+ * driver's ->setpolicy() callback (if present) or carry out a governor update
+ * for @policy.  That is, run the current governor's ->limits() callback (if the
+ * governor field in @new_policy points to the same object as the one in
+ * @policy) or replace the governor for @policy with the new one stored in
+ * @new_policy.
  *
  * The cpuinfo part of @policy is not updated by this function.
  */
@@ -2398,26 +2396,6 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
 	if (ret)
 		return ret;
 
-	/*
-	 * The notifier-chain shall be removed once all the users of
-	 * CPUFREQ_ADJUST are moved to use the QoS framework.
-	 */
-	/* adjust if necessary - all reasons */
-	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
-			CPUFREQ_ADJUST, new_policy);
-
-	/*
-	 * verify the cpu speed can be set within this limit, which might be
-	 * different to the first one
-	 */
-	ret = cpufreq_driver->verify(new_policy);
-	if (ret)
-		return ret;
-
-	/* notification of the new policy */
-	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
-			CPUFREQ_NOTIFY, new_policy);
-
 	policy->min = new_policy->min;
 	policy->max = new_policy->max;
 	trace_cpu_frequency_limits(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index e28c8af697d2..cb1e86a14c7a 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -456,10 +456,8 @@ static inline void cpufreq_resume(void) {}
 #define CPUFREQ_POSTCHANGE		(1)
 
 /* Policy Notifiers  */
-#define CPUFREQ_ADJUST			(0)
-#define CPUFREQ_NOTIFY			(1)
-#define CPUFREQ_CREATE_POLICY		(2)
-#define CPUFREQ_REMOVE_POLICY		(3)
+#define CPUFREQ_CREATE_POLICY		(0)
+#define CPUFREQ_REMOVE_POLICY		(1)
 
 #ifdef CONFIG_CPU_FREQ
 int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list);
-- 
2.21.0.rc0.269.g1a574e7a288b

