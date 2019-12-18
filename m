Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAB0C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 01:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923352146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 01:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKqQzMNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfLRBGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 20:06:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52147 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfLRBGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 20:06:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id d73so92751wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 17:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CIZH5Iz8Q+UcB5hqDpoZoMcl1+hdqO5hVl6PqRkR26c=;
        b=HKqQzMNVF3crjW88H263YTfhX7QmsQrjBxpoyIV5+9h921uzDgiR25TNJL/tQgwCMS
         H0c/rKXUMN6B4ieH9uDuSTngC5Q+wOXXk9dOtKbBV6Otye/DGFmAjFgwA2llcITQvHyW
         tcJ8d2EyXJr+6CMtLUfuLSpy5Jj0NfsxruKLZk17uhHHmPZJDLEvGGeyBJIl/lE2/g3d
         9UeM418rafRFktzw51VrL1siu8D+U6EI3jVgtWngtXYKzjYiXsB55tCWZ+W6/eP3fuSq
         UpS7FJ/AhTKFCVQGIw9Syf+Scm4wTd+NojwfReD8b0tqCgk9MBa85tyeybOMcD2tuqH4
         Mabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CIZH5Iz8Q+UcB5hqDpoZoMcl1+hdqO5hVl6PqRkR26c=;
        b=MOu9CDILLsqWRAiQuB/yO/N0siDMWOZOxtXPuFmQrO0HBH3xOV3xnsSSGhVJpl2v2X
         qhZDjRCyET1z//rTraQECIZh7St6WH6meuPVe+jSgowlGe+R67PgVKCO9t6mJcgzygdK
         3R0CfRx3fLhcKALDPtaeX+bfF9hAgQ+cv2zadGo8Se9k2aQO+mZhPvINQIMavo2dC213
         HUJAthnisj8czWcWLGgRwpBpHnhZ0HCWkU0eS0inepnqUseJeUWdxPFnciMlafA/hGUL
         03sYzWWikdLCakU41TI3ZUJEga3CzNy+ju8/cTXBbFWE0JaFYk83dm/LYyFTLUadpYA6
         JZuQ==
X-Gm-Message-State: APjAAAXMNTlkOkDW6miEh8Gi8BIf0YDhMA1os6Evi4dr4cRW09lHGKso
        3EKtyKi+G4s27nFdBnDdGzY=
X-Google-Smtp-Source: APXvYqyMl9k8MKXlxMm7wNyv/DWdhtcTNOXrTcixs3yJtvQhzXGKregw5hmJy2az5JqhZ9wteU3glA==
X-Received: by 2002:a1c:a543:: with SMTP id o64mr235510wme.73.1576631175947;
        Tue, 17 Dec 2019 17:06:15 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v14sm647455wrm.28.2019.12.17.17.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 17:06:15 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM STB NAND
        FLASH DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mtd: nand: brcmnand: Set appropriate DMA mask
Date:   Tue, 17 Dec 2019 16:56:35 -0800
Message-Id: <20191218005635.31636-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NAND controllers >= 7.0 with FLASH_DMA support physical addresses up to
40-bit, set an appropriate DMA mask for that purpose.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 1a66b1cd51c0..44518dada75b 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2635,6 +2635,16 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 		/* initialize the dma version */
 		brcmnand_flash_dma_revision_init(ctrl);
 
+		ret = -EIO;
+		if (ctrl->nand_version >= 0x0700)
+			ret = dma_set_mask_and_coherent(&pdev->dev,
+							DMA_BIT_MASK(40));
+		if (ret)
+			ret = dma_set_mask_and_coherent(&pdev->dev,
+							DMA_BIT_MASK(32));
+		if (ret)
+			goto err;
+
 		/* linked-list and stop on error */
 		flash_dma_writel(ctrl, FLASH_DMA_MODE, FLASH_DMA_MODE_MASK);
 		flash_dma_writel(ctrl, FLASH_DMA_ERROR_STATUS, 0);
-- 
2.17.1

