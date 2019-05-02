Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0098C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C49C2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyhiUhGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfEBPB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:01:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41699 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEBPB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:01:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so1182657pgs.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 08:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UuMFcOk4PKj91APfBr8006g4N2giQ/z6xm9K7QOYvPU=;
        b=RyhiUhGMu/07Fiptheef7l3Im7ZUgKwPpMGS171+3DfjyFghriz8AOvRTi8Me4ogUb
         5CDP5WtPupbfM5B0sODlecbeWn0+sDne5D+oprjQzCmrQwCx3oZHRp9+bKcQCBxlOyuK
         mT49R5DO+VPww+b/sKHXtQL8oDw/pvjKN8zcuitbVaLHAIGPfEv7mVB3lY3bpFfJq+Mq
         v9h9NoX2vL5P+ugHDTfKE5/6Fi/Undu5B1Dmq0AJ4FNV12IzcZaTIB9dhe2E4KCV+Bg7
         PDJJeYJAWaSL9/rdUNI7JYv8UcjtwGMqXUHaA61fFxQlkNwMnKC5k/iUotEXsQSOTTKj
         g37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UuMFcOk4PKj91APfBr8006g4N2giQ/z6xm9K7QOYvPU=;
        b=tYhdDvbLnpOZt9+W0fq474yBN3CvEtM3/rhmg9OhdwrYRgpEXiSEjoOHMtSdXg+msb
         SpSrpV8J4yQVmD46JaU8VWc047dbwH6A56Wrq2ypHe/+Vi1Uw6/NZxJkcrLkT5o4cp0t
         0Vny4NDleQs1YhF4WYIF3jeR11pGi+QBuKTbLnyAeG/xDlgr8DNWQTvvfk5USBV23Rp3
         rI2+GDJNloU3TwwSQl+hnachK28893C7V4eCETkXCaJonF9OFUXx3kwxIyyu1oMAKgOv
         mTO7jRAZG4ROJY2s1lZzHnBCjDHIDQ3n0GtFihXTZeGzmUt2oaoFublTZWDVac32gBfX
         V32A==
X-Gm-Message-State: APjAAAXJFTb0UCWfS8Esvv5luFIT4OchDHwPjbEb3Drri+Zmv0Uyg3E1
        dUmfKokmnkBsRdyBtCmvW14=
X-Google-Smtp-Source: APXvYqzp8Vsv3csm5hTN6igjY/ka0x3tKKPaQLzTG2OHdwte3ZIu4AHSVJo95JQxGCw4JKKtULZcqg==
X-Received: by 2002:a63:9214:: with SMTP id o20mr4452130pgd.203.1556809285953;
        Thu, 02 May 2019 08:01:25 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id o15sm21581450pgb.85.2019.05.02.08.01.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 08:01:25 -0700 (PDT)
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
Subject: [PATCH v2] mtd: nand: raw: brcmnand: When oops in progress use pio and interrupt polling
Date:   Thu,  2 May 2019 11:01:01 -0400
Message-Id: <1556809273-40009-1-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If mtd_oops is in progress, switch to polling during NAND command
completion instead of relying on DMA/interrupts so that the mtd_oops
buffer can be completely written in the assigned NAND partition.
This is needed in cases where and there is only one online CPU and
the panic is not on cpu0 as all IRQs are wired to cpu0.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 55 ++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 482c6f0..128a806 100644
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
+	return (i == 1);
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

