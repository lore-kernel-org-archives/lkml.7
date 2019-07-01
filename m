Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9DBC06510
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B0E2133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q19Xf6xV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfGAL0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:26:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39953 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbfGAL0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:26:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so7220805pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 04:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFea1NB8cblkfncT7oG1ziy//jPVykLkqdpiv/Sj2rY=;
        b=q19Xf6xVs1WEk56gh2njTMtLGT4SpsfN/TXoLH9k4sqQi59MufkhkvAeeXC3l2LCSu
         SZ6W4q2yMLzgHu03nuSYNdtba3Jn3QwwNvjE7Uion8tr0a7/G/zPhGuPgOdXUGJ+25cy
         wlWCdjywjns9TWQx5VMyH7RZprrV6Gu36GWA7y1K05pMHnf8Z7DGK7oI6S1FUZwqJTG8
         2KydMVt9I5y35NH9iz/2n38MJCARtEExNSwWxs5WoJH6tFJEI0Sg8G7SqCgwgzWVjq8R
         efXpYwBNUokSdc3vSa4TSPc9a7oqHMc+vGv7SMhGuo1C2R19ev6i86x+uMI7kRDHcRVE
         igKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFea1NB8cblkfncT7oG1ziy//jPVykLkqdpiv/Sj2rY=;
        b=JZJ/ojkpktt5IeL8pSfgbx+bZer2bv3BC0BPHU31l1CddjtkITvaKgqFby2HYGcVSx
         TdorGAqX3ghFe//z4CCYt95N9flLnOXfL533Fibd/JFIbAPjJ9PjTpNN3HzTIl2Q/uPZ
         DhDtTTxNeSfPBZBfa+R/vhGTf+kx3VkolTXNxG5IMDOBoyjt2nek4UBkytfJe4R7Mig1
         c7N2UOxnf4g4gXw0E2ZFUihBJA8U7ZgAkL+TpySdRDvW0wEwoFdbtuaruqatj7XEcq/I
         96/hQz/h1nXCOuWtM1vIJlu/9dhHwFvAFd+H5yzkAfh6eWwcaAucwi7qaQuggqkdvy86
         Lqkw==
X-Gm-Message-State: APjAAAXkupN2a4PP1SIZGAC6m3bvCXnNqct8Q9gxkIKU1LUHzlxlykAg
        2Jn6ATBxiU90NpBjexkuRf98WA==
X-Google-Smtp-Source: APXvYqxd/kWHYOBpA2Tbd26P/S/8mwpWXYYmGaz07CERnq8AYBpub/54s8vuktaM+1fAG5wVZcty/g==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr28742850pla.212.1561980392649;
        Mon, 01 Jul 2019 04:26:32 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id m100sm12021381pje.12.2019.07.01.04.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 04:26:32 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 3/7] PM / QOS: Pass request type to dev_pm_qos_read_value()
Date:   Mon,  1 Jul 2019 16:56:11 +0530
Message-Id: <58c6b468b1c2656df03a8265e82e2e4b8427d687.1561979715.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1561979715.git.viresh.kumar@linaro.org>
References: <cover.1561979715.git.viresh.kumar@linaro.org>
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

