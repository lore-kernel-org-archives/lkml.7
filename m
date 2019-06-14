Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4806BC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 04:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122F02168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 04:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTap/qZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfFNESP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 00:18:15 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:54641 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfFNESN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 00:18:13 -0400
Received: by mail-yw1-f73.google.com with SMTP id f69so1181046ywb.21
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 21:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XMHdLt0F/RebP7HWzdCoOFobZW4NF5SUvUmDw/iFZhM=;
        b=oTap/qZTUkne67PMlUoRRMatHHPoKZTDEI6qJcuLB9ihSS6zThbjemCxzkWFRfYDe4
         9d5fipYW0JDjBZJeOHeskT7pfF+F2CeBpJ+4vA1yNvx2v0cvuNhnlf9B1F4czXrF6e1E
         9KPWCEuAqkILo799F3zCy0q+meYFfDuPZ+paISctiLQNVa2A4nJsys8iaiFxlp3gmRhm
         ygQFxemjnu5T7BIut2Z9MFiKsjFKLfEJkIwabASqhhwBSNUs+h/RYpFnGb4bpGm7yI/f
         5B2BR72PGxmfhE8Ty/RgPIDa2ouzpT0/02fA87EU5jCUGNpJNjPCTJCQihiOgCFU+Y66
         Lgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XMHdLt0F/RebP7HWzdCoOFobZW4NF5SUvUmDw/iFZhM=;
        b=XtqJXoQ5tPklgNPoPc0FXzeGRLdZ76jA5jw1kPXz4Koq5sMRAjTNX7mSszZ4CoQK55
         +zZe0jUQLHvOLWZbW4EI6n/6CWuYXCpuNxr0105Gmb0Qp/pb4uk+L5HWfW1LwiuPAy37
         5/jqK4k88lybbeJfolj6MhHcq3ONpEDhevppZ4NoRBa4fI+GIlX1K2MUcLDIMgTbvrbp
         guprjIOQ124vDT51pviM6dOsxNbM9bpHS7gT5jaq4ZLJyu7S3HI576jz1+H+O9AxZ34n
         xw5ugcrOrxVTEWpYwyR17nU5LpooRbykPXSGIBuzpq6zGrgB062LRgEeDGf76JEJJKE7
         hBHg==
X-Gm-Message-State: APjAAAWunGr23LYKMgvx7glkyQYq1+YkCgZ8E1gj5fO9HtqDlcMKii36
        B09r6Ft7HCX//edKfGHz18E/STEvmlbQSiI=
X-Google-Smtp-Source: APXvYqyzotUOqc78Ajag02/VO0hFFB2pIylM0aPaNgvpI75rUDbQ8p8l6vCV8TAGFIu1713tf9bDphp6hphaolQ=
X-Received: by 2002:a81:35c9:: with SMTP id c192mr42314247ywa.193.1560485892382;
 Thu, 13 Jun 2019 21:18:12 -0700 (PDT)
Date:   Thu, 13 Jun 2019 21:17:33 -0700
In-Reply-To: <20190614041733.120807-1-saravanak@google.com>
Message-Id: <20190614041733.120807-12-saravanak@google.com>
Mime-Version: 1.0
References: <20190614041733.120807-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 11/11] interconnect: Add devfreq support
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
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
 drivers/interconnect/icc-devfreq.c | 156 +++++++++++++++++++++++++++++
 include/linux/interconnect.h       |  14 +++
 3 files changed, 171 insertions(+), 1 deletion(-)
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
index 000000000000..608716fbe612
--- /dev/null
+++ b/drivers/interconnect/icc-devfreq.c
@@ -0,0 +1,156 @@
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
+#if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
+	struct devfreq_passive_data p_data;
+#endif
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
+struct icc_devfreq *icc_create_devfreq(struct device *dev, char *name,
+				       struct devfreq *devf)
+{
+	struct icc_devfreq *d;
+	struct icc_path *path;
+	struct opp_table *opp_table;
+	struct dev_pm_opp *opp;
+	void *p_data = NULL;
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
+#if !IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
+	if (devf) {
+		d->p_data.parent = devf;
+		pdata = &d->p_data;
+	}
+#endif
+	d->dp.initial_freq = peak_bw;
+	d->dp.polling_ms = 0;
+	d->dp.target = icc_target;
+	d->dp.get_dev_status = icc_get_dev_status;
+	d->df = devm_devfreq_add_device(&d->icc_dev,
+					&d->dp,
+					p_data ? "passive" : "performance",
+					p_data);
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
index 0c0bc55f0e89..ec5879a79301 100644
--- a/include/linux/interconnect.h
+++ b/include/linux/interconnect.h
@@ -10,6 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/types.h>
 #include <linux/pm_opp.h>
+#include <linux/devfreq.h>
 
 /* macros for converting to icc units */
 #define Bps_to_icc(x)	((x) / 1000)
@@ -23,6 +24,7 @@
 
 struct icc_path;
 struct device;
+struct icc_devfreq;
 
 #if IS_ENABLED(CONFIG_INTERCONNECT)
 
@@ -32,6 +34,9 @@ struct icc_path *of_icc_get(struct device *dev, const char *name);
 struct opp_table *icc_get_opp_table(struct icc_path *path);
 void icc_put(struct icc_path *path);
 int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw);
+struct icc_devfreq *icc_create_devfreq(struct device *dev, char *name,
+				       struct devfreq *devf);
+void icc_remove_devfreq(struct icc_devfreq *d);
 
 #else
 
@@ -61,6 +66,15 @@ static inline int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	return 0;
 }
 
+static inline struct icc_devfreq *icc_create_devfreq(struct device *dev,
+						     char *name,
+						     struct devfreq *devf);
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

