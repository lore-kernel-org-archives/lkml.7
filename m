Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF06C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97F020679
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEOXB8LN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfKTSWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 13:22:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50296 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbfKTSWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:22:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id l17so721977wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 10:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bsTvEyFTeNIAUS3mVb8NukW/8rTsNI+eY8HxLdB3rvs=;
        b=ZEOXB8LNM+F7H6W+7y1cqZxcjPOkio0fm7L6hM9VgIALdPvRQLHfzGCjWM/C05c4hs
         h3L4Od7CbRVSFwLjypMzL4xVdlCYVVhFBoW1sfsv28rNEnJphQJdFZ59+wJyXKKTCRJ6
         FdwlolgecNxOIQW/VCfkIIQg49lom+6Hkg3U41WbdFMjAOscl+Bjf0K3DrD8Mzs7bHZ6
         RUgqnFUaXaGPA/qG7HU5GLgLAW42VmkUitFY9mlKnSjNMaJJm5OBQBZ+hEqd+5Aa0nYB
         O8lFSQBpSXRY3md0vh60ZfYwZWHc0WEWWFW9duhrrs/IZtQGTFz+CoZ+dvM3aStg0bZu
         AWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bsTvEyFTeNIAUS3mVb8NukW/8rTsNI+eY8HxLdB3rvs=;
        b=bp3APhMTLdyaen7GJ524cu2Z9XwoRXevI5rbfmFC5QyDSBO5cZ5QSf7OIvSU5Wv+ui
         AMUMnySDCe9W/P0Up1YnxqIYZolcdD1tMe7R2PXGE8Hv5bnOlaEkpd8BxPTN1zXtxmMq
         tsgf0iY2EJT9AcEL4FKFsNvEmY7u8wZDw4KODS6HuChhCfPaIVyL+lMzzxwYuRze4pe2
         3qNjtsfv8CGQGS2lfNbBMCGgC79azyUEIkdCiZTLCjHpdU07uybKlGy7Q75cDuXjtAx7
         aJXbEwybkACeqJajE98gxzkHAxOXGamP4G3B6aBcgVCi0ZMLQOkJ8efis8cD4boEJDVp
         xHsw==
X-Gm-Message-State: APjAAAVmA6ZJGFPARrnNNNJEBpcWEy/QgoM15IBry24VGyMOSKR8giwh
        M3dPHNFH+sbUbxh15OjlPYk=
X-Google-Smtp-Source: APXvYqz2ad4YfCM+3eB+sWJuYud2XkgXWhgx3KzNNhEiL2l22494dP0ekbPqI3yKhqC3QUjllzZ1PQ==
X-Received: by 2002:a7b:cf32:: with SMTP id m18mr5094987wmg.166.1574274150604;
        Wed, 20 Nov 2019 10:22:30 -0800 (PST)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id x205sm151153wmb.5.2019.11.20.10.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:22:30 -0800 (PST)
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
Subject: [PATCH 3/3] mtd: rawnand: brcmnand: Add support for flash-edu for dma transfers
Date:   Wed, 20 Nov 2019 13:20:59 -0500
Message-Id: <20191120182153.29732-3-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120182153.29732-1-kdasu.kdev@gmail.com>
References: <20191120182153.29732-1-kdasu.kdev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Legacy mips soc platforms that have controller v5.0 and 6.0 use
flash-edu block for dma transfers. This change adds support for
nand dma transfers using the EDU block.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 269 ++++++++++++++++++++++-
 1 file changed, 263 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 15ef30b368a5..05663e3ef20f 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -102,6 +102,44 @@ struct brcm_nand_dma_desc {
 #define NAND_CTRL_RDY			(INTFC_CTLR_READY | INTFC_FLASH_READY)
 #define NAND_POLL_STATUS_TIMEOUT_MS	100
 
+#define EDU_CMD_WRITE          0x00
+#define EDU_CMD_READ           0x01
+#define EDU_STATUS_ACTIVE      BIT(0)
+#define EDU_ERR_STATUS_ERRACK  BIT(0)
+
+#define EDU_CONFIG_MODE_NAND   BIT(0)
+#define EDU_CONFIG_SWAP_BYTE   BIT(1)
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define EDU_CONFIG_SWAP_CFG     EDU_CONFIG_SWAP_BYTE
+#else
+#define EDU_CONFIG_SWAP_CFG     0
+#endif
+
+/* edu registers */
+enum edu_reg {
+	EDU_CONFIG = 0,
+	EDU_DRAM_ADDR,
+	EDU_EXT_ADDR,
+	EDU_LENGTH,
+	EDU_CMD,
+	EDU_STOP,
+	EDU_STATUS,
+	EDU_DONE,
+	EDU_ERR_STATUS,
+};
+
+static const u16  edu_regs[] = {
+	[EDU_CONFIG] = 0x00,
+	[EDU_DRAM_ADDR] = 0x04,
+	[EDU_EXT_ADDR] = 0x08,
+	[EDU_LENGTH] = 0x0c,
+	[EDU_CMD] = 0x10,
+	[EDU_STOP] = 0x14,
+	[EDU_STATUS] = 0x18,
+	[EDU_DONE] = 0x1c,
+	[EDU_ERR_STATUS] = 0x20,
+};
+
 /* flash_dma registers */
 enum flash_dma_reg {
 	FLASH_DMA_REVISION = 0,
@@ -155,6 +193,8 @@ enum {
 	BRCMNAND_HAS_WP				= BIT(3),
 };
 
+struct brcmnand_host;
+
 struct brcmnand_controller {
 	struct device		*dev;
 	struct nand_controller	controller;
@@ -173,17 +213,32 @@ struct brcmnand_controller {
 
 	int			cmd_pending;
 	bool			dma_pending;
+	bool                    edu_pending;
 	struct completion	done;
 	struct completion	dma_done;
+	struct completion       edu_done;
 
 	/* List of NAND hosts (one for each chip-select) */
 	struct list_head host_list;
 
+	/* EDU info, per-transaction */
+	const u16               *edu_offsets;
+	void __iomem            *edu_base;
+	unsigned int            edu_irq;
+	int                     edu_count;
+	u64                     edu_dram_addr;
+	u32                     edu_ext_addr;
+	u32                     edu_cmd;
+	u32                     edu_config;
+
 	/* flash_dma reg */
 	const u16		*flash_dma_offsets;
 	struct brcm_nand_dma_desc *dma_desc;
 	dma_addr_t		dma_pa;
 
+	int (*dma_trans)(struct brcmnand_host *host, u64 addr, u32 *buf,
+			 u32 len, u8 dma_cmd);
+
 	/* in-memory cache of the FLASH_CACHE, used only for some commands */
 	u8			flash_cache[FC_BYTES];
 
@@ -204,6 +259,7 @@ struct brcmnand_controller {
 	u32			nand_cs_nand_xor;
 	u32			corr_stat_threshold;
 	u32			flash_dma_mode;
+	u32                     flash_edu_mode;
 	bool			pio_poll_mode;
 };
 
@@ -643,6 +699,22 @@ static inline void brcmnand_write_fc(struct brcmnand_controller *ctrl,
 	__raw_writel(val, ctrl->nand_fc + word * 4);
 }
 
+static inline void edu_writel(struct brcmnand_controller *ctrl,
+			      enum edu_reg reg, u32 val)
+{
+	u16 offs = ctrl->edu_offsets[reg];
+
+	brcmnand_writel(val, ctrl->edu_base + offs);
+}
+
+static inline u32 edu_readl(struct brcmnand_controller *ctrl,
+			    enum edu_reg reg)
+{
+	u16 offs = ctrl->edu_offsets[reg];
+
+	return brcmnand_readl(ctrl->edu_base + offs);
+}
+
 static void brcmnand_clear_ecc_addr(struct brcmnand_controller *ctrl)
 {
 
@@ -912,6 +984,16 @@ static inline bool has_flash_dma(struct brcmnand_controller *ctrl)
 	return ctrl->flash_dma_base;
 }
 
+static inline bool has_edu(struct brcmnand_controller *ctrl)
+{
+	return ctrl->edu_base;
+}
+
+static inline bool use_dma(struct brcmnand_controller *ctrl)
+{
+	return has_flash_dma(ctrl) || has_edu(ctrl);
+}
+
 static inline void disable_ctrl_irqs(struct brcmnand_controller *ctrl)
 {
 	if (ctrl->pio_poll_mode)
@@ -1285,6 +1367,40 @@ static int write_oob_to_regs(struct brcmnand_controller *ctrl, int i,
 	return tbytes;
 }
 
+/* edu irq */
+static irqreturn_t brcmnand_edu_irq(int irq, void *data)
+{
+	struct brcmnand_controller *ctrl = data;
+
+	if (ctrl->edu_count) {
+		ctrl->edu_count--;
+		while (!edu_readl(ctrl, EDU_DONE))
+			udelay(1);
+		edu_writel(ctrl, EDU_DONE, 0);
+		(void)edu_readl(ctrl, EDU_DONE);
+	}
+
+	if (ctrl->edu_count) {
+		ctrl->edu_dram_addr += FC_BYTES;
+		ctrl->edu_ext_addr += FC_BYTES;
+
+		edu_writel(ctrl, EDU_DRAM_ADDR, (u32)ctrl->edu_dram_addr);
+		(void)edu_readl(ctrl, EDU_DRAM_ADDR);
+		edu_writel(ctrl, EDU_EXT_ADDR, ctrl->edu_ext_addr);
+		(void)edu_readl(ctrl, EDU_EXT_ADDR);
+
+		mb(); /* flush previous writes */
+		edu_writel(ctrl, EDU_CMD, ctrl->edu_cmd);
+		(void)edu_readl(ctrl, EDU_CMD);
+
+		return IRQ_HANDLED;
+	}
+
+	complete(&ctrl->edu_done);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t brcmnand_ctlrdy_irq(int irq, void *data)
 {
 	struct brcmnand_controller *ctrl = data;
@@ -1293,6 +1409,16 @@ static irqreturn_t brcmnand_ctlrdy_irq(int irq, void *data)
 	if (ctrl->dma_pending)
 		return IRQ_HANDLED;
 
+	/* check if you need to piggy back on the ctrlrdy irq */
+	if (ctrl->edu_pending) {
+		if (irq == ctrl->irq && ((int)ctrl->edu_irq >= 0))
+	/* Discard interrupts while using dedicated edu irq */
+			return IRQ_HANDLED;
+
+	/* no registered edu irq, call handler */
+		return brcmnand_edu_irq(irq, data);
+	}
+
 	complete(&ctrl->done);
 	return IRQ_HANDLED;
 }
@@ -1630,6 +1756,82 @@ static void brcmnand_write_buf(struct nand_chip *chip, const uint8_t *buf,
 	}
 }
 
+/**
+ *  Kick EDU engine
+ */
+static int brcmnand_edu_trans(struct brcmnand_host *host, u64 addr, u32 *buf,
+			      u32 len, u8 edu_cmd)
+{
+	struct brcmnand_controller *ctrl = host->ctrl;
+	unsigned long timeo = msecs_to_jiffies(200);
+	int ret = 0;
+	int dir = edu_cmd == EDU_CMD_READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+	unsigned int trans = len/FC_BYTES;
+	dma_addr_t pa;
+
+	pa = dma_map_single(ctrl->dev, buf, len, dir);
+	if (dma_mapping_error(ctrl->dev, pa)) {
+		dev_err(ctrl->dev, "unable to map buffer for EDU DMA\n");
+		return -ENOMEM;
+	}
+
+	/* Start edu engine */
+	ctrl->edu_pending = true;
+	mb(); /* flush previous writes */
+
+	ctrl->edu_dram_addr = pa;
+	ctrl->edu_ext_addr = addr;
+	ctrl->edu_cmd = edu_cmd;
+	ctrl->edu_count = trans;
+
+	edu_writel(ctrl, EDU_DRAM_ADDR, (u32)ctrl->edu_dram_addr);
+	(void)brcmnand_read_reg(ctrl,  EDU_DRAM_ADDR);
+	edu_writel(ctrl, EDU_EXT_ADDR, ctrl->edu_ext_addr);
+	(void)edu_readl(ctrl, EDU_EXT_ADDR);
+	edu_writel(ctrl, EDU_LENGTH, FC_BYTES);
+	(void)edu_readl(ctrl, EDU_LENGTH);
+
+	mb(); /* flush previous writes */
+	edu_writel(ctrl, EDU_CMD, ctrl->edu_cmd);
+	(void)edu_readl(ctrl, EDU_CMD);
+
+	if (wait_for_completion_timeout(&ctrl->edu_done, timeo) <= 0) {
+		dev_err(ctrl->dev,
+			"timeout waiting for EDU; status %#x, error status %#x\n",
+			edu_readl(ctrl, EDU_STATUS),
+			edu_readl(ctrl, EDU_ERR_STATUS));
+	}
+
+	dma_unmap_single(ctrl->dev, pa, len, dir);
+
+	/* for program page check NAND status */
+	if (((brcmnand_read_reg(ctrl, BRCMNAND_INTFC_STATUS) &
+	      INTFC_FLASH_STATUS) & NAND_STATUS_FAIL) &&
+	    edu_cmd == EDU_CMD_WRITE) {
+		dev_info(ctrl->dev, "program failed at %llx\n",
+			 (unsigned long long)addr);
+		ret = -EIO;
+	}
+
+	/* Make sure the EDU status is clean */
+	if (edu_readl(ctrl, EDU_STATUS) & EDU_STATUS_ACTIVE)
+		dev_warn(ctrl->dev, "EDU still active: %#x\n",
+			 edu_readl(ctrl, EDU_STATUS));
+
+	if (unlikely(edu_readl(ctrl, EDU_ERR_STATUS) & EDU_ERR_STATUS_ERRACK)) {
+		dev_warn(ctrl->dev, "EDU RBUS error at addr %llx\n",
+			 (unsigned long long)addr);
+		ret = -EIO;
+	}
+
+	edu_writel(ctrl, EDU_ERR_STATUS, 0);
+
+	ctrl->edu_pending = false;
+	edu_writel(ctrl, EDU_STOP, 0); /* force stop */
+
+	return ret;
+}
+
 /**
  * Construct a FLASH_DMA descriptor as part of a linked list. You must know the
  * following ahead of time:
@@ -1833,9 +2035,11 @@ static int brcmnand_read(struct mtd_info *mtd, struct nand_chip *chip,
 try_dmaread:
 	brcmnand_clear_ecc_addr(ctrl);
 
-	if (has_flash_dma(ctrl) && !oob && flash_dma_buf_ok(buf)) {
-		err = brcmnand_dma_trans(host, addr, buf, trans * FC_BYTES,
-					     CMD_PAGE_READ);
+	if (ctrl->dma_trans && !oob && flash_dma_buf_ok(buf)) {
+		err = ctrl->dma_trans(host, addr, buf,
+				      trans * FC_BYTES,
+				      CMD_PAGE_READ);
+
 		if (err) {
 			if (mtd_is_bitflip_or_eccerr(err))
 				err_addr = addr;
@@ -1971,10 +2175,12 @@ static int brcmnand_write(struct mtd_info *mtd, struct nand_chip *chip,
 	for (i = 0; i < ctrl->max_oob; i += 4)
 		oob_reg_write(ctrl, i, 0xffffffff);
 
-	if (has_flash_dma(ctrl) && !oob && flash_dma_buf_ok(buf)) {
-		if (brcmnand_dma_trans(host, addr, (u32 *)buf,
-					mtd->writesize, CMD_PROGRAM_PAGE))
+	if (use_dma(ctrl) && !oob && flash_dma_buf_ok(buf)) {
+		if (ctrl->dma_trans(host, addr, (u32 *)buf, mtd->writesize,
+				    CMD_PROGRAM_PAGE))
+
 			ret = -EIO;
+
 		goto out;
 	}
 
@@ -2561,6 +2767,7 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 
 	init_completion(&ctrl->done);
 	init_completion(&ctrl->dma_done);
+	init_completion(&ctrl->edu_done);
 	nand_controller_init(&ctrl->controller);
 	ctrl->controller.ops = &brcmnand_controller_ops;
 	INIT_LIST_HEAD(&ctrl->host_list);
@@ -2650,6 +2857,56 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 		dev_info(dev, "enabling FLASH_DMA\n");
 	}
 
+	/* use EDU DMA only no FLASH_DMA present */
+	if (has_flash_dma(ctrl))
+		res = 0;
+	else
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   "flash-edu");
+
+	if (res) {
+		ctrl->edu_base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(ctrl->edu_base))
+			return PTR_ERR(ctrl->edu_base);
+
+		ctrl->edu_offsets = edu_regs;
+
+		edu_writel(ctrl, EDU_CONFIG, EDU_CONFIG_MODE_NAND |
+			   EDU_CONFIG_SWAP_CFG);
+		(void)edu_readl(ctrl, EDU_CONFIG);
+
+		/* initialize edu */
+		edu_writel(ctrl, EDU_ERR_STATUS, 0);
+		edu_writel(ctrl, EDU_DONE, 0);
+		(void)edu_readl(ctrl, EDU_DONE);
+
+		ctrl->edu_irq = platform_get_irq(pdev, 1);
+		if ((int)ctrl->edu_irq < 0) {
+			dev_warn(dev,
+				 "FLASH EDU enabled, using ctlrdy irq\n");
+		} else {
+			ret = devm_request_irq(dev, ctrl->edu_irq,
+					       brcmnand_edu_irq, 0,
+					       "brcmnand-edu", ctrl);
+			if (ret < 0) {
+				dev_err(dev, "can't allocate IRQ %d: error %d\n",
+					ctrl->edu_irq, ret);
+				return ret;
+			}
+
+			dev_info(dev, "FLASH EDU enabled using irq %u\n",
+				 ctrl->edu_irq);
+		}
+	}
+
+	/* set the appropriate dma transfer function to call */
+	if (has_flash_dma(ctrl))
+		ctrl->dma_trans = brcmnand_dma_trans;
+	else if (has_edu(ctrl))
+		ctrl->dma_trans = brcmnand_edu_trans;
+	else
+		ctrl->dma_trans = NULL;
+
 	/* Disable automatic device ID config, direct addressing */
 	brcmnand_rmw_reg(ctrl, BRCMNAND_CS_SELECT,
 			 CS_SELECT_AUTO_DEVICE_ID_CFG | 0xff, 0, 0);
-- 
2.17.1

