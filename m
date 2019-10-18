Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1BACA9EA8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58C0222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mbBsczHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633010AbfJRIwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:52:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34868 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2632989AbfJRIwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:52:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so3458334pfw.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Pg58XqMrgMUueF1t0WSUT94hNH4L7QyXjN2jFD44ecQ=;
        b=mbBsczHQ7geTZHLUH4glHa/GX3d3C6ZLa1u5dvWDZVaHWaS2JW7g3tU6SDyLxy6o1u
         Ds+uGnMxFI1XvqwwerVewsBsOJm0LG3yhE5/CfT0nTve6T4lYLg/BgbpeWs9FCp3bkP/
         2Ibs1iUqmJT+tkwK3dSKnVoWyVL0cPq9GW2PyGPwzyZQKgs07xKmYmo06UC3UTN9b1TI
         6DN0X7GFdOLHiURDDIY1mq6bMBwOnZi5VaudeF59RJejJJtl3JcMLLSqmVEKZh12MXZO
         O9krPHLIXRIT3dWmX/RwRshSQBwsyDEVqof8bpki2b5GXrFYAUiuAvb6PPcfNflVbqGI
         UBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Pg58XqMrgMUueF1t0WSUT94hNH4L7QyXjN2jFD44ecQ=;
        b=G3HelI2ycZgCLicZl+hgGt3EV2j/ljXi7776ygouF3pLKlbnB7GjaKL0RvTsNhjlQD
         pV1TuVICMsBy4vVZe3tbFcYbE48cRykKMoT7bxE095Zb/2/K36VOv6U29MxGsl78jowM
         gPbvG5AlPg7vNBRx4Kj0X5rOsBK2zFddqfsT4b/1IIGmmzq302VpDDdBQVZX+Om9LyoE
         DMzWL3tKx+8MmRiaQ9M5GUzDOnrUBQuS2vi1htKCEpUL/DLE7tvAQdWAU+wzPN6vSMrg
         eXTvpTTwzBvb3Q2IloGPSjBbOC9BZclskiNo0B97qBR9HhTdTerlANBF9t525DlCCy6I
         bvmA==
X-Gm-Message-State: APjAAAW+3EsdEBsxwJDb0OppluLoK6Ddc4R/nx8fQetKmPgjMrkQqxl9
        7dcKYv65r0L8/ZP/N8qPuP8VhbMVKeCvmw==
X-Google-Smtp-Source: APXvYqx8Mpcrks1BZxeEuPxaAnWhLPj55ZV7f4Bw1XHAjGHH8rk1ne6dxHoD9m6lONZAOPVwKvp1Fg==
X-Received: by 2002:a62:4ed6:: with SMTP id c205mr5321495pfb.208.1571388755817;
        Fri, 18 Oct 2019 01:52:35 -0700 (PDT)
Received: from localhost ([49.248.178.134])
        by smtp.gmail.com with ESMTPSA id s1sm4662870pgi.52.2019.10.18.01.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Oct 2019 01:52:35 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v4 6/6] cpufreq: qcom-hw: Move driver initialisation earlier
Date:   Fri, 18 Oct 2019 14:22:03 +0530
Message-Id: <3d367762ba72fa1cbd6391dc55d94b3284f6c00c.1571387352.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571387352.git.amit.kucheria@linaro.org>
References: <cover.1571387352.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571387352.git.amit.kucheria@linaro.org>
References: <cover.1571387352.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow qcom-hw driver to initialise right after the cpufreq and thermal
subsystems are initialised in core_initcall so we get earlier access to
thermal mitigation.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index a9ae2f84a4efc..fc92a8842e252 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -334,7 +334,7 @@ static int __init qcom_cpufreq_hw_init(void)
 {
 	return platform_driver_register(&qcom_cpufreq_hw_driver);
 }
-device_initcall(qcom_cpufreq_hw_init);
+postcore_initcall(qcom_cpufreq_hw_init);
 
 static void __exit qcom_cpufreq_hw_exit(void)
 {
-- 
2.17.1

