Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D67C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586F2216C8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ss6TJ6TD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfGBH45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:56:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33925 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfGBH45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:56:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so7860339pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Scn9fsW2BFpvwRQwjAqa1V7vmRu1XV/6QLq/1pbOzlQ=;
        b=ss6TJ6TDvbzLzyiRQnMO+JtkHw3+IPLkYCb+OeMrQvboEKQhFnCewYVPlqIjxEkIrI
         qtfz7QWPlpXT7QCcjJeuIwi5yoVvtsnbhgo77jn09y/Jd8VDd+7fiV7xftiFZf5UVoZ4
         Dzy5TxuysmV54BN0vQKRvlotbj0/fOPCAxCTqebr8hlLX8ZNHuqwrJmw8g1KpCnER2+K
         E6GbJcaWgKGvF9goxK5lBtYkZab8y9ew9F0ffHwk11bizYhLJxz6LiptaMnssWDvC5+J
         zkL3yfRuG3fw1T2Zz9is5rrDPN3YdYA311l0A308wq6FTbdl6A1g91OJ5YekncNSHM7U
         q2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Scn9fsW2BFpvwRQwjAqa1V7vmRu1XV/6QLq/1pbOzlQ=;
        b=kbrFNK696swtMPqhklyzWQSL6cBcEdL0hqLBRaaFANbhmb524gKgrKQMgV4fFySHTT
         FkVgJCQKG0/vpazU70uRSIVDmQe38v3BuifCKZFzBQPxAsl9IKUWQ3GKpccviHorEhZX
         bHDteu5p1Rm5y05S9OtTJkQEkclIayIY4BXlObAakvLXBP5KU/b5Hw2M88QemFoD8V0N
         wteC9/3wRCnqz9rzMOBwdIHK2z28MyZbYV7zeCMFPytRwZkj/X1XJUGo8bwu1sRSTR8F
         +q/6edNPSBsLgDWppr/lrXzDgEGUjjuLQHj3XcWzscAB021VdXXHaAfVaIwMS75dLsWD
         jGUw==
X-Gm-Message-State: APjAAAWsn5cyfKTFSbiOiQ/F/O0zO9z5zOTa3ORJlo4s57OONLJNCe0c
        3z3R7PYps10OsbhawS273k6iXj4MOp0=
X-Google-Smtp-Source: APXvYqyHHn6SbxL0yO9uJHBI1YmUYBYThhil4GhEdfuCNx5qg/wS0PLSxEigMIagBcOr3y0bQ7MUGg==
X-Received: by 2002:a17:90a:2224:: with SMTP id c33mr4098431pje.22.1562054216600;
        Tue, 02 Jul 2019 00:56:56 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id m16sm14803705pfd.127.2019.07.02.00.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:56:56 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 02/27] ata: Remove memset after dma_alloc_coherent/dmam_alloc_coherent
Date:   Tue,  2 Jul 2019 15:56:50 +0800
Message-Id: <20190702075650.23602-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent/dmam_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/ata/acard-ahci.c | 1 -
 drivers/ata/libahci.c    | 1 -
 drivers/ata/pdc_adma.c   | 1 -
 drivers/ata/sata_nv.c    | 2 --
 drivers/ata/sata_qstor.c | 1 -
 drivers/ata/sata_sil24.c | 1 -
 6 files changed, 7 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index b1b49dbd0b14..85357f27a66b 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -344,7 +344,6 @@ static int acard_ahci_port_start(struct ata_port *ap)
 	mem = dmam_alloc_coherent(dev, dma_sz, &mem_dma, GFP_KERNEL);
 	if (!mem)
 		return -ENOMEM;
-	memset(mem, 0, dma_sz);
 
 	/*
 	 * First item in chunk of DMA memory: 32-slot command table,
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 0984c4b76d7e..e4c45d3cca79 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2365,7 +2365,6 @@ static int ahci_port_start(struct ata_port *ap)
 	mem = dmam_alloc_coherent(dev, dma_sz, &mem_dma, GFP_KERNEL);
 	if (!mem)
 		return -ENOMEM;
-	memset(mem, 0, dma_sz);
 
 	/*
 	 * First item in chunk of DMA memory: 32-slot command table,
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 52fa8606a25f..c5bbb07aa7d9 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -550,7 +550,6 @@ static int adma_port_start(struct ata_port *ap)
 						(u32)pp->pkt_dma);
 		return -ENOMEM;
 	}
-	memset(pp->pkt, 0, ADMA_PKT_BYTES);
 	ap->private_data = pp;
 	adma_reinit_engine(ap);
 	return 0;
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 54bfab15c74a..b44b4b64354c 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1136,7 +1136,6 @@ static int nv_adma_port_start(struct ata_port *ap)
 				  &mem_dma, GFP_KERNEL);
 	if (!mem)
 		return -ENOMEM;
-	memset(mem, 0, NV_ADMA_PORT_PRIV_DMA_SZ);
 
 	/*
 	 * First item in chunk of DMA memory:
@@ -1946,7 +1945,6 @@ static int nv_swncq_port_start(struct ata_port *ap)
 				      &pp->prd_dma, GFP_KERNEL);
 	if (!pp->prd)
 		return -ENOMEM;
-	memset(pp->prd, 0, ATA_PRD_TBL_SZ * ATA_MAX_QUEUE);
 
 	ap->private_data = pp;
 	pp->sactive_block = ap->ioaddr.scr_addr + 4 * SCR_ACTIVE;
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 7ec0c216a6a6..865e5c58bd94 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -477,7 +477,6 @@ static int qs_port_start(struct ata_port *ap)
 				      GFP_KERNEL);
 	if (!pp->pkt)
 		return -ENOMEM;
-	memset(pp->pkt, 0, QS_PKT_BYTES);
 	ap->private_data = pp;
 
 	qs_enter_reg_mode(ap);
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index bfdf41912588..98aad8206921 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -1202,7 +1202,6 @@ static int sil24_port_start(struct ata_port *ap)
 	cb = dmam_alloc_coherent(dev, cb_size, &cb_dma, GFP_KERNEL);
 	if (!cb)
 		return -ENOMEM;
-	memset(cb, 0, cb_size);
 
 	pp->cmd_block = cb;
 	pp->cmd_block_dma = cb_dma;
-- 
2.11.0

