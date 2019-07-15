Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5B7C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D1F214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgn+MjbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfGODSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 23:18:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33540 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfGODSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 23:18:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so6745826pfq.0;
        Sun, 14 Jul 2019 20:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H/7gtO6yAtm6xFL2cscvQSgUmzdc7tC2HnfEMXV/YyM=;
        b=hgn+MjbW6pNToyTKhz/eCffftAp1rR+duFKQ3fhgUOCXYVcJqfOPliyonw3sn0wlPy
         O8GB1VWq6GNtjVBMfa52WZqtoPAw2vhcUviajJUOeA1GHd/VEdn1E42sHzOkY/i96oOh
         ueu1SLDUhHmBZg6BBUuLdtOaDErgWVXhHA5+CGCXWskYS6Ob01g3ML68j3Vd8AT2ALf4
         SHRNe6Gp2XwVNPPXnD/kblNsg0O9Rp95v1F3Pd/lFVCWq751YuPICsMpP0a73vSspMCJ
         +Kri0hOVysQwbRcdpAVrvcOEJZvHMP5wNZ7wAbF1yynuM6wiNIQCT07+MW2KAdCeTuYG
         zotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H/7gtO6yAtm6xFL2cscvQSgUmzdc7tC2HnfEMXV/YyM=;
        b=qNXpX5/sOiKaWvv18g6QGB6Gw0TkJmj6nTwLY82e9vdYvEdBvv4OLf/ZCWTR5ZzvRq
         V4qdnfBkYvl/JBA488rflFj0vw9J9tTJa0pmMcm9OCFFQ11igmmldtx1lwh1lCXkhWZL
         UCqvbjjdqJuWcxehnsLaa0T9LYrvpZZd0XPWhr0dfPrDNKQGE9J32FYoZKtfO+iw2JHV
         E8j4bXqoy3k+cANJwRmYT+F5CpPeZ0vOLOpXyVx9OVV9AjVWiiYNg2qr2Sa9LQaQHiCs
         C7cPL8jHr5MXoTdLWWDdqrHEgLqNQfIFuk25Gj8ZmMGYwbwOoFV8oo18+HfQXiEzaVQS
         oSiw==
X-Gm-Message-State: APjAAAWfCdwUeAsRiUZUz1mgZEUZZWkJBX5bkOYMy7H4J83yVfHev2Lr
        CL7pcP3SFULm45ZXpM4gL7YskPbzMOE=
X-Google-Smtp-Source: APXvYqx0XLKSZyJmsL/e1acT/CrEW7Mis0sk0gQE1cx7M9YJ6frtTl1veqDl01WUmiF4WYUctq4Gcg==
X-Received: by 2002:a63:181:: with SMTP id 123mr25145338pgb.63.1563160730158;
        Sun, 14 Jul 2019 20:18:50 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 124sm16878956pfw.142.2019.07.14.20.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 20:18:49 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 14/24] media: ngene: Remove call to memset after pci_alloc_consistent
Date:   Mon, 15 Jul 2019 11:18:44 +0800
Message-Id: <20190715031844.6844-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_alloc_consistent calls dma_alloc_coherent directly.
In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/media/pci/ngene/ngene-core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/media/pci/ngene/ngene-core.c b/drivers/media/pci/ngene/ngene-core.c
index b75ab7d29226..af15ca1c501b 100644
--- a/drivers/media/pci/ngene/ngene-core.c
+++ b/drivers/media/pci/ngene/ngene-core.c
@@ -854,8 +854,6 @@ static int create_ring_buffer(struct pci_dev *pci_dev,
 	if (!Head)
 		return -ENOMEM;
 
-	memset(Head, 0, MemSize);
-
 	PARingBufferCur = PARingBufferHead;
 	Cur = Head;
 
@@ -907,8 +905,6 @@ static int AllocateRingBuffers(struct pci_dev *pci_dev,
 	if (SCListMem == NULL)
 		return -ENOMEM;
 
-	memset(SCListMem, 0, SCListMemSize);
-
 	pRingBuffer->SCListMem = SCListMem;
 	pRingBuffer->PASCListMem = PASCListMem;
 	pRingBuffer->SCListMemSize = SCListMemSize;
-- 
2.11.0

