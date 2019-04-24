Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58610C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289072183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AdBMmEfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbfDXU4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:56:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41314 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731141AbfDXU4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:56:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id c12so20850012wrt.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 13:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5EE9+Co3ayTkacb38Au9Wln/sou6mhdQB8k31OtlwZA=;
        b=AdBMmEfqJ99hne/CnLZg9ZzQk7AU5q7FPT1KQBVJEzNz87NMCq/mHmPNqruslAQeN/
         /pr8tehnWcqSgrgXpPWzw0EFmu5qLQDg6pyM8WWeVK94QppLX51ZiZcKAls4+2cAUFF+
         1z1TqLbYA3Jh0H1z/VFCdgOV+n2/x6Aw/TibUJh2+e99tl2RGxyOWGzsZXl6zYUy/S3I
         /EpU+i+Ga2RIAk4zm8tjkk8tgvsiGG0FOi6d+9+h7GIyifBmjdkUciUMVZt2YP4iPPjh
         TMFc/PKyeAx9I6BWVZcuGbT3A1hmG+S11i6YQeoBUYlJ8+WUkq8p6EkbzmxvJB8LnzFv
         O8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5EE9+Co3ayTkacb38Au9Wln/sou6mhdQB8k31OtlwZA=;
        b=erm/inTLBWN17m6ZhyJ3lfXIC/NJmFMisTaL9u0DtnyecKm2aIqH/l7kpgvY72zM21
         NA3DTc8wm2+xY0IE1aUr51GmB37K8aFERrtt61tfgUjRuxJw1w+1E3MBCqhy2SaNNtwJ
         BD2L9TRkwILJK6nZfbYe118qWkMDy31sQtEUtSq2nSxGoLDhOJh+ehs2WKwQK72Oty5/
         m8AqmkMLXMvubDH6uBvgrA2SGqz6NxRXI60PuL0eNotz36AvGM6A+mR6B3N0TiTjprMK
         oicyzR3I4Yo/Crh3gyXeQXSs4+k3xjHfaecIM7nR64MIJhg6mVTh1MlW/+OODrXwErSk
         WobQ==
X-Gm-Message-State: APjAAAV8f/jJ+toyN70/AILKpAsb2OFwTZy2kO1LM+wm9AkoCd5fb96c
        Fe7VVeGmAmF2tF805DHK9SfLdA==
X-Google-Smtp-Source: APXvYqxLadYKfp46cgXPW/Zz22UPMqhXqdBh6F6tYiq30KQKyOvkWzAMyeu+GgjksF2/lyL4LKktyw==
X-Received: by 2002:adf:f309:: with SMTP id i9mr22488046wro.258.1556139381049;
        Wed, 24 Apr 2019 13:56:21 -0700 (PDT)
Received: from clegane.local (228.252.95.92.rev.sfr.net. [92.95.252.228])
        by smtp.gmail.com with ESMTPSA id w10sm16225375wrv.8.2019.04.24.13.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 13:56:20 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        linux-pm@vger.kernel.org (open list:THERMAL/CPU_COOLING),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/drivers/cpu_cooling: Remove pointless test in power2state()
Date:   Wed, 24 Apr 2019 22:56:09 +0200
Message-Id: <20190424205610.9376-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the static power computation was removed, the test with the power
being negative was not removed. However, the substraction which was
responsible of the negative value was removed and the variable is now
an u32. A double reason to remove the test which does not make sense.

Fixes: 84fe2cab48590 ("cpu_cooling: Drop static-power related stuff")
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index f7c1f49ec87f..ee8419a6390c 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -541,7 +541,6 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 	struct cpufreq_policy *policy = cpufreq_cdev->policy;
 
-	power = power > 0 ? power : 0;
 	last_load = cpufreq_cdev->last_load ?: 1;
 	normalised_power = (power * 100) / last_load;
 	target_freq = cpu_power_to_freq(cpufreq_cdev, normalised_power);
-- 
2.17.1

