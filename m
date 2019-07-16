Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A34C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01A220665
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FbuySQDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbfGPJzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:55:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40996 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732520AbfGPJzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:55:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so8858951pff.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 02:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QxH+UbD9tCF0KwHpPpNeLuejcWOqKPoBzOiXe/lF/gk=;
        b=FbuySQDtO2afso3Zxf3ISnrj/v2hbYkqAmDXCqX8MPUrL4zaHSiS5SY9RiGeUl4DBd
         QYFEwKX1LxMARj+z317ztFPrv0F4GtsdtsOHbWT6MhcS3V4/9MxUrlc/V3gklYoUHOs0
         a0Spyg/DNkDb/ExzrNrp0C/TIFJvN5XdZaLcrQXHaPYP7DRkPij+Gm8j2iS8Iyt81NpU
         RYd8ZR0FhyMs9jTWMMD516MbMp+JLzFaFrHFq19l7iCxCkC2OJKVFaH838fVGVaiF5Eu
         OFM4DMWboMqSSpHzjsdkOte3wz2s1/FFebxDMVpx5oLeFUyRxm8T3ZLw1FKyPtdKY9IX
         KCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QxH+UbD9tCF0KwHpPpNeLuejcWOqKPoBzOiXe/lF/gk=;
        b=OJisu7+HxeNKlbYKdHeV7wUIsqNYHy4btmRsserczKS4k0oxKs66pjNp0cVaZAsvcS
         g7k21B55BTEQlpHga69MEr+19QpiyYISDZT/rggsxLzu7tM17+MF5xKpj1w6QAXEvjcU
         nqgXhtgCG2MJ6lxuSA33+/uA2jWi0LQBSDj6AQkCs46YhC+Rdc6VhbhI/dmQpV1eqANI
         Hbktfd4yLfUI/nZTETshWZ9LgaokRe4r9fwa/9uTU2sN1xKPsxjWVQWAXxLwbhg7P+jM
         GDf+JN2FVk5WYYi5mqWWSYENbvKddb7jj5QbskRlFAyyETy1hxKxWHQr7jQnRj5c32ll
         OtIQ==
X-Gm-Message-State: APjAAAU9K9NdPlUxe9LDdSODD01Zy6O8+OAxpajo2U7sgXJiioDgxbDE
        ktFIKE9i9g2d3UQMNZvlmdNoGA==
X-Google-Smtp-Source: APXvYqxVvOwNilTqDTpbthb8pN3i7U94PEikdceh26u14QE+VwDQo/NV8TzLClLcmOdL0R6dY7c2PA==
X-Received: by 2002:a63:ad07:: with SMTP id g7mr30139354pgf.405.1563270905182;
        Tue, 16 Jul 2019 02:55:05 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id r188sm33754776pfr.16.2019.07.16.02.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 02:55:04 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] video: pxafb: Remove cpufreq policy notifier
Date:   Tue, 16 Jul 2019 15:24:47 +0530
Message-Id: <e69d47b1d497bdbd8c988754d98714e78ddc0a80.1563270828.git.viresh.kumar@linaro.org>
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

The notifier callback pxafb_freq_policy() isn't doing anything apart
from printing a debug message on CPUFREQ_ADJUST notification. There is
no point in keeping an otherwise empty callback and registering the
notifier.

Remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/video/fbdev/pxafb.c | 21 ---------------------
 drivers/video/fbdev/pxafb.h |  1 -
 2 files changed, 22 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 4282cb117b92..f70c9f79622e 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -1678,24 +1678,6 @@ pxafb_freq_transition(struct notifier_block *nb, unsigned long val, void *data)
 	}
 	return 0;
 }
-
-static int
-pxafb_freq_policy(struct notifier_block *nb, unsigned long val, void *data)
-{
-	struct pxafb_info *fbi = TO_INF(nb, freq_policy);
-	struct fb_var_screeninfo *var = &fbi->fb.var;
-	struct cpufreq_policy *policy = data;
-
-	switch (val) {
-	case CPUFREQ_ADJUST:
-		pr_debug("min dma period: %d ps, "
-			"new clock %d kHz\n", pxafb_display_dma_period(var),
-			policy->max);
-		/* TODO: fill in min/max values */
-		break;
-	}
-	return 0;
-}
 #endif
 
 #ifdef CONFIG_PM
@@ -2400,11 +2382,8 @@ static int pxafb_probe(struct platform_device *dev)
 
 #ifdef CONFIG_CPU_FREQ
 	fbi->freq_transition.notifier_call = pxafb_freq_transition;
-	fbi->freq_policy.notifier_call = pxafb_freq_policy;
 	cpufreq_register_notifier(&fbi->freq_transition,
 				CPUFREQ_TRANSITION_NOTIFIER);
-	cpufreq_register_notifier(&fbi->freq_policy,
-				CPUFREQ_POLICY_NOTIFIER);
 #endif
 
 	/*
diff --git a/drivers/video/fbdev/pxafb.h b/drivers/video/fbdev/pxafb.h
index b641289c8a99..86b1e9ab1a38 100644
--- a/drivers/video/fbdev/pxafb.h
+++ b/drivers/video/fbdev/pxafb.h
@@ -162,7 +162,6 @@ struct pxafb_info {
 
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
-	struct notifier_block	freq_policy;
 #endif
 
 	struct regulator *lcd_supply;
-- 
2.21.0.rc0.269.g1a574e7a288b

