Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407C8C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65182083B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJSTcsru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390930AbfGRSMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:12:12 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33621 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfGRSMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:12:12 -0400
Received: by mail-lf1-f68.google.com with SMTP id x3so19964903lfc.0;
        Thu, 18 Jul 2019 11:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ACngBykYqB0o3NihblCBOiLR+sDnmChE/17QqNQkmcw=;
        b=uJSTcsru+2y77L4tXI8gTk0Vh9M9kZz58/Bo/v3O06SEgqw+rIDR6rjtygmpsUf4oy
         Ri5PteBnltXPOLBcJEnzLXbaODQrcetYoBQRTqF7Hv1O5zVMIAL9IYTkT7xMEe86Bm0r
         AIxfMGoV+q86LemSXRXZC1MOo4B/PQdNZTPNYLCbPYZmMYfQmQJIZIQv74DTCLuJ7yq7
         CKmImcvKEMTowz6QhWlpYn8uWH4+MBbCecpX3GksUKIG71hIl6ozhV3vbAQj74KKOBKR
         1Tb5Dni1kxWb2GB4R2dHSA1AgTLORIwChFc+2NX2cAiwF0RhFfEIbIcm9qqfX6m7mAlM
         KyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ACngBykYqB0o3NihblCBOiLR+sDnmChE/17QqNQkmcw=;
        b=IIbreBdrfcVIyLgQj11Z5pbgrutAbZd0WTCp+3qTN8Ua8RMXSTm3AwyhyjMmA10kjk
         u+/WOOjHul01ygK28BgAAU0EsLlxJEG90vTwaOOjNFxg3AtgDqoW3IHRuH86Gi4eRsqm
         pY5qFAH0CPNi6XboasKVaxlm+IvT/PgxzzFAtbiJgESEOSd8WVoEkCqNUhHraLd9Ko6m
         Iir0sRvSyP911Z1NdnxXYgaH+opu7jDMT5W6nGhJY1IlNo9vSEh4/QmH4+gYESg2Wkoh
         Dei9XPIGzc0k8iekwn3y6xq2/Hb5/XjDIB///7p0WJHAm0rJCs6b2/JCVhWXcZWCY4yo
         1NhA==
X-Gm-Message-State: APjAAAWnfnlOJ3vVHM4weWMR2ywTTeiRjqrNUonR30PZBPMZZPHBcVXn
        tbZ5h308EFYkLh/qhfVXbGc=
X-Google-Smtp-Source: APXvYqxR8eJn2cUmQMFU+uiC3HTCCXhxoJvfz5G4665Mq6Y8N0RiDcyjRnmmQ8gQDTeHx/LtGcuxcQ==
X-Received: by 2002:a19:a87:: with SMTP id 129mr20910465lfk.98.1563473530065;
        Thu, 18 Jul 2019 11:12:10 -0700 (PDT)
Received: from ul001888.eu.tieto.com ([91.90.160.140])
        by smtp.gmail.com with ESMTPSA id x137sm4098586lff.23.2019.07.18.11.12.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 11:12:09 -0700 (PDT)
From:   Vasyl Gomonovych <gomonovych@gmail.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org
Cc:     Vasyl Gomonovych <gomonovych@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: pmcraid: Use dma_pool_zalloc rather than dma_pool_alloc
Date:   Thu, 18 Jul 2019 20:11:46 +0200
Message-Id: <20190718181146.23019-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use *_pool_zalloc rather than *_pool_alloc followed by memset with 0
The semantic patch that makes this change is available
in scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci.

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 drivers/scsi/pmcraid.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 71ff3936da4f945f3d8a798a8b2129ca3c07ec22..f79d7750934e629c6d6edc1a075205247889531d 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -4653,9 +4653,7 @@ static int pmcraid_allocate_control_blocks(struct pmcraid_instance *pinstance)
 		return -ENOMEM;
 
 	for (i = 0; i < PMCRAID_MAX_CMD; i++) {
-		pinstance->cmd_list[i]->ioa_cb =
-			dma_pool_alloc(
-				pinstance->control_pool,
+		pinstance->cmd_list[i]->ioa_cb = dma_pool_zalloc(pinstance->control_pool,
 				GFP_KERNEL,
 				&(pinstance->cmd_list[i]->ioa_cb_bus_addr));
 
@@ -4663,8 +4661,6 @@ static int pmcraid_allocate_control_blocks(struct pmcraid_instance *pinstance)
 			pmcraid_release_control_blocks(pinstance, i);
 			return -ENOMEM;
 		}
-		memset(pinstance->cmd_list[i]->ioa_cb, 0,
-			sizeof(struct pmcraid_control_block));
 	}
 	return 0;
 }
-- 
2.17.1

