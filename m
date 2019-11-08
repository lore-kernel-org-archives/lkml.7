Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92E5C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0971218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lrokpjAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbfKHK6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 05:58:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36952 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbfKHK6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 05:58:18 -0500
Received: by mail-pg1-f195.google.com with SMTP id z24so3725227pgu.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 02:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wISJS0OWPo2/E4IjX1pDBrYSwoR446f1IRAE3ZXUfNg=;
        b=lrokpjAz8qWZkc7OmPIgihn1TOvIx7tamO/UFjIQ7Hi9QRgTzND01Ew+Njm0A2ElvG
         A4/NwlYQ3eG1TrsgaVhIPxljDuBueDMoTmzyH9Q6sXTK3Ft1p3/sSDHZU8GeAo2O2wEZ
         2db2DoY07TwQ5JoatF1Cm2LQYXW+VniirkzYU1pqlFP4LlH+LyqLvLADu7B6hykhjOWt
         Zf7HjWjAPCac5zDv3skmiVawov0sh77DYhsRY96rh5ExzaHUb4tCiW3Dfti7YfYM1/YR
         e/EmGauYZQwDZvcDBvBw/1CrbShTJyCcBiYjzb30pQxYGrhNdfvpG48yNSbIBDBGPnV2
         /0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wISJS0OWPo2/E4IjX1pDBrYSwoR446f1IRAE3ZXUfNg=;
        b=CDdQXqjuHC3wlVV9HYuglJ3SwByAg8iw/lBOsaDgCZRNzpbd8ShyRuXAzXnjwcWeR8
         ec3IBLJvKHw6MjAN6wfy6YTKp/LU5Ldrq1m8S6oh143UrglF9DMOSsBBbnW9bhpSGlOP
         SN026NXq6tJQSIVWovnwtfaUpnavucPhwh0XJ2U99fQUADkdVBSC4a23fUhq1UG45bt6
         Ju9DMhbtk9oOJvsRauHXzcJUiDxqyYdgBXeSliNKt+3UgHH0bSFTan9ybSbGoYQoFWYC
         vx9ezC52NLuz47o91Ac7RY08WF2IkzJmsLEaA3eynYvh/uEferRRCj7mjQkUz0PUVf9R
         VSvQ==
X-Gm-Message-State: APjAAAWfchqC+ndJe/lw+a39jc93s12zGX6Va3dpZl7nOIyF8TClWUjL
        9YjtWZ7mkLJecjY1KIacg2hOPw==
X-Google-Smtp-Source: APXvYqw6zZqtJoMSVOyHzvFRbaQhcvNKVMam7pzqcTmDeakyOOULh6MNYGf+Nuovm/I4m812tZrLgg==
X-Received: by 2002:a17:90a:b78d:: with SMTP id m13mr12970166pjr.70.1573210697207;
        Fri, 08 Nov 2019 02:58:17 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x12sm5111180pfm.130.2019.11.08.02.58.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Nov 2019 02:58:16 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        baolin.wang7@gmail.com, dongwei.wang@unisoc.com,
        shuiqing.li@unisoc.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: sprd: Fix the incorrect pointer getting from driver data
Date:   Fri,  8 Nov 2019 18:57:12 +0800
Message-Id: <76d4687189ec940baa90cb8d679a8d4c8f02ee80.1573210405.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuiqing Li <shuiqing.li@unisoc.com>

The device driver data saved the 'struct sprd_wdt' object, it is
incorrect to get 'struct watchdog_device' object from the driver
data, thus fix it.

Fixes: 477603467009 ("watchdog: Add Spreadtrum watchdog driver")
Reported-by: Dongwei Wang <dongwei.wang@unisoc.com>
Signed-off-by: Shuiqing Li <shuiqing.li@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/watchdog/sprd_wdt.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/sprd_wdt.c b/drivers/watchdog/sprd_wdt.c
index 0bb17b0..65cb55f 100644
--- a/drivers/watchdog/sprd_wdt.c
+++ b/drivers/watchdog/sprd_wdt.c
@@ -327,10 +327,9 @@ static int sprd_wdt_probe(struct platform_device *pdev)
 
 static int __maybe_unused sprd_wdt_pm_suspend(struct device *dev)
 {
-	struct watchdog_device *wdd = dev_get_drvdata(dev);
 	struct sprd_wdt *wdt = dev_get_drvdata(dev);
 
-	if (watchdog_active(wdd))
+	if (watchdog_active(&wdt->wdd))
 		sprd_wdt_stop(&wdt->wdd);
 	sprd_wdt_disable(wdt);
 
@@ -339,7 +338,6 @@ static int __maybe_unused sprd_wdt_pm_suspend(struct device *dev)
 
 static int __maybe_unused sprd_wdt_pm_resume(struct device *dev)
 {
-	struct watchdog_device *wdd = dev_get_drvdata(dev);
 	struct sprd_wdt *wdt = dev_get_drvdata(dev);
 	int ret;
 
@@ -347,7 +345,7 @@ static int __maybe_unused sprd_wdt_pm_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (watchdog_active(wdd)) {
+	if (watchdog_active(&wdt->wdd)) {
 		ret = sprd_wdt_start(&wdt->wdd);
 		if (ret) {
 			sprd_wdt_disable(wdt);
-- 
1.7.9.5

