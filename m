Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7F5C5B578
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348BF2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATQ3ihl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfGDCgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 22:36:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44986 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfGDCgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 22:36:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so2171852pfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 19:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M8gkH2EuGEhpnR2pTwKfU95prWM3XzY3XXen65sRHVg=;
        b=ATQ3ihl05TYcxtg43qA/s8JbGDT/wgAy7Vl3nMui1WpNeUypKZ5Q4vATOEVms+yAz6
         dhkYBbOUGQ/9h/3iHkDXixRnBqKcQV/deA30JWCK9yTPjFHatnwvq+TFFgHAiApSS5fA
         SqD9VQKfMP2HxhpI7gk9OOt2B9Tiv5QC8NPsZ1q1yv/UWfVYffGdT6HldhOV8kMnYJHm
         rLUR/uhzuOTi5X7Mt2Bj+p0xn6NxJj1RQ+UYv1a7LGge1G/J6NsWitN1mXoPeHlAQkN1
         GUeTPYRaOs590b1UG3RyQHvuaiIJq4ZLJdmUtqZIUJshx2xvotmQqsYqa8zr3o96YtZc
         yMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M8gkH2EuGEhpnR2pTwKfU95prWM3XzY3XXen65sRHVg=;
        b=dbpbh9meld2TTYxmZQh2B5N4FhTwxfRlJt5IeCZuFisgjbqMxDP2lR5sxmCCmAdbrg
         F1smQA7wtfguAbXsq7quFf73iJFdVR5BDtPRhOsrJmza/8qfDJkRKJuyi3RmIYQJL+81
         opihPzHvnr0uc1ckNnroxi7Ta/00qefUnQS6enFlpsXIb9nM2otEykMyjRSO7SZGUr5/
         qy07id+CS2gQRktIHXGFXZNVfuSJO9H/aiqz7oNfOB8WerBQQuLOL3hOj5j1vuLGrlNn
         fjK47co4ftejSIobniXQ8DeGrtk2ZSD2oRzERkCLlvJ9A7xPDiJv3qAQHWsUNpndhOy5
         9PAA==
X-Gm-Message-State: APjAAAWYY1nKHQcoeDZruWRCXJuFUWGlm2WqixDsdD6d22FVIJbGu0sk
        7Xz0rns2DhwElUFNXJgSn9193uhSFaU=
X-Google-Smtp-Source: APXvYqyxwE96epy4/x19vlPe8oqA/kJ2mWSaBEXoQouHkUsGqF1WmvzBIURboBYiWkqDMvcD02U5Cg==
X-Received: by 2002:a17:90a:bf08:: with SMTP id c8mr16472122pjs.75.1562207772377;
        Wed, 03 Jul 2019 19:36:12 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id k70sm7858346pje.14.2019.07.03.19.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 19:36:12 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [Patch v2 04/10] drm/panfrost: using dev_get_drvdata directly
Date:   Thu,  4 Jul 2019 10:36:05 +0800
Message-Id: <20190704023605.4597-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several drivers cast a struct device pointer to a struct
platform_device pointer only to then call platform_get_drvdata().
To improve readability, these constructs can be simplified
by using dev_get_drvdata() directly.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Make the commit message more clearly.

 drivers/gpu/drm/panfrost/panfrost_devfreq.c | 6 +++---
 drivers/gpu/drm/panfrost/panfrost_device.c  | 6 ++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
index db798532b0b6..bef5df4d99ac 100644
--- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
+++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
@@ -18,7 +18,7 @@ static void panfrost_devfreq_update_utilization(struct panfrost_device *pfdev, i
 static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
 				   u32 flags)
 {
-	struct panfrost_device *pfdev = platform_get_drvdata(to_platform_device(dev));
+	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 	struct dev_pm_opp *opp;
 	unsigned long old_clk_rate = pfdev->devfreq.cur_freq;
 	unsigned long target_volt, target_rate;
@@ -86,7 +86,7 @@ static void panfrost_devfreq_reset(struct panfrost_device *pfdev)
 static int panfrost_devfreq_get_dev_status(struct device *dev,
 					   struct devfreq_dev_status *status)
 {
-	struct panfrost_device *pfdev = platform_get_drvdata(to_platform_device(dev));
+	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 	int i;
 
 	for (i = 0; i < NUM_JOB_SLOTS; i++) {
@@ -117,7 +117,7 @@ static int panfrost_devfreq_get_dev_status(struct device *dev,
 
 static int panfrost_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
 {
-	struct panfrost_device *pfdev = platform_get_drvdata(to_platform_device(dev));
+	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 
 	*freq = pfdev->devfreq.cur_freq;
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 3b2bced1b015..ed187648e6d8 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -227,8 +227,7 @@ const char *panfrost_exception_name(struct panfrost_device *pfdev, u32 exception
 #ifdef CONFIG_PM
 int panfrost_device_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panfrost_device *pfdev = platform_get_drvdata(pdev);
+	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 
 	panfrost_gpu_soft_reset(pfdev);
 
@@ -243,8 +242,7 @@ int panfrost_device_resume(struct device *dev)
 
 int panfrost_device_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct panfrost_device *pfdev = platform_get_drvdata(pdev);
+	struct panfrost_device *pfdev = dev_get_drvdata(dev);
 
 	if (!panfrost_job_is_idle(pfdev))
 		return -EBUSY;
-- 
2.11.0

