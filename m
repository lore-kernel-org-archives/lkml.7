Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF76C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FCD208C4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3pNtOCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfEARw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 13:52:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33796 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfEARw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 13:52:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id ck18so4201512plb.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c4GVYXdtGXK+NpA236Nt4eW2tTRsHxltrkwbVfBnPco=;
        b=J3pNtOClY2+lUvtAtbd2zfi7C3Bh0DJu8CPT7XYaBWgulAPLIWCZDKrOSyO5FPUKT5
         BwzjMNsitZNFmAJd5BM/edhuoljJoT3hkYvQz1Bmx7MtNhijbPKlJAukPx+FyflryLiM
         ysG9pN82/50/qOb3CjLWDbXer0cYdfiiuQMRT4JZRdt0IaK86LnuEhZJ/+vSwB7PpuuJ
         RLemfSoMn67+eXCEfxwG+6YhS0FAgfTYoRwQlMOtNqM3x2odcvV3qCe346FBw06OLyeX
         qKTvJLvp8WaSr5KYqNE/6VLF4UeIGpDgWD6tdc8qPm9LdX0Fdv8r48TI3mJrpGk+dWmJ
         O9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c4GVYXdtGXK+NpA236Nt4eW2tTRsHxltrkwbVfBnPco=;
        b=KCvDyVznvXa8uWZXnqVLAYjOP81Buy7QcoSOCtfRcqnnuhbp8Eha2kCuJZmicD7Gze
         PjXq+s8dimyvM/hPk0TmseInjMfxwLBmHdB8y92p99T+K96GI6CoS71yGAaJzbRcY5QY
         s1Tz8Gj3dgQOCqI9gH5Jsqr1sBoy4O6qbpHCYhx4JLIUpRAmdEhr27C3CaEVgx+oXcgC
         IdGshus8jsC6oq0CxkIQMFAoHjl7sopGwtSnx/hEfru9ANy7Dv7PgHzONST4RPoLLJ7P
         RtJpzBwh2hiDHREW7ROWohiNKHlZqp192yVIK8UYxEn9sUxeNZAiJhvU6QmBfvizQxt3
         1Rrg==
X-Gm-Message-State: APjAAAWvryFsiISaPhh8RqF5zyQzzh479c7IffPwFryYFx5mNtNV/8EJ
        aOQQ1oWlvQzqBPZ04savcUY=
X-Google-Smtp-Source: APXvYqyLj2w6QJeDUo/CBCheOxjdP1ZWlHLztJ310vNkx6Gcd8jk+hQIhOsniYvjqD0JY8yQPAKO9w==
X-Received: by 2002:a17:902:b210:: with SMTP id t16mr78192056plr.84.1556733147678;
        Wed, 01 May 2019 10:52:27 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id j5sm54182472pfe.15.2019.05.01.10.52.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 10:52:26 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH] mtd: nand: raw: brcmnand: When oops in progress use pio and interrupt polling
Date:   Wed,  1 May 2019 13:46:15 -0400
Message-Id: <1556733121-20133-1-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If mtd_oops is in progress switch to polling for nand command completion
interrupts and use PIO mode wihtout DMA so that the mtd_oops buffer can
be completely written in the assinged nand partition. This is needed in
cases where the panic does not happen on cpu0 and there is only one online
CPU and the panic is not on cpu0.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 55 ++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 482c6f0..cfbe51a 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -823,6 +823,12 @@ static inline bool has_flash_dma(struct brcmnand_controller *ctrl)
 	return ctrl->flash_dma_base;
 }
 
+static inline void disable_flash_dma_xfer(struct brcmnand_controller *ctrl)
+{
+	if (has_flash_dma(ctrl))
+		ctrl->flash_dma_base = 0;
+}
+
 static inline bool flash_dma_buf_ok(const void *buf)
 {
 	return buf && !is_vmalloc_addr(buf) &&
@@ -1237,15 +1243,58 @@ static void brcmnand_cmd_ctrl(struct nand_chip *chip, int dat,
 	/* intentionally left blank */
 }
 
+static bool is_mtd_oops_in_progress(void)
+{
+	int i = 0;
+
+#ifdef CONFIG_MTD_OOPS
+	if (oops_in_progress && smp_processor_id()) {
+		int cpu = 0;
+
+		for_each_online_cpu(cpu)
+			++i;
+	}
+#endif
+	return i == 1 ? true : false;
+}
+
+static bool brcmstb_nand_wait_for_completion(struct nand_chip *chip)
+{
+	struct brcmnand_host *host = nand_get_controller_data(chip);
+	struct brcmnand_controller *ctrl = host->ctrl;
+	bool err = false;
+	int sts;
+
+	if (is_mtd_oops_in_progress()) {
+		/* Switch to interrupt polling and PIO mode */
+		disable_flash_dma_xfer(ctrl);
+		sts = bcmnand_ctrl_poll_status(ctrl, NAND_CTRL_RDY |
+					       NAND_STATUS_READY,
+					       NAND_CTRL_RDY |
+					       NAND_STATUS_READY, 0);
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

