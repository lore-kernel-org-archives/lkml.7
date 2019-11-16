Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4ABC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051FC20723
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="troAVNLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfKPPNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:13:18 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37048 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbfKPPNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:13:18 -0500
Received: by mail-pl1-f196.google.com with SMTP id bb5so6790115plb.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 07:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6PMJBYfi+MFp/WSvHu4BfyahFpipNVPZufGnFKeqIJ0=;
        b=troAVNLK6jEpIWZCG31iWcNneowSZP0cl6OebHj0JDxZyjWmWvJrnCD4y+4LDk6HIg
         JUkDYVpeyxRMLnaRyOBmPzi02eHSAEnbII9uc2FtlDlYO0oFPn3zCY38+bVwSrObWvxN
         8x9R3H9THYKecHilAD//kkSqBIyS0icejEGsPy/uvB93hUAZnBoxO9capZjsOLdFVWJt
         16CV8EKLgiTrgdciHsGbQJlK6vesQyeeBK0u2ruR5mN9ARlUsq5sheUuebMS9AGTYyr+
         I2aRedqen49msIgAHWovC7RauzbZCV31AuSzGPrxbkD3IjrCjOyO2gMsksdpfq5CbIXy
         ceDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6PMJBYfi+MFp/WSvHu4BfyahFpipNVPZufGnFKeqIJ0=;
        b=S6buf2aTjgzUr1qaDU0B540t1vcF9PcEXFSk2j0o5WYOO6Jbzji5Z1wOrB6YKgzwJ0
         7Kdq6fn2YJy4CuO1FwwOxBvDnChAQvNPlqN+PPFHkyakUzMiHb/wkQo/297xqI6x4oik
         KNIRHd2qfZKV2UJ/Q6kPFjD+viay5jL3ZajRgiTkosorShsj9CEc4gyX2/5E3ZzxNOWK
         7oXKeiBHm/kHYSA4cqH0cjY+W3ThEmLwYKhgsBbWd+ZrHmlvOWCElecf3xUIgIp5cyl4
         MIfc+Rlhees/AJdElAy7jNKQ/6FJedsqCzkN6edkemILv2O1RaNTg/SsrVEdSzHSzhfF
         T8+g==
X-Gm-Message-State: APjAAAUDI6fcq+JBs2JdUQimvsce6Q+9CgKIQ6KjGlYc8xLbPg1Qd7bi
        pjDigEllNlC6VDY7Dp8tYo0=
X-Google-Smtp-Source: APXvYqznBQaKrsVLxYJyPZ3nDd2vWoExdvM61/5Tqtxu67JOFUswDLJf/Mou9v1M9tqU6Jfq/+pspQ==
X-Received: by 2002:a17:902:be14:: with SMTP id r20mr20084700pls.297.1573917197619;
        Sat, 16 Nov 2019 07:13:17 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id k24sm16187937pfk.63.2019.11.16.07.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 07:13:16 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] mfd: sm501: fix mismatches of request_mem_region
Date:   Sat, 16 Nov 2019 23:13:08 +0800
Message-Id: <20191116151308.17817-1-hslester96@gmail.com>
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

