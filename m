Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9F3C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F77721926
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uolqLFiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfGXNRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:17:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42632 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfGXNRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:17:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so20944627pff.9;
        Wed, 24 Jul 2019 06:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ynlMYwwbUrHc4SOrISDzcpXFXjwRYIJ/NcSOEUlhS+4=;
        b=uolqLFiJouhYH33CRrKgT+//sVZzPIrfc59iUU6EgZhr00v4l0ptOaDu0hPc/o53ar
         JZj8TTCyFEPxSh4IbMhxTQPCNR9ipqji3s6auZzfK791eBXTBiBs3gguqcYHBBozrHiO
         W/HqJYp5H/1iQycbJ1Wpy0ZgNnFmvHyspQOT2z8E2W6ViulHCH/ANPwCvlwVuqWzgp1v
         zDAOQuScR4t07QwfXSmBD4F/lUQexdNp9KWNKzwmbYXIDOhu57YXEtttk1lxL4c/RXq2
         NUInL4ZGIogVQqnGOmM6Ly/AxqhqdA0RrNWOdXUgUEE8QKXW5AwBQ7m8tC26h6QogKTy
         GkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ynlMYwwbUrHc4SOrISDzcpXFXjwRYIJ/NcSOEUlhS+4=;
        b=YUV7a+LqwrHSmLbFTdLVLpyb/1CBJQ9g3JimJWND6YghInlhuBenraz2IOPSSBlRIh
         t64MNcRB3uYT8/ZKo0e/rp1eX07DSf/Dq9iaTK3nhAQxev4AGRgbOYHdIy4HKTtbbNbS
         aX8b1LvFjGKXWkUh7McyDlyJpWLmXAM3Hz8ZFVROFZytN7+0ZLMKwKbh64JxwmFdAKCR
         gSIkmwCuGo/8Pgi73QVyZYCLjSr0mj1Kpi4XCstXBR2tAKQl4W8jmzshvPIUAPo+o4OF
         iLBshK5QDZSiVWfDFbxaW9ooti0RMDRyOGAaiJnMXxPEpJLQgQNEMtnOIZckbOLXN8Pm
         j9Pg==
X-Gm-Message-State: APjAAAXOrcovfnymutJHIWF6HSd5xJNa0HbT7nIV81D57vSZ36XoUysy
        uwTd52ViFBCZDxMnPX0siFw=
X-Google-Smtp-Source: APXvYqxe+3Q32Rp5kuQ5S3t50hpt5vPn7SU/JGnCM+q6dfXdaWCHHt6DzrAraogN/MLgkzva0xgd5A==
X-Received: by 2002:a63:8a43:: with SMTP id y64mr80625585pgd.104.1563974270480;
        Wed, 24 Jul 2019 06:17:50 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id 143sm67567613pgc.6.2019.07.24.06.17.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 06:17:49 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] fbdev: sm712fb: Use dev_get_drvdata
Date:   Wed, 24 Jul 2019 21:17:44 +0800
Message-Id: <20190724131744.1709-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/video/fbdev/sm712fb.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 7b1b0d8d27a7..207d0add684b 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1694,10 +1694,8 @@ static void smtcfb_pci_remove(struct pci_dev *pdev)
 
 static int __maybe_unused smtcfb_pci_suspend(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct smtcfb_info *sfb;
+	struct smtcfb_info *sfb = dev_get_drvdata(device);
 
-	sfb = pci_get_drvdata(pdev);
 
 	/* set the hw in sleep mode use external clock and self memory refresh
 	 * so that we can turn off internal PLLs later on
@@ -1717,10 +1715,8 @@ static int __maybe_unused smtcfb_pci_suspend(struct device *device)
 
 static int __maybe_unused smtcfb_pci_resume(struct device *device)
 {
-	struct pci_dev *pdev = to_pci_dev(device);
-	struct smtcfb_info *sfb;
+	struct smtcfb_info *sfb = dev_get_drvdata(device);
 
-	sfb = pci_get_drvdata(pdev);
 
 	/* reinit hardware */
 	sm7xx_init_hw();
-- 
2.20.1

