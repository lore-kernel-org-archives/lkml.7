Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D1FC76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771A6223A2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qtTFfvyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388149AbfGWGOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 02:14:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42863 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388145AbfGWGOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:14:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so20200113plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 23:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSy97MHTyvjB+tNxNcL94WmxX39zNt2juy/xtyGFT8Y=;
        b=qtTFfvyZQ+n3BuQV5HhEc01LRgT8Q3RVePNpiuu1aFBWLZo5PygfiqyPF5qZVn9kMs
         Ap/gS6I2/VtC79MvUUIFxAKz6PdL+jGvXs+qAQdfW+vWgCs0L5x6oMb817ZLrMRe+HJQ
         WQpmjP9g8/XywOFL87iUm1K0rWmzH6s0K/FknZkn08PcKHDV9j9derGTZZzn51hs2CvT
         bcbSjLS3S1IYcrl3kb/7UKnHwtQZcYDaFH2WL5o7WNBYy0kLw3qMjxeMVKpIO/5avxle
         slCcswwRW/HdUXQIyAaM/e+zokBpHfS8HYwRX12Njthf0f1F944t4XBK4n+1xmq6SCdT
         dckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSy97MHTyvjB+tNxNcL94WmxX39zNt2juy/xtyGFT8Y=;
        b=AqJwibQJ7/MrHOXMF/pVmeWcfScItpsGjIoQy8NqZoE9kCpLi0rp30QOvXcXSFwZM9
         s+CvDaxcKItRY+ZtF/YC4Dh71ArP39rzca6QirT1J3r3MFvaabRAqiiuJu0ZpJzpog+Z
         b1MKdL13sVVG6YCIiWv9Aj+MahzhQ/v3oZ11E9WCyYSKUKs0BadENmeG5jxUA0hdXPsh
         s81sd0JyNV7FrfqkzLcc+MV2opfbfS7qGZryz/liLQR1Pg6VgGVqOzUoOljrKk4aIhBc
         dSZalR8jgPCE+PQzxF454rfwNMsmp1kX2BmdS6MBC3O8JP3FcJVCA6D5P2xTSiAhfKja
         C5/w==
X-Gm-Message-State: APjAAAVnDKKUdKKb8mzzNUCxA/vkjkkR2FzsLRyqOsEO6CyxT0UdLUHw
        Vz5fjA8m3pgFDGlT2aKyQsgpZQ==
X-Google-Smtp-Source: APXvYqzUcFU3wsNIG8Q7OYgyK85j0SXIDJZX0XAXT4Zwbjja4zDuD7rUEYw8CerpGmcATZitxlwbIA==
X-Received: by 2002:a17:902:a504:: with SMTP id s4mr56706631plq.117.1563862483299;
        Mon, 22 Jul 2019 23:14:43 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id o3sm76723419pje.1.2019.07.22.23.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 23:14:42 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 07/10] video: sa1100fb: Remove cpufreq policy notifier
Date:   Tue, 23 Jul 2019 11:44:07 +0530
Message-Id: <b8ed154787c6930c9d098fe549fcfe52c82ad762.1563862014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563862014.git.viresh.kumar@linaro.org>
References: <cover.1563862014.git.viresh.kumar@linaro.org>
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

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
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

