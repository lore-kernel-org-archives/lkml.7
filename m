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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F48C48BDA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A513D2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jG81AaIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfF0Re1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:34:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45426 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfF0Re0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:34:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id z19so1322024pgl.12;
        Thu, 27 Jun 2019 10:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cFX/Hroy8JhGNcWKVgvUThIxX3llgz/HND0HFdXYwxY=;
        b=jG81AaIgPNJ48aUwfThvJxNL2urKXSbstAsexVme2UGgWQ1bJ/St85auPVnOB2vwf0
         zzoYMqj5dxtytrpbnaARpmkyN73bDdft7LJv7eNHHQJWCYVAPph9S79CO/t3IWpJqZwu
         ShMKNL67tdOgWZWXJEiMX3cTbE+Goz80p3ily4LXZfecMCRaBNySGiFO/xKqb5MsB4GX
         PLn8kdrA/3VDN+O+1A5ZhGOFQUa/ib8qKHEdtIFm93z70pQ9AHAXJCxGFxnZbA9rntdO
         oqkzJA0OrWvpPXQU4l6Lr4yEP5OceDKErEQoWIvx4e7Rg6oEpHzIlOxe/S+wrtMu3UWu
         yrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cFX/Hroy8JhGNcWKVgvUThIxX3llgz/HND0HFdXYwxY=;
        b=DVGpQKUYkwBPkzz7Zq0Qy+gIrKgzRTXMGIVKddFss05Ecl7RUO20zaITBIWfBLAeMT
         crTbMyFhOWqfHXTU3vP6ZdVpPvkTHAvJ24NzNspKQzSex58sbkTICB8yvngJPXHzbpzk
         qCYRJhrMjDf1sqFYgSbZcVqTl4WtjKE7CF6Im1aKKa4rBWYwHFoawSitha7OA8sBxW1r
         MNp/livbqzt9HPxau+uNwXYuNIRKKQGNtWzbmGrpQfvtId3AZF9XlliNfbvvGwouubeE
         n4XHzynT/2YJNyZy+4GqPBzfDW6S9i/bp4hlGlvSDa79ckkWDwvBIgkkZ688QtkAInph
         Q0Lw==
X-Gm-Message-State: APjAAAVqSl200VXrOIy+wv86BIPAIhUPBpQG27fwZQFyGpYflGS/qwd7
        UEzRB1hWYswwgWfOpCv/z2s=
X-Google-Smtp-Source: APXvYqxwTk/Fq6axi9N+BbOMaeI4oTfkGCGHgcpIOzd38CM7C5g7j9k2yvahCuvCEdO4pMIqBODmVA==
X-Received: by 2002:a63:5a0a:: with SMTP id o10mr4962990pgb.282.1561656865138;
        Thu, 27 Jun 2019 10:34:25 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 201sm7437093pfz.24.2019.06.27.10.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:34:24 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/87] ata: sata_nv: Remove call to memset after dmam_alloc_coherent
Date:   Fri, 28 Jun 2019 01:34:18 +0800
Message-Id: <20190627173418.2089-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dmam_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/ata/sata_nv.c | 2 --
 1 file changed, 2 deletions(-)

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
-- 
2.11.0

