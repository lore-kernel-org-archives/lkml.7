Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBC2C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 04:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C8B208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 04:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJ3aHcdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfFNESG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 00:18:06 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:53211 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFNESB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 00:18:01 -0400
Received: by mail-qk1-f201.google.com with SMTP id v80so986536qkb.19
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 21:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UKBZW/bY8zOAr/plZn+Op1rwjT9HYs9LkDIRTy2D6w8=;
        b=aJ3aHcdgyVnfvaTZCyFu4eGhtPlvIdnTr1YbDdC8IqvSTbaV5ewzq119FXRdGWbyJk
         +Yst8x9/AsfJCx5639sTDPYrKeGCRmttk5NbC58YhiXeafdHie+sOslPi0/Zz7zzDBya
         M4GsRLTvGGaxvVaCrjNKBj6U5Tjc/LfI4gBDZOj4YhUg10KFe+8NaQx6dHmi0F8ZXjm3
         DUyOpK3C5VKdCMYMXQ+681gBnCsF16o4dzAcD5DSdzBT1XCf1HS8f3UBsIsvxXg34cNn
         7vONj4BSGXj9k+9P8xHyycMAqXTD6B+kiZmoQ9oIm+gm8qiJqeRlkDuRWaxoQTE+ILo0
         TpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UKBZW/bY8zOAr/plZn+Op1rwjT9HYs9LkDIRTy2D6w8=;
        b=OGsAuHgbX0zAt+flJ+lMRNeWb7gVz/rv73QRSCceWU7nUybfbx+pHllyyUR1zNpb4/
         Jvn3Q0wE6kmjDgrp59Ht2Ysbx6VqvWlt6DFe0JB3/w1XF3ifEZOvSX6fR0n09ZtbPXCU
         KF/nfbZ18O0t2afSHiJHc7Xsl+m6rUb4Iaub93YE6xmCf34y0NOHl1RYcs50KVfbb6aV
         HaVpSsdbqdk3Gg3dufX4RtnYf39vQoP/7z0SeAwWZN0vOhO6cMqa1HFJDFCpJf3wmWF1
         AGxT5Q2p/6itW4aKZdLbGw5kuII2oJQ7KG4g353PCphPLNzzDTvIaMwdcYubMTfLJo73
         49Vg==
X-Gm-Message-State: APjAAAVCbHg3gOEM4LRMLYgnU104rPW12HKPaFG7qI4aODVSj6PWJWjz
        +xdoacIjJslk/eka9Dbl1tjQZfUfcmO2RuQ=
X-Google-Smtp-Source: APXvYqwNHVV/7PLhJwj+svcCIUrPmY1jO7vEGuD4JG4BFATM2A8M3NqvS+XDruf4o0rfUbchRAqDV/hvtm9tcVE=
X-Received: by 2002:a05:620a:1329:: with SMTP id p9mr6566138qkj.224.1560485880047;
 Thu, 13 Jun 2019 21:18:00 -0700 (PDT)
Date:   Thu, 13 Jun 2019 21:17:29 -0700
In-Reply-To: <20190614041733.120807-1-saravanak@google.com>
Message-Id: <20190614041733.120807-8-saravanak@google.com>
Mime-Version: 1.0
References: <20190614041733.120807-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 07/11] OPP: Add API to find an OPP table from its DT node
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

This allows finding a device's OPP table (when it has multiple) from a
phandle to the OPP table in DT.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/opp/of.c       | 42 ++++++++++++++++++++++++++++++++++--------
 include/linux/pm_opp.h |  7 +++++++
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index d5815289518a..e8697a4ca3bc 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -42,14 +42,9 @@ struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
 
-struct opp_table *_managed_opp(struct device *dev, int index)
+struct opp_table *_find_opp_table_from_node(struct device_node *np)
 {
 	struct opp_table *opp_table, *managed_table = NULL;
-	struct device_node *np;
-
-	np = _opp_of_get_opp_desc_node(dev->of_node, index);
-	if (!np)
-		return NULL;
 
 	list_for_each_entry(opp_table, &opp_tables, node) {
 		if (opp_table->np == np) {
@@ -69,11 +64,42 @@ struct opp_table *_managed_opp(struct device *dev, int index)
 		}
 	}
 
-	of_node_put(np);
-
 	return managed_table;
 }
 
+/**
+ * dev_pm_opp_of_find_table_from_node() - Find OPP table from its DT node
+ * @np: DT node used for finding the OPP table
+ *
+ * Return: OPP table corresponding to the DT node, else NULL on failure.
+ *
+ * The caller needs to put the node with of_node_put() after using it.
+ */
+struct opp_table *dev_pm_opp_of_find_table_from_node(struct device_node *np)
+{
+	struct opp_table *opp_table;
+
+	mutex_lock(&opp_table_lock);
+	opp_table = _find_opp_table_from_node(np);
+	mutex_unlock(&opp_table_lock);
+	return opp_table;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_find_table_from_node);
+
+struct opp_table *_managed_opp(struct device *dev, int index)
+{
+	struct device_node *np;
+	struct opp_table *opp_table;
+
+	np = _opp_of_get_opp_desc_node(dev->of_node, index);
+	if (!np)
+		return NULL;
+
+	opp_table = _find_opp_table_from_node(np);
+	of_node_put(np);
+	return opp_table;
+}
+
 /* The caller must call dev_pm_opp_put() after the OPP is used */
 static struct dev_pm_opp *_find_opp_of_np(struct opp_table *opp_table,
 					  struct device_node *opp_np)
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 2e122af26b8e..d9156b62d966 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -370,6 +370,7 @@ int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask);
 void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
+struct opp_table *dev_pm_opp_of_find_table_from_node(struct device_node *np);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
 int of_get_required_opp_performance_state(struct device_node *np, int index);
 void dev_pm_opp_of_register_em(struct cpumask *cpus);
@@ -407,6 +408,12 @@ static inline struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device
 	return NULL;
 }
 
+static inline struct opp_table *dev_pm_opp_of_find_table_from_node(
+							struct device_node *np)
+{
+	return NULL;
+}
+
 static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 {
 	return NULL;
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

