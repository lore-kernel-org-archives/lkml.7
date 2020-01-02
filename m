Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EC2C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0459E215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhOh/oE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgABRKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 12:10:17 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37383 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgABRKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 12:10:17 -0500
Received: by mail-yw1-f66.google.com with SMTP id z7so17456917ywd.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 09:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ICz0O08t3a/RBlQWCudjBOmlSFab7Caoxuic86MaXF4=;
        b=RhOh/oE8j3iq3lY4LyVvlnQs7jG3jFueKDDZlLUK33eQu/R0nr639qp3UgEvKk6iSx
         j9Pls8wvdcyXJebToFEogu2fq8G2mG4EKEXfts8GX0PNk6X4sj3Mgm1Lpiw21GyuwxHA
         kbDoFF1ZLgLHQpUz2DNSK51PZY0w4DfJh8K9MG2aOeUGEoOKRP3jiHKsAEbLn+2zgLwm
         reyFZc34fBBBkx7VMM8K2rGaH+NpxUG05HYaQ+EtIjDRBwWDpr81ZDS0V4kTDPiBm/Fk
         +K8wLHRuc8D8oCrEX9S+wViTP7cOofwPZz//Hgi3QO4B1CWA3XcLEXiRtqoz0fgFQARV
         McOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ICz0O08t3a/RBlQWCudjBOmlSFab7Caoxuic86MaXF4=;
        b=W9KzQrAlM2ah+t2IKGvjCjWunKvYQrgo8bjl0BTwoaOW8mgjGotyPhzg1QcuxAFfZI
         nZlpkQYRKZ9iclbdi7jeBx5+HplZ1VlKAwYFhihQmG5y92H+SpccgtpxZ3UO+AMkUv02
         Xvpz9/nck+bs0Xi98xXLFc5HdS9lxBadeEunGOA9aX5Gz2e3wE6RXLcChBY1XMwMeKtc
         gBZU721lmmDn9pHkDfTzTREgpHc1W/VPkfuLc4bm7ey01O6W4alljX1fdFbcWYeBsP9/
         kjswmcbz1Y3r3pql2T4BmS3+z0I8k9qyUSJBIplNr2jINVipkhOLHalQElAHWEEzN127
         vL/w==
X-Gm-Message-State: APjAAAU3Rs44QrEifoYPKlHUei7t1xrXznxpd85L+JUP9sSiamQquH5Z
        IqkUjnIwRcwTbj4phLghyFg=
X-Google-Smtp-Source: APXvYqyFP3Xyv6/igro5FdVIhb7NJIoBlArsJUFZZBHxW1/oFaTxbOQeAV+4eMn42OIJmufakICLgQ==
X-Received: by 2002:a81:72c3:: with SMTP id n186mr62008253ywc.342.1577985015967;
        Thu, 02 Jan 2020 09:10:15 -0800 (PST)
Received: from user-ThinkPad-X230 ([2601:cd:4005:d680:940e:5f6e:348a:1ff0])
        by smtp.gmail.com with ESMTPSA id d137sm20471827ywd.86.2020.01.02.09.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jan 2020 09:10:15 -0800 (PST)
Date:   Thu, 2 Jan 2020 12:10:08 -0500
From:   Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
To:     kyungmin.park@samsung.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: nand: checkpatch.pl cleanup - fix errors and checks
Message-ID: <20200102171008.GA15268@user-ThinkPad-X230>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct mispelling, spacing, and coding style flaws caught by
checkpatch.pl script.

Signed-off-by: Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
---
 drivers/mtd/nand/onenand/omap2.c        | 11 ++++++-----
 drivers/mtd/nand/onenand/onenand_base.c | 14 +++++++-------
 include/linux/mtd/flashchip.h           |  2 +-
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/onenand/omap2.c b/drivers/mtd/nand/onenand/omap2.c
index edf94ee54ec7..8cb2294bc837 100644
--- a/drivers/mtd/nand/onenand/omap2.c
+++ b/drivers/mtd/nand/onenand/omap2.c
@@ -148,13 +148,13 @@ static int omap2_onenand_wait(struct mtd_info *mtd, int state)
 	unsigned long timeout;
 	u32 syscfg;
 
-	if (state == FL_RESETING || state == FL_PREPARING_ERASE ||
+	if (state == FL_RESETTING || state == FL_PREPARING_ERASE ||
 	    state == FL_VERIFYING_ERASE) {
 		int i = 21;
 		unsigned int intr_flags = ONENAND_INT_MASTER;
 
 		switch (state) {
-		case FL_RESETING:
+		case FL_RESETTING:
 			intr_flags |= ONENAND_INT_RESET;
 			break;
 		case FL_PREPARING_ERASE:
@@ -375,7 +375,7 @@ static int omap2_onenand_read_bufferram(struct mtd_info *mtd, int area,
 	 * context fallback to PIO mode.
 	 */
 	if (!virt_addr_valid(buf) || bram_offset & 3 || (size_t)buf & 3 ||
-	    count < 384 || in_interrupt() || oops_in_progress )
+	    count < 384 || in_interrupt() || oops_in_progress)
 		goto out_copy;
 
 	xtra = count & 3;
@@ -422,7 +422,7 @@ static int omap2_onenand_write_bufferram(struct mtd_info *mtd, int area,
 	 * context fallback to PIO mode.
 	 */
 	if (!virt_addr_valid(buf) || bram_offset & 3 || (size_t)buf & 3 ||
-	    count < 384 || in_interrupt() || oops_in_progress )
+	    count < 384 || in_interrupt() || oops_in_progress)
 		goto out_copy;
 
 	dma_src = dma_map_single(dev, buf, count, DMA_TO_DEVICE);
@@ -528,7 +528,8 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 		 c->gpmc_cs, c->phys_base, c->onenand.base,
 		 c->dma_chan ? "DMA" : "PIO");
 
-	if ((r = onenand_scan(&c->mtd, 1)) < 0)
+	r = onenand_scan(&c->mtd, 1);
+	if (r < 0)
 		goto err_release_dma;
 
 	freq = omap2_onenand_get_freq(c->onenand.version_id);
diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index 77bd32a683e1..85640ee11c86 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -2853,7 +2853,7 @@ static int onenand_otp_write_oob_nolock(struct mtd_info *mtd, loff_t to,
 
 		/* Exit OTP access mode */
 		this->command(mtd, ONENAND_CMD_RESET, 0, 0);
-		this->wait(mtd, FL_RESETING);
+		this->wait(mtd, FL_RESETTING);
 
 		status = this->read_word(this->base + ONENAND_REG_CTRL_STATUS);
 		status &= 0x60;
@@ -2924,7 +2924,7 @@ static int do_otp_read(struct mtd_info *mtd, loff_t from, size_t len,
 
 	/* Exit OTP access mode */
 	this->command(mtd, ONENAND_CMD_RESET, 0, 0);
-	this->wait(mtd, FL_RESETING);
+	this->wait(mtd, FL_RESETTING);
 
 	return ret;
 }
@@ -2968,7 +2968,7 @@ static int do_otp_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	/* Exit OTP access mode */
 	this->command(mtd, ONENAND_CMD_RESET, 0, 0);
-	this->wait(mtd, FL_RESETING);
+	this->wait(mtd, FL_RESETTING);
 
 	return ret;
 }
@@ -3008,7 +3008,7 @@ static int do_otp_lock(struct mtd_info *mtd, loff_t from, size_t len,
 
 		/* Exit OTP access mode */
 		this->command(mtd, ONENAND_CMD_RESET, 0, 0);
-		this->wait(mtd, FL_RESETING);
+		this->wait(mtd, FL_RESETTING);
 	} else {
 		ops.mode = MTD_OPS_PLACE_OOB;
 		ops.ooblen = len;
@@ -3413,7 +3413,7 @@ static int flexonenand_get_boundary(struct mtd_info *mtd)
 		this->boundary[die] = bdry & FLEXONENAND_PI_MASK;
 
 		this->command(mtd, ONENAND_CMD_RESET, 0, 0);
-		this->wait(mtd, FL_RESETING);
+		this->wait(mtd, FL_RESETTING);
 
 		printk(KERN_INFO "Die %d boundary: %d%s\n", die,
 		       this->boundary[die], locked ? "(Locked)" : "(Unlocked)");
@@ -3635,7 +3635,7 @@ static int flexonenand_set_boundary(struct mtd_info *mtd, int die,
 	ret = this->wait(mtd, FL_WRITING);
 out:
 	this->write_word(ONENAND_CMD_RESET, this->base + ONENAND_REG_COMMAND);
-	this->wait(mtd, FL_RESETING);
+	this->wait(mtd, FL_RESETTING);
 	if (!ret)
 		/* Recalculate device size on boundary change*/
 		flexonenand_get_size(mtd);
@@ -3671,7 +3671,7 @@ static int onenand_chip_probe(struct mtd_info *mtd)
 	/* Reset OneNAND to read default register values */
 	this->write_word(ONENAND_CMD_RESET, this->base + ONENAND_BOOTRAM);
 	/* Wait reset */
-	this->wait(mtd, FL_RESETING);
+	this->wait(mtd, FL_RESETTING);
 
 	/* Restore system configuration 1 */
 	this->write_word(syscfg, this->base + ONENAND_REG_SYS_CFG1);
diff --git a/include/linux/mtd/flashchip.h b/include/linux/mtd/flashchip.h
index ecc88a41792a..c04f690871ca 100644
--- a/include/linux/mtd/flashchip.h
+++ b/include/linux/mtd/flashchip.h
@@ -40,7 +40,7 @@ typedef enum {
 	FL_READING,
 	FL_CACHEDPRG,
 	/* These 4 come from onenand_state_t, which has been unified here */
-	FL_RESETING,
+	FL_RESETTING,
 	FL_OTPING,
 	FL_PREPARING_ERASE,
 	FL_VERIFYING_ERASE,
-- 
2.17.1

