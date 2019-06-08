Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D044C468C3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 04:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D060C20840
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 04:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o0y7GGh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfFHEoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 00:44:03 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:52876 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbfFHEn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 00:43:56 -0400
Received: by mail-pg1-f202.google.com with SMTP id a13so2729131pgw.19
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 21:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9TRFnG9Pa4xihjbLr7RAzObBFSHpSGvF+wx+CoYHe04=;
        b=o0y7GGh8l3VL4MUBhV0b37+P5uxmTWR3hOCHXucOM+gGogO9VRqImq1BjnHjjqczVX
         CdmCQQP0td9an3P2JHgXjledRwCGknTgFr2DWH9+yeSUE0Iz9sfF0k6VXodhYKfleFfI
         8676yQcSxMPTkd7jkxoI5YJj88ct6YkCz+U1FPW/0KPOxEovCSuBVs5Qk0LlYp9raI5j
         qPsnP8KtSbPSKFCCTaV44dMbk7+Z35vGfg5hhKYqSzkR/OtFTb/WQ4REUvrZ6Uh558H5
         2Xs3pvwT7B0oQOY59w5zmROT28hofI6YfJa2aJYJaB6d3/XDxUlbk7FuC8TLHYPH2rau
         RJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9TRFnG9Pa4xihjbLr7RAzObBFSHpSGvF+wx+CoYHe04=;
        b=l8ZqemmyZd1GtgUjqmVgfwDFITMR3+SfNI6f+T9ILubGZxU2i5Bwzmsrv1p1YTQzXA
         D8SVfXxhgIj6TUBb9hVjrR7DVvuUSz2c/koI97Er4p20j6l1n8o9qEAizGVcusLIbN0I
         Yc7ZCZKgQbFw7QqX0TFQz5LTVrKuZlOcRY/dthJAN176CcB7TsbrG2PRh0ZaQ3eHn9Nn
         hDWhUELQoRPKcXD+R0TYGpR4mJZl3uP13P1URnwNSlB7bm700PcMib8iJ7Hb/9c/DOe9
         Vl2eaJTWUTbk9KxyhGwHkCwCVkLI5L1n53Dn2XQVJHuyf/NUo4Z+9cNX6d/e6PSs2VIl
         n5HA==
X-Gm-Message-State: APjAAAUb6iyZr8RHJjoSolAFgmbs8wH0Sp0E327/9uHCITuab3C1jQPt
        +C2TPj07333SyUb9/LVb8ggZDezn1LRVnXM=
X-Google-Smtp-Source: APXvYqwB3pJhgw3FEqCmaUjeAEEeT2g7UFlbBPH/9ouyGNfYMh2IC0TwNiylyTg/Jrax1O5b3gwzoyWOxiPsIFs=
X-Received: by 2002:a63:1c16:: with SMTP id c22mr6276558pgc.333.1559969035102;
 Fri, 07 Jun 2019 21:43:55 -0700 (PDT)
Date:   Fri,  7 Jun 2019 21:43:33 -0700
In-Reply-To: <20190608044339.115026-1-saravanak@google.com>
Message-Id: <20190608044339.115026-4-saravanak@google.com>
Mime-Version: 1.0
References: <20190608044339.115026-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v1 3/9] OPP: Add helper function for bandwidth OPP tables
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

The frequency OPP tables have helper functions to search for entries in the
table based on frequency and get the frequency values for a given (or
suspend) OPP entry.

Add similar helper functions for bandwidth OPP tables to search for entries
in the table based on peak bandwidth and to get the peak and average
bandwidth for a given (or suspend) OPP entry.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/opp/core.c     | 51 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 19 ++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0e7703fe733f..89a2ece88480 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -130,6 +130,29 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
 
+/**
+ * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an available opp
+ * @opp:	opp for which frequency has to be returned for
+ * @avg_bw:	Pointer where the corresponding average bandwidth is stored.
+ *		Can be NULL.
+ *
+ * Return: Peak bandwidth in KBps corresponding to the opp, else
+ * return 0
+ */
+unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp, unsigned long *avg_bw)
+{
+	if (IS_ERR_OR_NULL(opp) || !opp->available) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return 0;
+	}
+
+	if (avg_bw)
+		avg_bw = opp->avg_bw;
+
+	return opp->rate;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_bw);
+
 /**
  * dev_pm_opp_get_level() - Gets the level corresponding to an available opp
  * @opp:	opp for which level value has to be returned for
@@ -302,6 +325,34 @@ unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_freq);
 
+/**
+ * dev_pm_opp_get_suspend_opp_bw() - Get peak bandwidth of suspend opp in KBps
+ * @dev:	device for which we do this operation
+ * @avg_bw:	Pointer where the corresponding average bandwidth is stored.
+ *		Can be NULL.
+ *
+ * Return: This function returns the peak bandwidth of the OPP marked as
+ * suspend_opp if one is available, else returns 0;
+ */
+unsigned long dev_pm_opp_get_suspend_opp_bw(struct device *dev,
+					    unsigned long avg_bw)
+{
+	struct opp_table *opp_table;
+	unsigned long peak_bw = 0;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table))
+		return 0;
+
+	if (opp_table->suspend_opp && opp_table->suspend_opp->available)
+		peak_bw = dev_pm_opp_get_bw(opp_table->suspend_opp, avg_bw);
+
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return peak_bw;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_suspend_opp_bw);
+
 int _get_opp_count(struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp;
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index b150fe97ce5a..7f040cc20daf 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -85,6 +85,7 @@ void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
+unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp, unsigned long *avg_bw);
 
 unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp);
 
@@ -95,6 +96,8 @@ unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev);
 unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev);
 unsigned long dev_pm_opp_get_max_transition_latency(struct device *dev);
 unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev);
+unsigned long dev_pm_opp_get_suspend_opp_bw(struct device *dev,
+					    unsigned long avg_bw);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
@@ -161,6 +164,11 @@ static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 {
 	return 0;
 }
+static inline unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp,
+					      unsigned long avg_bw)
+{
+	return 0;
+}
 
 static inline unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
 {
@@ -197,6 +205,12 @@ static inline unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
 	return 0;
 }
 
+static inline unsigned long dev_pm_opp_get_suspend_opp_bw(struct device *dev,
+							  unsigned long avg_bw)
+{
+	return 0;
+}
+
 static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					unsigned long freq, bool available)
 {
@@ -332,6 +346,11 @@ static inline void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask
 
 #endif		/* CONFIG_PM_OPP */
 
+#define dev_pm_opp_find_peak_bw_exact	dev_pm_opp_find_freq_exact
+#define dev_pm_opp_find_peak_bw_floor	dev_pm_opp_find_freq_floor
+#define dev_pm_opp_find_peak_bw_ceil_by_volt dev_pm_opp_find_freq_ceil_by_volt
+#define dev_pm_opp_find_peak_bw_ceil	dev_pm_opp_find_freq_ceil
+
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
 int dev_pm_opp_of_add_table(struct device *dev);
 int dev_pm_opp_of_add_table_indexed(struct device *dev, int index);
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

