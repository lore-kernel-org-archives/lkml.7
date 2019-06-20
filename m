Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728ECC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 03:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF8620B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 03:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UT17hYIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbfFTDGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 23:06:25 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36737 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfFTDGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 23:06:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so799783pfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 20:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FbHOn34+83W+J2f3XHDBG84b3Et0zmkMSETpfTN9TuM=;
        b=UT17hYIwO07T+JXmCNzUy25KZuNg7TFnGECmDQriV9z5Zc5iK/562PnnVfxwrM6+/z
         NN9S6GFPYLifZ84Wh7XCcbJGNkV5Y7UWS40WSuZzMCL7Z0Qt34GwRoKObd+F35Ng7MKB
         D1UOxmySiMuh5cLXRmvJ0EuTneYj6dlX84Fg5tPOac5vsS/WUkniFmlUUTY2F8CnwDM1
         NrPVz78uVqELIPnN25wEg7YF4YXExqJvtPk8NbE+K8yrNvtiY47q8cUYa8GpX0KWbK4i
         ded7OAYwOaUzU6wiTK/rOLNSus+CjQO6rUy5BKlxEdZn8ZA3EkBVeMThnnUkTQDmTfrb
         OLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FbHOn34+83W+J2f3XHDBG84b3Et0zmkMSETpfTN9TuM=;
        b=H+PF5z611+9SnTKEtZ6worAbTiz3MKJkZLkxC4m0KVD3h+L29N3QRW6WHgKUBhztqE
         sXyK30EZufDq6awAlvyYf+fmRfoDrh7DPMAGaLy2JuwrAX1Kqkoo66sf3EKK7a0XCxnb
         5bkzocw+NYhL0dDfN9UuK7DCcleUY7fDN0f5UyUvXBX6aNmEPJlJbe1tPqx1X1QqiKWp
         XQBqN7Bw5c1JYEG+egXuABp4rGt7gQ7KYs/UxsD3xftVx9/iZc7yU+blpGoskkPT3G/Q
         CNgxh2mFQnDXrOccRWs6GyTvKl7O2VhD+8AN3yBzvX56TDswBRyWeWLTjQSqj7TvrmoA
         uytw==
X-Gm-Message-State: APjAAAXz1ihWP5NOeRdfUsBVxwDKD3uDgGa7N5ELYLouy5U71h4iM3lH
        N7ioaAgXyvyIDEqMvYhxJWxpRg==
X-Google-Smtp-Source: APXvYqwJTRDFmZNAIEaGMNDIRyAWQI1nd69Xf4gQfwcFrHb5UyE97h39NTtwabsG2oSB4Bjr2oCrzw==
X-Received: by 2002:a62:28b:: with SMTP id 133mr5409487pfc.251.1560999983761;
        Wed, 19 Jun 2019 20:06:23 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id g2sm18949048pgi.92.2019.06.19.20.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 20:06:23 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/5] cpufreq: Remove the redundant !setpolicy check
Date:   Thu, 20 Jun 2019 08:35:46 +0530
Message-Id: <b9bac95bcc36f5f70e910e4801be5d4f8fd32d0c.1560999838.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1560999838.git.viresh.kumar@linaro.org>
References: <cover.1560999838.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpufreq_start_governor() is only called for !setpolicy case, checking it
again is not required.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 85ff958e01f1..54befd775bd6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2153,7 +2153,7 @@ static int cpufreq_start_governor(struct cpufreq_policy *policy)
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
 
-	if (cpufreq_driver->get && !cpufreq_driver->setpolicy)
+	if (cpufreq_driver->get)
 		cpufreq_update_current_freq(policy);
 
 	if (policy->governor->start) {
-- 
2.21.0.rc0.269.g1a574e7a288b

