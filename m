Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C3FFA373B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16C62089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CXTEhQJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394049AbfJQM2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:28:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42141 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393750AbfJQM2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:28:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id f14so1267207pgi.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 05:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=smRwPgvncTjnAR1YtPvLb1bA4/kxUscSlcxDGMtB+pk=;
        b=CXTEhQJBPSdCMw+IoywZVcKHtNxz/LdSoAfySQJBtoF3why8XyOtLveH0F98ftlzbg
         lGN1tXAB5pOEi228FfTu3mTnbXXgzEL8jxCzcBQNqxu2Z8iqUYLRzTfa20NlNC2uWZ1A
         csJXKyMDgWRqHhEHI3FWP4EE7cwtkQ6TyPV0ntYhcX+uT1/ULigN1FbKODf9k4HqW+nx
         s1fLpu7h7BX13D552cMBe2TzriGx4y8IjiEFvEIpuM9W2e9wMrAOZlCFxB7Z3qrlIFgN
         NsDhWCfxagZcFmKo4ORUuv9OA75QRv2XeYORTsFjVx57Kj0GcbMHNK+j7izjMyYer3UC
         Hb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=smRwPgvncTjnAR1YtPvLb1bA4/kxUscSlcxDGMtB+pk=;
        b=moqZ/r6+JpAnOYLlVBTUW5jBfOF7gxl1LEs5hNKzBDPTZ0yIFKbBOVKKqU507n1MII
         IkslCRx6ltlxlSMl2ImzbkYPBFKQ+1uSRfThb4dFvRCGAiMVtgF43A0+HhIigmII0x7W
         cSVsCU3z9fjCebzMs4xc2dQoV/gp09KLUdC4h18qEe1YU2zCQZfOL2Oy6JxDjY8N2U9A
         RfzCgx9lz3DQqi6n2L5/EgMH9SvMqV50PZR1YllEbXnnstXZXoZQlQ/2x9tFSF03lHMs
         Lvpgant56z1Hu6PQIf4kfxDfYrB0OqFehPEAigU5QrEINN8idF/as8EYNODP8glxiuqV
         OogQ==
X-Gm-Message-State: APjAAAVX0TjFwfGGaqwpRIUkB9GuzOnJAsDap+Bgao6lhOFAzvkkTR/5
        AAC1MvnO1GnuMYOYxZFDy70XR7dt/ygkGg==
X-Google-Smtp-Source: APXvYqwv1uq5A9qIqW0buX8pAXgbhIdbQCV4Xyis8lzdNFPlH5cGLHz39J+R4PxT0WHConQkAoKbvg==
X-Received: by 2002:a62:7643:: with SMTP id r64mr3573835pfc.106.1571315286536;
        Thu, 17 Oct 2019 05:28:06 -0700 (PDT)
Received: from localhost ([49.248.54.231])
        by smtp.gmail.com with ESMTPSA id c128sm2897104pfc.166.2019.10.17.05.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 05:28:05 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        sudeep.holla@arm.com, bjorn.andersson@linaro.org,
        edubezval@gmail.com, agross@kernel.org, tdas@codeaurora.org,
        swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v3 6/6] cpufreq: qcom-hw: Move driver initialisation earlier
Date:   Thu, 17 Oct 2019 17:57:38 +0530
Message-Id: <3468b8cf9c764ea139296ee149d33cd7a9d79e3e.1571314830.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571314830.git.amit.kucheria@linaro.org>
References: <cover.1571314830.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1571314830.git.amit.kucheria@linaro.org>
References: <cover.1571314830.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow qcom-hw driver to initialise right after the cpufreq and thermal
subsystems are initialised in core_initcall so we get earlier access to
thermal mitigation.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index a9ae2f84a4ef..fc92a8842e25 100644
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

