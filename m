Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4264C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB78A21537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c36ZpSew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfFUNXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:23:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33436 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfFUNXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:23:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so9151128wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 06:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hWOyvG8gK3Yd2gZuZPX+zS+OzCMre8gWSxnhV9rJDR4=;
        b=c36ZpSewLyxdsNlrsvfl54dP1d3jg1M3kR6dJKnAlk5Kh6PlPsU1RM1YhgbelAsiB8
         KpDVG6V6mFy2Emmx9iXwPq8EIC6KiyewIFRtn7C86MwlueFkplHP1GF74Vi4K12kxjIB
         x2I3j7ScntkAxx19yk6Z339XPBZ1fQkRdWTGiUJ3xsUlU79u9TGcvn2+CrijnwNf2JiF
         u9o421T2miZQiLckihrPw66oLEHr1elWqUNNCGt020T49WC32Jsb5xkOQTHBdFQpYeTU
         G3D+d7LeI1PWxZ2zpYpm8PnS4+UsS0KRK3B6tZGx66Xw5HHqzyGTQbJbQjUz6uvy0yvh
         rIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hWOyvG8gK3Yd2gZuZPX+zS+OzCMre8gWSxnhV9rJDR4=;
        b=oRey3E/BWSsGVLzQlF1ekphyyMh6fNc5BREX5cv835gkv1zioimzowE1iismmkwk2r
         6DZN2CMg38tDkIbifnrdT7HFc0MThx9qXp4uev5szQ/AHI8irJh6p9RoCZYIQ+ws/AQk
         U5mVObyPrIyNMncNRMiCuaA+ZaEqBYVOiSnaKseoJobBsBzOtDh1OKhrfxdJFcDvb/P4
         DstI8UixIRoxGMBC8mV2+xmqdFpUtSMuOIZ16rmKjb2edCBCh0iE/QL00e1WlyTYABup
         ye+vwT4EknJPpXJWLDxVQoQPJnc5SUFFbqx/oifWEP+RViW1RE/6v4cX1x3nxxWiNRZg
         9tQw==
X-Gm-Message-State: APjAAAXgqRu6vjyRMMS94IvkNcg0scSGh7TY4Y8U3lNcFYrDxPubOgV4
        unP4hGRwCID8RvCQlh9uWy6t6w==
X-Google-Smtp-Source: APXvYqy3Q4/KfwLZiWac+IHlKAnk7Sl69mV+esSGzR2nnxIARsD/wBgEhPqG7TrBrUdnQkcJUBT6jw==
X-Received: by 2002:a1c:730d:: with SMTP id d13mr4066497wmb.88.1561123414277;
        Fri, 21 Jun 2019 06:23:34 -0700 (PDT)
Received: from clegane.local (206.105.129.77.rev.sfr.net. [77.129.105.206])
        by smtp.gmail.com with ESMTPSA id s188sm1981234wmf.40.2019.06.21.06.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 06:23:33 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER),
        linux-omap@vger.kernel.org (open list:TI BANDGAP AND THERMAL DRIVER)
Subject: [PATCH 6/6] thermal/drivers/ti: Remove cooling device usage
Date:   Fri, 21 Jun 2019 15:23:02 +0200
Message-Id: <20190621132302.30414-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621132302.30414-1-daniel.lezcano@linaro.org>
References: <20190621132302.30414-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpufreq_cooling_unregister() function uses now the policy to
unregister itself. The only purpose of the cooling device pointer is
to unregister the cpu cooling device.

As there is no more need of this pointer, remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 217b1aae8b4f..170b70b6ec61 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -41,7 +41,6 @@ struct ti_thermal_data {
 	struct cpufreq_policy *policy;
 	struct thermal_zone_device *ti_thermal;
 	struct thermal_zone_device *pcb_tz;
-	struct thermal_cooling_device *cool_dev;
 	struct ti_bandgap *bgp;
 	enum thermal_device_mode mode;
 	struct work_struct thermal_wq;
@@ -233,6 +232,7 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id)
 {
 	struct ti_thermal_data *data;
 	struct device_node *np = bgp->dev->of_node;
+	struct thermal_cooling_device *cdev;
 
 	/*
 	 * We are assuming here that if one deploys the zone
@@ -256,9 +256,9 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id)
 	}
 
 	/* Register cooling device */
-	data->cool_dev = cpufreq_cooling_register(data->policy);
-	if (IS_ERR(data->cool_dev)) {
-		int ret = PTR_ERR(data->cool_dev);
+	cdev = cpufreq_cooling_register(data->policy);
+	if (IS_ERR(cdev)) {
+		int ret = PTR_ERR(cdev);
 		dev_err(bgp->dev, "Failed to register cpu cooling device %d\n",
 			ret);
 		cpufreq_cpu_put(data->policy);
-- 
2.17.1

