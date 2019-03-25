Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FED5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317F3206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Dv55CJ8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbfCYWy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:54:58 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:44934 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbfCYWy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:54:58 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id BFBAF7CB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 22:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hosv6PXdkddI for <linux-kernel@vger.kernel.org>;
        Mon, 25 Mar 2019 17:54:56 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 8C08A9B0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:54:56 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id z131so10246936itb.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rTbn3Xj/HCow5qMRGfdyIR+VPuFDRM1tAPDvRBOHTIA=;
        b=Dv55CJ8Gz8kDe3wQoEF8MgOJQR7I4eX9aFQp2iBJSChXTs1WqTz96W1duTJH32BnI+
         HHH2cZk6v3NyXZe4gT5woqsHgq5gy3YPC7QIZWK/nSo4JVlCWKt/AcBKhRpextNI5m3Q
         3OWa0/Qhu13wd13YARXIlcKqLXHnEqZAYe8ZQg6Rzq6My7aQ9QeWURZDCCXxNC7BsAgR
         O0vTQVS7oKwdlp6TYCIEX6lPIHfds9uzpQGrEeekC6UkKFU56hpr2XpSeTKOiYikdXD9
         NOOfEW8tknerdQfcebDhv3Du6yxRVPvXnkU/6sw4ChmkYOXa2Wk0i03zsVRmbElvgykr
         5kvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rTbn3Xj/HCow5qMRGfdyIR+VPuFDRM1tAPDvRBOHTIA=;
        b=JugnHdyA2nHtUU6qLzldVDPbhbGCAj2i4ZDvgXdLGpeYVrOid5D4jMcrtax336Kavj
         c+TRKjahXXitr/UI0AHOUxWExsjC6l6lfQl2soffDVKw4I0N0KMmOm4IIBEz1+62Waje
         y5ovE/jsonPl+22FHIEj7r4PdZ+4Mpp/EvRpZoVB1E44Ng2uoA4q76u8AORMu5UUBBcG
         neaEHoczJZmsBRPrqGJSSmc3dSAS6uk9VRHQ0r3A/wGIh1AubW0cPiIQSdhGp/xS5JdI
         FRH7K1DIscJhCC6hkPr/6n3lEAFw9xnAkmgkluQz8VMjafdsOe4ks4Nqi4jNxdVl8v/l
         /0Jg==
X-Gm-Message-State: APjAAAUWeFkBte+aU1zD7xi/xNanxz6NIEPcJIRouZQhCnN3wgSWZKWs
        q3aced+XEhLYHuh3xxACUT51T+lpItn2K17FBQMgqPgFt0OnI0YCxVfvfbdbrxhZnkQOkDWAq+X
        gtBg+8qBY3c2kYZG34bp3OJ8vl2E+
X-Received: by 2002:a24:ac5d:: with SMTP id m29mr1230983iti.139.1553554496192;
        Mon, 25 Mar 2019 15:54:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxpyMGtqDzCJVqW0DOOZ7prf93YaFKEBQF+cNgd9ZdY0yg6V9e21MxWf2WRsbFrBKFXMtMucg==
X-Received: by 2002:a24:ac5d:: with SMTP id m29mr1230967iti.139.1553554495979;
        Mon, 25 Mar 2019 15:54:55 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id 133sm6471074itl.13.2019.03.25.15.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 15:54:55 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ata: dwc_460ex: Avoid potential NULL pointer dereference
Date:   Mon, 25 Mar 2019 17:54:53 -0500
Message-Id: <20190325225453.14276-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_async_tx_descriptor can contain a NULL variable and using
it in dmaengine_submit without checking can crash the process.
This patch avoids such a scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v1: Return error in case of failure to desc variable to avoid hang up.
---
 drivers/ata/sata_dwc_460ex.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 6f142aa54f5f..63d922c624a4 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -185,7 +185,7 @@ enum {
 /*
  * Prototypes
  */
-static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag);
+static int sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag);
 static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc,
 				u32 check_status);
 static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32 check_status);
@@ -512,7 +512,7 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 	u8 status, tag;
-	int handled, num_processed, port = 0;
+	int handled, num_processed, ret, port = 0;
 	uint intpr, sactive, sactive2, tag_mask;
 	struct sata_dwc_device_port *hsdevp;
 	hsdev->sactive_issued = 0;
@@ -553,10 +553,11 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 		 * be completed.
 		 */
 		qc->ap->link.active_tag = tag;
-		sata_dwc_bmdma_start_by_tag(qc, tag);
-
-		handled = 1;
-		goto DONE;
+		ret = sata_dwc_bmdma_start_by_tag(qc, tag);
+		if (!ret) {
+			handled = 1;
+			goto DONE;
+		}
 	}
 	sata_dwc_scr_read(&ap->link, SCR_ACTIVE, &sactive);
 	tag_mask = (hsdev->sactive_issued | sactive) ^ sactive;
@@ -1008,7 +1009,7 @@ static void sata_dwc_bmdma_setup(struct ata_queued_cmd *qc)
 	sata_dwc_bmdma_setup_by_tag(qc, tag);
 }
 
-static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
+static int sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
 {
 	int start_dma;
 	u32 reg;
@@ -1018,6 +1019,9 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
 	struct dma_async_tx_descriptor *desc = hsdevp->desc[tag];
 	int dir = qc->dma_dir;
 
+	if (!desc)
+		return -ENOMEM;
+
 	if (hsdevp->cmd_issued[tag] != SATA_DWC_CMD_ISSUED_NOT) {
 		start_dma = 1;
 		if (dir == DMA_TO_DEVICE)
@@ -1055,9 +1059,10 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
 		dmaengine_submit(desc);
 		dma_async_issue_pending(hsdevp->chan);
 	}
+	return 0;
 }
 
-static void sata_dwc_bmdma_start(struct ata_queued_cmd *qc)
+static int sata_dwc_bmdma_start(struct ata_queued_cmd *qc)
 {
 	u8 tag = qc->hw_tag;
 
@@ -1068,7 +1073,7 @@ static void sata_dwc_bmdma_start(struct ata_queued_cmd *qc)
 		tag = 0;
 	}
 	dev_dbg(qc->ap->dev, "%s\n", __func__);
-	sata_dwc_bmdma_start_by_tag(qc, tag);
+	return sata_dwc_bmdma_start_by_tag(qc, tag);
 }
 
 static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
-- 
2.17.1

