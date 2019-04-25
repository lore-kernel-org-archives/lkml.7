Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFA7C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2387D214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BAmUdz0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfDYJEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:04:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35774 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbfDYJEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:04:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id z26so1758939ljj.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ljpH5vhDYU6UY/Q2jNUSgYZIZdDGjQoptAffM3+XQlk=;
        b=BAmUdz0A6ucFtMa3FlMjlvWEkgHz+I/RgilH744my9IIg2l5Ut2yeVd499EqUNrr6R
         uV/4d0GC3qYyx6hCiI49R6RLU0kg/2hLato1gnweW5VdtAIm8JM2e0zrpFNRcFPidZnd
         h3/qVFeDrsxuCRCGoaPPavPlZpDY7b7UMRlMdiXQXYk9Zrw73S1i5lRTrrtbIRHkdGwb
         ewlfzjEnDEjEXq7oGTSkAonepLVdiQ/Hizm1tR0DDbGj44fhARuiSq0PIR7rFyEgI7JK
         klfi2i29i5xjhTfk+vEM6yAgeYBd690fWdvNX9Ybvab1BGCzhknbbmqCaB1iggqbLqWV
         FjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ljpH5vhDYU6UY/Q2jNUSgYZIZdDGjQoptAffM3+XQlk=;
        b=SzHnXCOrwSmp7QSN0hlEgyXHYbwouFjgvW7HF+9mdqcCGAHP7AFX7zf2Q2XBan6+5f
         04kdUHgpedi6ZICYkSu7jW0vBgyivc4y+2K8BmHP13T9vzLxOWRqx5R1MS9lEDZ1dNGw
         wNqChzhjJYV/59LkaoOr7mdi50vfjqUio9epH27xiV1EPXvBI7z9veeCAnCCR4B8dEDY
         fBU4YIZ9M4xaAeKuQCMcfUkHP/NH94ho4899GW1uBKXFv9dNFh8a4cqjWMClB/hNNx5R
         i+10piaw1bo+0QUoaTEMptkHNKG5rWWaEgmpyoJDSe9BXd0G13Yj5PzotZsSt1gm1Agk
         g49g==
X-Gm-Message-State: APjAAAX8Lsq9ghh5rRRpnpeOQfWaxPhTL2+8u+0S888AXDcha/uGXqvb
        0T40K/wnr2i1gIPamS6g9hjeIA==
X-Google-Smtp-Source: APXvYqwUgctYNY2PsII4FPHfAlMMLwytUkPcselJGfHLwIChpuih8ndC76NbC/2TMSVHxD4zsiSlAg==
X-Received: by 2002:a2e:9a0f:: with SMTP id o15mr10280206lji.130.1556183073597;
        Thu, 25 Apr 2019 02:04:33 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id v26sm4517353lja.60.2019.04.25.02.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:04:32 -0700 (PDT)
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
Subject: [PATCH 3/4] PM / Domains: Search for the CPU device outside the genpd lock
Date:   Thu, 25 Apr 2019 11:04:12 +0200
Message-Id: <20190425090413.10700-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425090413.10700-1-ulf.hansson@linaro.org>
References: <20190425090413.10700-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While attaching/detaching a device to a PM domain (genpd) that has the
GENPD_FLAG_CPU_DOMAIN set, genpd iterates the cpu_possible_mask to check
whether the device corresponds to a CPU. This iteration is done while
holding the genpd's lock, which is unnecessary. Let's avoid the locking,
by restructuring the corresponding code a bit.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 52 +++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 93298b7db408..da1c99178943 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1450,8 +1450,8 @@ static void genpd_free_dev_data(struct device *dev,
 	dev_pm_put_subsys_data(dev);
 }
 
-static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
-				   int cpu, bool set, unsigned int depth)
+static void genpd_update_cpumask(struct generic_pm_domain *genpd,
+				 int cpu, bool set, unsigned int depth)
 {
 	struct gpd_link *link;
 
@@ -1462,7 +1462,7 @@ static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
 		struct generic_pm_domain *master = link->master;
 
 		genpd_lock_nested(master, depth + 1);
-		__genpd_update_cpumask(master, cpu, set, depth + 1);
+		genpd_update_cpumask(master, cpu, set, depth + 1);
 		genpd_unlock(master);
 	}
 
@@ -1472,38 +1472,37 @@ static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
 		cpumask_clear_cpu(cpu, genpd->cpus);
 }
 
-static void genpd_update_cpumask(struct generic_pm_domain *genpd,
-				 struct device *dev, bool set)
+static void genpd_set_cpumask(struct generic_pm_domain *genpd, int cpu)
+{
+	if (cpu >= 0)
+		genpd_update_cpumask(genpd, cpu, true, 0);
+}
+
+static void genpd_clear_cpumask(struct generic_pm_domain *genpd, int cpu)
+{
+	if (cpu >= 0)
+		genpd_update_cpumask(genpd, cpu, false, 0);
+}
+
+static int genpd_get_cpu(struct generic_pm_domain *genpd, struct device *dev)
 {
 	int cpu;
 
 	if (!genpd_is_cpu_domain(genpd))
-		return;
+		return -1;
 
 	for_each_possible_cpu(cpu) {
-		if (get_cpu_device(cpu) == dev) {
-			__genpd_update_cpumask(genpd, cpu, set, 0);
-			return;
-		}
+		if (get_cpu_device(cpu) == dev)
+			return cpu;
 	}
-}
 
-static void genpd_set_cpumask(struct generic_pm_domain *genpd,
-			      struct device *dev)
-{
-	genpd_update_cpumask(genpd, dev, true);
-}
-
-static void genpd_clear_cpumask(struct generic_pm_domain *genpd,
-				struct device *dev)
-{
-	genpd_update_cpumask(genpd, dev, false);
+	return -1;
 }
 
 static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
 {
 	struct generic_pm_domain_data *gpd_data;
-	int ret;
+	int ret, cpu;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -1514,13 +1513,15 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev)
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
 
+	cpu = genpd_get_cpu(genpd, dev);
+
 	ret = genpd->attach_dev ? genpd->attach_dev(genpd, dev) : 0;
 	if (ret)
 		goto out;
 
 	genpd_lock(genpd);
 
-	genpd_set_cpumask(genpd, dev);
+	genpd_set_cpumask(genpd, cpu);
 	dev_pm_domain_set(dev, &genpd->domain);
 
 	genpd->device_count++;
@@ -1560,13 +1561,14 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 {
 	struct generic_pm_domain_data *gpd_data;
 	struct pm_domain_data *pdd;
-	int ret = 0;
+	int cpu, ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
 	pdd = dev->power.subsys_data->domain_data;
 	gpd_data = to_gpd_data(pdd);
 	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
+	cpu = genpd_get_cpu(genpd, dev);
 
 	genpd_lock(genpd);
 
@@ -1578,7 +1580,7 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 	genpd->device_count--;
 	genpd->max_off_time_changed = true;
 
-	genpd_clear_cpumask(genpd, dev);
+	genpd_clear_cpumask(genpd, cpu);
 	dev_pm_domain_set(dev, NULL);
 
 	list_del_init(&pdd->list_node);
-- 
2.17.1

