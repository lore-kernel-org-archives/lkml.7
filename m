Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9630FC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC922064A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HzhzU7pW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388110AbfG3SQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:16:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41613 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388039AbfG3SQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so20131230pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+LwxKh+rGV2TldYFaibsGc6jv64xvgd6qWUW7IJGL4=;
        b=HzhzU7pWiJQ2/6+p2YWgzzRKNpggqYFIfL605hH5WJwJLsgD7Ez+gO9WjqY+/SZNCh
         T8nZ/Jq8szKWQP0fpYpxOA/mwARN+o0iWnqFKKxI7Qv0+pc6INWmzOQQuxkkJMUbKC8Y
         kNEPco6aVNnwmUazs+zmmcTNBV6vYXml1F/XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+LwxKh+rGV2TldYFaibsGc6jv64xvgd6qWUW7IJGL4=;
        b=XQXlKOWf7gbEgykt4v5DT5pWZKeSjbeLj7wSOxM7u3rlQkam9RGpdNxwXxNJswZPWF
         qtuR9uCCfVp9i2lsPFx5FosvVXW9n7BupwbLHRe1v7l1GO7ex1XUQ3cRTrVNItlDu1aG
         KSYGZOoPK2MlGFL1KZCNIN+dopteSCAxBGZA4AOOQkZncwmoA7a/24KG9nWGD5CfaDM6
         nBFwvrCLYAWAH5lVADT7b+SN3TlVBHOR5pphWgDtQmwiI3+tHnJ2iQWaZlfkPYOIVwd5
         KokuIDzErTLPPMQEZfZOx5Bzcyp9FYA2cMz2hQiuTu24cj2IaxB/u8AoG6MsENbsiJD7
         umKg==
X-Gm-Message-State: APjAAAWJ21NbGDdIBtwfKI5CbsPymZnO9Jc/u6NnaUEQ9IJ0ESDxqtZP
        PxgSUOOwcgV6gymVfZ7Qk7bR+Y9esRKNsQ==
X-Google-Smtp-Source: APXvYqwlugLrblhpkKg5MgH82DH3I2ZfTTIFs4nYin9BP3UU2LX7voVgbAYYN2JbqVBDzMxKaeAoGw==
X-Received: by 2002:a62:642:: with SMTP id 63mr43464543pfg.257.1564510589976;
        Tue, 30 Jul 2019 11:16:29 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:29 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 38/57] remoteproc: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:38 -0700
Message-Id: <20190730181557.90391-39-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-remoteproc@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/remoteproc/da8xx_remoteproc.c    |  4 +--
 drivers/remoteproc/keystone_remoteproc.c |  4 ---
 drivers/remoteproc/qcom_q6v5.c           | 35 ++++--------------------
 3 files changed, 6 insertions(+), 37 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index b2c7af323ed1..98e0be9476a4 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -249,10 +249,8 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 	int ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "platform_get_irq(pdev, 0) error: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	irq_data = irq_get_irq_data(irq);
 	if (!irq_data) {
diff --git a/drivers/remoteproc/keystone_remoteproc.c b/drivers/remoteproc/keystone_remoteproc.c
index 4cb44017af8a..5c4658f00b3d 100644
--- a/drivers/remoteproc/keystone_remoteproc.c
+++ b/drivers/remoteproc/keystone_remoteproc.c
@@ -424,16 +424,12 @@ static int keystone_rproc_probe(struct platform_device *pdev)
 	ksproc->irq_ring = platform_get_irq_byname(pdev, "vring");
 	if (ksproc->irq_ring < 0) {
 		ret = ksproc->irq_ring;
-		dev_err(dev, "failed to get vring interrupt, status = %d\n",
-			ret);
 		goto disable_clk;
 	}
 
 	ksproc->irq_fault = platform_get_irq_byname(pdev, "exception");
 	if (ksproc->irq_fault < 0) {
 		ret = ksproc->irq_fault;
-		dev_err(dev, "failed to get exception interrupt, status = %d\n",
-			ret);
 		goto disable_clk;
 	}
 
diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 0d33e3079f0d..cb0f4a0be032 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -187,13 +187,8 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	init_completion(&q6v5->stop_done);
 
 	q6v5->wdog_irq = platform_get_irq_byname(pdev, "wdog");
-	if (q6v5->wdog_irq < 0) {
-		if (q6v5->wdog_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve wdog IRQ: %d\n",
-				q6v5->wdog_irq);
+	if (q6v5->wdog_irq < 0)
 		return q6v5->wdog_irq;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->wdog_irq,
 					NULL, q6v5_wdog_interrupt,
@@ -205,13 +200,8 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	}
 
 	q6v5->fatal_irq = platform_get_irq_byname(pdev, "fatal");
-	if (q6v5->fatal_irq < 0) {
-		if (q6v5->fatal_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve fatal IRQ: %d\n",
-				q6v5->fatal_irq);
+	if (q6v5->fatal_irq < 0)
 		return q6v5->fatal_irq;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->fatal_irq,
 					NULL, q6v5_fatal_interrupt,
@@ -223,13 +213,8 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	}
 
 	q6v5->ready_irq = platform_get_irq_byname(pdev, "ready");
-	if (q6v5->ready_irq < 0) {
-		if (q6v5->ready_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve ready IRQ: %d\n",
-				q6v5->ready_irq);
+	if (q6v5->ready_irq < 0)
 		return q6v5->ready_irq;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->ready_irq,
 					NULL, q6v5_ready_interrupt,
@@ -241,13 +226,8 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	}
 
 	q6v5->handover_irq = platform_get_irq_byname(pdev, "handover");
-	if (q6v5->handover_irq < 0) {
-		if (q6v5->handover_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve handover IRQ: %d\n",
-				q6v5->handover_irq);
+	if (q6v5->handover_irq < 0)
 		return q6v5->handover_irq;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->handover_irq,
 					NULL, q6v5_handover_interrupt,
@@ -260,13 +240,8 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	disable_irq(q6v5->handover_irq);
 
 	q6v5->stop_irq = platform_get_irq_byname(pdev, "stop-ack");
-	if (q6v5->stop_irq < 0) {
-		if (q6v5->stop_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve stop-ack IRQ: %d\n",
-				q6v5->stop_irq);
+	if (q6v5->stop_irq < 0)
 		return q6v5->stop_irq;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->stop_irq,
 					NULL, q6v5_stop_interrupt,
-- 
Sent by a computer through tubes

