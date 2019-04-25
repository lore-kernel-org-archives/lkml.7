Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3159C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943B3214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yC5dRReB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfDYJEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:04:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46613 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbfDYJEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:04:37 -0400
Received: by mail-lf1-f67.google.com with SMTP id k18so16891848lfj.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+vO/H92ltJAN7Sc2E9gRf3gzSgRQawDyXMnQqUjpfmc=;
        b=yC5dRReBJJI91/9zHctiDbBK59FaHXwQvaYJBTJebSGUCyuzX/iD6Buf3sCzCASEqs
         NmeLl71rKWz3ChLuH3k8bRaYGUa9bkODHy531ZOa+0dPu6nMNXfg6d/fMpKJT1VJf0SS
         igBn8+5X2lfYrp6Y3N2KYQklvlU/tpTdiCLvl78TcSITlhpLRvJ0WVshNKmVCovDJsBY
         r3K73wXOzmWETpoYQVNMLcSKBlpxpmQ31bh9p14BxZnG0PHtdHILwcx4IjLygixHEQU8
         XcFxD9itxPzWX8dF3ZUDS1TuceFbeyme+Mg1cA37EQog0ybfvN9XnIbN3mjxxh7t25wf
         +Mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+vO/H92ltJAN7Sc2E9gRf3gzSgRQawDyXMnQqUjpfmc=;
        b=nlzZGJMI9Z/42Me+bXpPyWAgSxxWmaN8uqmXLN7T3UASATmyNVdrg6yWR43QlpRSo6
         xJgg0a0Z2Y52ltNoFrXSaWzCB9epVD+L6x9TbjmS15BeyWDvlo15KHN6WOtLhSv0JFWM
         /kO+hVbcWBIn3xJgmdXH1v6sbuWheDIlJ6+Gy3W2vcCylewKE8+hp75B0zl3KO3ER517
         Fq7czv9CcS4xmfRVKDTDSLGnfrPj7b7o9MIdX+j2cXos0vbhloSarALzM2dkqbee0B9X
         0wd93DA7MeAzwOYQWv9nqFVcbfGbDQM577lbpsob7chOh8IMuV/aYH22RCEww6ASSAWf
         eWIQ==
X-Gm-Message-State: APjAAAUBKutjTbYHPwWnI2SWzwAcjzVn7cSkl8PALgAXOzQVoaF6bVy1
        nThjmlPvKbh04hDTCPy7fhNFDQ==
X-Google-Smtp-Source: APXvYqzk3cC5yBbK4/5Bi8xvesd2ymcePZ07SfwUeHdRpIavXWYij45EEO0csvL4Ao/ccnoOMwwZSA==
X-Received: by 2002:ac2:5088:: with SMTP id f8mr21568780lfm.107.1556183075155;
        Thu, 25 Apr 2019 02:04:35 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id v26sm4517353lja.60.2019.04.25.02.04.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:04:34 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] PM / Domains: Allow to attach a CPU via genpd_dev_pm_attach_by_id|name()
Date:   Thu, 25 Apr 2019 11:04:13 +0200
Message-Id: <20190425090413.10700-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425090413.10700-1-ulf.hansson@linaro.org>
References: <20190425090413.10700-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attaching a device via genpd_dev_pm_attach_by_id|name() makes genpd to
allocate a virtual device that it attaches instead. This leads to a problem
in case the base device belongs to a CPU. More precisely, it means
genpd_get_cpu() compares against the virtual device, thus it fails to find
a matching CPU device.

Address this limitation, by passing the base device to genpd_get_cpu()
rather than the virtual device. Moreover, to deal with detach correctly
from genpd_remove_device(), let's store the CPU number in the struct
generic_pm_domain_data, as to be able to clear the corresponding bit in the
cpumask for the genpd.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 20 ++++++++++----------
 include/linux/pm_domain.h   |  1 +
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index da1c99178943..3d899e8abd58 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1499,10 +1499,11 @@ static int genpd_get_cpu(struct generic_pm_domain *genpd, struct device *dev)
 	return -1;
 }
 
-static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
+static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
+			    struct device *base_dev)
 {
 	struct generic_pm_domain_data *gpd_data;
-	int ret, cpu;
+	int ret;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -1513,7 +1514,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
 
-	cpu = genpd_get_cpu(genpd, dev);
+	gpd_data->cpu = genpd_get_cpu(genpd, base_dev);
 
 	ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
 	if (ret)
@@ -1521,7 +1522,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
 
 	genpd_lock(genpd);
 
-	genpd_set_cpumask(genpd, cpu);
+	genpd_set_cpumask(genpd, gpd_data->cpu);
 	dev_pm_domain_set(dev, &genpd->domain);
 
 	genpd->device_count++;
@@ -1549,7 +1550,7 @@ int pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
 	int ret;
 
 	mutex_lock(&gpd_list_lock);
-	ret = genpd_add_device(genpd, dev);
+	ret = genpd_add_device(genpd, dev, dev);
 	mutex_unlock(&gpd_list_lock);
 
 	return ret;
@@ -1561,14 +1562,13 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 {
 	struct generic_pm_domain_data *gpd_data;
 	struct pm_domain_data *pdd;
-	int cpu, ret = 0;
+	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
 	pdd = dev->power.subsys_data->domain_data;
 	gpd_data = to_gpd_data(pdd);
 	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
-	cpu = genpd_get_cpu(genpd, dev);
 
 	genpd_lock(genpd);
 
@@ -1580,7 +1580,7 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 	genpd->device_count--;
 	genpd->max_off_time_changed = true;
 
-	genpd_clear_cpumask(genpd, cpu);
+	genpd_clear_cpumask(genpd, gpd_data->cpu);
 	dev_pm_domain_set(dev, NULL);
 
 	list_del_init(&pdd->list_node);
@@ -2256,7 +2256,7 @@ int of_genpd_add_device(struct of_phandle_args *genpdspec, struct device *dev)
 		goto out;
 	}
 
-	ret = genpd_add_device(genpd, dev);
+	ret = genpd_add_device(genpd, dev, dev);
 
 out:
 	mutex_unlock(&gpd_list_lock);
@@ -2426,7 +2426,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
 
-	ret = genpd_add_device(pd, dev);
+	ret = genpd_add_device(pd, dev, base_dev);
 	mutex_unlock(&gpd_list_lock);
 
 	if (ret < 0) {
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index bc82e74560ee..0e8e356bed6a 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -175,6 +175,7 @@ struct generic_pm_domain_data {
 	struct pm_domain_data base;
 	struct gpd_timing_data td;
 	struct notifier_block nb;
+	int cpu;
 	unsigned int performance_state;
 	void *data;
 };
-- 
2.17.1

