Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7D7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414172184E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U0NoQAE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfCMJAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:00:23 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38469 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfCMJAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:00:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id x13so806850ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 02:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zhFevYCoUsTXnKrIe0oUFGZvHECD1lnXeInV/z6OmOY=;
        b=U0NoQAE1rR2jpG5MwyyZKfkfQKR6xE5Rd4/w9dDhDv10qtf3Rw9N1i1KbP0QJJ+XvD
         tUg95cFcxFnv4dw0zuWP528Gqcr5+Alh5+SuxTQSvkBd+MDVWlyl+ytFS5vQjvXwXu6C
         4jIqDYVQijLop1yo8WJXa6vemosaBoVyRB47nIROuwJww9U+igUw6gDfvT/VJNn1KTLj
         5pCpcdD9onBhuOdJXFk+aOSF6d4dljpxf478+jSik1raUbB5P0roZ+YpmKeEeSaJIyyP
         cRTq5tFwby+fnEj7q40cZBOlFwdSXSpOf7g946Rq5yrZCHYy4NKs8sKi8h4n+SMt63hS
         6krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zhFevYCoUsTXnKrIe0oUFGZvHECD1lnXeInV/z6OmOY=;
        b=eBBBQ+cAKnXuTgkSeiogYhjDcdW6ZBqgZ6NTOczaxAB9GUnSEGr/Wmd9BLJxceEg71
         r2gI9CV9rnC07eNtYQuWgJxooFXRkKzGM+kC8xhuDcDljdZr5noDodAx0A6mQcd40JTK
         NcGsjJdCJmugZnX7ybN9L209TMhaKOeA8BYLHbUnK3MPdYKsNpdwrftDi1S2nAvFHzXS
         InukOVTuIn9CQi5VEpQnn3HHcAWlYveaRk70uQEFoQpph+55byxsNfe/JJESrJHMEfZL
         XRd+g2bUBDtJF/qJSHPhE6cZtOD+jGrxhrLuoYwY/OmGiYY0/NH8XZAKPPLj4mvPuM2w
         RZew==
X-Gm-Message-State: APjAAAUoc9Q6rzxOP2uUfsx+r/FjF3mYL7qXAfb4WzfdTxYilKKEPMtv
        DhqAKD9uNYjAFxAd4FtXpmnaRw==
X-Google-Smtp-Source: APXvYqyDs9ZIvENt3V0xXCjw7+Yf3lFbjOD5pmJNzXjFLKJW+kuXRCc4fOoAazfEUcfvxu/rU5TweA==
X-Received: by 2002:a2e:719:: with SMTP id 25mr22507673ljh.122.1552467618197;
        Wed, 13 Mar 2019 02:00:18 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id u15sm1701986lja.73.2019.03.13.02.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 02:00:17 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     vireshk@kernel.org, sboyd@kernel.org, nm@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net
Cc:     jcrouse@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, sibis@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH 2/4] OPP: Add support for parsing the interconnect bandwidth
Date:   Wed, 13 Mar 2019 11:00:08 +0200
Message-Id: <20190313090010.20534-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313090010.20534-1-georgi.djakov@linaro.org>
References: <20190313090010.20534-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP bindings now support bandwidth values, so add support to parse it
from device tree and store it into the new dev_pm_opp_icc_bw struct, which
is part of the dev_pm_opp.

Also add and export the dev_pm_opp_set_path() and dev_pm_opp_put_path()
helpers, to set (and release) an interconnect path to a device. The
bandwidth of this path will be updated when the OPPs are switched.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/opp/core.c     | 67 ++++++++++++++++++++++++++++++++++++++++++
 drivers/opp/of.c       | 44 +++++++++++++++++++++++++++
 drivers/opp/opp.h      |  6 ++++
 include/linux/pm_opp.h | 14 +++++++++
 4 files changed, 131 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e06a0ab05ad6..4b019cecaa07 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/interconnect.h>
 #include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
 
@@ -1645,6 +1646,72 @@ void dev_pm_opp_put_clkname(struct opp_table *opp_table)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_clkname);
 
+/**
+ * dev_pm_opp_set_path() - Set interconnect path for a device
+ * @dev: Device for which interconnect path is being set.
+ * @name: Interconnect path name or NULL.
+ *
+ * This must be called before any OPPs are initialized for the device.
+ */
+struct opp_table *dev_pm_opp_set_path(struct device *dev, const char *name)
+{
+	struct opp_table *opp_table;
+	int ret;
+
+	opp_table = dev_pm_opp_get_opp_table(dev);
+	if (!opp_table)
+		return ERR_PTR(-ENOMEM);
+
+	/* This should be called before OPPs are initialized */
+	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	/* Another CPU that shares the OPP table has set the path */
+	if (opp_table->path)
+		return opp_table;
+
+	/* Find interconnect path for the device */
+	opp_table->path = of_icc_get(dev, name);
+	if (IS_ERR(opp_table->path)) {
+		ret = PTR_ERR(opp_table->clk);
+		if (ret != -EPROBE_DEFER) {
+			dev_err(dev, "%s: Couldn't find path: %d\n", __func__,
+				ret);
+		}
+		goto err;
+	}
+
+	return opp_table;
+
+err:
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_path);
+
+/**
+ * dev_pm_opp_put_path() - Release interconnect path resources
+ * @opp_table: OPP table returned from dev_pm_opp_set_path().
+ */
+void dev_pm_opp_put_path(struct opp_table *opp_table)
+{
+	if (!opp_table->path)
+		goto put_opp_table;
+
+	/* Make sure there are no concurrent readers while updating opp_table */
+	WARN_ON(!list_empty(&opp_table->opp_list));
+
+	icc_put(opp_table->path);
+	opp_table->path = NULL;
+
+put_opp_table:
+	dev_pm_opp_put_opp_table(opp_table);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_put_path);
+
 /**
  * dev_pm_opp_register_set_opp_helper() - Register custom set OPP helper
  * @dev: Device for which the helper is getting registered.
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 1779f2c93291..96fb7fdda8c7 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -16,6 +16,7 @@
 #include <linux/cpu.h>
 #include <linux/errno.h>
 #include <linux/device.h>
+#include <linux/interconnect.h>
 #include <linux/of_device.h>
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
@@ -526,6 +527,45 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 	return ret;
 }
 
+static int opp_parse_icc_bw(struct dev_pm_opp *opp, struct device *dev,
+			    struct opp_table *opp_table)
+{
+	struct property *prop = NULL;
+	char name[NAME_MAX];
+	int count;
+	u32 avg = 0;
+	u32 peak = 0;
+
+	/* Search for "opp-bw-MBs" */
+	sprintf(name, "opp-bw-MBs");
+	prop = of_find_property(opp->np, name, NULL);
+
+	/* Missing property is not a problem */
+	if (!prop) {
+		dev_dbg(dev, "%s: Missing opp-bw-MBs\n", __func__);
+		return 0;
+	}
+
+	count = of_property_count_u32_elems(opp->np, name);
+	if (count != 2) {
+		dev_err(dev, "%s: Invalid number of elements in %s property\n",
+			__func__, name);
+		return -EINVAL;
+	}
+
+	opp->bandwidth = kzalloc(sizeof(*opp->bandwidth), GFP_KERNEL);
+	if (!opp->bandwidth)
+		return -ENOMEM;
+
+	of_property_read_u32_index(opp->np, name, 0, &avg);
+	of_property_read_u32_index(opp->np, name, 1, &peak);
+
+	opp->bandwidth->avg = MBps_to_icc(avg);
+	opp->bandwidth->peak = MBps_to_icc(peak);
+
+	return 0;
+}
+
 /**
  * dev_pm_opp_of_remove_table() - Free OPP table entries created from static DT
  *				  entries
@@ -619,6 +659,10 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	if (ret)
 		goto free_required_opps;
 
+	ret = opp_parse_icc_bw(new_opp, dev, opp_table);
+	if (ret)
+		goto free_required_opps;
+
 	if (opp_table->is_genpd)
 		new_opp->pstate = pm_genpd_opp_to_performance_state(dev, new_opp);
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 4458175aa661..b4287d065c24 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -24,6 +24,7 @@
 
 struct clk;
 struct regulator;
+struct icc_path;
 
 /* Lock to allow exclusive modification to the device and opp lists */
 extern struct mutex opp_table_lock;
@@ -62,6 +63,7 @@ extern struct list_head opp_tables;
  * @rate:	Frequency in hertz
  * @level:	Performance level
  * @supplies:	Power supplies voltage/current values
+ * @bandwidth:	Interconnect bandwidth values
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
  *		frequency from any other OPP's frequency.
  * @required_opps: List of OPPs that are required by this OPP.
@@ -85,6 +87,8 @@ struct dev_pm_opp {
 
 	struct dev_pm_opp_supply *supplies;
 
+	struct dev_pm_opp_icc_bw *bandwidth;
+
 	unsigned long clock_latency_ns;
 
 	struct dev_pm_opp **required_opps;
@@ -152,6 +156,7 @@ enum opp_table_access {
  * property).
  * @genpd_performance_state: Device's power domain support performance state.
  * @is_genpd: Marks if the OPP table belongs to a genpd.
+ * @path: Interconnect path handle
  * @set_opp: Platform specific set_opp callback
  * @set_opp_data: Data to be passed to set_opp callback
  * @dentry:	debugfs dentry pointer of the real device directory (not links).
@@ -196,6 +201,7 @@ struct opp_table {
 	int regulator_count;
 	bool genpd_performance_state;
 	bool is_genpd;
+	struct icc_path *path;
 
 	int (*set_opp)(struct dev_pm_set_opp_data *data);
 	struct dev_pm_set_opp_data *set_opp_data;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 900359342965..5edce71a15d6 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -43,6 +43,18 @@ struct dev_pm_opp_supply {
 	unsigned long u_amp;
 };
 
+/**
+ * struct dev_pm_opp_icc_bw - Interconnect bandwidth values
+ * @avg:	Average bandwidth corresponding to this OPP (in icc units)
+ * @peak:	Peak bandwidth corresponding to this OPP (in icc units)
+ *
+ * This structure stores the bandwidth values for a single interconnect path.
+ */
+struct dev_pm_opp_icc_bw {
+	u32 avg;
+	u32 peak;
+};
+
 /**
  * struct dev_pm_opp_info - OPP freq/voltage/current values
  * @rate:	Target clk rate in hz
@@ -127,6 +139,8 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * con
 void dev_pm_opp_put_regulators(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
+struct opp_table *dev_pm_opp_set_path(struct device *dev, const char *name);
+void dev_pm_opp_put_path(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index);
