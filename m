Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A3AC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474A020665
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dnnh+kwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbfGPJzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:55:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42412 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfGPJzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:55:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so8848796pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 02:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wglnm+6yqzntyC9h13b4Wh3S/G9NJM2x5q1vPNkqSgU=;
        b=Dnnh+kwHRtS9hSr7z8dtYzFB/z6nWaIrUpsWPzeEf7Pb6hhhWP8YrQn6phTamDKNCJ
         r5ZsKcNuHQ+Eu35xX8eqMfOOc2GB9DW4slEjuF3JodDKrfbAZJm9l1Ooet/IVl5P6S6U
         Sz0UkF/tUwYvWd5MgI9me+GK3bjcCp8fr/g4H4xmlOpIqjjnkxFBhnxIteeX/R5pvcTo
         fFbz3ZpTfK6TPS/8AIdScSwOH9C9MzZ0EwKDGaxCnoaw6xQARQ5I0erDT6lXSXHRppbI
         cXuEmVGUB4B7r+3GGUarHf2AwnUa4MWpRJhKm59XYpfXh8j4IV3qZ+BtA2LAN7z6OqmG
         mGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wglnm+6yqzntyC9h13b4Wh3S/G9NJM2x5q1vPNkqSgU=;
        b=B278UXtcOsnrN5Hh3JMqarDs9maEqZAJD3VJiHxO9RzehgUQJ5WBCAs6jXBHriMVvq
         NAKkS+ZcNjVvn2b46oKgaWKN//LNctTA3rqv5KKfoFC9WsUYpD/wDGdwQL5OSmQ7DIMF
         8Ipb3k0bYoiStrc0EjiROjzgfcRiSPaO1NW9Bi27HmASezqLaDR46DNGkDH/yZeCO5gU
         kvU3RF7wAmXapsdwhNnSWOHEfWBbQB8vRqvevIhpZLvx9mzgc3NViZX+BPbUa+TZ1VC3
         Su+CduhUI/BrRhb8g7Ke9dUNHPhJliqfxJ/QNrRodfi5nhYeWpKROP+JfZBAHogD5gaE
         eZFw==
X-Gm-Message-State: APjAAAXL3Xzo9Pz/y305q7aU3WQGqucmg+ebXi+JgeN5bSCtCBxCZHAk
        iQkl3G63oWEawKheVYdGB4EiRg==
X-Google-Smtp-Source: APXvYqwE4djRSjudt1aj7hnAPyyjlo+Rw7Ep4ui1p1jCkZWoK7MWPCNdhvgpR/DouQUGSOiXwWBkjg==
X-Received: by 2002:a17:90a:8c90:: with SMTP id b16mr34610804pjo.133.1563270901894;
        Tue, 16 Jul 2019 02:55:01 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id o14sm42384517pfh.153.2019.07.16.02.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 02:55:01 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] video: sa1100fb: Remove cpufreq policy notifier
Date:   Tue, 16 Jul 2019 15:24:46 +0530
Message-Id: <7163e57cfa1780d42732fa6b5ec424c24d1d4dc8.1563270828.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563270828.git.viresh.kumar@linaro.org>
References: <cover.1563270828.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpufreq policy notifier's CPUFREQ_ADJUST notification is going to
get removed soon.

The notifier callback sa1100fb_freq_policy() isn't doing anything apart
from printing a debug message on CPUFREQ_ADJUST notification. There is
no point in keeping an otherwise empty callback and registering the
notifier.

Remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/video/fbdev/sa1100fb.c | 27 ---------------------------
 drivers/video/fbdev/sa1100fb.h |  1 -
 2 files changed, 28 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index f7f8dee044b1..ae2bcfee338a 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -1005,31 +1005,6 @@ sa1100fb_freq_transition(struct notifier_block *nb, unsigned long val,
 	}
 	return 0;
 }
-
-static int
-sa1100fb_freq_policy(struct notifier_block *nb, unsigned long val,
-		     void *data)
-{
-	struct sa1100fb_info *fbi = TO_INF(nb, freq_policy);
-	struct cpufreq_policy *policy = data;
-
-	switch (val) {
-	case CPUFREQ_ADJUST:
-		dev_dbg(fbi->dev, "min dma period: %d ps, "
-			"new clock %d kHz\n", sa1100fb_min_dma_period(fbi),
-			policy->max);
-		/* todo: fill in min/max values */
-		break;
-	case CPUFREQ_NOTIFY:
-		do {} while(0);
-		/* todo: panic if min/max values aren't fulfilled 
-		 * [can't really happen unless there's a bug in the
-		 * CPU policy verififcation process *
-		 */
-		break;
-	}
-	return 0;
-}
 #endif
 
 #ifdef CONFIG_PM
@@ -1242,9 +1217,7 @@ static int sa1100fb_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_CPU_FREQ
 	fbi->freq_transition.notifier_call = sa1100fb_freq_transition;
-	fbi->freq_policy.notifier_call = sa1100fb_freq_policy;
 	cpufreq_register_notifier(&fbi->freq_transition, CPUFREQ_TRANSITION_NOTIFIER);
-	cpufreq_register_notifier(&fbi->freq_policy, CPUFREQ_POLICY_NOTIFIER);
 #endif
 
 	/* This driver cannot be unloaded at the moment */
diff --git a/drivers/video/fbdev/sa1100fb.h b/drivers/video/fbdev/sa1100fb.h
index 7a1a9ca33cec..d0aa33b0b88a 100644
--- a/drivers/video/fbdev/sa1100fb.h
+++ b/drivers/video/fbdev/sa1100fb.h
@@ -64,7 +64,6 @@ struct sa1100fb_info {
 
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
-	struct notifier_block	freq_policy;
 #endif
 
 	const struct sa1100fb_mach_info *inf;
-- 
2.21.0.rc0.269.g1a574e7a288b

