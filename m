Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE548C468C9
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 04:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A39F20840
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 04:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sGxRHU9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbfFHEoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 00:44:17 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43535 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731028AbfFHEoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 00:44:15 -0400
Received: by mail-pf1-f202.google.com with SMTP id j7so2874864pfn.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 21:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X/0NqtCGqUmOq4nLYX8jL0qKKJXqxo5c/Ras/XYEZ30=;
        b=sGxRHU9J6/WBdSx6fV4lvlmqJRkCIBhCKnkxlP2A6WFEW+TPmoxuIwxU/QxhjV/fg7
         /FoAmfZkNcSjdPpmL5ehNppf/RPEpMu0zP+H3qTyZTFQLtYGYa8y9/Ylk1PwUiPttEco
         lwGacdhFHJIokJjrbPKkwNQJjMWfzhYycY8tHrP85QZrBvaiHmFyrLLJd7TvDUI3JXd1
         ho5vXJdBfwyx9tMUZix67KP4mtoXuru6aeevvUzt5m7m5/GVT0sxGkzfu5NLHE1/J9e+
         FG6nbS1fhDfHQpgtpwYdj/fRGdojh9ogJBjijzfbAxOa5i6kF0OKgg9sJdm+F9Qm+oLk
         stOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X/0NqtCGqUmOq4nLYX8jL0qKKJXqxo5c/Ras/XYEZ30=;
        b=UeM9DDEU9GtVdGWtWbufFvbBnooUW3+dJ8BX7639TxKWesRRiv4ulmPVmiclsleYr8
         U1RvLL/y/iamndZ8E7Kw51GD8wwZG4zARfwI8TB+bu/FaNYAA8679apv9CP2VAdPAv9h
         En7zfZVdJxHFUXMTqOQ1kYmpZkWQ2uyeEesAsX3Av93Z1Ve2SZjCOvl1Pb6VBzMEnM4J
         xqqZ6ak3v2n3VZacqivlZe6OiO2o21noRFJI3+b2x9noFQRsw231beOzpOqnSqgv9NX/
         43KyWKRTqq57yZwFXKvaI/UDOV89KFy+hK73TZl1kMmR6I7yyyBpi2f+6k7SoC9br7pk
         1TqQ==
X-Gm-Message-State: APjAAAXu45rAsTs5nGYAHiokzmQzdhB17UwxGsAgXOHq0vRYM2eb8S5G
        +dTjIrQQJbIxOEBeY1a33Oz5Q65DQHJP7HA=
X-Google-Smtp-Source: APXvYqw+aLvw6BhTGdaOngx8+WAxudDKeQuk6uRkUc6lti20wsGbVu9yrVV0Sa5OuwKBTg9T03aHut5pp6KUHxY=
X-Received: by 2002:a65:6104:: with SMTP id z4mr5999890pgu.319.1559969054138;
 Fri, 07 Jun 2019 21:44:14 -0700 (PDT)
Date:   Fri,  7 Jun 2019 21:43:39 -0700
In-Reply-To: <20190608044339.115026-1-saravanak@google.com>
Message-Id: <20190608044339.115026-10-saravanak@google.com>
Mime-Version: 1.0
References: <20190608044339.115026-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v1 9/9] interconnect: Add devfreq support
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        sibis@codeaurora.org, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a icc_create_devfreq() and icc_remove_devfreq() to create and remove
devfreq devices for interconnect paths. A driver can create/remove devfreq
devices for the interconnects needed for its device by calling these APIs.
This would allow various devfreq governors to work with interconnect paths
and the device driver itself doesn't have to actively manage the bandwidth
votes for the interconnects.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/interconnect/Makefile      |   2 +-
 drivers/interconnect/icc-devfreq.c | 145 +++++++++++++++++++++++++++++
 include/linux/interconnect.h       |  11 +++
 3 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100644 drivers/interconnect/icc-devfreq.c

diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index 28f2ab0824d5..ddfb65b7fa55 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-icc-core-objs				:= core.o
+icc-core-objs				:= core.o icc-devfreq.o
 
 obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
 obj-$(CONFIG_INTERCONNECT_QCOM)		+= qcom/
diff --git a/drivers/interconnect/icc-devfreq.c b/drivers/interconnect/icc-devfreq.c
new file mode 100644
index 000000000000..f88b267d281e
--- /dev/null
+++ b/drivers/interconnect/icc-devfreq.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * A devfreq device driver for interconnect paths
+ *
+ * Copyright (C) 2019 Google, Inc
+ */
+
+#include <linux/devfreq.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+#include <linux/interconnect.h>
+#include <linux/limits.h>
+
+struct icc_devfreq {
+	struct device icc_dev;
+	struct icc_path *path;
+	struct devfreq_dev_profile dp;
+	struct devfreq *df;
+	unsigned long peak_bw;
+	unsigned long avg_bw;
+};
+
+static int icc_target(struct device *dev, unsigned long *freq,
+				u32 flags)
+{
+	struct icc_devfreq *d = dev_get_drvdata(dev);
+	struct dev_pm_opp *opp;
+	unsigned long peak_bw, avg_bw;
+
+	opp = devfreq_recommended_opp(dev, &peak_bw, flags);
+	if (IS_ERR(opp)) {
+		dev_err(dev, "Failed to find opp for %lu KHz\n", *freq);
+		return PTR_ERR(opp);
+	}
+	peak_bw = dev_pm_opp_get_bw(opp, &avg_bw);
+	dev_pm_opp_put(opp);
+
+	if (!icc_set_bw(d->path, avg_bw, peak_bw)) {
+		*freq = peak_bw;
+		d->peak_bw = peak_bw;
+		d->avg_bw = avg_bw;
+	}
+
+	return 0;
+}
+
+static int icc_get_dev_status(struct device *dev,
+					struct devfreq_dev_status *stat)
+{
+	struct icc_devfreq *d = dev_get_drvdata(dev);
+
+	stat->current_frequency = d->peak_bw;
+	return 0;
+}
+
+#define icc_dev_to_data(DEV)	container_of((DEV), struct icc_devfreq, icc_dev)
+static void icc_dev_release(struct device *dev)
+{
+	struct icc_devfreq *d = icc_dev_to_data(dev);
+
+	kfree(d);
+}
+
+struct icc_devfreq *icc_create_devfreq(struct device *dev, char *name)
+{
+	struct icc_devfreq *d;
+	struct icc_path *path;
+	struct opp_table *opp_table;
+	struct dev_pm_opp *opp;
+	unsigned long peak_bw = U32_MAX, avg_bw = U32_MAX;
+	int err;
+
+	if (!name)
+		return ERR_PTR(-EINVAL);
+
+	path = of_icc_get(dev, name);
+	if (IS_ERR(path))
+		return (void *) path;
+
+	opp_table = icc_get_opp_table(path);
+	if (!opp_table) {
+		err = -EINVAL;
+		goto out_path;
+	}
+
+	d = kzalloc(sizeof(*d), GFP_KERNEL);
+	if (!d) {
+		err = -ENOMEM;
+		goto out_path;
+	}
+	d->path = path;
+
+	d->icc_dev.parent = dev;
+	d->icc_dev.release = icc_dev_release;
+	dev_set_name(&d->icc_dev, "%s-icc-%s", dev_name(dev), name);
+	err = device_register(&d->icc_dev);
+	if (err) {
+		put_device(&d->icc_dev);
+		goto out_path;
+	}
+
+	dev_pm_opp_add_opp_table(&d->icc_dev, opp_table);
+	opp = dev_pm_opp_find_peak_bw_floor(dev, &peak_bw);
+	peak_bw = dev_pm_opp_get_bw(opp, &avg_bw);
+	dev_pm_opp_put(opp);
+
+	if (!icc_set_bw(d->path, avg_bw, peak_bw)) {
+		d->peak_bw = peak_bw;
+		d->avg_bw = avg_bw;
+	}
+
+	d->dp.initial_freq = peak_bw;
+	d->dp.polling_ms = 0;
+	d->dp.target = icc_target;
+	d->dp.get_dev_status = icc_get_dev_status;
+	d->df = devm_devfreq_add_device(&d->icc_dev,
+					&d->dp,
+					"performance",
+					NULL);
+	if (IS_ERR(d->df)) {
+		err = PTR_ERR(d->df);
+		goto out_dev;
+	}
+
+	return d;
+out_dev:
+	put_device(&d->icc_dev);
+out_path:
+	icc_put(path);
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(icc_create_devfreq);
+
+void icc_remove_devfreq(struct icc_devfreq *d)
+{
+	icc_put(d->path);
+	put_device(&d->icc_dev);
+}
+EXPORT_SYMBOL_GPL(icc_remove_devfreq);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("interconnect devfreq device driver");
+MODULE_AUTHOR("Saravana Kannan <saravanak@google.com>");
diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
index 0c0bc55f0e89..cb166cbcdf88 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -23,6 +23,7 @@
 
 struct icc_path;
 struct device;
+struct icc_devfreq;
 
 #if IS_ENABLED(CONFIG_INTERCONNECT)
 
@@ -32,6 +33,8 @@ struct icc_path *of_icc_get(struct device *dev, const char *name);
 struct opp_table *icc_get_opp_table(struct icc_path *path);
 void icc_put(struct icc_path *path);
 int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
+struct icc_devfreq *icc_create_devfreq(struct device *dev, char *name);
+void icc_remove_devfreq(struct icc_devfreq *d);
 
 #else
 
@@ -61,6 +64,14 @@ static inline int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	return 0;
 }
 
+static inline struct icc_devfreq *icc_create_devfreq(struct device *dev,
+						     char *name)
+{
+	return NULL;
+}
+
+void icc_remove_devfreq(struct icc_devfreq *d) {}
+
 #endif /* CONFIG_INTERCONNECT */
 
 #endif /* __LINUX_INTERCONNECT_H */
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

