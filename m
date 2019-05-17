Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04082C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A3E2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoRnPB9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfEQSeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:34:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37083 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfEQSeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:34:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id w37so11899315edw.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 11:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+gGOM25ejTAKC+1qNs9h6JfI5r6nDsWbjQN0oopbMfI=;
        b=IoRnPB9B/JvU2nVCjPBjm+QyRjCJATFpPzZTek4Czv27WRcWJsEtRjPM2+TSX4Iwzv
         XOWZ2ByePcAYpARXG09zDrAenkZJ0ZuxV9OifqMRs0WSyerZZRk69nOpqD+kEsQqHHPJ
         5RI5i9/bBE8E0QNtx7xTr/0l5lz3MV9jt/CSqaAo6NkzilmM5YpOs9bEpmVHLJ/84j2H
         n9QquJlBW/qslnNWalXd3h40wncOQADzLXe/0RdKQVFwubTL3D9n5IWt5VIxAz/iohxO
         1EdCC7btpM0vffDLRhzAo5pRwUlHIHzn1l3KZLG4ws/QsxSHDfcVxz/7C0kxlAsE+Sge
         2H5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+gGOM25ejTAKC+1qNs9h6JfI5r6nDsWbjQN0oopbMfI=;
        b=fieNlXx7m5XaOMlWyWcGOEJbnS+u+15EkqoxibU5goI/xMfA+MVsKEa0sGPY4VROLX
         tNhXfRmO88ciVTfaGbuQiuxX7vmbRSP7ttfe9nya7OwPIc2eRknjG8RK2RqDwFLB/3AF
         lmJXJAtXMQdiGdYcBZn3WhEKlRI8XVtK7zHqxb0JWguFU1hKMZbWd0gloR2PnrT4g1Jd
         rHheuKW8I4cNU/o2T2NFxePSpNXy9QmHsWkS8K47yckeb2avFZYBGhKuQcbL/W67dtnc
         x2jQK4+aylWwBrxRfGmXB6jjOGllNGXwYwHz3cmUnoJUl38ampEu5W18I6QSZyh4+TDb
         OGyQ==
X-Gm-Message-State: APjAAAWPLIPpsNcSWxRM9/HKeNYjTNm+Z5CkcAQKtd0cOk0RPUkhnmaz
        VHNDdpnTitURpw2cznTUcsPZCepg
X-Google-Smtp-Source: APXvYqwEQ8lwC+r7D0x+J0BZChabjhiB5CbgmhW9M3zWYPJLDaOuT5i8dikb7f+4TZ1Y70rxTdj/kw==
X-Received: by 2002:a17:906:6c15:: with SMTP id j21mr34177085ejr.33.1558118047713;
        Fri, 17 May 2019 11:34:07 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id q19sm1687127eja.59.2019.05.17.11.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 11:34:07 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 2/2] mtd: nand: raw: brcmnand: fallback to detected ecc-strength, ecc-step-size
Date:   Fri, 17 May 2019 14:29:55 -0400
Message-Id: <1558117914-35807-2-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1558117914-35807-1-git-send-email-kdasu.kdev@gmail.com>
References: <1558117914-35807-1-git-send-email-kdasu.kdev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change supports nand-ecc-step-size and nand-ecc-strenght fields in
brcmnand dt node to be  optional.
see: Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt

If both nand-ecc-strength and nand-ecc-step-size are not specified in
device tree node for NAND, nand_base driver does detect onfi ext ecc
info from ONFI extended parameter page for parts using ONFI >= 2.1. In
case of non-onfi NAND there could be a nand_id table entry with the ecc
info. If there is a valid  device tree entry for nand-ecc-strength and
nand-ecc-step-size fields it still shall override the detected values.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index ce0b8ff..e967b30 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2144,6 +2144,16 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
 		return -EINVAL;
 	}
 
+	if (!(chip->ecc.size > 0 && chip->ecc.strength > 0) &&
+	    (chip->base.eccreq.strength > 0 &&
+	     chip->base.eccreq.step_size > 0)) {
+		/* use detected ecc parameters */
+		chip->ecc.size = chip->base.eccreq.step_size;
+		chip->ecc.strength = chip->base.eccreq.strength;
+		pr_info("Using detected nand-ecc-step-size %d, nand-ecc-strength %d\n",
+			chip->ecc.size, chip->ecc.strength);
+	}
+
 	switch (chip->ecc.size) {
 	case 512:
 		if (chip->ecc.algo == NAND_ECC_HAMMING)
-- 
1.9.0.138.g2de3478

