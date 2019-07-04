Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04068C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2982218A6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4qt1XA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfGDHgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:36:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44580 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfGDHgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:36:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so2489625pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 00:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LJkFEiuUysgePRh2tewcbbbkLJSBBfe9i4VtJ5ijDyo=;
        b=d4qt1XA+TZ0H7KjnMMTnTK7yEZTN3p4mH+JlezdoFw4mNp36T34B90viSaqTLFE5Os
         NDYwJum33XQE6+ppRoD5mxCIlCyik7E4LgMiGyJ7P2xkWiIxnSgd99sH8X2/jOn6FqDj
         8BJLuDkZUWwNYn2njtKnzd3Sh7I5JnsWdbvkJizhVacBjOU2aBSWtRVV9aQxO4VH3wFw
         +Cjv70onAne77oB217Y+/JxjTySb4wDgjhAO/LIXGZ7X013uWAxBj91DrE4flMxduMiJ
         Kge89RKmcNoVXJaJBvrNNVHP+7JNy38hOxILtg/9nGbIXMD5K+6ZNPuwSo7zknI1iLGV
         CHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LJkFEiuUysgePRh2tewcbbbkLJSBBfe9i4VtJ5ijDyo=;
        b=fooSdqlJBXFDCZzyaV+CHpxEunwDUt5Rnku2l3sGQDSg0kCVCd9X7m2vFllVaAVyse
         5SbNmDXZCypKkxH7rCOq3MvlCtg5cADIU7Hoeu8AyQbtIcOLVeOaeMqvdjV/GYXEBGVL
         s841RKt9JlSN46hiJfGUPjENpwPFASBDnMIORNLpyXRK1rrtqgcH6edOzElzD/j+N6MD
         2ejF7wh5UEtZAKjfbG3BntZOitz7UPGrm4droOFNizUmc7x41YIwXXUaekM5CL3dl7DP
         KSi3+a6wxngvedWZMf8ao7q8fe5pwoy/3uYHPm+VPEV5pu83XUFGzHR3LcK86XXIW1jd
         LHug==
X-Gm-Message-State: APjAAAUiocMHyV7k+iyln7ZYSF6Ktijhspf7YkJHrWReHnxhJR2nQGIy
        SUb2beYK/cIcV6mJ0pod26wlrw==
X-Google-Smtp-Source: APXvYqwTqBcbHSWz3rTrWk/N589UwsxjcrVCiCVfj9LdCc0Nzo1D/EP1XJqHnFUn+Bwu2VgmZ7Bvkw==
X-Received: by 2002:a17:90a:1ae2:: with SMTP id p89mr17119525pjp.26.1562225798655;
        Thu, 04 Jul 2019 00:36:38 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id k22sm6872919pfg.77.2019.07.04.00.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 00:36:38 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 3/7] PM / QOS: Pass request type to dev_pm_qos_read_value()
Date:   Thu,  4 Jul 2019 13:06:19 +0530
Message-Id: <8dfa21c3c99d677fdd04a2729acc00cdf4409818.1562210705.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1562210705.git.viresh.kumar@linaro.org>
References: <cover.1562210705.git.viresh.kumar@linaro.org>
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
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
index 5e09d4980786..9a21b7ba72ae 100644
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
+	switch (type) {
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

