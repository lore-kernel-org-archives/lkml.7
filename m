Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836B6C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D33420685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pFONKqXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfDWN2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:28:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39683 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbfDWN2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:28:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id l7so13518652ljg.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 06:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QtHDB3QMogv515ITSyvJXMA+IzhZoNxGiv5NT5h1biw=;
        b=pFONKqXyBmUDG4wQo07YI3Wbdza5aMEyIASoDSFX6o8AcxMLF6619lBuscNbCsqJvB
         p2JTMAdUlew+S99HAcKB+uoxUm0qYmzo7ESgwwJMLJjrQ33GweVt+eNFpiURepbvGhym
         9n9J7H6WkH2EJc4fjiX5IQC6wb3jOLTdCEZCCokb8qol1sQT4/x2RytS/0jzzkNSX+YL
         B9zXytaOQ2hMXoEeeX1OK39hUhxqBVp8ke0S6ejVkQVka9fRxpw4iYmtnGaRAP3x6Y6v
         k/Nd4rPgF5A3w8bWt3iRW4SnGnpcL6qpid8/Psn3Qjwd6soR+zOq1XJ3QMf9v0fQdNA4
         ptuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QtHDB3QMogv515ITSyvJXMA+IzhZoNxGiv5NT5h1biw=;
        b=tRcEr6Num5yfAKuZ4X85ltYBbs6Vm+1e9CJf3ElVMn3USUxCKGsfCQFVXdibxO+R2y
         eqvVAQAXtK8x1pyEBq6kILJ+mo5OOQFlwZEyLvfJXZABgTBc/f/7y+h91Vd+FaPLO59H
         frqrgpJUMB6PIWk+IKA1nHrH154Ixn0WS3YJuIWnMeg27CMRWur/+A5xTcp6vxX3/6tQ
         TL+GT0tMhYE6DW7H5B0o/sfDNmTXS1cUpFG5qAI0zv+JSlIh7Ns2n+F+CI0sGbLzuatf
         Bv5i81Jhl+wSPGlfe6o9matV5jixRJqPAA7SZx6WxxaksKw41xk8UwXOX20J8aqCjrZS
         +W7Q==
X-Gm-Message-State: APjAAAVfdERQvyKSQ2MINc/BwtRSyBlBgeO/dusRQBKjPjPD0YnPxzTZ
        2PvSe3foO77LPiaesty4SIYxXg==
X-Google-Smtp-Source: APXvYqy0XJIbuwvem78ICkHllbYavZe5S7u7nhzcgk+bOirZg0VOKGzw1i6QGcAoOm1+gDGWVPnU6g==
X-Received: by 2002:a2e:9ac3:: with SMTP id p3mr14664445ljj.109.1556026112981;
        Tue, 23 Apr 2019 06:28:32 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y206sm4617107lfc.72.2019.04.23.06.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 06:28:32 -0700 (PDT)
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
Subject: [PATCH v2 3/5] OPP: Add support for parsing the interconnect bandwidth
Date:   Tue, 23 Apr 2019 16:28:21 +0300
Message-Id: <20190423132823.7915-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423132823.7915-1-georgi.djakov@linaro.org>
References: <20190423132823.7915-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP bindings now support bandwidth values, so add support to parse it
from device tree and store it into the new dev_pm_opp_icc_bw struct, which
is part of the dev_pm_opp.

Also add and export the dev_pm_opp_set_paths() and dev_pm_opp_put_paths()
helpers, to set (and release) an interconnect paths to a device. The
bandwidth of these paths will be updated when the OPPs are switched.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/opp/core.c     |  87 ++++++++++++++++++++++++++++++++++-
 drivers/opp/of.c       | 102 +++++++++++++++++++++++++++++++++++++++++
 drivers/opp/opp.h      |   9 ++++
 include/linux/pm_opp.h |  14 ++++++
 4 files changed, 210 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0420f7e8ad5b..97ee39ecdebd 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/interconnect.h>
 #include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
 
@@ -876,6 +877,8 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 				ret);
 	}
 
+	_of_find_paths(opp_table, dev);
+
 	BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
 	INIT_LIST_HEAD(&opp_table->opp_list);
 	kref_init(&opp_table->kref);
@@ -1129,11 +1132,12 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_remove_all_dynamic);
 struct dev_pm_opp *_opp_allocate(struct opp_table *table)
 {
 	struct dev_pm_opp *opp;
-	int count, supply_size;
+	int count, supply_size, icc_size;
 
 	/* Allocate space for at least one supply */
 	count = table->regulator_count > 0 ? table->regulator_count : 1;
 	supply_size = sizeof(*opp->supplies) * count;
+	icc_size = sizeof(*opp->bandwidth) * table->path_count;
 
 	/* allocate new OPP node and supplies structures */
 	opp = kzalloc(sizeof(*opp) + supply_size, GFP_KERNEL);
@@ -1141,7 +1145,8 @@ struct dev_pm_opp *_opp_allocate(struct opp_table *table)
 		return NULL;
 
 	/* Put the supplies at the end of the OPP structure as an empty array */
-	opp->supplies = (struct dev_pm_opp_supply *)(opp + 1);
+	opp->bandwidth = (struct dev_pm_opp_icc_bw *)(opp + 1);
+	opp->supplies = (struct dev_pm_opp_supply *)(opp + icc_size + 1);
 	INIT_LIST_HEAD(&opp->node);
 
 	return opp;
@@ -1637,6 +1642,84 @@ void dev_pm_opp_put_clkname(struct opp_table *opp_table)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_put_clkname);
 
+/**
+ * dev_pm_opp_set_paths() - Set interconnect path for a device
+ * @dev: Device for which interconnect path is being set.
+ *
+ * This must be called before any OPPs are initialized for the device.
+ */
+struct opp_table *dev_pm_opp_set_paths(struct device *dev)
+{
+	struct opp_table *opp_table;
+	int ret, i;
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
+	if (opp_table->paths)
+		return opp_table;
+
+	opp_table->paths = kmalloc_array(opp_table->path_count,
+					 sizeof(*opp_table->paths), GFP_KERNEL);
+
+	/* Find interconnect path(s) for the device */
+	for (i = 0; i < opp_table->path_count; i++) {
+		opp_table->paths[i] = of_icc_get_by_index(dev, i);
+		if (IS_ERR(opp_table->paths[i])) {
+			ret = PTR_ERR(opp_table->paths[i]);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "%s: Couldn't find path%d: %d\n",
+					__func__, i, ret);
+			goto err;
+		}
+	}
+
+	return opp_table;
+
+err:
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_set_paths);
+
+/**
+ * dev_pm_opp_put_paths() - Release interconnect path resources
+ * @opp_table: OPP table returned from dev_pm_opp_set_paths().
+ */
+void dev_pm_opp_put_paths(struct opp_table *opp_table)
+{
+	int i;
+
+	if (!opp_table->paths) {
+		pr_err("%s: Doesn't have paths set\n", __func__);
+		return;
+	}
+
+	/* Make sure there are no concurrent readers while updating opp_table */
+	WARN_ON(!list_empty(&opp_table->opp_list));
+
+	for (i = opp_table->path_count - 1; i >= 0; i--)
+		icc_put(opp_table->paths[i]);
+
+	_free_set_opp_data(opp_table);
+
+	kfree(opp_table->paths);
+	opp_table->paths = NULL;
+	opp_table->path_count = 0;
+
+	dev_pm_opp_put_opp_table(opp_table);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_put_paths);
+
 /**
  * dev_pm_opp_register_set_opp_helper() - Register custom set OPP helper
  * @dev: Device for which the helper is getting registered.
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index c10c782d15aa..00af23280bc6 100644
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
@@ -363,6 +364,45 @@ static int _of_opp_alloc_required_opps(struct opp_table *opp_table,
 	return ret;
 }
 
+int _of_find_paths(struct opp_table *opp_table, struct device *dev)
+{
+	struct device_node *np;
+	int ret, i, count, num_paths;
+
+	np = of_node_get(dev->of_node);
+	if (np) {
+		count = of_count_phandle_with_args(np, "interconnects",
+						   "#interconnect-cells");
+		if (count % 2) {
+			dev_err(dev, "%s: Invalid interconnects values\n",
+				__func__);
+			ret = -EINVAL;
+			goto put_of_node;
+		}
+
+		num_paths = count / 2;
+		opp_table->paths = kcalloc(num_paths, sizeof(*opp_table->paths),
+					   GFP_KERNEL);
+		if (!opp_table->paths) {
+			ret = -ENOMEM;
+			goto put_of_node;
+		}
+
+		for (i = 0; i < num_paths; i++)
+			opp_table->paths[i] = of_icc_get_by_index(dev, i);
+
+		opp_table->path_count = num_paths;
+		of_node_put(np);
+	}
+
+	return 0;
+
+put_of_node:
+	of_node_put(np);
+
+	return ret;
+}
+
 static bool _opp_is_supported(struct device *dev, struct opp_table *opp_table,
 			      struct device_node *np)
 {
@@ -539,6 +579,64 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 	return ret;
 }
 
+static int opp_parse_icc_bw(struct dev_pm_opp *opp, struct device *dev,
+			    struct opp_table *opp_table)
+{
+	struct property *prop = NULL;
+	u32 *bandwidth;
+	char name[] = "bandwidth-MBps";
+	int count, i, j, ret;
+
+	/* Search for "bandwidth-MBps" */
+	prop = of_find_property(opp->np, name, NULL);
+
+	/* Missing property is not a problem */
+	if (!prop) {
+		dev_dbg(dev, "%s: Missing %s property\n", __func__, name);
+		return 0;
+	}
+
+	if (!prop->value) {
+		dev_dbg(dev, "%s: Missing %s value\n", __func__, name);
+		return -ENODATA;
+	}
+
+	/*
+	 * Bandwidth consists of average and peak values like:
+	 * bandwidth-MBps = <avg-MBps peak-MBps>
+	 */
+	count = prop->length / sizeof(u32);
+	if (count % 2) {
+		dev_err(dev, "%s: Invalid %s values\n", __func__, name);
+		return -EINVAL;
+	}
+
+	if (opp_table->path_count != count / 2) {
+		dev_err(dev, "%s Mismatch between values and paths (%d %d)\n",
+			__func__, opp_table->path_count, count / 2);
+		return -EINVAL;
+	}
+
+	bandwidth = kmalloc_array(count, sizeof(*bandwidth), GFP_KERNEL);
+	if (!bandwidth)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(opp->np, name, bandwidth, count);
+	if (ret) {
+		dev_err(dev, "%s: Error parsing %s: %d\n", __func__, name, ret);
+		goto free_bandwidth;
+	}
+	for (i = 0, j = 0; i < count; i++) {
+		opp->bandwidth[i].avg = MBps_to_icc(bandwidth[j++]);
+		opp->bandwidth[i].peak = MBps_to_icc(bandwidth[j++]);
+	}
+
+free_bandwidth:
+	kfree(bandwidth);
+
+	return ret;
+}
+
 /**
  * dev_pm_opp_of_remove_table() - Free OPP table entries created from static DT
  *				  entries
@@ -635,6 +733,10 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 	if (opp_table->is_genpd)
 		new_opp->pstate = pm_genpd_opp_to_performance_state(dev, new_opp);
 
+	ret = opp_parse_icc_bw(new_opp, dev, opp_table);
+	if (ret)
+		goto free_opp;
+
 	ret = _opp_add(dev, new_opp, opp_table, rate_not_available);
 	if (ret) {
 		/* Don't return error for duplicate OPPs */
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 569b3525aa67..70a537f2dbd3 100644
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
@@ -84,6 +86,7 @@ struct dev_pm_opp {
 	unsigned int level;
 
 	struct dev_pm_opp_supply *supplies;
+	struct dev_pm_opp_icc_bw *bandwidth;
 
 	unsigned long clock_latency_ns;
 
@@ -150,6 +153,8 @@ enum opp_table_access {
  * @regulator_count: Number of power supply regulators. Its value can be -1
  * (uninitialized), 0 (no opp-microvolt property) or > 0 (has opp-microvolt
  * property).
+ * @paths: Interconnect path handles
+ * @path_count: Number of interconnect paths
  * @genpd_performance_state: Device's power domain support performance state.
  * @is_genpd: Marks if the OPP table belongs to a genpd.
  * @set_opp: Platform specific set_opp callback
@@ -194,6 +199,8 @@ struct opp_table {
 	struct clk *clk;
 	struct regulator **regulators;
 	int regulator_count;
+	struct icc_path **paths;
+	unsigned int path_count;
 	bool genpd_performance_state;
 	bool is_genpd;
 
@@ -228,12 +235,14 @@ void _of_clear_opp_table(struct opp_table *opp_table);
 struct opp_table *_managed_opp(struct device *dev, int index);
 void _of_opp_free_required_opps(struct opp_table *opp_table,
 				struct dev_pm_opp *opp);
+int _of_find_paths(struct opp_table *opp_table, struct device *dev);
 #else
 static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index) {}
 static inline void _of_clear_opp_table(struct opp_table *opp_table) {}
 static inline struct opp_table *_managed_opp(struct device *dev, int index) { return NULL; }
 static inline void _of_opp_free_required_opps(struct opp_table *opp_table,
 					      struct dev_pm_opp *opp) {}
+static inline int _of_find_paths(struct opp_table *opp_table, struct device *dev) { return 0; }
 #endif
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 24c757a32a7b..dabee09a92b8 100644
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
+struct opp_table *dev_pm_opp_set_paths(struct device *dev);
+void dev_pm_opp_put_paths(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index);
