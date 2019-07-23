Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2545C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD852239F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qbj5m+n+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388197AbfGWGPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 02:15:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43096 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732457AbfGWGOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:14:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so13192023pld.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 23:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JQKPSfuw5DbCIirqqIDBXsU1/ucOSKObdNO60ntwNTU=;
        b=qbj5m+n+BO01X6WUkYr4iIMz44Y5GyxzX+56ztB2cxEWQkOK7JTj1U9C3bTi7wjFO5
         gI6KcNWalrFLBhnNf2g+ZrY3CcSUIMqWjE+2GBvLOr2Qwp/etwXraRoCuZ3Np5xXtnMc
         9yTiJMilFZPro7O2f7rKeBI3jkL06KgxtaltLd4Hb/3dVL6XUagNimPY7FRW6F7e/Zrn
         gBhR2T4h1ncAB26r3+OmIMgtVoKviA7DmWi60tCiEZ4ULUgs/h1e+sXufTX0Cjkuem4s
         Qv1+cqKo4bWNtrAWCgh6IjhnB6Q7KSTfAMz4wOWUDpAG0y7sVSrS2/E8S33Ol0geJpJ+
         M2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQKPSfuw5DbCIirqqIDBXsU1/ucOSKObdNO60ntwNTU=;
        b=Nz73IGJjjg/oJTz9B/VBRbbcTMhqvUOMyNKHgTWH6/vqvylHJ8JPyHNeaSVDrVmuon
         t9Yt8p0a0dBU889SAKE1/5+MYtaEECoaGabP4ebVQB9ZJzEuWPECL92N9NW8htT6JtAF
         8ThpKA83LXxE0dpb2vNcBuN+ue5//w0AEVF5svKJp8Aq42wdU3jfvIUksb8BNLD7pMfD
         qIHt5EuqpzbaSAZdQ18acBcFDdVhSr/HfcYihg0xGOccBcfJDjRXN7uHXzkCxWcnezZP
         mQjxqEPps7tiVTPSuhXa+OmZxMSRR2/7lEHrBEhzBREpbpm+mcwpGyrRXL2TQqi2uBMD
         yfow==
X-Gm-Message-State: APjAAAUI2Up+Ekni/DJwts3FMvnjPcy6sMnF0ai+HgIUghhpCdGLz5C1
        RDC16Am/IEJpgzTR5zOsVg/DlQ==
X-Google-Smtp-Source: APXvYqzvUFuULJQ5jQbKRLhXSxe3muRcBX6FJSmHDzxEXzQwOKWxUdsU878arFEOVwke8ZW5ImjvMA==
X-Received: by 2002:a17:902:e582:: with SMTP id cl2mr79536058plb.60.1563862489459;
        Mon, 22 Jul 2019 23:14:49 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id 64sm43449485pfe.128.2019.07.22.23.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 23:14:48 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 09/10] cpufreq: Remove CPUFREQ_ADJUST and CPUFREQ_NOTIFY policy notifier events
Date:   Tue, 23 Jul 2019 11:44:09 +0530
Message-Id: <0b9220ad282d38922d968be278da3e5aa9ca5895.1563862014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563862014.git.viresh.kumar@linaro.org>
References: <cover.1563862014.git.viresh.kumar@linaro.org>
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
index c13dcb59b30c..e0ee23895497 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2360,15 +2360,13 @@ EXPORT_SYMBOL(cpufreq_get_policy);
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
@@ -2396,26 +2394,6 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
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
index afc10384a681..c57e88e85c41 100644
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

