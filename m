Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1401EC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D062082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9B/50nf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389611AbfFJKwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:52:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39999 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389594AbfFJKwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:52:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so3506940pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 03:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Xj0jDnX21fNEC3ZF4PKaKhWtErmpnH3vsz+xoxoJ3Y=;
        b=X9B/50nfJuXZ7x/KBnzAkOd3iAlb2ntDnyFmwstooaDChCb/0UmmQxmPJLen/hfr/a
         /TB6dU6m09QNIkLznVdUN47g5runWcD+9vXXiLXvUOHOgKHZFFJBi3U02aSmZl1rcgZB
         nSfvQv5IE8ACQYRRCUPbpHS2Ll0yvuAe6l1NKjadHBMyyUVMUp8bZlFrziKXjZwzL11O
         MNVhEdDgFywJvliFxTdcMjxlZot8CagFHFEq5mTooGXETc/TmUnGQUIanDarBc6DJyCV
         VnHuqLGSlsllq2KuI7KZryx3n6o5VHbU3U9tiqHcZ+ccuvGPSteNUZPdnFXEbUgkF1No
         KPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Xj0jDnX21fNEC3ZF4PKaKhWtErmpnH3vsz+xoxoJ3Y=;
        b=FpYSJI5Ks8BgzF/MgOrTkYuewNl2s1gkcFAVfl5iBqYk+x5oo9gzA/k0mm250xOPre
         n+PDfGl49V+6AZl0IyyVOBrw0NTjX9DX9v4NrfEV+p+rocm8MWW1YcwacpXiqKXinhRo
         lQ7CcRH8roG9SXJzG+Wlop/w/Sy1aaA7Lxg/IhFZU2fdKgo6IT3meB4Y8ToSZa/hc6O3
         A6qtjM3A4mGTVZaqxAzlsSLwvoAh8ZiKLKpGo+aCY7gwZImUp21LOZ7OTPHE5c8HGv0+
         tNPpxIjXrBo4/KKvrVzS1Uzg2dVHGzDHqjtELQuIz6OX78VNaR0AMC6XNFS6IGW/cGBY
         6Ieg==
X-Gm-Message-State: APjAAAWP0rdV0RQx0rfFEfFoSWnBLRE39zSF9x1BU8ZuVPH+JSMrspOb
        rzbf+pkND/wPharj6n18AvIWzw==
X-Google-Smtp-Source: APXvYqx0EJeHMdSJTbTOxqfl5xutzFvSOfMU3HwYTxUw5+DHWI3F01GsP96fVwC81GahdwcH6HQt9A==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34mr32327138pld.16.1560163920895;
        Mon, 10 Jun 2019 03:52:00 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id 14sm10130508pgp.37.2019.06.10.03.52.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 03:52:00 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/5] PM / QoS: Add support for MIN/MAX frequency constraints
Date:   Mon, 10 Jun 2019 16:21:34 +0530
Message-Id: <8c0ead9cc598f9eb7d15bd4878108b545368dd6e.1560163748.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560163748.git.viresh.kumar@linaro.org>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the min-frequency and max-frequency device
constraints, which will be used by the cpufreq core to begin with.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/qos.c | 103 +++++++++++++++++++++++++++++++++------
 include/linux/pm_qos.h   |  18 +++++++
 2 files changed, 107 insertions(+), 14 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 7bb88174371f..e977aef437a5 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -151,6 +151,14 @@ static int apply_constraint(struct dev_pm_qos_request *req,
 			req->dev->power.set_latency_tolerance(req->dev, value);
 		}
 		break;
+	case DEV_PM_QOS_MIN_FREQUENCY:
+		ret = pm_qos_update_target(&qos->min_frequency,
+					   &req->data.pnode, action, value);
+		break;
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		ret = pm_qos_update_target(&qos->max_frequency,
+					   &req->data.pnode, action, value);
+		break;
 	case DEV_PM_QOS_FLAGS:
 		ret = pm_qos_update_flags(&qos->flags, &req->data.flr,
 					  action, value);
@@ -179,12 +187,11 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	if (!qos)
 		return -ENOMEM;
 
-	n = kzalloc(sizeof(*n), GFP_KERNEL);
+	n = kzalloc(3 * sizeof(*n), GFP_KERNEL);
 	if (!n) {
 		kfree(qos);
 		return -ENOMEM;
 	}
-	BLOCKING_INIT_NOTIFIER_HEAD(n);
 
 	c = &qos->resume_latency;
 	plist_head_init(&c->list);
@@ -193,6 +200,7 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	c->no_constraint_value = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 	c->type = PM_QOS_MIN;
 	c->notifiers = n;
+	BLOCKING_INIT_NOTIFIER_HEAD(n);
 
 	c = &qos->latency_tolerance;
 	plist_head_init(&c->list);
@@ -201,6 +209,24 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 	c->no_constraint_value = PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
 	c->type = PM_QOS_MIN;
 
+	c = &qos->min_frequency;
+	plist_head_init(&c->list);
+	c->target_value = PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
+	c->default_value = PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
+	c->no_constraint_value = PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
+	c->type = PM_QOS_MAX;
+	c->notifiers = ++n;
+	BLOCKING_INIT_NOTIFIER_HEAD(n);
+
+	c = &qos->max_frequency;
+	plist_head_init(&c->list);
+	c->target_value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
+	c->default_value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
+	c->no_constraint_value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
+	c->type = PM_QOS_MIN;
+	c->notifiers = ++n;
+	BLOCKING_INIT_NOTIFIER_HEAD(n);
+
 	INIT_LIST_HEAD(&qos->flags.list);
 
 	spin_lock_irq(&dev->power.lock);
@@ -254,11 +280,25 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
 		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
 		memset(req, 0, sizeof(*req));
 	}
+
 	c = &qos->latency_tolerance;
 	plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {
 		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
 		memset(req, 0, sizeof(*req));
 	}
+
+	c = &qos->min_frequency;
+	plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {
+		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE);
+		memset(req, 0, sizeof(*req));
+	}
+
+	c = &qos->max_frequency;
+	plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {
+		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
+		memset(req, 0, sizeof(*req));
+	}
+
 	f = &qos->flags;
 	list_for_each_entry_safe(req, tmp, &f->list, data.flr.node) {
 		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
@@ -370,6 +410,8 @@ static int __dev_pm_qos_update_request(struct dev_pm_qos_request *req,
 	switch(req->type) {
 	case DEV_PM_QOS_RESUME_LATENCY:
 	case DEV_PM_QOS_LATENCY_TOLERANCE:
+	case DEV_PM_QOS_MIN_FREQUENCY:
+	case DEV_PM_QOS_MAX_FREQUENCY:
 		curr_value = req->data.pnode.prio;
 		break;
 	case DEV_PM_QOS_FLAGS:
@@ -482,9 +524,6 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
 {
 	int ret = 0;
 
-	if (WARN_ON(type != DEV_PM_QOS_RESUME_LATENCY))
-		return -EINVAL;
-
 	mutex_lock(&dev_pm_qos_mtx);
 
 	if (IS_ERR(dev->power.qos))
@@ -492,10 +531,28 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
 	else if (!dev->power.qos)
 		ret = dev_pm_qos_constraints_allocate(dev);
 
-	if (!ret)
+	if (ret)
+		goto unlock;
+
+	switch (type) {
+	case DEV_PM_QOS_RESUME_LATENCY:
 		ret = blocking_notifier_chain_register(dev->power.qos->resume_latency.notifiers,
 						       notifier);
+		break;
+	case DEV_PM_QOS_MIN_FREQUENCY:
+		ret = blocking_notifier_chain_register(dev->power.qos->min_frequency.notifiers,
+						       notifier);
+		break;
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		ret = blocking_notifier_chain_register(dev->power.qos->max_frequency.notifiers,
+						       notifier);
+		break;
+	default:
+		WARN_ON(1);
+		ret = -EINVAL;
+	}
 
+unlock:
 	mutex_unlock(&dev_pm_qos_mtx);
 	return ret;
 }
@@ -516,20 +573,35 @@ int dev_pm_qos_remove_notifier(struct device *dev,
 			       struct notifier_block *notifier,
 			       enum dev_pm_qos_req_type type)
 {
-	int retval = 0;
-
-	if (WARN_ON(type != DEV_PM_QOS_RESUME_LATENCY))
-		return -EINVAL;
+	int ret = 0;
 
 	mutex_lock(&dev_pm_qos_mtx);
 
 	/* Silently return if the constraints object is not present. */
-	if (!IS_ERR_OR_NULL(dev->power.qos))
-		retval = blocking_notifier_chain_unregister(dev->power.qos->resume_latency.notifiers,
-							    notifier);
+	if (IS_ERR_OR_NULL(dev->power.qos))
+		goto unlock;
 
+	switch (type) {
+	case DEV_PM_QOS_RESUME_LATENCY:
+		ret = blocking_notifier_chain_unregister(dev->power.qos->resume_latency.notifiers,
+							 notifier);
+		break;
+	case DEV_PM_QOS_MIN_FREQUENCY:
+		ret = blocking_notifier_chain_unregister(dev->power.qos->min_frequency.notifiers,
+							 notifier);
+		break;
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		ret = blocking_notifier_chain_unregister(dev->power.qos->max_frequency.notifiers,
+							 notifier);
+		break;
+	default:
+		WARN_ON(1);
+		ret = -EINVAL;
+	}
+
+unlock:
 	mutex_unlock(&dev_pm_qos_mtx);
-	return retval;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_remove_notifier);
 
@@ -589,6 +661,9 @@ static void __dev_pm_qos_drop_user_request(struct device *dev,
 		req = dev->power.qos->flags_req;
 		dev->power.qos->flags_req = NULL;
 		break;
+	default:
+		WARN_ON(1);
+		return;
 	}
 	__dev_pm_qos_remove_request(req);
 	kfree(req);
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 55814d48c39c..3f994283a5ae 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -40,6 +40,8 @@ enum pm_qos_flags_status {
 #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT	PM_QOS_LATENCY_ANY
 #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS	PM_QOS_LATENCY_ANY_NS
 #define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE	0
+#define PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE	0
+#define PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE	(-1)
 #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT	(-1)
 
 #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
@@ -58,6 +60,8 @@ struct pm_qos_flags_request {
 enum dev_pm_qos_req_type {
 	DEV_PM_QOS_RESUME_LATENCY = 1,
 	DEV_PM_QOS_LATENCY_TOLERANCE,
+	DEV_PM_QOS_MIN_FREQUENCY,
+	DEV_PM_QOS_MAX_FREQUENCY,
 	DEV_PM_QOS_FLAGS,
 };
 
@@ -99,10 +103,14 @@ struct pm_qos_flags {
 struct dev_pm_qos {
 	struct pm_qos_constraints resume_latency;
 	struct pm_qos_constraints latency_tolerance;
+	struct pm_qos_constraints min_frequency;
+	struct pm_qos_constraints max_frequency;
 	struct pm_qos_flags flags;
 	struct dev_pm_qos_request *resume_latency_req;
 	struct dev_pm_qos_request *latency_tolerance_req;
 	struct dev_pm_qos_request *flags_req;
+	struct dev_pm_qos_request *min_frequency_req;
+	struct dev_pm_qos_request *max_frequency_req;
 };
 
 /* Action requested to pm_qos_update_target */
@@ -185,6 +193,12 @@ static inline s32 dev_pm_qos_raw_read_value(struct device *dev,
 	case DEV_PM_QOS_RESUME_LATENCY:
 		return IS_ERR_OR_NULL(qos) ? PM_QOS_RESUME_LATENCY_NO_CONSTRAINT
 			: pm_qos_read_value(&qos->resume_latency);
+	case DEV_PM_QOS_MIN_FREQUENCY:
+		return IS_ERR_OR_NULL(qos) ? PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE
+			: pm_qos_read_value(&qos->min_frequency);
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		return IS_ERR_OR_NULL(qos) ? PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE
+			: pm_qos_read_value(&qos->max_frequency);
 	default:
 		WARN_ON(1);
 		return 0;
@@ -256,6 +270,10 @@ static inline s32 dev_pm_qos_raw_read_value(struct device *dev,
 	switch type {
 	case DEV_PM_QOS_RESUME_LATENCY:
 		return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+	case DEV_PM_QOS_MIN_FREQUENCY:
+		return PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
+	case DEV_PM_QOS_MAX_FREQUENCY:
+		return PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
 	default:
 		WARN_ON(1);
 		return 0;
-- 
2.21.0.rc0.269.g1a574e7a288b

