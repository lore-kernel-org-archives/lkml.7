Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43C3CA9EC0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B422083E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPwCZVCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfJ3JL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:11:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34333 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfJ3JL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:11:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id v3so3808138wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 02:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bOJ34PW9YadKMWVy7Lq7RFshOmanpmOaFJ0/LQDvOqk=;
        b=cPwCZVCovU/2CggOdtlONW+HZ6vJ7trmhL6nPvJqYuw/oD1PyHK17o3Tz6pwRytnQ8
         CrPypUXTHXlG8BoCEPtuwAzA9U1uWgHRJQwmCInvns67XnF+kWFy0hMm3NOG5UyoT/cq
         0ycPALIj/Vgu//Ye9inmkdYDNjuKDw+Hrd34RhvLlFEbc/kSbr/R3mRY1RMC4gZiT9rN
         EhnO++bBeYFzwPbTyiwXLJy9yvyiFFpxsBU07mk+fw/ft6vj7n0T73TZxecfbyBi6YRG
         vHcwmIrVz1R9pDf4v4cEcKi7LrjFnFzQ2c9pm5tvv48nHEtON21c7C45Avw6axIGDOI3
         6ZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bOJ34PW9YadKMWVy7Lq7RFshOmanpmOaFJ0/LQDvOqk=;
        b=aZUtjsJfo3TsCgNYRT2h7XSTgEIx945/RvAuErKE5SUqlHVKCcEkeUJLmLfJxaGdKy
         EFGhlsvDDQW5Q+z2FUXikLoubQ95Uipud3hh9dmzCRyauJfUJ6mj2JdGojZZU+IrqHen
         q2QFvgIJz3jdbMiO9UpYTZDD1GhV6Lz5Y9k5szjj9g+jO2WFPDIF1ft+Gs0SoPJGkd2v
         miMSrbq0pscZUxRPDyeegJz3nmabW9GNh/RwiuX0ftDWCyq4jagnCthkiBe8L74VciYZ
         cRvmPusmmpMCkn0d1Zj1fMT2mOGGjlz92stImmfzWodUjM00M7siG+MWW2WvdhWL+FlT
         HhYg==
X-Gm-Message-State: APjAAAUlm26o04gNIRV0qeVfaYkQVwpIWgP78nz4gl1haPdoquVMKqhf
        0GHxoszT74kugoTLxE0CLUBTYB4qEk0=
X-Google-Smtp-Source: APXvYqy0w7naVwNgnhQ/SgNL4RSoXuzbGVisLCeRIfRNlMZSRXD/MvlZHZRncQDBE1MAoEA51vnfOg==
X-Received: by 2002:a7b:c94f:: with SMTP id i15mr8250697wml.8.1572426686603;
        Wed, 30 Oct 2019 02:11:26 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:2c7f:2fc:5551:ee55])
        by smtp.gmail.com with ESMTPSA id t24sm2608394wra.55.2019.10.30.02.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 02:11:26 -0700 (PDT)
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
Subject: [PATCH 1/2] thermal: cpu_cooling: Remove pointless dependency on CONFIG_OF
Date:   Wed, 30 Oct 2019 10:10:36 +0100
Message-Id: <20191030091038.678-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The option CONFIG_CPU_THERMAL depends on CONFIG_OF in the Kconfig.

It it pointless to check if CONFIG_OF is set in the header file as
this is always true if CONFIG_CPU_THERMAL is true. Remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/cpu_cooling.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index bae54bb7c048..72d1c9c5e538 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -47,7 +47,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 }
 #endif	/* CONFIG_CPU_THERMAL */
 
-#if defined(CONFIG_THERMAL_OF) && defined(CONFIG_CPU_THERMAL)
+#ifdef CONFIG_CPU_THERMAL
 /**
  * of_cpufreq_cooling_register - create cpufreq cooling device based on DT.
  * @policy: cpufreq policy.
@@ -60,6 +60,6 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
 	return NULL;
 }
-#endif /* defined(CONFIG_THERMAL_OF) && defined(CONFIG_CPU_THERMAL) */
+#endif /* CONFIG_CPU_THERMAL */
 
 #endif /* __CPU_COOLING_H__ */
-- 
2.17.1

