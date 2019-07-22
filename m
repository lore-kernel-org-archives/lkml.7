Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB01C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16A421955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txJ5ZWv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfGVF5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 01:57:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44834 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfGVF5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 01:57:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so39452199edr.11
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 22:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=bhNuL7XR6WEpgsenxUTTXd4yjWX8/ASS+IMSViWNwpg=;
        b=txJ5ZWv3UKmiuk5ssBeCveRyf9AJmr1QKUJybWC0DM2RF05KdMQrda6cmGBnCr/QLL
         ri+3uMOvgMfnu5d9xee6QcqvW2HvouJ8Xbm2s8JGvAU2ttSe3kiq+gBc6Uvvk0yKhmpV
         XwJ6dAmbOuW84v95gcIv4W5StOdwXDniKeA+ehK7WNVllMzF3y8a3/fT5lsOO+uyisDN
         LR49ltmjpBVUcbybXcr+5ta4q7B/Q9GWSbi5kUwp2kNbgcGBQJ0hLPRfcKpeJlR0WNwr
         tgkAJxU/LcV2m4fO6Dh+FsET5x4I8fmAYsKV6Ve4wm9jabUusrK0vFrJ28ybe257oVBA
         IXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=bhNuL7XR6WEpgsenxUTTXd4yjWX8/ASS+IMSViWNwpg=;
        b=CjqmwLirtPAGJx4wWBGqc8mdSKOaYNhzG7MAUqXxzq1ZQ1Eh65kQ+GVi20fn/bDlEz
         m4L9jarbcjFlztWJvYieDgCDJMvbQMC62ZlqWClLlN4Qb08k/D+G/A+dQQ+HMsNNaDd2
         FvEoftU1ZsVsC4T7nlOBoqAXd+5NbehqOOCbSjgMtuCMfSF1FgHYg2v22P/DtpNEcm4w
         nqJw6lXtvGE1D2uNjxuP5jG9kRCmVrOFLsBKu12QmAMXbF8kLxjiImRn8W1zneXU24+T
         bdPBvj682o4Ttm84mS0B77ATtmEUdlwe2rR5TYTuJ46cgoB6Q0LniOJOLVB/lyAChk8B
         0MaA==
X-Gm-Message-State: APjAAAW6BAN2cB5uP3QRLXXaVboqPvJoG1w2Ej2S1crv0CiRMbpig5BO
        lMzISys0S5mXuU9xVUVz9Mg=
X-Google-Smtp-Source: APXvYqxG50dPPkeMZPABlYE+bDSQXe0vmIiBeaCAjtUOw965SYgsTWI6lWdD9a3aFJBew6lyZc17xQ==
X-Received: by 2002:a17:906:a481:: with SMTP id m1mr27835309ejz.87.1563775025026;
        Sun, 21 Jul 2019 22:57:05 -0700 (PDT)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id a6sm10351725eds.19.2019.07.21.22.57.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 22:57:04 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeff Kletsky <git-commits@allycomm.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: [PATCH 3/8] mtd: nand: create ONFI table parsing instance
Date:   Mon, 22 Jul 2019 07:56:16 +0200
Message-Id: <20190722055621.23526-4-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722055621.23526-1-sshivamurthy@micron.com>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

ONFI table parsing is common, as most of the variables are common
between raw and SPI NAND. The parsing function is instantiated in
onfi.c, which fills ONFI parameters into nand_memory_organization.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/onfi.c          | 32 ++++++++++++++++++++++++++++++++
 drivers/mtd/nand/raw/nand_onfi.c | 22 ++--------------------
 include/linux/mtd/onfi.h         |  2 ++
 3 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/nand/onfi.c b/drivers/mtd/nand/onfi.c
index 7aaf36dfc5e0..e78700894aea 100644
--- a/drivers/mtd/nand/onfi.c
+++ b/drivers/mtd/nand/onfi.c
@@ -87,3 +87,35 @@ void sanitize_string(u8 *s, size_t len)
 	strim(s);
 }
 EXPORT_SYMBOL_GPL(sanitize_string);
+
+/**
+ * fill_nand_memorg() - Parse ONFI table and fill memorg
+ * @memorg: NAND memorg to be filled
+ * @p: ONFI table to be parsed
+ *
+ */
+void parse_onfi_params(struct nand_memory_organization *memorg,
+		       struct nand_onfi_params *p)
+{
+	memorg->pagesize = le32_to_cpu(p->byte_per_page);
+
+	/*
+	 * pages_per_block and blocks_per_lun may not be a power-of-2 size
+	 * (don't ask me who thought of this...). MTD assumes that these
+	 * dimensions will be power-of-2, so just truncate the remaining area.
+	 */
+	memorg->pages_per_eraseblock =
+			1 << (fls(le32_to_cpu(p->pages_per_block)) - 1);
+
+	memorg->oobsize = le16_to_cpu(p->spare_bytes_per_page);
+
+	memorg->luns_per_target = p->lun_count;
+	memorg->planes_per_lun = 1 << p->interleaved_bits;
+
+	/* See erasesize comment */
+	memorg->eraseblocks_per_lun =
+		1 << (fls(le32_to_cpu(p->blocks_per_lun)) - 1);
+	memorg->max_bad_eraseblocks_per_lun = le32_to_cpu(p->blocks_per_lun);
+	memorg->bits_per_cell = p->bits_per_cell;
+}
+EXPORT_SYMBOL_GPL(parse_onfi_params);
diff --git a/drivers/mtd/nand/raw/nand_onfi.c b/drivers/mtd/nand/raw/nand_onfi.c
index 2e8edfa636ef..263796d3298c 100644
--- a/drivers/mtd/nand/raw/nand_onfi.c
+++ b/drivers/mtd/nand/raw/nand_onfi.c
@@ -181,30 +181,12 @@ int nand_onfi_detect(struct nand_chip *chip)
 		goto free_onfi_param_page;
 	}
 
-	memorg->pagesize = le32_to_cpu(p->byte_per_page);
-	mtd->writesize = memorg->pagesize;
+	parse_onfi_params(memorg, p);
 
-	/*
-	 * pages_per_block and blocks_per_lun may not be a power-of-2 size
-	 * (don't ask me who thought of this...). MTD assumes that these
-	 * dimensions will be power-of-2, so just truncate the remaining area.
-	 */
-	memorg->pages_per_eraseblock =
-			1 << (fls(le32_to_cpu(p->pages_per_block)) - 1);
+	mtd->writesize = memorg->pagesize;
 	mtd->erasesize = memorg->pages_per_eraseblock * memorg->pagesize;
-
-	memorg->oobsize = le16_to_cpu(p->spare_bytes_per_page);
 	mtd->oobsize = memorg->oobsize;
 
-	memorg->luns_per_target = p->lun_count;
-	memorg->planes_per_lun = 1 << p->interleaved_bits;
-
-	/* See erasesize comment */
-	memorg->eraseblocks_per_lun =
-		1 << (fls(le32_to_cpu(p->blocks_per_lun)) - 1);
-	memorg->max_bad_eraseblocks_per_lun = le32_to_cpu(p->blocks_per_lun);
-	memorg->bits_per_cell = p->bits_per_cell;
-
 	if (le16_to_cpu(p->features) & ONFI_FEATURE_16_BIT_BUS)
 		chip->options |= NAND_BUSWIDTH_16;
 
diff --git a/include/linux/mtd/onfi.h b/include/linux/mtd/onfi.h
index 2c8a05a02bb0..4cacf4e9db6d 100644
--- a/include/linux/mtd/onfi.h
+++ b/include/linux/mtd/onfi.h
@@ -183,5 +183,7 @@ void nand_bit_wise_majority(const void **srcbufs,
 			    void *dstbuf,
 			    unsigned int bufsize);
 void sanitize_string(u8 *s, size_t len);
+void parse_onfi_params(struct nand_memory_organization *memorg,
+		       struct nand_onfi_params *p);
 
 #endif /* __LINUX_MTD_ONFI_H */
-- 
2.17.1

