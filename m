Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD49C48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B08B21530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cdA8J+bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfFUNXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:23:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51136 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfFUNXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:23:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so6340749wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 06:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=abmrRJIbn15CKe4jAYwpNznA72/AKAAATV1fQchJZq8=;
        b=cdA8J+bs/MRPvemLKcO6rzSy1aIFncfOfsoPbv9tLkihvL9mR4vUHXGqZNRGWY8WeV
         1n9+lWedZTxuMsje160UJwcaqNftcjDQp4mxgB7FHoYZI4CSc75WEBKTHuQic248qlmi
         pazm4zf7Y1Pgjm+nUkUA77Wu2YaqCgurF5nI35cHs15xD75THN46ZKDrj/7QSBboJzk+
         PLvf9reZ/A4i9sggeYiNObhNmqpgzzWYJIbaPZtAjwEiIqVz/KeRzHpp93W4+GOZwRpV
         SA3x+XMTA0QvUIedkoGk4pc4pvnMUVXuzwvE9uMOKHkU/KGf94zZkX0uI9wdWxlDbz9L
         ky8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=abmrRJIbn15CKe4jAYwpNznA72/AKAAATV1fQchJZq8=;
        b=LyMmPokXq6GzmaZPv6Bma6K8FAWDxP4DOsEZUP5y/KuJFPkKFxb5b3FoQZ4q7ebmte
         OsynEV2P1gKaR5HM8WeJnsQlOo9rk9Uf3FLfSG2TYdh4kn7ymL9C3JcpSpLL+Beh0yoK
         GvZcb/WYZ6Fc6ePUxV+4uJjAO+or2saktuc+MTnh2CEvoYE7+oaXrVidkecAheAIseRE
         6bjY/GwIvV6AfwebIVi+hiTvODfE38znpkpnwwXCv+vKTpvyQYC9924G1JM2Kv3cf6c8
         LncL7fEMi5fV5y78lS9D7KR5clyesFagrNDF3JfdZQGxEtPoPDjoO2avLBpjw2QyoQiR
         u7gw==
X-Gm-Message-State: APjAAAWlAoulC7PHzDV/ET6R8QxGH8jy7QxVJh37NnIeNkplkYQcbKK9
        CLA6zODgiDVLyFEgFLWUYGY3sIQna8k=
X-Google-Smtp-Source: APXvYqx15WC+pGOYPsxUjY6M0s5AxON7z4GMohrz0VtpXz087dwRWRTMtDN6uRHy9tTaPz2oKaVQAA==
X-Received: by 2002:a1c:8a:: with SMTP id 132mr4159361wma.44.1561123410813;
        Fri, 21 Jun 2019 06:23:30 -0700 (PDT)
Received: from clegane.local (206.105.129.77.rev.sfr.net. [77.129.105.206])
        by smtp.gmail.com with ESMTPSA id s188sm1981234wmf.40.2019.06.21.06.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 06:23:30 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     viresh.kumar@linaro.org
Cc:     edubezval@gmail.com, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCH 4/6] cpufreq:  Remove cooling device usage
Date:   Fri, 21 Jun 2019 15:23:00 +0200
Message-Id: <20190621132302.30414-4-daniel.lezcano@linaro.org>
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
 drivers/cpufreq/cpufreq.c | 6 ++----
 include/linux/cpufreq.h   | 3 ---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index dfbc9bea606c..1d8f85faeaca 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1379,7 +1379,7 @@ static int cpufreq_online(unsigned int cpu)
 		cpufreq_driver->ready(policy);
 
 	if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
-		policy->cdev = of_cpufreq_cooling_register(policy);
+		of_cpufreq_cooling_register(policy);
 
 	pr_debug("initialization complete\n");
 
@@ -1468,10 +1468,8 @@ static int cpufreq_offline(unsigned int cpu)
 		goto unlock;
 	}
 
-	if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV) {
+	if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
 		cpufreq_cooling_unregister(policy);
-		policy->cdev = NULL;
-	}
 
 	if (cpufreq_driver->stop_cpu)
 		cpufreq_driver->stop_cpu(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d01a74fbc4db..9a42711f338b 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -144,9 +144,6 @@ struct cpufreq_policy {
 
 	/* For cpufreq driver's internal use */
 	void			*driver_data;
-
-	/* Pointer to the cooling device if used for thermal mitigation */
-	struct thermal_cooling_device *cdev;
 };
 
 struct cpufreq_freqs {
-- 
2.17.1

