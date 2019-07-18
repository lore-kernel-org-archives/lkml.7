Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEE4C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73F22173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 02:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="IufrID5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389205AbfGRCJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 22:09:28 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33826 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389172AbfGRCJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 22:09:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id l12so20243961oil.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 19:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s3FqD/9ywMtWUkGKcxfI+KWW3y3k4HPd03zVQggO5Ss=;
        b=IufrID5Sr3HYLTvrB1JEBLM4Y244W5hlYc8yTqb10u/IZOq2MPm3BEF5jsUcrgBobz
         fpSjrbbPexHaQFjTG12zIRt/cqwYqyZiq3f0/l021qEYrJHrqEUgNsFAYe2tfhSi5Smi
         /aRxxdNcOForx4r8Rx3LCtx+Q+UPSG1g8Fz+d3Y88agVLBtC1nbRtBpAo4cyCigpY2Ph
         A20KMPQ5nWJnSMZehuxb7VGGrK5raiYn4UweHo+FYtjDCfSxzMqZlSWC2/EOnzKYHHqg
         mal54dB80t2anMd7E9WZ2EPM4IVN6lKbvVsGZTPMO9w8txm1qWuD9+EqiNvgVR11B1Jo
         Uv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s3FqD/9ywMtWUkGKcxfI+KWW3y3k4HPd03zVQggO5Ss=;
        b=GwXkzb7PN+Du+ueVo0NSONkMLLgSVT/lmp+0Boy5Cthn+nkYd9bXL0aXZB99SjYKFV
         SIeun0EhERiQXA4UVh40lI0Ed739TyBDObfrag0oiqaz3WAj4oP/9RWadz0NTmoXBCfK
         L0JoxI8Xrk8bSCVJaZqfSDuxQvoiOL1CewLVn6iNWBr6skmmveP4TO1F1ODN3BliTMI2
         ogd4DBHcOCwUR7va3cUuWe+kH40vhlRiEcObbQ3bk7foxa3zWsspw2IVxYRleMLbRk6r
         VhzZpDWRL2xPcCyTF+MB4F49EVQboPLrNYsvO8LuU4qQJlvWDepagJux2b25+Ih6X7uS
         8YZQ==
X-Gm-Message-State: APjAAAW+KKJyke9CpplJVgJ6dyg8MwqK3JJ31ztzWpz2me8llFGpj76s
        cCcu5+nV/L97wBQXCNgbmVc=
X-Google-Smtp-Source: APXvYqz6tEy6n6Wi0XTil8XV5pjWBp+Ube8SAl5QzppXo9MjeKvfvMGevGGdtTkt2PooVfDdys7CDA==
X-Received: by 2002:a54:4f95:: with SMTP id g21mr21522031oiy.23.1563415766758;
        Wed, 17 Jul 2019 19:09:26 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:18af:e893:6cb0:139a])
        by smtp.gmail.com with ESMTPSA id m21sm9392567otn.12.2019.07.17.19.09.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 19:09:26 -0700 (PDT)
From:   Frederick Lawler <fred@fredlawl.com>
To:     axboe@kernel.dk
Cc:     Frederick Lawler <fred@fredlawl.com>, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: [PATCH] skd: Prefer pcie_capability_read_word()
Date:   Wed, 17 Jul 2019 21:07:45 -0500
Message-Id: <20190718020745.8867-10-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190718020745.8867-1-fred@fredlawl.com>
References: <20190718020745.8867-1-fred@fredlawl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8c0d3a02c130 ("PCI: Add accessors for PCI Express Capability")
added accessors for the PCI Express Capability so that drivers didn't
need to be aware of differences between v1 and v2 of the PCI
Express Capability.

Replace pci_read_config_word() and pci_write_config_word() calls with
pcie_capability_read_word() and pcie_capability_write_word().

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/block/skd_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 7d3ad6c22ee5..996c38d03fc4 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -3137,18 +3137,14 @@ MODULE_DEVICE_TABLE(pci, skd_pci_tbl);
 
 static char *skd_pci_info(struct skd_device *skdev, char *str)
 {
-	int pcie_reg;
-
 	strcpy(str, "PCIe (");
-	pcie_reg = pci_find_capability(skdev->pdev, PCI_CAP_ID_EXP);
 
-	if (pcie_reg) {
+	if (pci_is_pcie(skdev->pdev)) {
 
 		char lwstr[6];
 		uint16_t pcie_lstat, lspeed, lwidth;
 
-		pcie_reg += 0x12;
-		pci_read_config_word(skdev->pdev, pcie_reg, &pcie_lstat);
+		pcie_capability_read_word(skdev->pdev, 0x12, &pcie_lstat);
 		lspeed = pcie_lstat & (0xF);
 		lwidth = (pcie_lstat & 0x3F0) >> 4;
 
-- 
2.17.1

