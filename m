Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC0CCA9EC0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6466320874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jcy8Fggj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfJ3JLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:11:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44305 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfJ3JL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:11:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so1354321wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 02:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0cMzmwOQ45CvCpy5BV9I0axI+oTcT02C42maobILAtA=;
        b=Jcy8FggjKwJb4bd9H4Q6f/qntfaIsKoRcwzdf8bVSIBZsq/wZACAWyQxjs8qrpoM48
         0ojV8Qx7fKxGvn1Ln8S3TyUUB2yHjlEIbRFbrWIPy6gqUg+cq1BwbLCUPD3//EwoprbA
         AgGv2ykIUrdJ0p3sJsRBFDWKLmEm2e1yZMwHwVPUUzdzXR2f/e46jXEky77tjWm7SmOm
         +pCMyc8RIFnudmO8HCTTXlsoQpgvD5OSf6MlAZxumT0m8PyR0xwCe5aXgbKqRzprLcKq
         ZsblpQ+IM82gyL4ansMguDQ6BFePNWjNBI5BYGWQwFY56600Vfb/MQRl+GTWWYPd7eK+
         YETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0cMzmwOQ45CvCpy5BV9I0axI+oTcT02C42maobILAtA=;
        b=Xs6VRZXpquPx+af8d2wYOJMm6j6SWrUHUbAPW/1wLTCeiQYh9uIKxDYedaYMsMKcnZ
         gtIbciLkm5fMQnOuoeM5NpgRD7xlII0drGJ1wZ507XVxJYTeNbRtc47QdYPH/2Tq4h6y
         avpSNlxBxZ1IV5DDh/JE8qHVj2OjOJ2jMYD5pZm93uDunxOSLNRH5QNlT9e8pLx//djs
         FQxXduMAmEHzXKcB5xMn8Sy7+w379R2tP0hu+d8v/LUrRo324L6H01WdOLG6arm29kMj
         FLC/Go7ip6qjFmnz/TBv/9eXcyQX0L102dxvhaR7NGCHbJ739Aq+KBVC/DMlOafLPZrz
         c37Q==
X-Gm-Message-State: APjAAAU9A+pc+KEmW4ZlF2Mn3QtPmVLwxT0WF9NkK2Hd2DxmwC8uIXQe
        u132He7bn7sElovSeY6gLb4bRA==
X-Google-Smtp-Source: APXvYqz2E4NMQlmOnxogLoFoSCKmtXixmPvQMaVqKsn2Qt80aUGkIwMVP0MmgrZZNDpIGpFr/1oowA==
X-Received: by 2002:a5d:66c6:: with SMTP id k6mr23308468wrw.152.1572426688132;
        Wed, 30 Oct 2019 02:11:28 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:2c7f:2fc:5551:ee55])
        by smtp.gmail.com with ESMTPSA id t24sm2608394wra.55.2019.10.30.02.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 02:11:27 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org (open list:THERMAL/CPU_COOLING),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] thermal: cpu_cooling: Reorder the header file
Date:   Wed, 30 Oct 2019 10:10:37 +0100
Message-Id: <20191030091038.678-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030091038.678-1-daniel.lezcano@linaro.org>
References: <20191030091038.678-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the conditions are simplified and unified, it is useless to have
different blocks of definitions under the same compiler condition,
let's merge the blocks.

There is no functional change.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/cpu_cooling.h | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index 72d1c9c5e538..b74732535e4b 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -33,6 +33,13 @@ cpufreq_cooling_register(struct cpufreq_policy *policy);
  */
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
 
+/**
+ * of_cpufreq_cooling_register - create cpufreq cooling device based on DT.
+ * @policy: cpufreq policy.
+ */
+struct thermal_cooling_device *
+of_cpufreq_cooling_register(struct cpufreq_policy *policy);
+
 #else /* !CONFIG_CPU_THERMAL */
 static inline struct thermal_cooling_device *
 cpufreq_cooling_register(struct cpufreq_policy *policy)
@@ -45,16 +52,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
 	return;
 }
-#endif	/* CONFIG_CPU_THERMAL */
 
-#ifdef CONFIG_CPU_THERMAL
-/**
- * of_cpufreq_cooling_register - create cpufreq cooling device based on DT.
- * @policy: cpufreq policy.
- */
-struct thermal_cooling_device *
-of_cpufreq_cooling_register(struct cpufreq_policy *policy);
-#else
 static inline struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
-- 
2.17.1

