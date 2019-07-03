Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F349C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6F220673
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwTMOg1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfGCBKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:10:36 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:48176 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfGCBKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:10:35 -0400
Received: by mail-oi1-f202.google.com with SMTP id a198so352924oii.15
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 18:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BIB5A9ngYQ21e4UWwpxGoaLXwuW8tNl9DCFK747Sb4o=;
        b=XwTMOg1R7C9eWoppaFTrTaFBZmQOj8k2Yscg00eIPwDaQoRQYl7ee8Qc2FlcNMASXT
         1EitN34YZe7NVLEzs82LisWVDqKQy3jLsFxUO0uikI4SF6BZitqw2zXRhjS8YN2s+EEH
         DTVmz86oZ+kv4UxmbIlgT741QhfKU3533HE0LDTdUjzqPbSSemPADj6FHkPjibGEOTqt
         /wYNZe5Ce+ftw0C6V2HsMcbWTO7VQ4n0U7UXUpNm9tlzN5qVVmXxMeTAC/Fp/9poRVRq
         PoFPVgzZpBoPlKdeDPtTWp5fpymHNxlMeTr1TRpDnaSrTCOSnEfxyYjpDwapfjanHwkb
         5Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BIB5A9ngYQ21e4UWwpxGoaLXwuW8tNl9DCFK747Sb4o=;
        b=Liin9pQbLMPpIeyBrki8Z7shA4/UHdtyvURaWXhCxW3FD3BflT+9EOcbjLHtnKjj7h
         nzp32IL1pWFcwOb4N9Il+4YvwNEFXBtrhoqGlM9jycs5r6vxqKHCUQMXfBl4H5jTl8y1
         DnM7qvj2s4e985n1FSS9CNhY142nmM5JA7Q152KQ0psLO5Wyi31x1GsgDtunoaOHh2DV
         oSl+5mVk+mlTgxAPsleOod+LmIxhSA+gM9vk6zyjUdya6lnKTveOwEZbmMErBaNvM5Tn
         fFZpjgZgQuk/JcNYHvwV/vAk1tTpRRhXADlbN087hsFh0uoVH3bNPArLrRpUyxd/uZ74
         wV6g==
X-Gm-Message-State: APjAAAWLazHqIyPtnBGAbzuwbHAAavm09gFoUf1cqYsTmMbkId3IzvQn
        qS643DWvomJJuYwWmO6rjtdlTFyUnq9jpik=
X-Google-Smtp-Source: APXvYqzPIXzYYdzVqfphJDXQq8xQWI4gZvxXm7m36ULqwEMX1J38/YQsNoWLJJCp7fu+IZQfcrZEqEkXz+SZMDQ=
X-Received: by 2002:aca:6ccc:: with SMTP id h195mr4897756oic.163.1562116234188;
 Tue, 02 Jul 2019 18:10:34 -0700 (PDT)
Date:   Tue,  2 Jul 2019 18:10:17 -0700
In-Reply-To: <20190703011020.151615-1-saravanak@google.com>
Message-Id: <20190703011020.151615-4-saravanak@google.com>
Mime-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 3/6] OPP: Add helper function for bandwidth OPP tables
From:   Saravana Kannan <saravanak@google.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>, vincent.guittot@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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
index 0e7703fe733f..0168862579f1 100644
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
+		*avg_bw = opp->avg_bw;
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
+					    unsigned long *avg_bw)
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
index b150fe97ce5a..d4d79ac0b5b2 100644
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
+					    unsigned long *avg_bw);
 
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
@@ -161,6 +164,11 @@ static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 {
 	return 0;
 }
+static inline unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp,
+					      unsigned long *avg_bw)
+{
+	return 0;
+}
 
 static inline unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
 {
@@ -197,6 +205,12 @@ static inline unsigned long dev_pm_opp_get_suspend_opp_freq(struct device *dev)
 	return 0;
 }
 
+static inline unsigned long dev_pm_opp_get_suspend_opp_bw(struct device *dev,
+							  unsigned long *avg_bw)
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
2.22.0.410.gd8fdbe21b5-goog

