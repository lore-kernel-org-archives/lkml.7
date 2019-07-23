Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACBFC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A8520578
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="acOECtFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbfGWGO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 02:14:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37888 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731307AbfGWGOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:14:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id az7so20162193plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 23:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nSry5tHM9RfBOmIKpr9LmoQMa70G9y55/xkG15xZ4dM=;
        b=acOECtFzXcNr8wH91jVpU+QCAxg4f02keJtwJpfZ71lbvRGloj62uIAu74gaAy0Bo0
         S51fFMkXeSB0ABaR8PMZ7u9iHNj7/Jxegy3RYT5dfp4kHfGC4FhBI2jZYsu6PiDQRssw
         jhswXrVHzcxqk5BriDTnks0Nsemh2eF6IPFFso9iPH4hdvv6SJQ0JoeKrgOoXctaclcD
         7oExmNPhSNYCLwoj9Ku6ftzNhW7eyqdJfhCnrHfFVT2jqHYxT5Roj5+jvEvWAO9+9k58
         RvPxHt+csJ4SL0bHacKFmdRa2jFNzLobeo29CPPIlpdnqM3GCqJba/1uH61dfhtylHsQ
         pu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nSry5tHM9RfBOmIKpr9LmoQMa70G9y55/xkG15xZ4dM=;
        b=WanozS06YleopqKu9R2ND8H+eGpKgV+kuq1W+apvwXAKXAV3FoVPu73dRR6+JR/wgx
         mOKX9qoyAd9E7WTcUpq0dD/ubKh98wYsaDS6H1SKNaBLE549XwrP5+ocXJHbqY1qjBiZ
         1oVeMQHDXyhoJVfHznevQwRC21TQd9inNDMtXyvfqJYtNp9hg3sZCqzAKmgx06nqvO/a
         b6zje72sll8FDIFCVA6YoeKQOIvBdSiTTPjubn7y04+q03S8hzvxrD+1jFwK68/7BigD
         noJOkMLO1LkR7oQIvf24KU9f1XTt4X0wKhsivDEP47rp+lpOW0nZow6q5iIBnAMVJaaL
         Z6RA==
X-Gm-Message-State: APjAAAXtWKAlZMANRuYDxXzsBRj4Vx357ow9k4FGmduAh89O4NOlULdR
        sB6BWZjaA01FafofjM/eQtay1A==
X-Google-Smtp-Source: APXvYqyFSL4Ua4WRS4fM0C+hsgD4WHVzH/qYHJ7W9Np+1dVPjMabaI19L/MGrJjv4iAi3n7UC7CgFA==
X-Received: by 2002:a17:902:b702:: with SMTP id d2mr81525584pls.259.1563862464605;
        Mon, 22 Jul 2019 23:14:24 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id a3sm38023673pfl.145.2019.07.22.23.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 23:14:24 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 01/10] cpufreq: Add policy create/remove notifiers
Date:   Tue, 23 Jul 2019 11:44:01 +0530
Message-Id: <1b93721f076ec9006b99c92e8a7045d01630cf4b.1563862014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563862014.git.viresh.kumar@linaro.org>
References: <cover.1563862014.git.viresh.kumar@linaro.org>
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
index 8dda62367816..c13dcb59b30c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1266,7 +1266,17 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
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
 
@@ -1391,6 +1401,9 @@ static int cpufreq_online(unsigned int cpu)
 				ret);
 			goto out_destroy_policy;
 		}
+
+		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+				CPUFREQ_CREATE_POLICY, policy);
 	}
 
 	if (cpufreq_driver->get && has_target()) {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 536a049d7ecc..afc10384a681 100644
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

