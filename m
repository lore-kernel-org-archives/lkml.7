Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B335C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A2D21738
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlWxbbm2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfF0RoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:44:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33788 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfF0RoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:44:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so1601120pfq.0;
        Thu, 27 Jun 2019 10:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yLwq/FK/dOd0WnikC6tG24I8Sc4D1+91vUmD4gEKD0I=;
        b=YlWxbbm2+Hf2SJ6wfKGxju7Sl69GcIZyHXX/omiPZeGOTCaRp0LGug6hg1YYHcs1x1
         3Jt4UD5bvVsNkAiG4hluYI00HvlrgQvuJD5Adtr7aC/xq87aEyG2m4AuPzACJl2eKCwG
         KVTuS9ZRsyO0wT66jisniTtXGjzFHs26Un7Gxa4332+CKq+mf3OvETSkCX3bIoSLacyj
         Pb5jrOfA9J+cKHbG+r+YbE/wzEm2GcsCAh2T2RLBSxYBbpELUghvVh48G5FW/6MMwQyP
         6xcDtYmUOnKt6tYbroop6IuQLGqvv/HyQPNP0/AiM3t57wtqMKgD8A0MJQLWuXzoaqFR
         whYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yLwq/FK/dOd0WnikC6tG24I8Sc4D1+91vUmD4gEKD0I=;
        b=MR9ajAAvIT/F7Yh+nv3aV4BeSszXLfAtBULUFCKgRosatNMIa/0L/D6zUbClE5qKna
         9LLDnRprkeFonFvc36ZivctXJxvqcdNFs0+pjrF/Sdh9Vo0+VbMIaizkUERRrxjv17Lt
         JhNXvLnO9KByZ9pf7BX6OV9lihzq08sbmpyNUnBk74v4XUwbGYcG5XjK9IGkTFJBVHd/
         gyXSSN4IHIREdmPBzm/JnOrAP8jTT2gpJGMQnInfGNkBj5ZrUGZqy9TsxECnZhX5mwQN
         bNZkjlkXudKban6Hk/sekMJ+HyaLGSrbFgRpXYbfRCYQi70ITqRg/9QmxP7luHw29ppH
         +uiA==
X-Gm-Message-State: APjAAAWpHtR96/Z1MN2sDkJMay9FcEhwQWGWHxzWcTD3g4hkCkOc2PDR
        TbYRiIhpp6F+txTtHo8cem0=
X-Google-Smtp-Source: APXvYqykh/LdSMFIuQuvdctT4jSIPqOETT8c8vW6CFsLlZvpN88og23JZYQRJHfYEspMZKCYsKCJrw==
X-Received: by 2002:a17:90a:a00d:: with SMTP id q13mr7387601pjp.80.1561657444815;
        Thu, 27 Jun 2019 10:44:04 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 1sm3516603pfe.102.2019.06.27.10.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:44:04 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 58/87] scsi: mvsas: remove memset after dma_alloc_coherent
Date:   Fri, 28 Jun 2019 01:43:53 +0800
Message-Id: <20190627174355.5252-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/scsi/mvsas/mv_init.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index da719b0694dc..f2fae160691d 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -241,19 +241,16 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
 				     &mvi->tx_dma, GFP_KERNEL);
 	if (!mvi->tx)
 		goto err_out;
-	memset(mvi->tx, 0, sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ);
 	mvi->rx_fis = dma_alloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
 					 &mvi->rx_fis_dma, GFP_KERNEL);
 	if (!mvi->rx_fis)
 		goto err_out;
-	memset(mvi->rx_fis, 0, MVS_RX_FISL_SZ);
 
 	mvi->rx = dma_alloc_coherent(mvi->dev,
 				     sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1),
 				     &mvi->rx_dma, GFP_KERNEL);
 	if (!mvi->rx)
 		goto err_out;
-	memset(mvi->rx, 0, sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1));
 	mvi->rx[0] = cpu_to_le32(0xfff);
 	mvi->rx_cons = 0xfff;
 
@@ -262,7 +259,6 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
 				       &mvi->slot_dma, GFP_KERNEL);
 	if (!mvi->slot)
 		goto err_out;
-	memset(mvi->slot, 0, sizeof(*mvi->slot) * slot_nr);
 
 	mvi->bulk_buffer = dma_alloc_coherent(mvi->dev,
 				       TRASH_BUCKET_SIZE,
-- 
2.11.0

