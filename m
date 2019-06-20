Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EC3C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232A52084B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="neDtkbnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfFTHfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 03:35:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35195 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfFTHfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 03:35:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id p1so1042977plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 00:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PlxocW5hWVYXfPkN8RZ8vxi1sxzrmOenQcvIcTZd5kM=;
        b=neDtkbnB32fNUiWRtuM8IA9wvANTqdn4GCX0BHaSi+sZp9pJZWz/+yK7URvT057gpm
         mOAiBkCY6b10Dx1M2aVrWFGT6vV1dxhR68qH/LnfIQ2WPEKkdHHWXOap0WA58bsC7jSY
         KQkbIe6ps7Q35RT0ophUMWBQy3N+2HWmgvFDiSvceXN1/NBol+47TtuDZe+mFyYCdoW6
         UA65wyMnKnZTheqEexkIEmd9m8cTGMdhm6TA9ojLwZvKPmPLH9SG8kOHGG3IzIVHIg5d
         y6iVMu1LqXFH9srEDq/cEBy7ssJot4+oVARC+N6rZGVBXlKdu6gO1axEQLhxX9KMUYfC
         FkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PlxocW5hWVYXfPkN8RZ8vxi1sxzrmOenQcvIcTZd5kM=;
        b=T0kZL0pXE4bjPBP5+m1p2G4mRkZe09RYDaUtR7mF/Rq/9JZ/u4SRgJvctexb3/X8wx
         I6pclufquPvcrh6lroCsUBnCKAeJyNjS7FsggAd0gTZNNQH3gCRhQdJNXqVuf2AyFi4T
         DTLDN0vUCA5o6TsBfAWwVNpDDnfMHjxXb70zYMFVBlPzJm3teGQqPhO6hmcW+bw6DefC
         EMXPXVmRY7LdwDYn3wiJa7Rx2N4D4wREJJ6QWgJ+Qq2qERj3at1VFGPlj3igOgdOampT
         2XUWvCbm9qlVeUxcmG0MThSvtnsgxZ4E6a808hsdYgAfZfrMTmXJDpW0+9MZNUM6meSX
         4TgA==
X-Gm-Message-State: APjAAAUngNTlsEDs8EI5yWo8LDlSVAQ/X8CetpvJ5ODK5mAyxv8gGWud
        An9WbnUwhbTTHRJxispvanmygg==
X-Google-Smtp-Source: APXvYqwvydDpjxVc0YgXiq55R1zrSeQFQcZ0OknZiFAEJ8CvCofSBk2fY8zZz9BX8X86k8WRmfChbw==
X-Received: by 2002:a17:902:e65:: with SMTP id 92mr117937368plw.13.1561016147164;
        Thu, 20 Jun 2019 00:35:47 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id s24sm20879349pfh.133.2019.06.20.00.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 00:35:46 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/6] PM / QOS: Rename __dev_pm_qos_read_value() and dev_pm_qos_raw_read_value()
Date:   Thu, 20 Jun 2019 13:05:25 +0530
Message-Id: <4597b5639f58b8a55f97241abcbdd49f9dea34e8.1561014965.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1561014965.git.viresh.kumar@linaro.org>
References: <cover.1561014965.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_qos_read_value() will soon need to support more constraint types
(min/max frequency) and will have another argument to it, i.e. type of
the constraint. While that is fine for the existing users of
dev_pm_qos_read_value(), but not that optimal for the callers of
__dev_pm_qos_read_value() and dev_pm_qos_raw_read_value() as all the
callers of these two routines are only looking for resume latency
constraint.

Lets make these two routines care only about the resume latency
constraint and rename them to __dev_pm_qos_resume_latency() and
dev_pm_qos_raw_resume_latency().

Suggested-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain_governor.c |  2 +-
 drivers/base/power/qos.c             | 13 +++++++++----
 drivers/base/power/runtime.c         |  2 +-
 drivers/cpuidle/governor.c           |  2 +-
 include/linux/pm_qos.h               |  8 ++++----
 5 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 3838045c9277..20e56a5be01f 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -66,7 +66,7 @@ static bool default_suspend_ok(struct device *dev)
 	td->constraint_changed = false;
 	td->cached_suspend_ok = false;
 	td->effective_constraint_ns = 0;
-	constraint_ns = __dev_pm_qos_read_value(dev);
+	constraint_ns = __dev_pm_qos_resume_latency(dev);
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index cfd463212513..7a0d197f0809 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -90,16 +90,16 @@ enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev, s32 mask)
 EXPORT_SYMBOL_GPL(dev_pm_qos_flags);
 
 /**
- * __dev_pm_qos_read_value - Get PM QoS constraint for a given device.
+ * __dev_pm_qos_resume_latency - Get resume latency constraint for a given device.
  * @dev: Device to get the PM QoS constraint value for.
  *
  * This routine must be called with dev->power.lock held.
  */
-s32 __dev_pm_qos_read_value(struct device *dev)
+s32 __dev_pm_qos_resume_latency(struct device *dev)
 {
 	lockdep_assert_held(&dev->power.lock);
 
-	return dev_pm_qos_raw_read_value(dev);
+	return dev_pm_qos_raw_resume_latency(dev);
 }
 
 /**
@@ -112,7 +112,12 @@ s32 dev_pm_qos_read_value(struct device *dev)
 	s32 ret;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
-	ret = __dev_pm_qos_read_value(dev);
+
+	if (IS_ERR_OR_NULL(dev->power.qos))
+		ret = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+	else
+		ret = pm_qos_read_value(&dev->power.qos->resume_latency);
+
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
 	return ret;
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 952a1e7057c7..b75335508d2c 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -275,7 +275,7 @@ static int rpm_check_suspend_allowed(struct device *dev)
 	    || (dev->power.request_pending
 			&& dev->power.request == RPM_REQ_RESUME))
 		retval = -EAGAIN;
-	else if (__dev_pm_qos_read_value(dev) == 0)
+	else if (__dev_pm_qos_resume_latency(dev) == 0)
 		retval = -EPERM;
 	else if (dev->power.runtime_status == RPM_SUSPENDED)
 		retval = 1;
diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index 9fddf828a76f..2e3e14192bee 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -110,7 +110,7 @@ int cpuidle_governor_latency_req(unsigned int cpu)
 {
 	int global_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
 	struct device *device = get_cpu_device(cpu);
-	int device_req = dev_pm_qos_raw_read_value(device);
+	int device_req = dev_pm_qos_raw_resume_latency(device);
 
 	return device_req < global_req ? device_req : global_req;
 }
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 1f4d456e8fff..06aa88496761 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -139,7 +139,7 @@ s32 pm_qos_read_value(struct pm_qos_constraints *c);
 #ifdef CONFIG_PM
 enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev, s32 mask);
 enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev, s32 mask);
-s32 __dev_pm_qos_read_value(struct device *dev);
+s32 __dev_pm_qos_resume_latency(struct device *dev);
 s32 dev_pm_qos_read_value(struct device *dev);
 int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
 			   enum dev_pm_qos_req_type type, s32 value);
@@ -176,7 +176,7 @@ static inline s32 dev_pm_qos_requested_flags(struct device *dev)
 	return dev->power.qos->flags_req->data.flr.flags;
 }
 
-static inline s32 dev_pm_qos_raw_read_value(struct device *dev)
+static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
 {
 	return IS_ERR_OR_NULL(dev->power.qos) ?
 		PM_QOS_RESUME_LATENCY_NO_CONSTRAINT :
@@ -189,7 +189,7 @@ static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
 static inline enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev,
 							s32 mask)
 			{ return PM_QOS_FLAGS_UNDEFINED; }
-static inline s32 __dev_pm_qos_read_value(struct device *dev)
+static inline s32 __dev_pm_qos_resume_latency(struct device *dev)
 			{ return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT; }
 static inline s32 dev_pm_qos_read_value(struct device *dev)
 			{ return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT; }
@@ -245,7 +245,7 @@ static inline s32 dev_pm_qos_requested_resume_latency(struct device *dev)
 	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 }
 static inline s32 dev_pm_qos_requested_flags(struct device *dev) { return 0; }
-static inline s32 dev_pm_qos_raw_read_value(struct device *dev)
+static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
 {
 	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
 }
-- 
2.21.0.rc0.269.g1a574e7a288b

