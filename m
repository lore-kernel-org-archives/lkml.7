Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11540CA9EA7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF2C222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VmFlhBj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632998AbfJRIwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:52:34 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41099 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2632989AbfJRIwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:52:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id q7so3444886pfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=yJmW/rmXm26duaDyfOHOFYteagLDpotWOjrp7D9YhkU=;
        b=VmFlhBj2FrlOil5Ro2+R3NNGOF/BhIIl/xJUhPKmdZjV4yp/3W9q2FDa07vgRUyBwe
         77DJhlG/aRp27LbwoEJXO7aSur71B1sjKABDOgQo9FiuCPRzwhM2EGYDXppyDUskM2w4
         oDQKuW9cziROsrSoLFPjze+hVNCnYlyglffqO4JyHA1qALqjQJkA+0jJJrI4srNoaco/
         6gZXAyhkxhS6Z12KgmQrt3Ou3COXNlyA9t3QoHgdbQxa9NpK4QKcBfmpGK0KTEp58xFY
         ZXoClqiKOSskIQt0qq3AHrxAfi3TvvA9L/F4nD/q4KeBj9rMfrxCDjL9eW/mmDmSOhtO
         aj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=yJmW/rmXm26duaDyfOHOFYteagLDpotWOjrp7D9YhkU=;
        b=mZuSbiuKk6UhPsBUqrdulGNjrNUwbZYwIdDVf0BgqT37YpdFdm0MAGUjdIj9JBYncm
         8s4tS2FgFSynQKWrk2L/MFKLeRaYEPeQgZdknuMoBIjUvrfVo9ARMjaRYbPe+aKlbzNj
         xtBTNk3ERuxB+vYypua0auiLkO53xl9pdjw2cC6tRaxf4xivuhEjUkU4g4Wgc7nnbn75
         ApR2Y9OJPxeV9f9Bu5X2SvTv73S7KmPvMPHMNuZcdjlAd4eXxrZp630qI/Iq5Co5UHPy
         MSY4DwMb3s13dYMYCy1w14Ig4IyC3VAdskNynpfLRaziuKtoWWgmJpUxirUBrfdHEz4k
         Gktw==
X-Gm-Message-State: APjAAAW33ICzf0qcwHe95g3s8PaBJ8ECfUD64Snx1oVCb59PLFQA6LXW
        2LlEzGHD53Lf4TkC84g1bf6zwxKpcUzJEQ==
X-Google-Smtp-Source: APXvYqxI49Qp/6OHcYXVbuLyz5IE0hCMoyGFSumazKMZCgeoR23NYt8ytaEwx3DYBTG7pFS8jSIMCg==
X-Received: by 2002:a63:f854:: with SMTP id v20mr8674374pgj.92.1571388751747;
        Fri, 18 Oct 2019 01:52:31 -0700 (PDT)
Received: from localhost ([49.248.178.134])
        by smtp.gmail.com with ESMTPSA id d11sm5278150pfo.104.2019.10.18.01.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Oct 2019 01:52:31 -0700 (PDT)
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
Cc:     linux-clk@vger.kernel.org
Subject: [PATCH v4 5/6] clk: qcom: Initialise clock drivers earlier
Date:   Fri, 18 Oct 2019 14:22:02 +0530
Message-Id: <a59321a1016de3f08098739b6db5d5190ac1c85c.1571387352.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571387352.git.amit.kucheria@linaro.org>
References: <cover.1571387352.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571387352.git.amit.kucheria@linaro.org>
References: <cover.1571387352.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialise the clock drivers on sdm845 and qcs404 in core_initcall so we
can have earlier access to cpufreq during booting.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/clk-rpmh.c   | 2 +-
 drivers/clk/qcom/gcc-qcs404.c | 2 +-
 drivers/clk/qcom/gcc-sdm845.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 96a36f6ff667d..20d4258f125b9 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -487,7 +487,7 @@ static int __init clk_rpmh_init(void)
 {
 	return platform_driver_register(&clk_rpmh_driver);
 }
-subsys_initcall(clk_rpmh_init);
+core_initcall(clk_rpmh_init);
 
 static void __exit clk_rpmh_exit(void)
 {
diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
index bd32212f37e64..9b0c4ce2ef4ec 100644
--- a/drivers/clk/qcom/gcc-qcs404.c
+++ b/drivers/clk/qcom/gcc-qcs404.c
@@ -2855,7 +2855,7 @@ static int __init gcc_qcs404_init(void)
 {
 	return platform_driver_register(&gcc_qcs404_driver);
 }
-subsys_initcall(gcc_qcs404_init);
+core_initcall(gcc_qcs404_init);
 
 static void __exit gcc_qcs404_exit(void)
 {
diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 95be125c3bddf..49dcff1af2db1 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -3628,7 +3628,7 @@ static int __init gcc_sdm845_init(void)
 {
 	return platform_driver_register(&gcc_sdm845_driver);
 }
-subsys_initcall(gcc_sdm845_init);
+core_initcall(gcc_sdm845_init);
 
 static void __exit gcc_sdm845_exit(void)
 {
-- 
2.17.1

