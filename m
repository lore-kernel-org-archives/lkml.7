Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9B4C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE1C2072B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqBQcuqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLRJ5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:57:36 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33252 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfLRJ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:57:35 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so1257177lfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 01:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KjaQHbXEtUPbdJ5QolbnF2SXTiBMUzW0K/9APW3u0l8=;
        b=qqBQcuqWxfmEOhAv2j2zB9V7DG9wlHUZh0Lntv5/nArDEyFNeBWjxQSpkFQpcMGQzL
         nOZnjHG21pchuRXBzstaMuKQHSZsPed929jEUocODrPV9zt9pzGPKQBh620ztRuFgx6+
         h3qtMwV6Q9eD3EpCNfUKH4Nim1UxocwqsqmSb/RatDe866l5a1DfBj7f69Ddx9ngilJu
         M5H/Fq7e120StNIm5qwvoMHC2XPgSCNuZfp47CHoAfmsSKUELixulRK/xrfbKms6m11h
         w41zuUHkdpNPrs+zx+CIr/BYyn6+C7o8WD+8H30UpKFOBJ2jCL3WIj1d4iYuSCURaQ1g
         lexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KjaQHbXEtUPbdJ5QolbnF2SXTiBMUzW0K/9APW3u0l8=;
        b=Tw35Pmyc58W2EIxUsS89EEVleI2mrh2gaiA4xFo6Yq0oqHdix4VuwWz0ls5s6eXsFR
         PU5GhKlpQry67+0YyA74QEJdQdjRalg1AtGLy55v/AzDqn8q9D/Pbanyrdb1jJDgk+ex
         UxmSIEKBwIn2iP43hWPWEnE9j7dUgbA/i4g8Lsem7OtAozGB9iJGmMWarOA/BUeWHZmu
         nLRyQLlQwHiBfHaO2cwd4Z2W2hQz5GMYvQhuz/2ApmBtdm1K+jhhKrA8Z6HOqM+yIWJT
         br4KLV9dyA6FPKJHliF8GSTqS1325kcFtwAcCLWVXnGqSuWcaO3PvR41bBFoXVrnpXDg
         kk8w==
X-Gm-Message-State: APjAAAV2knaPEoyiG3hR8X1pxtBfhPRaHrnaJgs7MprcimmO8HjwY9Ao
        z+33yXI/PmEpWBufnVFvB6A=
X-Google-Smtp-Source: APXvYqw85KoX8B9V58ziifcfW3NELC+JU9AdHtK13IDrwqjZeTnTVLzU9rFYc1TPL2FPyuBgBhEKNQ==
X-Received: by 2002:ac2:4194:: with SMTP id z20mr1226185lfh.20.1576663053560;
        Wed, 18 Dec 2019 01:57:33 -0800 (PST)
Received: from kbp1-lhp-A00636.cisco.com ([195.238.92.77])
        by smtp.gmail.com with ESMTPSA id o69sm830412lff.14.2019.12.18.01.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 01:57:33 -0800 (PST)
From:   Vasyl Gomonovych <gomonovych@gmail.com>
To:     piotrs@cadence.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Cc:     Vasyl Gomonovych <gomonovych@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtd: cadence: Fix cast to pointer from integer of different size warning
Date:   Wed, 18 Dec 2019 11:57:15 +0200
Message-Id: <20191218095715.25585-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216110947.6fb2423a@xps13>
References: <20191216110947.6fb2423a@xps13>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dma_addr_t type to pass memory address and control data in
DMA descriptor fields memory_pointer and ctrl_data_ptr
To fix warning: cast to pointer from integer of different size

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---

Changes since v1:
 * Remove type casting (void *)(uintptr_t)dma_buf
 * Change type of function parameters
 
 drivers/mtd/nand/raw/cadence-nand-controller.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 3a36285a8d8a..f6c7102a1e32 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -914,8 +914,8 @@ static void cadence_nand_get_caps(struct cdns_nand_ctrl *cdns_ctrl)
 /* Prepare CDMA descriptor. */
 static void
 cadence_nand_cdma_desc_prepare(struct cdns_nand_ctrl *cdns_ctrl,
-			       char nf_mem, u32 flash_ptr, char *mem_ptr,
-			       char *ctrl_data_ptr, u16 ctype)
+			       char nf_mem, u32 flash_ptr, dma_addr_t mem_ptr,
+				   dma_addr_t ctrl_data_ptr, u16 ctype)
 {
 	struct cadence_nand_cdma_desc *cdma_desc = cdns_ctrl->cdma_desc;
 
@@ -931,13 +931,13 @@ cadence_nand_cdma_desc_prepare(struct cdns_nand_ctrl *cdns_ctrl,
 	cdma_desc->command_flags |= CDMA_CF_DMA_MASTER;
 	cdma_desc->command_flags  |= CDMA_CF_INT;
 
-	cdma_desc->memory_pointer = (uintptr_t)mem_ptr;
+	cdma_desc->memory_pointer = mem_ptr;
 	cdma_desc->status = 0;
 	cdma_desc->sync_flag_pointer = 0;
 	cdma_desc->sync_arguments = 0;
 
 	cdma_desc->command_type = ctype;
-	cdma_desc->ctrl_data_ptr = (uintptr_t)ctrl_data_ptr;
+	cdma_desc->ctrl_data_ptr = ctrl_data_ptr;
 }
 
 static u8 cadence_nand_check_desc_error(struct cdns_nand_ctrl *cdns_ctrl,
@@ -1280,8 +1280,7 @@ cadence_nand_cdma_transfer(struct cdns_nand_ctrl *cdns_ctrl, u8 chip_nr,
 	}
 
 	cadence_nand_cdma_desc_prepare(cdns_ctrl, chip_nr, page,
-				       (void *)dma_buf, (void *)dma_ctrl_dat,
-				       ctype);
+				       dma_buf, dma_ctrl_dat, ctype);
 
 	status = cadence_nand_cdma_send_and_wait(cdns_ctrl, thread_nr);
 
@@ -1360,7 +1359,7 @@ static int cadence_nand_erase(struct nand_chip *chip, u32 page)
 
 	cadence_nand_cdma_desc_prepare(cdns_ctrl,
 				       cdns_chip->cs[chip->cur_cs],
-				       page, NULL, NULL,
+				       page, 0, 0,
 				       CDMA_CT_ERASE);
 	status = cadence_nand_cdma_send_and_wait(cdns_ctrl, thread_nr);
 	if (status) {
-- 
2.17.1

