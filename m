Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0291C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7E420C01
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HF5OnRSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388094AbfG3SQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:16:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35300 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387944AbfG3SQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so29209334plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AZvanaYGQHCeCe8d2+RSzqNKocPRl2CR5zzefJtoMkI=;
        b=HF5OnRSmMh2mz0tcIzJD/fB71owMPCZLGeTM1w0J44yIRKz6ezQnukLhlUbQs54QH0
         VcTZU85lRduHS+pPoNoiI/1gOtnVnUcym28dtLh/iqXnU3l60s9c85wMcauQgZQgPQLQ
         hjYmYUEvujlBiprv/pluRVkJKsrv1XJGt7f0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AZvanaYGQHCeCe8d2+RSzqNKocPRl2CR5zzefJtoMkI=;
        b=aICk7eFBWe9Ra8vc7GhIch7TOwUayo2UIWnDuNb3ZJy9GnUWTC9Ln5NXd5FrbbLQWz
         d2+so767UxThmj+z1ugePu7tOchPX6vs/vlb5TYGe3Jm6zD0lKeE2b4TWpbVMmflgQbG
         fTOlBmPBzL6slmApEG5b+C+iD6lVtzvDiXRy7ux/EmzVOtFfS/pfdeVsTfRh9PYIhpKA
         kyFnKbBSEzUaJwELwDsGYRnBRy198mh3SshGrmZacY2asMvqMBjY+7B/IuUvMrQaz8sZ
         3780LRUahfjnuaBg1qOhHlQoV+a+2LYqA/yAnXVZaaPOcvh3GDcqKujBaSzqa3y0IBfN
         vuPQ==
X-Gm-Message-State: APjAAAVRSGdutLbACrv85EjP4plj/x4xGXWZXg6bKG3PUk0mMIUvPxJD
        XIxSP4H0H5QrfwFMkgrlsuoDrMdFumv9ZQ==
X-Google-Smtp-Source: APXvYqzp3gdb8JqpjQ0n3ss05I71VUq27CGUDkIsctzC6HmCCofvpLMH1Tg0Gl+4gJbHgu+hPLZPew==
X-Received: by 2002:a17:902:ac87:: with SMTP id h7mr120307087plr.36.1564510585537;
        Tue, 30 Jul 2019 11:16:25 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:24 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 32/57] perf: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:32 -0700
Message-Id: <20190730181557.90391-33-swboyd@chromium.org>
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

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 4 +---
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 4 +---
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 4 +---
 drivers/perf/qcom_l2_pmu.c                    | 6 +-----
 drivers/perf/xgene_pmu.c                      | 4 +---
 5 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
index 6ad0823bcf23..e42d4464c2cf 100644
--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -217,10 +217,8 @@ static int hisi_ddrc_pmu_init_irq(struct hisi_pmu *ddrc_pmu,
 
 	/* Read and init IRQ */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "DDRC PMU get irq fail; irq:%d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, hisi_ddrc_pmu_isr,
 			       IRQF_NOBALANCING | IRQF_NO_THREAD,
diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
index 4f2917f3e25e..f28063873e11 100644
--- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
@@ -207,10 +207,8 @@ static int hisi_hha_pmu_init_irq(struct hisi_pmu *hha_pmu,
 
 	/* Read and init IRQ */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "HHA PMU get irq fail; irq:%d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, hisi_hha_pmu_isr,
 			      IRQF_NOBALANCING | IRQF_NO_THREAD,
diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index 9153e093f9df..078b8dc57250 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -206,10 +206,8 @@ static int hisi_l3c_pmu_init_irq(struct hisi_pmu *l3c_pmu,
 
 	/* Read and init IRQ */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "L3C PMU get irq fail; irq:%d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, hisi_l3c_pmu_isr,
 			       IRQF_NOBALANCING | IRQF_NO_THREAD,
diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index d06182fe14b8..21d6991dbe0b 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -909,12 +909,8 @@ static int l2_cache_pmu_probe_cluster(struct device *dev, void *data)
 	cluster->cluster_id = fw_cluster_id;
 
 	irq = platform_get_irq(sdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev,
-			"Failed to get valid irq for cluster %ld\n",
-			fw_cluster_id);
+	if (irq < 0)
 		return irq;
-	}
 	irq_set_status_flags(irq, IRQ_NOAUTOEN);
 	cluster->irq = irq;
 
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 3259e2ebeb39..7e328d6385c3 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1901,10 +1901,8 @@ static int xgene_pmu_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 
 	rc = devm_request_irq(&pdev->dev, irq, xgene_pmu_isr,
 				IRQF_NOBALANCING | IRQF_NO_THREAD,
-- 
Sent by a computer through tubes

