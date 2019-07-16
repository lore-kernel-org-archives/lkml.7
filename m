Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5ECC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C6E2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eWuR4BWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732624AbfGPJta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:49:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34323 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732451AbfGPJt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:49:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so9850605plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 02:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l2pQOR1f7DHhM0Qtl8EEm1QRrX6xqQ9Jku8fM4tSlRk=;
        b=eWuR4BWgpheOmCtw4+kojvX5WouC4KSz5jV/JpYetm1IJwE8WFQ0Y3E7aQ/xgr+pyT
         Qj02V6mPD2oTaWBvK8eWGD/yjZqYozTdGyVRQaFef2A6zxdtGGVUieak0WTn4XKcTws/
         6f6Mgl/IVQho2TwZEldORKlOxns5g6WQwYuUwo9cI2RftvqkqKMbVQBBg8bFA//OhLai
         LQ+3tKZZYAIX3il6vCxYOsCSUTcVstHUp/iTKLFNEriPeHSAQoPX4RK82tH6VSWXa3cN
         qbGbrlFFizujBFgMXiKDSfbc9w1EYJHrb1SIy2prXfP6XkHmOcMjih7XjOAemxAeILj9
         4kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2pQOR1f7DHhM0Qtl8EEm1QRrX6xqQ9Jku8fM4tSlRk=;
        b=oeSdkvDv5siDR1ib3w6tifxL2id41GmwZlr6ZyR4ngH+DXkz2xNNjmmIOj9bGOl6I2
         onxY7bzqI0utJwa6kMRCe46r7Sv8pbuemSkVT3LLIe7BclrZzPMk5QUGhT/Wyxd4pku2
         G7FORSdaLZeOoQIHynSRjm8qYNH2GtwaxmMfeWO4pQb8Vd/uk15tsVHnySeDZK5ldJTQ
         QMR/C1hs+enTv29kKk/R5B1SWyfvsJGR2vpO0nHsDaC8lMnHw+uUcf1bOl4Qtr+KjBGS
         CISmxfx8C//pkACsjM4HHzd036kYwNUB0/+FHogVxZAhRho6sA9mOj911YYbtQg5l2l4
         yxAA==
X-Gm-Message-State: APjAAAVqC1svbapl2P7RSwX72wmZqpsyyOz/PazSpTLmmZofpdufxa10
        7DgmdKkdrOwPVNe7JuwmTRua/g==
X-Google-Smtp-Source: APXvYqzbOOzbjo3FzFCtJezebgRb1OxMiIkrqUibaTnZhvgRbxUBjVWBNq44NgKnsrOO/Hd4KkyUHA==
X-Received: by 2002:a17:902:b591:: with SMTP id a17mr32950833pls.96.1563270568321;
        Tue, 16 Jul 2019 02:49:28 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id f12sm18339014pgo.85.2019.07.16.02.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 02:49:27 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] cpufreq: Add policy create/remove notifiers
Date:   Tue, 16 Jul 2019 15:18:57 +0530
Message-Id: <cc34754314ee513eff9f09c08cd1e325614779ce.1563269894.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563269894.git.viresh.kumar@linaro.org>
References: <cover.1563269894.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit f9f41e3ef99ac9d4e91b07634362e393fb929aad.

We have a new use case for policy create/remove notifiers (for
allocating/freeing QoS requests per policy), lets add them back.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 15 ++++++++++++++-
 include/linux/cpufreq.h   |  2 ++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4d6043ee7834..8a7eff2a3771 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1268,7 +1268,17 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 				   DEV_PM_QOS_MAX_FREQUENCY);
 	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
 				   DEV_PM_QOS_MIN_FREQUENCY);
-	dev_pm_qos_remove_request(policy->max_freq_req);
+
+	if (policy->max_freq_req) {
+		/*
+		 * CPUFREQ_CREATE_POLICY notification is sent only after
+		 * successfully adding max_freq_req request.
+		 */
+		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+					     CPUFREQ_REMOVE_POLICY, policy);
+		dev_pm_qos_remove_request(policy->max_freq_req);
+	}
+
 	dev_pm_qos_remove_request(policy->min_freq_req);
 	kfree(policy->min_freq_req);
 
@@ -1393,6 +1403,9 @@ static int cpufreq_online(unsigned int cpu)
 				ret);
 			goto out_destroy_policy;
 		}
+
+		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+				CPUFREQ_CREATE_POLICY, policy);
 	}
 
 	if (cpufreq_driver->get && has_target()) {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d757a56a74dc..e28c8af697d2 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -458,6 +458,8 @@ static inline void cpufreq_resume(void) {}
 /* Policy Notifiers  */
 #define CPUFREQ_ADJUST			(0)
 #define CPUFREQ_NOTIFY			(1)
+#define CPUFREQ_CREATE_POLICY		(2)
+#define CPUFREQ_REMOVE_POLICY		(3)
 
 #ifdef CONFIG_CPU_FREQ
 int cpufreq_register_notifier(struct notifier_block *nb, unsigned int list);
-- 
2.21.0.rc0.269.g1a574e7a288b

