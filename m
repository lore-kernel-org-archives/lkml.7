Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EC3C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E9A2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQN5Ajlv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbfFRS1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:27:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45394 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfFRS1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:27:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so8132814pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 11:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f1jztib4H2AhReDzbfPoXEq38V+b/2OjoyCgjVjM/vY=;
        b=qQN5AjlvxoOzG6zwGQCL4kP4KMEGWQWZBJwkiUejECOHE1LzLRRze29XzBsI9kIf93
         wefOzzVhaGj5tNJujkqJULJTeDydev5qgyw4XF6HkP+Ibpgb5e6/AStQywOrVor3B6/Q
         NVSTQ9Ja0CMVgNihdqI1lmDS6BApg51HwyNKsdR5c9azUL5XFNq17/aIFbk79uZiyHfF
         Gs4O7vnSFTyBoXDBJ44AMiaJCbQt5Yhz8pFgOL0ik8VWl1sTVT1QciHexbnlCrBMUC8x
         7j0OXIkL1A/A+GTeaY8OC46Xt8uiz9yxPQWCIbvQhqjdc5v2YlwMMDFfGqgiE2gYZGJ+
         DAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f1jztib4H2AhReDzbfPoXEq38V+b/2OjoyCgjVjM/vY=;
        b=Kycnr4AGaeCLir7n7T/7RAwCD83oL9eR7nSD65lZ4j8pIQ98lUMWpCYoykWq9l924j
         egoM6hQGkMJTXIx4VARLvHA/HWP/1opH2qiUevxLq/YI7SSpxLjGBnww4HFSE3TZSu7v
         gwtURr6OGHlqYYMo26oH27oKVLoNnL0N9tKtdnSkvI1mLsKK6rXo//y1ibUvKqoKpZB/
         HjRHqwvE5MuLxOXIgnxNeoD0F+gcPK54v+zydkpHoUOhRGgppAVm14zcAdJgpe5fuQqP
         3hBgcLIBmfRMaHHaQTjO/dAzE21QbJ71nQ99B3b932SB+1yBQ8RB0vRkXViF1mHmcElD
         K9aw==
X-Gm-Message-State: APjAAAXa0j2EiqMfVYYi0Hms7froQdOuRn4DpldMVm7FUJcnB9Zma4nd
        wH/61UHq/ulnwwNPMbtzpi0WpIhc
X-Google-Smtp-Source: APXvYqz03SVDLN2muSEnZep8XNk3L8zbZHPF+1yClksQ9xmMNrWxQpH80qjXYUyIlPzm4unlxTnPHQ==
X-Received: by 2002:a63:6883:: with SMTP id d125mr3963722pgc.281.1560882449634;
        Tue, 18 Jun 2019 11:27:29 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id k4sm6639480pfk.42.2019.06.18.11.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:27:29 -0700 (PDT)
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
Subject: [PATCH v4 2/2] mtd: nand: raw: brcmnand: When oops in progress use pio and interrupt polling
Date:   Tue, 18 Jun 2019 14:26:43 -0400
Message-Id: <1560882420-727-2-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1560882420-727-1-git-send-email-kdasu.kdev@gmail.com>
References: <1560882420-727-1-git-send-email-kdasu.kdev@gmail.com>
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
index 8735277..27b22d6 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -151,6 +151,7 @@ struct brcmnand_controller {
 	u32			nand_cs_nand_xor;
 	u32			corr_stat_threshold;
 	u32			flash_dma_mode;
+	bool			pio_poll_mode;
 };
 
 struct brcmnand_cfg {
@@ -815,6 +816,20 @@ static inline bool has_flash_dma(struct brcmnand_controller *ctrl)
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
@@ -1229,15 +1244,42 @@ static void brcmnand_cmd_ctrl(struct nand_chip *chip, int dat,
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
+	if (mtd->panic_write_triggered) {
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

