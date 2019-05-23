Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F409DC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A4A20879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="X58KYUnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbfEWMvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:51:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45775 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730817AbfEWMvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:51:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id r76so5317375lja.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AhSeNDsoUdUKug5x4JHt0IZKHwNd5yuItEIHg6AIB9c=;
        b=X58KYUnxMFoMN706or9z2easKrW5izuFJCrAsqJILNZcCL142GV7pxV8NY0AnI/03S
         o4ryaFG2rPhg0tryyLmAhgtyxJK8Tn5O2TMQPKkfnzNGcV7nIiGSd6//BbRe5Id9oMZT
         oOoK2GvIEiKEoNlymxU1bDZJxqbQXre+KxXDQw095gZnLwB9m05AZgQKjx5eTOTR34BD
         Vugpn6DkAYVKHiYbA7ovIhidlEkwDTSznPkXY6XJ13o8azCAz6VzrwZ3PDgGoc+bZccK
         6zVmFw23qSckDGACy7LpZ/h7s1QxfAXvNqSKFJVZTihyyGq9UdQatZJuF1LsKGnyhcHH
         06CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AhSeNDsoUdUKug5x4JHt0IZKHwNd5yuItEIHg6AIB9c=;
        b=OGCHzuFKLZNNTmqtZiNu/qOXSeNMkM4SkmkMnpYBOWMMua0KRJgevEQylL10ProGD3
         BSqygWOxJbI9HVS7pm7Mji+Y53R2eKUPG5gY54FIyWQvOZAOasqeA0VeDulCxe6QB6W4
         OtRWA06Ppc5wU6WvjrWFpwsnO8gUx8FgWGArx1bZzmpkCboxTLmBTVnrEyCHdiKaiEZr
         SKd5ai77EnEiFuPAvy/R8u2jUdxyao9h+m5evFlQ5jsCGo6cFvJQEL40NzSP7nI1K+SU
         5o9c6Md/opSmePBM67NY20y33/PTOySSBKAiAaBHG5a9vd7xSI1PXwKaFf4RBtqw+QPg
         WqJA==
X-Gm-Message-State: APjAAAWt9iGmdDEwDv8CBCaYvJFiw+7XH1kMwdfLhybNS3LTZ/kLwJxp
        /JOKlq7URfPjBDFC/C+4X4MmLOtZogJEnw==
X-Google-Smtp-Source: APXvYqwOETQo629+dgWMiuq2qkyk7+rhOWXt+13MZ83XUiWEmei63fhPIe02F/bF6AYf32h2G342og==
X-Received: by 2002:a2e:7d02:: with SMTP id y2mr22280232ljc.62.1558615908429;
        Thu, 23 May 2019 05:51:48 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id c19sm5947154lfi.69.2019.05.23.05.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 05:51:47 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] staging: kpc2000: use __func__ in debug messages
Date:   Thu, 23 May 2019 14:51:36 +0200
Message-Id: <20190523125143.32511-3-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523125143.32511-1-simon@nikanor.nu>
References: <20190523125143.32511-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warning "Prefer using '"%s...", __func__' to using
'<function name>', this function's name, in a string".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index 95bfbe4aae4d..b559ade04aca 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -327,7 +327,8 @@ static int probe_core_uio(unsigned int core_num, struct kp2000_device *pcard,
 
 	kudev->dev = device_create(kpc_uio_class, &pcard->pdev->dev, MKDEV(0, 0), kudev, "%s.%d.%d.%d", kudev->uioinfo.name, pcard->card_num, cte.type, kudev->core_num);
 	if (IS_ERR(kudev->dev)) {
-		dev_err(&pcard->pdev->dev, "probe_core_uio device_create failed!\n");
+		dev_err(&pcard->pdev->dev, "%s: device_create failed!\n",
+			__func__);
 		kfree(kudev);
 		return -ENODEV;
 	}
@@ -335,7 +336,8 @@ static int probe_core_uio(unsigned int core_num, struct kp2000_device *pcard,
 
 	rv = uio_register_device(kudev->dev, &kudev->uioinfo);
 	if (rv) {
-		dev_err(&pcard->pdev->dev, "probe_core_uio failed uio_register_device: %d\n", rv);
+		dev_err(&pcard->pdev->dev, "%s: failed uio_register_device: %d\n",
+			__func__, rv);
 		put_device(kudev->dev);
 		kfree(kudev);
 		return rv;
@@ -410,7 +412,8 @@ static int  kp2000_setup_dma_controller(struct kp2000_device *pcard)
 	return 0;
 
 err_out:
-	dev_err(&pcard->pdev->dev, "kp2000_setup_dma_controller: failed to add a DMA Engine: %d\n", err);
+	dev_err(&pcard->pdev->dev, "%s: failed to add a DMA Engine: %d\n",
+		__func__, err);
 	return err;
 }
 
@@ -423,7 +426,8 @@ int  kp2000_probe_cores(struct kp2000_device *pcard)
 	unsigned int highest_core_id = 0;
 	struct core_table_entry cte;
 
-	dev_dbg(&pcard->pdev->dev, "kp2000_probe_cores(pcard = %p / %d)\n", pcard, pcard->card_num);
+	dev_dbg(&pcard->pdev->dev, "%s(pcard = %p / %d)\n", __func__, pcard,
+		pcard->card_num);
 
 	err = kp2000_setup_dma_controller(pcard);
 	if (err)
@@ -472,8 +476,8 @@ int  kp2000_probe_cores(struct kp2000_device *pcard)
 			}
 			if (err) {
 				dev_err(&pcard->pdev->dev,
-					"kp2000_probe_cores: failed to add core %d: %d\n",
-					i, err);
+					"%s: failed to add core %d: %d\n",
+					__func__, i, err);
 				goto error;
 			}
 			core_num++;
@@ -492,7 +496,8 @@ int  kp2000_probe_cores(struct kp2000_device *pcard)
 	cte.irq_base_num        = 0;
 	err = probe_core_uio(0, pcard, "kpc_uio", cte);
 	if (err) {
-		dev_err(&pcard->pdev->dev, "kp2000_probe_cores: failed to add board_info core: %d\n", err);
+		dev_err(&pcard->pdev->dev, "%s: failed to add board_info core: %d\n",
+			__func__, err);
 		goto error;
 	}
 
-- 
2.20.1

