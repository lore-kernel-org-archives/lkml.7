Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75917C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CAB206DB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWG861A9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfLEQGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:06:03 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35590 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEQGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 11:06:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so1816374pgk.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 08:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6PMJBYfi+MFp/WSvHu4BfyahFpipNVPZufGnFKeqIJ0=;
        b=tWG861A95IR3KeLoJ6ISGMqpRFRsh+4kT2VrWLWzl7Z87KPc1QPKQydDDWnSrRYZCh
         98ruGK7Ln4YEDX2o3QzH8tjwycJs/rpN3Ba9PUBkgha2L6fVKtBSY88bp3YAfYd321wa
         EkhPxuD0s9yf2KqZ7VS4OHxXY1hZlUGbZu6fbgxwe+NhY/KVTVX/XDy8vTd5f8/0UuXF
         ytK6mTGvGCHCvcomGFrPVGmvskm2bjqD+FE3R/2TOfLLcma/DQmcXtwdyxdfhxSe3/Yr
         j4oMkRfFLtFYa4ndDkNb2iyqP6vRg+07t0wN0axy17FX+jc2rMgPHXsYxjX6n4L0cMmO
         a9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6PMJBYfi+MFp/WSvHu4BfyahFpipNVPZufGnFKeqIJ0=;
        b=noB1T8otJptuv3E58UG84Og/j4TzBj65pIPeTX4oNH+goF5b5DqUXGmdZsvLF1Ltnc
         fxuF4e7iyhLbzqcCurNHRQxL5uyKNphJ9K4vOOQM9fMQAoZcRStRXxEvvrUUmB1c/i3y
         Q+Ul/nnN5gPeqYL4Ndvx3k+23/2uaucJDpwiHSqicdsAoC2XG1LlLd4NGlSnwg2gx9Ih
         484qIUYrK7dK7RQEqu5TraUX5aXQBZ1LItbZ8pEgN6WKiNaZ0D0jx4EPlZHMQZ7dFZYm
         fdKT7HeMiqZnTAtKCdsVns+c0XV1KvUV/WTrTUySiRtPrwgvffiwV3ybJ9tccFcc1fy+
         BLUg==
X-Gm-Message-State: APjAAAXIIw1gVDy9L75lbuFKdGlv+uPhT93cwDjlE7hOMay57tVAL+2D
        qTqQ4L6Q8DGtSsT1moawLhM=
X-Google-Smtp-Source: APXvYqxzdS58SMRlt6k6OGl7KkMGZipy6JXtsliTFArXfcsEg+83ZQ4FS7MlTuDr4hKhrCvdFdUFtA==
X-Received: by 2002:a63:d306:: with SMTP id b6mr9840885pgg.195.1575561962114;
        Thu, 05 Dec 2019 08:06:02 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id i3sm12294316pfg.94.2019.12.05.08.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 08:06:01 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH resend] mfd: sm501: fix mismatches of request_mem_region
Date:   Fri,  6 Dec 2019 00:05:53 +0800
Message-Id: <20191205160553.32011-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver misuses release_resource + kfree to match request_mem_region,
which is incorrect.
The right way is to use release_mem_region.
Replace the mismatched calls with the right ones to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/mfd/sm501.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 154270f8d8d7..e49787e6bb93 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1086,8 +1086,7 @@ static int sm501_register_gpio(struct sm501_devdata *sm)
 	iounmap(gpio->regs);
 
  err_claimed:
-	release_resource(gpio->regs_res);
-	kfree(gpio->regs_res);
+	release_mem_region(iobase, 0x20);
 
 	return ret;
 }
@@ -1095,6 +1094,7 @@ static int sm501_register_gpio(struct sm501_devdata *sm)
 static void sm501_gpio_remove(struct sm501_devdata *sm)
 {
 	struct sm501_gpio *gpio = &sm->gpio;
+	resource_size_t iobase = sm->io_res->start + SM501_GPIO;
 
 	if (!sm->gpio.registered)
 		return;
@@ -1103,8 +1103,7 @@ static void sm501_gpio_remove(struct sm501_devdata *sm)
 	gpiochip_remove(&gpio->high.gpio);
 
 	iounmap(gpio->regs);
-	release_resource(gpio->regs_res);
-	kfree(gpio->regs_res);
+	release_mem_region(iobase, 0x20);
 }
 
 static inline int sm501_gpio_isregistered(struct sm501_devdata *sm)
@@ -1427,8 +1426,7 @@ static int sm501_plat_probe(struct platform_device *dev)
 	return sm501_init_dev(sm);
 
  err_claim:
-	release_resource(sm->regs_claim);
-	kfree(sm->regs_claim);
+	release_mem_region(sm->io_res->start, 0x100);
  err_res:
 	kfree(sm);
  err1:
@@ -1637,8 +1635,7 @@ static int sm501_pci_probe(struct pci_dev *dev,
 	return 0;
 
  err4:
-	release_resource(sm->regs_claim);
-	kfree(sm->regs_claim);
+	release_mem_region(sm->io_res->start, 0x100);
  err3:
 	pci_disable_device(dev);
  err2:
@@ -1673,8 +1670,7 @@ static void sm501_pci_remove(struct pci_dev *dev)
 	sm501_dev_remove(sm);
 	iounmap(sm->regs);
 
-	release_resource(sm->regs_claim);
-	kfree(sm->regs_claim);
+	release_mem_region(sm->io_res->start, 0x100);
 
 	pci_disable_device(dev);
 }
@@ -1686,8 +1682,7 @@ static int sm501_plat_remove(struct platform_device *dev)
 	sm501_dev_remove(sm);
 	iounmap(sm->regs);
 
-	release_resource(sm->regs_claim);
-	kfree(sm->regs_claim);
+	release_mem_region(sm->io_res->start, 0x100);
 
 	return 0;
 }
-- 
2.24.0

