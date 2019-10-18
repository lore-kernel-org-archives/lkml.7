Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBDBCA9EA6
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9688821897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="npNq6UNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632986AbfJRIwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:52:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38733 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2632964AbfJRIw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:52:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3so2992999pgt.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tSzJEpJmDmeHOSEU0I3AfQXPKpO46HQzH7+Mdke63aU=;
        b=npNq6UNtXYpoaXJ3I7t2IdXdGe06e+rEdJhFxtv6H/2c3gYxsM311WsUfYe2YPeLXv
         768UOT5TJugLFh5EWKwXxgf4gtmYK6e7eIRLahWH2yT1KURVAnfccBCO2XbYoIymgvLe
         oZst0d+algxp9nI8DMjO10QY+hsuBXYeJ6RYVcE51TeViEB0PkvV9xzBvleJJJZps71V
         lsDlm3yKkeYTjOg9cL7X6UdsU62Tc0D0PP1k+7cqUcXlI4ONOObK0fbVD9B6cNngIhZ0
         kSh+IrH7TnmolNGlzhyO0VOTLYEfDqPxcS8iRqahIyPJVRFKb6+MQ/gJ++/MrcAHG6sG
         aDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tSzJEpJmDmeHOSEU0I3AfQXPKpO46HQzH7+Mdke63aU=;
        b=UP5GsvEEMp3AeVWdPaaqiccs4XItQ9IOJ3GmhkvcuNahtIjdfM/47z67sJGprdf0ZC
         GN9z6IQrHNHQKwTl6SdzrMBxmq/twa4ZOydJlYieqR4tLHfpxfFpVvsz3Dj1JPDz2beG
         mQokvCxaBV/yyQlzU/A2KPs3xHzr6RZM5Hn8s6tNAfkC1UCHfQd7CTgBYD+Qy310SwKM
         vTylc7iWLPPqvISC2X4s2qEYk+CGen8zFN8nHmSfDxztji3tlIFutS9APcM6QvUCynp3
         4Tvcr+/ewoL+rKJFccrYpSCr7f6lf31Bzuc0rG5/+ipcA1L0OVvWWdyJhsMEyMxh3XaX
         VQzQ==
X-Gm-Message-State: APjAAAXGYbPUmcCUWBo7qUQTiL2xFHohEj67HWQuA+N3K3K3CTTP82PX
        Ww6PtVT+O0pMvvIW0QoUlSTQov3dxpgDNA==
X-Google-Smtp-Source: APXvYqwZ9DcorsT0otODsjVhMRV+5vmVK01y/h76Hpz5XctIkGGXzAYAJLgHoIMc38KZoHfdcV+AJw==
X-Received: by 2002:a63:6b0a:: with SMTP id g10mr8500894pgc.296.1571388747372;
        Fri, 18 Oct 2019 01:52:27 -0700 (PDT)
Received: from localhost ([49.248.178.134])
        by smtp.gmail.com with ESMTPSA id x19sm8025248pgc.59.2019.10.18.01.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Oct 2019 01:52:26 -0700 (PDT)
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
Subject: [PATCH v4 4/6] cpufreq: Initialize cpufreq-dt driver earlier
Date:   Fri, 18 Oct 2019 14:22:01 +0530
Message-Id: <66d8ae593ce7936a5f492d0c6855c1ac225b64ee.1571387352.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571387352.git.amit.kucheria@linaro.org>
References: <cover.1571387352.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571387352.git.amit.kucheria@linaro.org>
References: <cover.1571387352.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows HW drivers that depend on cpufreq-dt to initialise earlier.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index bca8d1f47fd2c..3282defe14d41 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -180,4 +180,4 @@ static int __init cpufreq_dt_platdev_init(void)
 			       -1, data,
 			       sizeof(struct cpufreq_dt_platform_data)));
 }
-device_initcall(cpufreq_dt_platdev_init);
+core_initcall(cpufreq_dt_platdev_init);
-- 
2.17.1

