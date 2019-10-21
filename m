Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A716ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79990206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqLxwUJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfJUQqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:46:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50351 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfJUQqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:46:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id q13so4064995wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 09:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eFEl28Vsq9lpGG0tWVSoyc2R2rajJ8eE9XSI+a0Gbrg=;
        b=QqLxwUJGYaKcPWLKeSxpAN6+o30jzM7ZO17CH8H2x7rhjBdYoE5e8Kn1krRcF7FfBS
         s9c6j9gUfHPvThKy9JaUcm/ZvPL0bxmsMGWvbcl3jBWpiuUBCCXeJLnqWCTRZAjmC67u
         3mIp1vyR1GEL/ztXZ7HxZuH6oEziVOMbC8cJXRC92ICD5AZonsV0BLVJLYhq+LWPRdjY
         71G/Wm6pb6/4tElBxCmFaobxo3jwNmb2r+dy5dnJnuFmke07CYRpUsDFbBTecyLnPA08
         IqqZvSgQ6XG+LWODwFTiifHYsSOKyvktVEuwdCiPxpPYLUOefJouj3I0eL1n8o08k/pL
         kOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eFEl28Vsq9lpGG0tWVSoyc2R2rajJ8eE9XSI+a0Gbrg=;
        b=fps6GVSLxKPRj6Kk5D47UgMoFPcxm+hm92aTx8WtvxiLxbxYNdckDu5tEVr8pYS55y
         ZJTI2C03jhXQqJKGh+w5+9gocbPxiCC9MI1KmW5Lk4V+x3FJ2cxbBqPotcI1uW7/S/It
         RTYewek5A/6n3wkSTM4O4eyldTmkGqB6ozTCSrPrMMKXLMzFTjURGnYMsMyQRj+d92Ew
         Dc1wMuCuCstjbWmq8p6UWxxHIR9J8VVjf7ZFq4k+jOdSOJTVrZJg5mdQ3txNWkUq/fpi
         Av3OQaTUwloVqWdqMtA5czn6ba5tWL35YPJpwWMj2Vba0bQvFtqSBNHtdJO0NpeJ79i6
         Cpzw==
X-Gm-Message-State: APjAAAVKI/bBSy/R6cQ4lPXkNsY6/rUajZfFoicpIoRWoQt4rDJ/SLbR
        hq0z03GvGGhLi04LkMfy0bY=
X-Google-Smtp-Source: APXvYqwO/ZxNe6wlvGMpLPz78adJYcNEatmv3ktbpu3T4PyUN6GNSk4e4jCA53/yC6PGls1UUVIeAA==
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr2897648wmh.118.1571676369073;
        Mon, 21 Oct 2019 09:46:09 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 26sm13693867wmf.20.2019.10.21.09.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 09:46:08 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org (open list:BROADCOM STB NAND FLASH DRIVER),
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM STB NAND
        FLASH DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] mtd: rawnand: brcmnand: Fix NULL pointer assignment
Date:   Mon, 21 Oct 2019 09:45:54 -0700
Message-Id: <20191021164555.5330-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse complained about the following:

drivers/mtd/nand/raw/brcmnand/brcmnand.c:921:40: warning: Using plain integer as NULL pointer

fix this issue by assigning the pointer to NULL.

Fixes: c1ac2dc34b51 ("mtd: rawnand: brcmnand: When oops in progress use pio and interrupt polling")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 15ef30b368a5..6a7f0211f5a5 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -918,7 +918,7 @@ static inline void disable_ctrl_irqs(struct brcmnand_controller *ctrl)
 		return;
 
 	if (has_flash_dma(ctrl)) {
-		ctrl->flash_dma_base = 0;
+		ctrl->flash_dma_base = NULL;
 		disable_irq(ctrl->dma_irq);
 	}
 
-- 
2.17.1

