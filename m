Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948C9CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A827205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EW5sDR0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfJUMPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:15:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39773 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbfJUMPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:15:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so6532792plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 05:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Cukx8ujHc8MZYDdytnpBWfM0F4aiiT0HrshMHuyoYiA=;
        b=EW5sDR0BhvXc5p2C2yYb6Ly5+xBcSNYaYAMkfBRcHMvST6fBuTLsWUipr6L1RkaRHR
         EyQ/H1mFn/ZhFeoaHosy+oDTjscGr13sRayWyNPEf5vnw4QJRA35GkR84gG6DyvZc416
         VTWlu1owMddSIyvuBExTYfiRkBmm8T0iC4NPVX9FXIOxND35hCBjW51j8vY+xqn4Ztmx
         Vfl39SaOokAvpylKjusmOdhXZOyMu+1qRqwkgdcNrcewQot7pzpdBskEGhj6Ri86OLDh
         lrDsx8HLSHqVT07Ud81PSb2H10wWUkVZ/day47X+8dGQjogXPa1x617kWPv/z6Pw8KCl
         DKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Cukx8ujHc8MZYDdytnpBWfM0F4aiiT0HrshMHuyoYiA=;
        b=qTWEpWWBn3CXq+pOQ5FfgvAyJtyZKErbQYF48iVi8IS9LMWDfO3jU6BpdmaWuJdnbp
         xRtEddiA6S5hRmlnf9LutR8Tpd9K2dMLo8H+kqvueSLdRizxV0MVYqKueAFXB54OAiPa
         rjf5y16IhszSa7xmG5SfxMWZAkUnaANPUejbmM+JGOV8yfsD7UsmUOeVUWkSHkUoEaHj
         /6VtdZNFSUckPQRXvjUERY32bXomSiaeqQIxQD7l0Bs8s/6zsb1u7rcx9+EtDrfXGA9W
         4iL9Jn0cqiF7QXIWm+PAls98WpFeM2+tw9jQh/Cq42yYBlFONpaKvggdn8Z9DuXQpHpC
         vpHA==
X-Gm-Message-State: APjAAAVWHjTSggvA/00AlpTEkcNUtGjf/3olwVxdPsycxux54euzk+Zs
        PmtlWZlGPID1EJ9NMr0mR6lx5nfNtTeVxw==
X-Google-Smtp-Source: APXvYqxxOzJafjce4b4GYvuqt+JhynnibQqUNBuGu1L6adXLHdWZzFTJzN1XM6qXNR42+xvxeXPBuw==
X-Received: by 2002:a17:902:fe8c:: with SMTP id x12mr14860552plm.55.1571660142988;
        Mon, 21 Oct 2019 05:15:42 -0700 (PDT)
Received: from localhost ([49.248.62.222])
        by smtp.gmail.com with ESMTPSA id e9sm12976482pgs.86.2019.10.21.05.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 05:15:42 -0700 (PDT)
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
Subject: [PATCH v5 6/6] cpufreq: qcom-hw: Move driver initialization earlier
Date:   Mon, 21 Oct 2019 17:45:15 +0530
Message-Id: <eacce8d08388b0bdfc908d2701fe7c2b78d90441.1571656015.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571656014.git.amit.kucheria@linaro.org>
References: <cover.1571656014.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571656014.git.amit.kucheria@linaro.org>
References: <cover.1571656014.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow qcom-hw driver to initialize right after the cpufreq and thermal
subsystems are initialised in core_initcall so we get earlier access to
thermal mitigation.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Taniya Das <tdas@codeaurora.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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

