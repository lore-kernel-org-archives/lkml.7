Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00B4C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E27720645
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/z7DR9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfEPQmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:42:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45295 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbfEPQmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:42:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id g57so6111080edc.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wa1mrjd2PehMiQ4tkO2lOhokR8tf+BLQRnMqAVbGJys=;
        b=g/z7DR9BmTxEIxCYbvmHbg6qBFLxaVwDPKWyQqTzjFpeonA3/xxh6TTSnxTVMrYPuh
         3Bb0qTQaYoaiaE1tZbJxW3yT0A6iBGhPNtkXJnX5ATbFX5oIjzk5QmBmasxxLNNDaQI9
         3IbRvhNTMBu35NaDQjVCMwsoCWW9rHVr1RelvgLuTvmT5Pa+JowucaGMTj0a5vJsF4Mh
         hl1MiRg2nhqw91tUlvpOGFK3voLLVx5IkeSObZBvAI0LUKxUP1hz4dMnq9917Fk+gesc
         XxJpOWqurq25m0TqSBw8TP4kVi8lW8HwY7rrE1mkZxb2P0kRLUSA1EvU8k/0QyJ2J+dp
         aWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wa1mrjd2PehMiQ4tkO2lOhokR8tf+BLQRnMqAVbGJys=;
        b=TDva9oSMPeXMyXtm8Ayir6sw3LdeFLebppkTIl/khna+CdnBWpJoc21y8qg7OV38mg
         5E7ozigxnUEyrkn8AGHzpjMvjVSW0EpWn6emM9OnPyfy2l/zlh6lBDpGSDw/zPCxy9Ka
         oJFQs3IR4lJAJ6YNmybS+5hxhOUvA/7wmaWawQaFQ2iuUaael3OziHd5mJGaMWzUkz3h
         EmhEmn9x4BZp0IpcSv101FvivGeFY+VJONEopmFfEYtt9pQ5+tH7sOWErZZgZVLjF9jT
         Ey5SbdtjZZkd0L91ROPpDKyUNY0kSoXv0CFcasP/zeaIwIgrYWhb57RfIgXTvduLpT/V
         5+eg==
X-Gm-Message-State: APjAAAUDsuuFSajVeQCVnp39Z5zrlr+aHTB6YdmiCChDhJd7MdbCx/ZW
        XaAnOzHOs5a997t1z5GqJhI=
X-Google-Smtp-Source: APXvYqxVkN8VU/C2NqT5TNs/gJqQuUgvqrlRLD7rfThGYlt6/mc7Qi88kYFV9TNRC3Mkvp9j3h9MKw==
X-Received: by 2002:aa7:c645:: with SMTP id z5mr16773975edr.43.1558024951396;
        Thu, 16 May 2019 09:42:31 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id i45sm2013709eda.67.2019.05.16.09.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 09:42:30 -0700 (PDT)
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
Subject: [PATCH v3 2/2] mtd: nand: raw: brcmnand: When oops in progress use pio and interrupt polling
Date:   Thu, 16 May 2019 12:41:47 -0400
Message-Id: <1558024913-26502-2-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1558024913-26502-1-git-send-email-kdasu.kdev@gmail.com>
References: <1558024913-26502-1-git-send-email-kdasu.kdev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If mtd_oops is in progress, switch to polling during NAND command
completion instead of relying on DMA/interrupts so that the mtd_oops
buffer can be completely written in the assigned NAND partition.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 48 ++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index ce0b8ff..dca8eb8 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -159,6 +159,7 @@ struct brcmnand_controller {
 	u32			nand_cs_nand_xor;
 	u32			corr_stat_threshold;
 	u32			flash_dma_mode;
+	bool			pio_poll_mode;
 };
 
 struct brcmnand_cfg {
@@ -823,6 +824,20 @@ static inline bool has_flash_dma(struct brcmnand_controller *ctrl)
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
+	ctrl->pio_poll_mode = true;
+}
+
 static inline bool flash_dma_buf_ok(const void *buf)
 {
 	return buf && !is_vmalloc_addr(buf) &&
@@ -1237,15 +1252,42 @@ static void brcmnand_cmd_ctrl(struct nand_chip *chip, int dat,
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
 
-- 
1.9.0.138.g2de3478

