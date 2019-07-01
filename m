Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A18C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24F8208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 11:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dUVUrmBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfGAL03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 07:26:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43336 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbfGAL01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 07:26:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id cl9so7192688plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ZHoXqHDnWQNNxjeBIgVIp/1BFcAyIjpzOAOe/B47LU=;
        b=dUVUrmBauCNjHwpY8xMBZYQ4GRFLbO3Ntb704oAqX/pDjDK0rOXg5VkeBAmg6imlY9
         lokkn1xb/h9XsSw2u8r7CIFC+li7G26E61o6Bm/py3Wd8PjkaOr3VgVkHSfEy/D+4gTM
         /YrlRxXz41Ytm+AjWojVND1+8ge/LSch2TnKq/h8oTadHMqK7mAScvXgE3/jgB+T2zyH
         G8PZoDdWD3USPuPIwLukR2YfR/zpbQxABrogxN8dbY2+Lx7rnAFVOQOHtbGudAGRqXjg
         yw30KTpn4calrfr4TDCGdpsQ3TaLl7LRj0n+SnQnibSKXfk66iQ8OEiAGhdhWDGgFqwC
         e0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZHoXqHDnWQNNxjeBIgVIp/1BFcAyIjpzOAOe/B47LU=;
        b=mpApMqGkD81sdFpV9wm49z5erqSSnRmrV9rjmmo/DxwzK1QrRGSc2AovbIaBTEi03F
         DbfyL8W8RA9BdU7Hbp/BTVDmel67+0zuD1MoOt8WMSb8DpH/ODaO+8E230xgMFMSWFIR
         faWs/NF73GOQBbEARj6xJF8IOTKZAfWeRMLgVN2djNnWOusmGoAxxY3Ib3bIQuLFpLZw
         ttyuoGBmxLyqx4QE2nWAVgI9jzU+8qzpH3yP7APN9+zpf1cCK0pRcMiMspZ1xUaNnBmI
         tiDaSxEa+EH15CARBjl94hKq5H079csz60Hud12nAacDK56ZQT45kKY9G5DNODvAVEQF
         ggAA==
X-Gm-Message-State: APjAAAV4CiYZaVMCLne8S7lzcW9p2aRdStahkT24XxLka7lmfBCZni3J
        DYUVvWbvzpdVOsOqqS+WgSDzxQ==
X-Google-Smtp-Source: APXvYqxHyj/M3/VqfFJ/XqQ1DHsx6mXt5jHUDWFFtYDkLlartJEIurf3on6CbsKQcC4pE0gge93NEQ==
X-Received: by 2002:a17:902:7791:: with SMTP id o17mr27113451pll.162.1561980386414;
        Mon, 01 Jul 2019 04:26:26 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id d14sm11077204pfo.154.2019.07.01.04.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 04:26:25 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 1/7] PM / QOS: Pass request type to dev_pm_qos_{add|remove}_notifier()
Date:   Mon,  1 Jul 2019 16:56:09 +0530
Message-Id: <765f3e870723a69580febc099e24e67a918f7828.1561979715.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1561979715.git.viresh.kumar@linaro.org>
References: <cover.1561979715.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use the same set of routines to register notifiers for
different request types, update the existing
dev_pm_qos_{add|remove}_notifier() routines with an additional
parameter: request-type.

For now, it only supports resume-latency request type but will be
extended to frequency limit (min/max) constraints later on.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/power/pm_qos_interface.txt | 10 ++++++----
 drivers/base/power/domain.c              |  8 +++++---
 drivers/base/power/qos.c                 | 14 ++++++++++++--
 include/linux/pm_qos.h                   | 12 ++++++++----
 4 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/Documentation/power/pm_qos_interface.txt b/Documentation/power/pm_qos_interface.txt
index 19c5f7b1a7ba..ec7d662d1707 100644
--- a/Documentation/power/pm_qos_interface.txt
+++ b/Documentation/power/pm_qos_interface.txt
@@ -164,12 +164,14 @@ directory.
 Notification mechanisms:
 The per-device PM QoS framework has a per-device notification tree.
 
-int dev_pm_qos_add_notifier(device, notifier):
-Adds a notification callback function for the device.
+int dev_pm_qos_add_notifier(device, notifier, type):
+Adds a notification callback function for the device for a particular request
+type.
+
 The callback is called when the aggregated value of the device constraints list
-is changed (for resume latency device PM QoS only).
+is changed.
 
-int dev_pm_qos_remove_notifier(device, notifier):
+int dev_pm_qos_remove_notifier(device, notifier, type):
 Removes the notification callback function for the device.
 
 
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 33c30c1e6a30..b063bc41b0a9 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1536,7 +1536,8 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
 	else
-		dev_pm_qos_add_notifier(dev, &gpd_data->nb);
+		dev_pm_qos_add_notifier(dev, &gpd_data->nb,
+					DEV_PM_QOS_RESUME_LATENCY);
 
 	return ret;
 }
@@ -1569,7 +1570,8 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 
 	pdd = dev->power.subsys_data->domain_data;
 	gpd_data = to_gpd_data(pdd);
-	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
+	dev_pm_qos_remove_notifier(dev, &gpd_data->nb,
+				   DEV_PM_QOS_RESUME_LATENCY);
 
 	genpd_lock(genpd);
 
@@ -1597,7 +1599,7 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 
  out:
 	genpd_unlock(genpd);
-	dev_pm_qos_add_notifier(dev, &gpd_data->nb);
+	dev_pm_qos_add_notifier(dev, &gpd_data->nb, DEV_PM_QOS_RESUME_LATENCY);
 
 	return ret;
 }
diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 6c91f8df1d59..cfd463212513 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -467,6 +467,7 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_remove_request);
  *
  * @dev: target device for the constraint
  * @notifier: notifier block managed by caller.
+ * @type: request type.
  *
  * Will register the notifier into a notification chain that gets called
  * upon changes to the target value for the device.
@@ -474,10 +475,14 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_remove_request);
  * If the device's constraints object doesn't exist when this routine is called,
  * it will be created (or error code will be returned if that fails).
  */
-int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier)
+int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
+			    enum dev_pm_qos_req_type type)
 {
 	int ret = 0;
 
+	if (WARN_ON(type != DEV_PM_QOS_RESUME_LATENCY))
+		return -EINVAL;
+
 	mutex_lock(&dev_pm_qos_mtx);
 
 	if (IS_ERR(dev->power.qos))
@@ -500,15 +505,20 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_add_notifier);
  *
  * @dev: target device for the constraint
  * @notifier: notifier block to be removed.
+ * @type: request type.
  *
  * Will remove the notifier from the notification chain that gets called
  * upon changes to the target value.
  */
 int dev_pm_qos_remove_notifier(struct device *dev,
-			       struct notifier_block *notifier)
+			       struct notifier_block *notifier,
+			       enum dev_pm_qos_req_type type)
 {
 	int retval = 0;
 
+	if (WARN_ON(type != DEV_PM_QOS_RESUME_LATENCY))
+		return -EINVAL;
+
 	mutex_lock(&dev_pm_qos_mtx);
 
 	/* Silently return if the constraints object is not present. */
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 6ea1ae373d77..1f4d456e8fff 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -146,9 +146,11 @@ int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
 int dev_pm_qos_update_request(struct dev_pm_qos_request *req, s32 new_value);
 int dev_pm_qos_remove_request(struct dev_pm_qos_request *req);
 int dev_pm_qos_add_notifier(struct device *dev,
-			    struct notifier_block *notifier);
+			    struct notifier_block *notifier,
+			    enum dev_pm_qos_req_type type);
 int dev_pm_qos_remove_notifier(struct device *dev,
-			       struct notifier_block *notifier);
+			       struct notifier_block *notifier,
+			       enum dev_pm_qos_req_type type);
 void dev_pm_qos_constraints_init(struct device *dev);
 void dev_pm_qos_constraints_destroy(struct device *dev);
 int dev_pm_qos_add_ancestor_request(struct device *dev,
@@ -202,10 +204,12 @@ static inline int dev_pm_qos_update_request(struct dev_pm_qos_request *req,
 static inline int dev_pm_qos_remove_request(struct dev_pm_qos_request *req)
 			{ return 0; }
 static inline int dev_pm_qos_add_notifier(struct device *dev,
-					  struct notifier_block *notifier)
+					  struct notifier_block *notifier,
+					  enum dev_pm_qos_req_type type);
 			{ return 0; }
 static inline int dev_pm_qos_remove_notifier(struct device *dev,
-					     struct notifier_block *notifier)
+					     struct notifier_block *notifier,
+					     enum dev_pm_qos_req_type type)
 			{ return 0; }
 static inline void dev_pm_qos_constraints_init(struct device *dev)
 {
-- 
2.21.0.rc0.269.g1a574e7a288b

