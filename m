Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6DEC742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 23:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6005208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 23:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhwebymS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfGKXso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 19:48:44 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45536 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbfGKXso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 19:48:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id x22so1411264qtp.12;
        Thu, 11 Jul 2019 16:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j14GQzrD4oSijzpopT5rfc1BSXQi49Lm8QoGCpYkFwM=;
        b=QhwebymSsYreNq4Cd+ekVWxhtXre7tVlRMfVJGHsvgZE2F/4JU2dp4e4WQtmbq01nj
         XzknUQDtdD4FrsFuFwd3EMGTjBKOC4z45NpIzLDYEY8SpMD9llZ62FK1DM7PW+/Q/OmX
         j1eRQGI788kLcRxL6Y/yN6RU/J4vmr8bgpRTawIwkeFYuBhgMremhW1FtWBIZRYfX2cg
         xD0D/y1IGQSccW3n/DAhfz7mZYERFV09MOV0oCWm6q1xlGbr21zz0x+ivJcZXIuOO+Rj
         bq8lHyL/j+ldbWmV0+cCGlzSch2ICCzA3UgZ0PyxDfyXDnCTcukDUryo3sp5cHXJIlUj
         lc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j14GQzrD4oSijzpopT5rfc1BSXQi49Lm8QoGCpYkFwM=;
        b=j/MpeXU3ebC48XAzM9MxYuXp7qvQqvrR4JehcEbRjB2lfENTgVVfumk4J30WLkJXRT
         fxQj3ALf3/dWAedm81WJ32TcUh2Op9Bai4pHFUuhLVLk45Lk1jCP6QgJKxvWojAcanV0
         fZtE2c9EWMtXqIc6+4hi9eGiKYGVr8O+7q48TdTFjPZR78teUNvOVgB/r7anIxuXjsSe
         SoMMogiN3Ngg3A/cD4MVy9XwP1skJbqcAVJido10jINYBSPKWdOLx9uPuaaG4nknIqsB
         iRlJfUFw+1ymuzAyIQX0XN8UePqlNfcOdPRSm8TAq7quoniisbM/Vpe+5fpKwVG4lUat
         ZZvQ==
X-Gm-Message-State: APjAAAWFX9HEXnbYmiipOT2hwDNWHQfhT+Ri9W/IvbVRvs3P/fC5T8O7
        ykfIFGtiIqnOaU4ClROnhQ==
X-Google-Smtp-Source: APXvYqxYj0IIpLEdyIrtoCH4en4GeHH53ZzMWL5qkRyNdlxU/lMLtOAX0LrvV+fUGnelC0aPD8Vn8A==
X-Received: by 2002:aed:2063:: with SMTP id 90mr3906973qta.307.1562888923405;
        Thu, 11 Jul 2019 16:48:43 -0700 (PDT)
Received: from localhost.localdomain (modemcable148.230-83-70.mc.videotron.ca. [70.83.230.148])
        by smtp.googlemail.com with ESMTPSA id n5sm3359957qta.29.2019.07.11.16.48.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 16:48:42 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
Cc:     iamkeyur96@gmail.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aha1740: Use !x in place of NULL comparisons
Date:   Thu, 11 Jul 2019 19:48:33 -0400
Message-Id: <20190711234833.27475-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change (x == NULL) to !x and (x != NULL) to x, to fix
following checkpatch.pl warnings:
CHECK: Comparison to NULL could be written "!x".

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
 drivers/scsi/aha1740.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aha1740.c b/drivers/scsi/aha1740.c
index da4150c17781..ec81b7be0a60 100644
--- a/drivers/scsi/aha1740.c
+++ b/drivers/scsi/aha1740.c
@@ -385,7 +385,7 @@ static int aha1740_queuecommand_lck(struct scsi_cmnd * SCpnt,
 	SCpnt->host_scribble = dma_alloc_coherent (&host->edev->dev,
 						   sizeof (struct aha1740_sg),
 						   &sg_dma, GFP_ATOMIC);
-	if(SCpnt->host_scribble == NULL) {
+	if (!(SCpnt->host_scribble)) {
 		printk(KERN_WARNING "aha1740: out of memory in queuecommand!\n");
 		return 1;
 	}
@@ -576,7 +576,7 @@ static int aha1740_probe (struct device *dev)
 	       translation ? "en" : "dis");
 	shpnt = scsi_host_alloc(&aha1740_template,
 			      sizeof(struct aha1740_hostdata));
-	if(shpnt == NULL)
+	if (!shpnt)
 		goto err_release_region;
 
 	shpnt->base = 0;
-- 
2.22.0

