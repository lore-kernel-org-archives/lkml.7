Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0DDC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507BA2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNX471oJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfF1CqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:46:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33502 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfF1CqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:46:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id m4so1907118pgk.0;
        Thu, 27 Jun 2019 19:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EuPDx5u5RK+hCsAdEjRKMaKQ5gSdX1lfaO9PdTqs7Ec=;
        b=CNX471oJg8FKxStXxp1UzV2rT9BZjwhH1MX3qCgaSAGEX4B0GsMtW0+H7vY36cskTi
         efVcrjnHCQpXtPOtkvhOzsUkIurZe2gnz2Mf9me/Uy0rkzlQUJufOnfRS4mHV4h4P/1C
         lCfgoEMwYs592rL/IvxlYPnXP0xE7RYAfWfyaqOakZFhZ/sjZ3EExIozUjO5CEcC8mB2
         ye8d29OdNAs2S032xy992LSfETURqmnXZNlq/wRrFr0QZE7uTqFZwS05ZwSlwYGuToAH
         Nt5p+FIaZnraDsT2bHncDnvtCMPpQZ22tPgpSzckfo0nv7JefV/2fwmLIXgBE3BVRDJT
         7E4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EuPDx5u5RK+hCsAdEjRKMaKQ5gSdX1lfaO9PdTqs7Ec=;
        b=IJ5ZdkNKsaHPCk0IS2sGx7jmcTdMfHcsQ0nofTPJkpFx4mY2GkO3qhE9AMUcE3G9cY
         SkbZutOVUB0RSsCdH1uzSGdb8IAxC7UGD3ztA1t5AjBHKPi/hWj9pZA7iM/7kVtvCCjb
         H8mMmGGx2faSbQfOhfv3Di8kouaFS7qCdchJdCbjdgp87zWRsGowFVGneSfZSHeECidx
         dyzo25I9e+KriuA6zw7Pgwns5pMBH/JqOiUbexkGLYJ8OXMonDV2kSo7br0daos3IwGc
         q1GGM6wp69uVAgV5LLE36VfC55lM5QxXhoxqAq8cjkTUgVko24nl+mHGFWKbKnOSamx8
         bqPQ==
X-Gm-Message-State: APjAAAW/equvp4Qt8OEHJfEGQQim6XGGQQk/i9N8jlc/YJzY13peEyeI
        fhRZLXsrdqUMXsF5v8fmm76sWueemtxIKQ==
X-Google-Smtp-Source: APXvYqzqcZT1GqoxviH2ukiigfDCliO909KmxH8cSnLodFoEr7QI32CM0YX9aq8dYjbtDxG6zNJRQQ==
X-Received: by 2002:a63:1322:: with SMTP id i34mr7127157pgl.424.1561689972532;
        Thu, 27 Jun 2019 19:46:12 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id u65sm10885874pjb.1.2019.06.27.19.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 19:46:12 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/27] ata: Remove memset after dma_alloc_coherent/dmam_alloc_coherent
Date:   Fri, 28 Jun 2019 10:46:05 +0800
Message-Id: <20190628024605.14877-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent/dmam_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
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

