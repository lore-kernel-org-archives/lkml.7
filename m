Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CB6C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 01:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8385D229F5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 01:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tmIxXRh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfGXBmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 21:42:35 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:38962 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfGXBmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 21:42:33 -0400
Received: by mail-pl1-f202.google.com with SMTP id r7so23120331plo.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 18:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AlLsqq3JZoQR71QbtZw0BssW/4/b+9WusH3P4c2zA1g=;
        b=tmIxXRh1CzRVBErDXUtwQUib7z0gyuxbrGT4Dumdpo/LNx5ctaIziALV0oC5vyzdtF
         ZUYLE5BllTzxVwqOtyxmp+aCGIuKR9GKgEcLfh3ezGCjqa0xrWQhkYvklb52TNMP3ymN
         b/QcJ2/GaLDuhNFs05zgY8kY79sLDbc03HH1VBFrUUdioOpiYx5Ag3hK9kY2tw4pm8Gs
         Ez/G9GLiHLQpuuq/Fx+CG2OEGbld5166zf6hvstPbj1zy4/2Ggtsvg5hXMCmmvl85nd6
         SWk51mt+f4FMxt7HoYCOLW/F9MPvzK1XhJ+9xjKjria5kw2+4iy0O9KmAAYi4z6vZCA4
         UYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AlLsqq3JZoQR71QbtZw0BssW/4/b+9WusH3P4c2zA1g=;
        b=tY690HsOY6Txj5F0ulDqPZEYU17+6HQOIeWB5v/U/EK0pCoZeN/MYGbQL66gedncrH
         dnzqsXnVm0ey+tN8JsKz07lfLbmdXbgtLXYRgg6TcC1q5h32rJCf3Xlt68kyOgWTkcXE
         UsCjuwRSjAeWKfm+rVyHV0H7MPI5/fXuDweSHUcTRhB+ym/wq5qdRPZqhiRvCqY79G7P
         4G66O7mrBtXpIhQ4YQu1uTAk73PjPDFoKYWGEGWKiVuixXKCapYSyJUVRjZRqkoZ+err
         nDhV7yh2WFPA4EBsX2J8qXZZEBLrLVVAoYebjShys5VJJNn6ff79Fe0/oMfR0V6p+PWx
         Xy3A==
X-Gm-Message-State: APjAAAXmcmTo2cNWJQ7ZYEAU7hPEMIGvpHxhfByUJHG1UNI3nnWiB45w
        /OWYBiuFO5s5xnT/Q/GYNRSlaeWAx60aw5c=
X-Google-Smtp-Source: APXvYqzkaFKYh5Ik7ceQ1KGE0Fun2/u+dwQaWFzR63gtTpqlU+7qAEOGUQV3Nw0gt36cj5Mvk0/G9fNaDXazOnM=
X-Received: by 2002:a65:49cc:: with SMTP id t12mr73912466pgs.83.1563932552371;
 Tue, 23 Jul 2019 18:42:32 -0700 (PDT)
Date:   Tue, 23 Jul 2019 18:42:18 -0700
In-Reply-To: <20190724014222.110767-1-saravanak@google.com>
Message-Id: <20190724014222.110767-3-saravanak@google.com>
Mime-Version: 1.0
References: <20190724014222.110767-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v4 2/5] OPP: Add function to look up required OPP's for a
 given OPP
From:   Saravana Kannan <saravanak@google.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function that allows looking up required OPPs given a source OPP
table, destination OPP table and the source OPP.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/opp/core.c     | 53 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 11 +++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 438fcd134d93..5460b7da110e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1883,6 +1883,59 @@ void dev_pm_opp_detach_genpd(struct opp_table *opp_table)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_detach_genpd);
 
+/**
+ * dev_pm_opp_xlate_required_opp() - Find required OPP for @src_table OPP.
+ * @src_table: OPP table which has @dst_table as one of its required OPP table.
+ * @dst_table: Required OPP table of the @src_table.
+ *
+ * This function returns the OPP (present in @dst_table) pointed out by the
+ * "required-opps" property of the OPP (present in @src_table).
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ *
+ * Return: destination table OPP on success, otherwise NULL on errors.
+ */
+struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
+						 struct opp_table *dst_table,
+						 struct dev_pm_opp *src_opp)
+{
+	struct dev_pm_opp *opp, *dest_opp = NULL;
+	int i;
+
+	if (!src_table || !dst_table || !src_opp)
+		return NULL;
+
+	for (i = 0; i < src_table->required_opp_count; i++) {
+		if (src_table->required_opp_tables[i]->np == dst_table->np)
+			break;
+	}
+
+	if (unlikely(i == src_table->required_opp_count)) {
+		pr_err("%s: Couldn't find matching OPP table (%p: %p)\n",
+		       __func__, src_table, dst_table);
+		return NULL;
+	}
+
+	mutex_lock(&src_table->lock);
+
+	list_for_each_entry(opp, &src_table->opp_list, node) {
+		if (opp == src_opp) {
+			dest_opp = opp->required_opps[i];
+			dev_pm_opp_get(dest_opp);
+			goto unlock;
+		}
+	}
+
+	pr_err("%s: Couldn't find matching OPP (%p: %p)\n", __func__, src_table,
+	       dst_table);
+
+unlock:
+	mutex_unlock(&src_table->lock);
+
+	return dest_opp;
+}
+
 /**
  * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
  * @src_table: OPP table which has dst_table as one of its required OPP table.
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index af5021f27cb7..21d331de98b9 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -130,6 +130,9 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*s
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char **names);
 void dev_pm_opp_detach_genpd(struct opp_table *opp_table);
+struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
+						 struct opp_table *dst_table,
+						 struct dev_pm_opp *src_opp);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
@@ -299,6 +302,14 @@ static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, cons
 
 static inline void dev_pm_opp_detach_genpd(struct opp_table *opp_table) {}
 
+static inline struct dev_pm_opp *dev_pm_opp_xlate_required_opp(
+						struct opp_table *src_table,
+						struct opp_table *dst_table,
+						struct dev_pm_opp *src_opp)
+{
+	return NULL;
+}
+
 static inline int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate)
 {
 	return -ENOTSUPP;
-- 
2.22.0.709.g102302147b-goog

