Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC629C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 04:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB382087C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 04:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qF3lZmPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCPE7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 00:59:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40739 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfCPE7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 00:59:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id u9so7803701pgo.7;
        Fri, 15 Mar 2019 21:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W4Q7ZutFc9u+NUmudNHsjjkbbUE884gFYUqTtrYwTQc=;
        b=qF3lZmPm9q/Ow3aGxOZnoUXn+qVXQLOxUh17pt6uAMgJncocN7L1MjukyvgP4Ff2ZZ
         QWRLPa4sPbmbCDrnnpDhG2PFOUZRm7UYtTPX7VYhefjr4zy1tnBa0WDAUWvQ0oTSCOlR
         7aiSgFH9v6NlT4EbsJ307GuF4485H2eY3Lr/6yreF8w3DdfVQG3ivpHAiTJf5zc5WFdU
         OxiMiZc62aTv8nVS9rSPOgAM4JasXf3e1TJZcifXqBGCIVsFboN43UHQhfjhiJuclXvo
         aeNtRmWDEXXSqyH6yRjo0QCoV/9LYTYicOV35e/Mgw5bx55YTXFOdq67sJQZo+5F+rr5
         xzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W4Q7ZutFc9u+NUmudNHsjjkbbUE884gFYUqTtrYwTQc=;
        b=j7Cd3RcsgHdcgmO9qUDPZIYFye2M8wuZ7tuPefTVdufYxsZAEMK+cJ3CqMUB/a6O8/
         W+1Pd3PoXm7i5Xg2XedNKLwAq3gBdAWY362JtZk7F9TG6jER/q11RWeqrC+kPJ2+ZoFt
         RYw43B15H6X+FMYCTT4+DDrf9RG3Xo9idhZeQq45hZyiz7wWiTtufaqbQhzDZvV1odG0
         BJgz+UzBS+8I0teDsKy69xfZwgPwte29D2Q0a5A0nWHJ7LrMmAJ3Y0Mz/VCK6ykfAg/+
         yAEAZCq1Jv8Cgycntk7N3z5Sh/mzb6thr5yMIMuLQJyTOmANgQRTb6UAHLKubxlzvHds
         eQJQ==
X-Gm-Message-State: APjAAAVhwHPdc1byaFXX5ezOQyxommpADONhTr+3kgSVYSBwbxe59Ixu
        NBgAxKNExePv7tZb8zBm1uw=
X-Google-Smtp-Source: APXvYqx5h6EsvVD3cyuRDAVBFfRcQyRmkV2bz95IBjZSW8qy2uhioUpx3rEHl35wWpeGNOs+W4vsrg==
X-Received: by 2002:a63:ea52:: with SMTP id l18mr6977524pgk.317.1552712380301;
        Fri, 15 Mar 2019 21:59:40 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id g2sm6792004pfm.144.2019.03.15.21.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 21:59:39 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/4] PM / core: Introduce dpm_async_fn() helper
Date:   Sat, 16 Mar 2019 00:59:25 -0400
Message-Id: <20190316045928.31934-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190316045928.31934-1-tiny.windzz@gmail.com>
References: <20190316045928.31934-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we want to execute device pm functions asynchronously, we'll
do the following for the device:

  1) reinit_completion(&dev->power.completion);
  2) Check if the device enables asynchronous suspend.
  3) If necessary, execute the corresponding function asynchronously.

There are a lot of such repeated operations here, in fact we can avoid
this. So introduce dpm_async_fn() to have better code readability and
reuse.

And use this function to do some cleanup.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/power/main.c | 62 +++++++++++++++------------------------
 1 file changed, 23 insertions(+), 39 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index eddb54057ed6..cb44bb6b2b66 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -706,6 +706,19 @@ static bool is_async(struct device *dev)
 		&& !pm_trace_is_enabled();
 }
 
+static bool dpm_async_fn(struct device *dev, async_func_t func)
+{
+	reinit_completion(&dev->power.completion);
+
+	if (is_async(dev)) {
+		get_device(dev);
+		async_schedule(func, dev);
+		return true;
+	}
+
+	return false;
+}
+
 static void async_resume_noirq(void *data, async_cookie_t cookie)
 {
 	struct device *dev = (struct device *)data;
@@ -732,13 +745,8 @@ void dpm_noirq_resume_devices(pm_message_t state)
 	 * in case the starting of async threads is
 	 * delayed by non-async resuming devices.
 	 */
-	list_for_each_entry(dev, &dpm_noirq_list, power.entry) {
-		reinit_completion(&dev->power.completion);
-		if (is_async(dev)) {
-			get_device(dev);
-			async_schedule_dev(async_resume_noirq, dev);
-		}
-	}
+	list_for_each_entry(dev, &dpm_noirq_list, power.entry)
+		dpm_async_fn(dev, async_resume_noirq);
 
 	while (!list_empty(&dpm_noirq_list)) {
 		dev = to_device(dpm_noirq_list.next);
@@ -889,13 +897,8 @@ void dpm_resume_early(pm_message_t state)
 	 * in case the starting of async threads is
 	 * delayed by non-async resuming devices.
 	 */
-	list_for_each_entry(dev, &dpm_late_early_list, power.entry) {
-		reinit_completion(&dev->power.completion);
-		if (is_async(dev)) {
-			get_device(dev);
-			async_schedule_dev(async_resume_early, dev);
-		}
-	}
+	list_for_each_entry(dev, &dpm_late_early_list, power.entry)
+		dpm_async_fn(dev, async_resume_early);
 
 	while (!list_empty(&dpm_late_early_list)) {
 		dev = to_device(dpm_late_early_list.next);
@@ -1053,13 +1056,8 @@ void dpm_resume(pm_message_t state)
 	pm_transition = state;
 	async_error = 0;
 
-	list_for_each_entry(dev, &dpm_suspended_list, power.entry) {
-		reinit_completion(&dev->power.completion);
-		if (is_async(dev)) {
-			get_device(dev);
-			async_schedule_dev(async_resume, dev);
-		}
-	}
+	list_for_each_entry(dev, &dpm_suspended_list, power.entry)
+		dpm_async_fn(dev, async_resume);
 
 	while (!list_empty(&dpm_suspended_list)) {
 		dev = to_device(dpm_suspended_list.next);
@@ -1373,13 +1371,9 @@ static void async_suspend_noirq(void *data, async_cookie_t cookie)
 
 static int device_suspend_noirq(struct device *dev)
 {
-	reinit_completion(&dev->power.completion);
-
-	if (is_async(dev)) {
-		get_device(dev);
-		async_schedule_dev(async_suspend_noirq, dev);
+	if (dpm_async_fn(dev, async_suspend_noirq))
 		return 0;
-	}
+
 	return __device_suspend_noirq(dev, pm_transition, false);
 }
 
@@ -1576,13 +1570,8 @@ static void async_suspend_late(void *data, async_cookie_t cookie)
 
 static int device_suspend_late(struct device *dev)
 {
-	reinit_completion(&dev->power.completion);
-
-	if (is_async(dev)) {
-		get_device(dev);
-		async_schedule_dev(async_suspend_late, dev);
+	if (dpm_async_fn(dev, async_suspend_late))
 		return 0;
-	}
 
 	return __device_suspend_late(dev, pm_transition, false);
 }
@@ -1842,13 +1831,8 @@ static void async_suspend(void *data, async_cookie_t cookie)
 
 static int device_suspend(struct device *dev)
 {
-	reinit_completion(&dev->power.completion);
-
-	if (is_async(dev)) {
-		get_device(dev);
-		async_schedule_dev(async_suspend, dev);
+	if (dpm_async_fn(dev, async_suspend))
 		return 0;
-	}
 
 	return __device_suspend(dev, pm_transition, false);
 }
-- 
2.17.0

