Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080CAC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A6D208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 07:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OOTIOuNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbfFTHfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 03:35:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39174 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730561AbfFTHfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 03:35:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id 196so1117312pgc.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 00:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFea1NB8cblkfncT7oG1ziy//jPVykLkqdpiv/Sj2rY=;
        b=OOTIOuNBVoc/plqifbqrBTSSXmNakHwestFW6A2YysPYs4Vlc7duA3jFanwE2V9IeU
         56gCclEffi02AbZ2RfA0mt79kOdt4JwcpXftyAaPSyc/plIPmIU1zOTBX1JGHD8BuSA2
         IOivuhwkgMYoGgDVCB8cyJhJNKvp7TFkFyPYlKN5xhCOJ49DvrOu3uzyMw8zwRjdKEER
         4DNsVGH+gQj66S39tUAO9EmGfBoplClGS1FqDPoRVIvFGQiBYX/LO1qIVr1zv5miWhJ9
         NWrI01a1UhVuD/+r8ZXmedbvS6HPkNLQZ0nR/I8iaeQUTwuUeJzeM5pOYYP23nomHqPr
         rZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFea1NB8cblkfncT7oG1ziy//jPVykLkqdpiv/Sj2rY=;
        b=DFQ0LvU0s0Dj3kIF9V3OJ/RhMfCXeMtN+tHSx2NXbeB9AUVpVEV+iZs0GgwVbCY6Bq
         7Z8PCPx5l84PFnINCbyFCgXvYDduUvOyQFzsbV81IEzaTlyz8G0r4ec79sud2b6LVcNx
         o2y+Nh8wEKCJ5YauOngKCzj8hbh8xOBMdYHBlejFMcJU/y3z00hZ+pxUwquP3DzypGdU
         LYIjL88D5bSU585bRMYJ5ywQrBY88/7udhQZXUItVwLLUcQKPUjbIFa0hcuypXutYmwQ
         Hx1SCWw2kk2f21T+wLV4mvulWZ50roML+QkavhDWIaxYoSRjBSnlGxq/s/M0WUYzIKd0
         STNw==
X-Gm-Message-State: APjAAAXpJsbYRboRoI7HuJAqeS/8iidYl57mfSNa8w3bDu4SWsEsH5Un
        GynKjkDsb53JcUWG4LpcINgMng==
X-Google-Smtp-Source: APXvYqy4TLM9VHaD1MblXyOST+/ynrt3L/eX3fimO++3e8ICBRdE83/Y6ltod4L403NeJkhiek/blA==
X-Received: by 2002:aa7:972a:: with SMTP id k10mr95648994pfg.116.1561016150170;
        Thu, 20 Jun 2019 00:35:50 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id j14sm20915268pfe.10.2019.06.20.00.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 00:35:49 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/6] PM / QOS: Pass request type to dev_pm_qos_read_value()
Date:   Thu, 20 Jun 2019 13:05:26 +0530
Message-Id: <8ab3d45109443c381a417ee1d019516781216a48.1561014965.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1561014965.git.viresh.kumar@linaro.org>
References: <cover.1561014965.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow dev_pm_qos_read_value() to read values for different
QoS requests, pass request type as a parameter to these routines.

For now, it only supports resume-latency request type but will be
extended to frequency limit (min/max) constraints later on.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/power/pm_qos_interface.txt |  2 +-
 drivers/base/power/domain_governor.c     |  2 +-
 drivers/base/power/qos.c                 | 17 ++++++++++++-----
 include/linux/pm_qos.h                   | 16 +++++++++++++---
 4 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/Documentation/power/pm_qos_interface.txt b/Documentation/power/pm_qos_interface.txt
index ec7d662d1707..cfcb1df39799 100644
--- a/Documentation/power/pm_qos_interface.txt
+++ b/Documentation/power/pm_qos_interface.txt
@@ -123,7 +123,7 @@ Will remove the element.  After removal it will update the aggregate target and
 call the notification trees if the target was changed as a result of removing
 the request.
 
-s32 dev_pm_qos_read_value(device):
+s32 dev_pm_qos_read_value(device, type):
 Returns the aggregated value for a given device's constraints list.
 
 enum pm_qos_flags_status dev_pm_qos_flags(device, mask)
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 20e56a5be01f..daa8c7689f7e 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -33,7 +33,7 @@ static int dev_update_qos_constraint(struct device *dev, void *data)
 		 * take its current PM QoS constraint (that's the only thing
 		 * known at this point anyway).
 		 */
-		constraint_ns = dev_pm_qos_read_value(dev);
+		constraint_ns = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
 		constraint_ns *= NSEC_PER_USEC;
 	}
 
diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 7a0d197f0809..2461fed0efa0 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -105,18 +105,25 @@ s32 __dev_pm_qos_resume_latency(struct device *dev)
 /**
  * dev_pm_qos_read_value - Get PM QoS constraint for a given device (locked).
  * @dev: Device to get the PM QoS constraint value for.
+ * @type: QoS request type.
  */
-s32 dev_pm_qos_read_value(struct device *dev)
+s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type)
 {
+	struct dev_pm_qos *qos = dev->power.qos;
 	unsigned long flags;
 	s32 ret;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
 
-	if (IS_ERR_OR_NULL(dev->power.qos))
-		ret = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
-	else
-		ret = pm_qos_read_value(&dev->power.qos->resume_latency);
+	switch (type) {
+	case DEV_PM_QOS_RESUME_LATENCY:
+		ret = IS_ERR_OR_NULL(qos) ? PM_QOS_RESUME_LATENCY_NO_CONSTRAINT
+			: pm_qos_read_value(&qos->resume_latency);
+		break;
+	default:
+		WARN_ON(1);
+		ret = 0;
+	}
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 06aa88496761..5ce1c310373e 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -140,7 +140,7 @@ s32 pm_qos_read_value(struct pm_qos_constraints *c);
 enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev, s32 mask);
 enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev, s32 mask);
 s32 __dev_pm_qos_resume_latency(struct device *dev);
-s32 dev_pm_qos_read_value(struct device *dev);
+s32 dev_pm_qos_read_value(struct device *dev, enum dev_pm_qos_req_type type);
 int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
 			   enum dev_pm_qos_req_type type, s32 value);
 int dev_pm_qos_update_request(struct dev_pm_qos_request *req, s32 new_value);
@@ -191,8 +191,18 @@ static inline enum pm_qos_flags_status dev_pm_qos_flags(struct device *dev,
 			{ return PM_QOS_FLAGS_UNDEFINED; }
 static inline s32 __dev_pm_qos_resume_latency(struct device *dev)
 			{ return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT; }
-static inline s32 dev_pm_qos_read_value(struct device *dev)
-			{ return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT; }
+static inline s32 dev_pm_qos_read_value(struct device *dev,
+					enum dev_pm_qos_req_type type)
+{
+	switch type {
+	case DEV_PM_QOS_RESUME_LATENCY:
+		return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+	default:
+		WARN_ON(1);
+		return 0;
+	}
+}
+
 static inline int dev_pm_qos_add_request(struct device *dev,
 					 struct dev_pm_qos_request *req,
 					 enum dev_pm_qos_req_type type,
-- 
2.21.0.rc0.269.g1a574e7a288b

