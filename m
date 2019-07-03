Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46F9C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7692187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYr3n8ck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfGCQac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:30:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40185 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCQab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:30:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so1529780pfp.7;
        Wed, 03 Jul 2019 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Gkn3vtw/wKbiE9yDLNxFjk7ZvpNBqpkx3Gx9EfielCI=;
        b=rYr3n8ckCCzYVUXCL/A/uAB08qfjJ3q8sWPmBaZ7L8mjcTkkF7CEttydEnNjLmmJey
         JNqD+ktv97HFpLXtH/3YY+jIxwKAocicJaUO+j/iTAvM65cgBX/zXT8oEWXfC/+hw4I8
         yDoiHEZ7RO/oDuwRsirPqQ+6vPlhR73LmeND8hCYLPIrAd/lzmie8OzR8HftMtOeXU88
         QHCE3g0fMiVOCVTgtPPdQY8A34C95zSxiI27lZ38mWnoMjw+46KOwQ8mO1fMwLJY5f3D
         f8HidmLiwRlkerfali1Baq3zwa1LJbgbSz9YIUnoDPcm4hrPvQaPlccFIpZE/UKJnxs4
         8Dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Gkn3vtw/wKbiE9yDLNxFjk7ZvpNBqpkx3Gx9EfielCI=;
        b=eib7x0DeXn+4PR849AVwLAQVEZWPYLnhU6ncwUp+jJ/vrfKnl4bPoEhjuZ8srtnfXv
         uoALXuvDqjZNmHETb9gj2V2F7aNzPvrOUxRE45NXdEkvOcsqLdUW9LrA3gItGWYx5YK7
         g/3NDvkMkQncqZDzmtrC+RQac42RqopgTtWmk0SVBJmQQfFcpctwfDHgC59lU7WdE+cf
         iVsEq9QENTUtGEAxdVDErQk+ePbX0wcVNZM7xl2Oeo1ZrNnBtNc4LwfpJ980oRcCU/Q1
         9Ho68iJ/y041J2fzcOVxb40/747qED/GcmOJobvmpOfZwWo8wi+50QI9f0dh+Y4GXjEj
         W9uw==
X-Gm-Message-State: APjAAAUuHujp/Lu7NYNBwt6d8FZVKV06dl/Y0x3jMuwzZ4kuEbDMLjP4
        PQrL61zDuP8wz9BmrMQ2M10=
X-Google-Smtp-Source: APXvYqwBdaYbRrBZNq9aGvyXxWn685mLA5szS7/gJwXYCmLMYW8+B7/LgoRYY5Zoaz9S6SLvgtUf+w==
X-Received: by 2002:a63:a35c:: with SMTP id v28mr23334581pgn.144.1562171431084;
        Wed, 03 Jul 2019 09:30:31 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id b19sm2959684pgh.57.2019.07.03.09.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:30:30 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Hannes Reinecke <hare@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 23/35] scsi: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:30:22 +0800
Message-Id: <20190703163022.410-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)

 drivers/scsi/myrb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index 539ac8ce4fcd..5e6b5e7ae93a 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -1658,14 +1658,12 @@ static int myrb_ldev_slave_alloc(struct scsi_device *sdev)
 	if (!ldev_info)
 		return -ENXIO;
 
-	sdev->hostdata = kzalloc(sizeof(*ldev_info), GFP_KERNEL);
+	sdev->hostdata = kmemdup(ldev_info, sizeof(*ldev_info), GFP_KERNEL);
 	if (!sdev->hostdata)
 		return -ENOMEM;
 	dev_dbg(&sdev->sdev_gendev,
 		"slave alloc ldev %d state %x\n",
 		ldev_num, ldev_info->state);
-	memcpy(sdev->hostdata, ldev_info,
-	       sizeof(*ldev_info));
 	switch (ldev_info->raid_level) {
 	case MYRB_RAID_LEVEL0:
 		level = RAID_LEVEL_LINEAR;
-- 
2.11.0

