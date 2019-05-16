Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F29C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E73920848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHLggaIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfEPQAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:00:31 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37545 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfEPQAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:00:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id w37so5994463edw.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=40SvhtWBUctj9+S+m8DxOe/VChkRebT6Ohk0rHAg6js=;
        b=QHLggaIX8qLntcteJprWDMNXEF4m5roi8ecviFniHZepI65lRi+cug/BSR1clU0ev9
         fW5E6RTikEbksO5qsROQycZ8/HcreUTmV7+HXXJ4hyvDHEJ5sivZd6rHRDG9EuEq68kt
         2ZmKV6qK6AJ6QR7QsLWebr/BZD2r+HcJcTevURhtkqdvSh6jmcpBUpcfjfJJ2+o2x8cl
         VrM1SwE3MrKa+AmtUbbm15ygkP0ZIMuugFXTt2/xoCihciOUQZsJcfUZnvyjvGDF1v5S
         Dyt19m7G/QY92CzMZg9ZfDEUyBWHRIiVBe9wlHDuEyLJuG5fy5aOjtT7cKfkOR4SERFL
         dlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=40SvhtWBUctj9+S+m8DxOe/VChkRebT6Ohk0rHAg6js=;
        b=s2wV+rhdrMUqsFRebKqb/hm9ZLQHe9u6Jfoi8patPFnKrQuMapgj886g8BBP9klTd8
         4mi4Ep2jwuAlkQ0b6minnEw5U8qZyYXD6Uz3Vvj/bHaRo+a2YZdr5wgDsKc3jxY1UNe4
         vRNWRsmtZ4dbbyTYNAJxOiPuql0ut6eqp1tCgogVtDwdSRm+4km3Puff/Tx5EmFMO0gk
         5bjj1pTVgGIWNCDP/vr9jiLVWqCfuep/Fp5I2RZtW6uK4/nDpi5yd08xDg0P7JnAfbO5
         DV6I7kAAlglO6d24PV3t0NEEwEX8q8uZxT05mGh1QMvZkKf4bVzzwIiGBzSLg3kfy+jT
         Yx1Q==
X-Gm-Message-State: APjAAAVBmfrRvPQDbQ9IZTRJbeWrCYHoFX/WJFwx1Njx3Qcvt3hxSALG
        CKa/lWx/q6BmsBYAh5hHwjM=
X-Google-Smtp-Source: APXvYqxFwA4MBXten7Nivfuff+a7/ozMhF32vXLiGMWKvNWcDBFPkoeJLEyW4+8wQP6T1Qwnx6OOmw==
X-Received: by 2002:a50:ad42:: with SMTP id z2mr52428235edc.9.1558022421720;
        Thu, 16 May 2019 09:00:21 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id n8sm348307ejk.45.2019.05.16.09.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 09:00:21 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 1/2] mtd: Add flag to indicate panic_write
Date:   Thu, 16 May 2019 11:45:39 -0400
Message-Id: <1558022399-24863-1-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a flag to indicate a panic_write so that low level drivers can
use it to take required action where applicable, to ensure oops data
gets written to assigned mtd device.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/mtdcore.c                    |  3 ++
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 49 ++++++++++++++++++++++++++++++--
 include/linux/mtd/mtd.h                  |  6 ++++
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 76b4264..a83decd 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1138,6 +1138,9 @@ int mtd_panic_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
 		return -EROFS;
 	if (!len)
 		return 0;
+	if (!mtd->oops_panic_write)
+		mtd->oops_panic_write = true;
+
 	return mtd->_panic_write(mtd, to, len, retlen, buf);
 }
 EXPORT_SYMBOL_GPL(mtd_panic_write);
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index ce0b8ff..a30a7f0 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -159,6 +159,7 @@ struct brcmnand_controller {
 	u32			nand_cs_nand_xor;
 	u32			corr_stat_threshold;
 	u32			flash_dma_mode;
+	bool			pio_poll_mode;
 };
 
 struct brcmnand_cfg {
@@ -823,6 +824,21 @@ static inline bool has_flash_dma(struct brcmnand_controller *ctrl)
 	return ctrl->flash_dma_base;
 }
 
+static inline void disable_ctrl_irqs(struct brcmnand_controller *ctrl)
+{
+	if (ctrl->pio_poll_mode)
+		return;
+
+	if (has_flash_dma(ctrl)) {
+		ctrl->flash_dma_base = 0;
+		disable_irq(ctrl->dma_irq);
+	}
+
+	disable_irq(ctrl->irq);
+
+	ctrl->pio_poll_mode = true;
+}
+
 static inline bool flash_dma_buf_ok(const void *buf)
 {
 	return buf && !is_vmalloc_addr(buf) &&
@@ -1237,15 +1253,42 @@ static void brcmnand_cmd_ctrl(struct nand_chip *chip, int dat,
 	/* intentionally left blank */
 }
 
+static bool brcmstb_nand_wait_for_completion(struct nand_chip *chip)
+{
+	struct brcmnand_host *host = nand_get_controller_data(chip);
+	struct brcmnand_controller *ctrl = host->ctrl;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	bool err = false;
+	int sts;
+
+	if (mtd->oops_panic_write) {
+		/* switch to interrupt polling and PIO mode */
+		disable_ctrl_irqs(ctrl);
+		sts = bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY,
+					       NAND_CTRL_RDY, 0);
+		err = (sts < 0) ? true : false;
+	} else {
+		unsigned long timeo = msecs_to_jiffies(
+						NAND_POLL_STATUS_TIMEOUT_MS);
+		/* wait for completion interrupt */
+		sts = wait_for_completion_timeout(&ctrl->done, timeo);
+		err = (sts <= 0) ? true : false;
+	}
+
+	return err;
+}
+
 static int brcmnand_waitfunc(struct nand_chip *chip)
 {
 	struct brcmnand_host *host = nand_get_controller_data(chip);
 	struct brcmnand_controller *ctrl = host->ctrl;
-	unsigned long timeo = msecs_to_jiffies(100);
+	bool err = false;
 
 	dev_dbg(ctrl->dev, "wait on native cmd %d\n", ctrl->cmd_pending);
-	if (ctrl->cmd_pending &&
-			wait_for_completion_timeout(&ctrl->done, timeo) <= 0) {
+	if (ctrl->cmd_pending)
+		err = brcmstb_nand_wait_for_completion(chip);
+
+	if (err) {
 		u32 cmd = brcmnand_read_reg(ctrl, BRCMNAND_CMD_START)
 					>> brcmnand_cmd_shift(ctrl);
 
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 677768b..791c34d 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -330,6 +330,12 @@ struct mtd_info {
 	int (*_get_device) (struct mtd_info *mtd);
 	void (*_put_device) (struct mtd_info *mtd);
 
+	/*
+	 * flag indicates a panic write, low level drivers can take appropriate
+	 * action if required to ensure writes go through
+	 */
+	bool oops_panic_write;
+
 	struct notifier_block reboot_notifier;  /* default mode before reboot */
 
 	/* ECC status information */
-- 
1.9.0.138.g2de3478

