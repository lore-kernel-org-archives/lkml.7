Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A58AC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C6920645
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 00:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2m8w/Ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfFVAfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:35:01 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:45235 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfFVAfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:35:00 -0400
Received: by mail-pl1-f201.google.com with SMTP id y9so4498237plp.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 17:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=55ECQLYpQeuYJFjToVK2bkLCDXOJV5cNzofiMV5ttzw=;
        b=u2m8w/LyjTKU398ywsG1EgvHiUfgIU5yp696wFXRjl9TB1xpA42rFJUABHd3vVWwlH
         m94rzxMY/7apBRBw+EzDWNWWFHiOce1gFwYhnzwPKEs+qxbIQOV2le2AlFx+zWKyfDDL
         ZfUtH3r81qkp6royf/6nBfcr14HuZI+CKqcc5GGB159p8eVk4RfFWqF8ARObvl5UoJwA
         gA0XfLCJ95GBLcqdWouZzNPsy0187RixzBRsfF+necBVm72zAkyT4VeQgg2QYpP1/bAb
         jfO0t/zpMrCOno6C6xQ6BK4O9L2/UNgR+6dzm31Z2N50Z3gJWER+tT59uTfkMOTbojNi
         JT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=55ECQLYpQeuYJFjToVK2bkLCDXOJV5cNzofiMV5ttzw=;
        b=RXJ2kJI6CUzWB7mWUcATMjObcdlvwDyXlD/WjZPsZcD6+qs9fxwkyX/pVuQp3PZ/jo
         TqmRc8TofnqopDGhgyMVF4TzswWc65YTwzfksnsSxRgpvaBxS48rzbLfY8SLghy+CKk8
         xxg5M8XwYE+zTH7IKfci7IIYT8rmR7nIp0mnf5Jkq5fmTin85602DNYXhx6hxBTyXaWj
         fCBY1BwWfT+O7n9uE7XsX6xQub6I3BPE1Vh45AoGz1WhI4H+ruNLlcL8HYtvUsTq15/S
         hM9rjUM1+ZATvs+P9M09W48vMz6Ir+wdIYmwlshyxGMa18Y/E7hMh8MLJ2/CmjeRQvbC
         CYBQ==
X-Gm-Message-State: APjAAAUvutLRBOc8vZmXIfBG2ACJ2vXLP7lcXc4lxfJ4QEI94B5WeSdt
        TvdxBWxVyFGrRxWQKIoPv+A3za3gNroSSsU=
X-Google-Smtp-Source: APXvYqwWgCs0ldl/mpHZIh41BsP9PFiTHrfRcMpUcfAnsV6RUvw3NVGk2Tr4lo80Ii1068Ec6BwkBVsREfj80uw=
X-Received: by 2002:a65:64d5:: with SMTP id t21mr21593132pgv.310.1561163699545;
 Fri, 21 Jun 2019 17:34:59 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:34:47 -0700
In-Reply-To: <20190622003449.33707-1-saravanak@google.com>
Message-Id: <20190622003449.33707-3-saravanak@google.com>
Mime-Version: 1.0
References: <20190622003449.33707-1-saravanak@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v1 2/3] OPP: Add function to look up required OPP's for a
 given OPP
From:   Saravana Kannan <saravanak@google.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
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
 drivers/opp/core.c     | 54 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 11 +++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 74c7bdc6f463..4f7870bffbf8 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1830,6 +1830,60 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
 		dev_err(virt_dev, "Failed to find required device entry\n");
 }
 
+/**
+ * dev_pm_opp_xlate_opp() - Find required OPP for src_table OPP.
+ * @src_table: OPP table which has dst_table as one of its required OPP table.
+ * @dst_table: Required OPP table of the src_table.
+ * @pstate: OPP of the src_table.
+ *
+ * This function returns the OPP (present in @dst_table) pointed out by the
+ * "required-opps" property of the OPP (present in @src_table).
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ *
+ * Return: destination table OPP on success, otherwise NULL on errors.
+ */
+struct dev_pm_opp *dev_pm_opp_xlate_opp(struct opp_table *src_table,
+					struct opp_table *dst_table,
+					struct dev_pm_opp *src_opp)
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
index b150fe97ce5a..bc5c68bdfc8d 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -134,6 +134,9 @@ void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index);
 void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev);
 int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
+struct dev_pm_opp *dev_pm_opp_xlate_opp(struct opp_table *src_table,
+					struct opp_table *dst_table,
+					struct dev_pm_opp *src_opp);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
@@ -307,6 +310,14 @@ static inline int dev_pm_opp_xlate_performance_state(struct opp_table *src_table
 	return -ENOTSUPP;
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_xlate_opp(
+						struct opp_table *src_table,
+						struct opp_table *dst_table,
+						struct dev_pm_opp *src_opp)
+{
+	return NULL;
+}
+
 static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
 	return -ENOTSUPP;
-- 
2.22.0.410.gd8fdbe21b5-goog

