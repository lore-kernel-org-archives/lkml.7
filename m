Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B34C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A2B20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B+vvApzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDCBS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:18:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37628 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfDCBS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 21:18:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id w23so4205299ply.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 18:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=83/mldvfQ5ApRYZnv6v/w72tJwVC4hhAsACcD/Fvxbc=;
        b=B+vvApzbmUQBFRCkgulMCQnJKPpzX1g4MCT9eUDq5dQMxZprPfxVgdzCcDw9s5HwRP
         fRuq1DcCCmx6tOrg1F+C7BoJuDW+vNVviBx8fV0511JUaN4EpUgzUz0+1YKuidX8Pxve
         39dRtUroZ6FyFQZBBsd1oLbaligB649YXJBOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=83/mldvfQ5ApRYZnv6v/w72tJwVC4hhAsACcD/Fvxbc=;
        b=cLsaunmNl9kwmI4aMZHbQy+wi+YSrTfPscGaEeBc2aX9FF9HtMelzoI5gZzaIQA6Ki
         B3FSn147fwUPOKCJ/7m6yp2c1YA8uBb0S/P80ymSq7FApRw7e0Vtr8YHbUpG5kC1fxeo
         SDFpC2cVVyhRBZsKtBAHAtOl3okW+HyloXhOeTleKXyR+dxv/G9R0Zf0KTpgaOeYHDZf
         3clojyHzH+hRU/8nL6mwfKCOqeomRyFVykhMINxaheGyPJmTzz6Vf+E3X4c8STO1xLIV
         zYCQptvZIqk9VVz1dgHYltQfLG0y0QIBfmsH2ipz3di89CXToGXZHFPWcNkAkhg97ft4
         4rKA==
X-Gm-Message-State: APjAAAWIB4BrzdV7525quGSWiQj0pSsp0TfWDDRWMZhyiWRS+LuY4dL5
        RAjEexl+BDQQZldhsjfDKu6ysPEmjW+PrQ==
X-Google-Smtp-Source: APXvYqy6/QhDe+ANYDzZlDNaB7daHEDF4Oob05cwElKKR8cEM7VkMUwcNjoxUdZJzBFjOsI4lFkneQ==
X-Received: by 2002:a17:902:b282:: with SMTP id u2mr55960720plr.9.1554254334768;
        Tue, 02 Apr 2019 18:18:54 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 4sm19589046pfn.159.2019.04.02.18.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 18:18:53 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>,
        Michael Cheng <ccheng@broadcom.com>
Subject: [PATCH v6 2/9] i2c: iproc: Add slave mode support
Date:   Tue,  2 Apr 2019 18:18:23 -0700
Message-Id: <20190403011830.3254-3-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403011830.3254-1-ray.jui@broadcom.com>
References: <20190403011830.3254-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>

Add slave mode support to the iProc I2C driver.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Michael Cheng <ccheng@broadcom.com>
Signed-off-by: Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/i2c/busses/Kconfig         |   1 +
 drivers/i2c/busses/i2c-bcm-iproc.c | 304 ++++++++++++++++++++++++++++-
 2 files changed, 299 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index f8979abb9a19..a425198c9fc1 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -425,6 +425,7 @@ config I2C_BCM_IPROC
 	tristate "Broadcom iProc I2C controller"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
 	default ARCH_BCM_IPROC
+	select I2C_SLAVE
 	help
 	  If you say yes to this option, support will be included for the
 	  Broadcom iProc I2C controller.
diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 4c31f4e178b6..915c1b5aafd8 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -23,11 +23,30 @@
 #define CFG_OFFSET                   0x00
 #define CFG_RESET_SHIFT              31
 #define CFG_EN_SHIFT                 30
+#define CFG_SLAVE_ADDR_0_SHIFT       28
 #define CFG_M_RETRY_CNT_SHIFT        16
 #define CFG_M_RETRY_CNT_MASK         0x0f
 
 #define TIM_CFG_OFFSET               0x04
 #define TIM_CFG_MODE_400_SHIFT       31
+#define TIM_RAND_SLAVE_STRETCH_SHIFT      24
+#define TIM_RAND_SLAVE_STRETCH_MASK       0x7f
+#define TIM_PERIODIC_SLAVE_STRETCH_SHIFT  16
+#define TIM_PERIODIC_SLAVE_STRETCH_MASK   0x7f
+
+#define S_CFG_SMBUS_ADDR_OFFSET           0x08
+#define S_CFG_EN_NIC_SMB_ADDR3_SHIFT      31
+#define S_CFG_NIC_SMB_ADDR3_SHIFT         24
+#define S_CFG_NIC_SMB_ADDR3_MASK          0x7f
+#define S_CFG_EN_NIC_SMB_ADDR2_SHIFT      23
+#define S_CFG_NIC_SMB_ADDR2_SHIFT         16
+#define S_CFG_NIC_SMB_ADDR2_MASK          0x7f
+#define S_CFG_EN_NIC_SMB_ADDR1_SHIFT      15
+#define S_CFG_NIC_SMB_ADDR1_SHIFT         8
+#define S_CFG_NIC_SMB_ADDR1_MASK          0x7f
+#define S_CFG_EN_NIC_SMB_ADDR0_SHIFT      7
+#define S_CFG_NIC_SMB_ADDR0_SHIFT         0
+#define S_CFG_NIC_SMB_ADDR0_MASK          0x7f
 
 #define M_FIFO_CTRL_OFFSET           0x0c
 #define M_FIFO_RX_FLUSH_SHIFT        31
@@ -37,6 +56,14 @@
 #define M_FIFO_RX_THLD_SHIFT         8
 #define M_FIFO_RX_THLD_MASK          0x3f
 
+#define S_FIFO_CTRL_OFFSET           0x10
+#define S_FIFO_RX_FLUSH_SHIFT        31
+#define S_FIFO_TX_FLUSH_SHIFT        30
+#define S_FIFO_RX_CNT_SHIFT          16
+#define S_FIFO_RX_CNT_MASK           0x7f
+#define S_FIFO_RX_THLD_SHIFT         8
+#define S_FIFO_RX_THLD_MASK          0x3f
+
 #define M_CMD_OFFSET                 0x30
 #define M_CMD_START_BUSY_SHIFT       31
 #define M_CMD_STATUS_SHIFT           25
@@ -54,17 +81,36 @@
 #define M_CMD_RD_CNT_SHIFT           0
 #define M_CMD_RD_CNT_MASK            0xff
 
+#define S_CMD_OFFSET                 0x34
+#define S_CMD_START_BUSY_SHIFT       31
+#define S_CMD_STATUS_SHIFT           23
+#define S_CMD_STATUS_MASK            0x07
+#define S_CMD_STATUS_SUCCESS         0x0
+#define S_CMD_STATUS_TIMEOUT         0x5
+
 #define IE_OFFSET                    0x38
 #define IE_M_RX_FIFO_FULL_SHIFT      31
 #define IE_M_RX_THLD_SHIFT           30
 #define IE_M_START_BUSY_SHIFT        28
 #define IE_M_TX_UNDERRUN_SHIFT       27
+#define IE_S_RX_FIFO_FULL_SHIFT      26
+#define IE_S_RX_THLD_SHIFT           25
+#define IE_S_RX_EVENT_SHIFT          24
+#define IE_S_START_BUSY_SHIFT        23
+#define IE_S_TX_UNDERRUN_SHIFT       22
+#define IE_S_RD_EVENT_SHIFT          21
 
 #define IS_OFFSET                    0x3c
 #define IS_M_RX_FIFO_FULL_SHIFT      31
 #define IS_M_RX_THLD_SHIFT           30
 #define IS_M_START_BUSY_SHIFT        28
 #define IS_M_TX_UNDERRUN_SHIFT       27
+#define IS_S_RX_FIFO_FULL_SHIFT      26
+#define IS_S_RX_THLD_SHIFT           25
+#define IS_S_RX_EVENT_SHIFT          24
+#define IS_S_START_BUSY_SHIFT        23
+#define IS_S_TX_UNDERRUN_SHIFT       22
+#define IS_S_RD_EVENT_SHIFT          21
 
 #define M_TX_OFFSET                  0x40
 #define M_TX_WR_STATUS_SHIFT         31
@@ -78,6 +124,18 @@
 #define M_RX_DATA_SHIFT              0
 #define M_RX_DATA_MASK               0xff
 
+#define S_TX_OFFSET                  0x48
+#define S_TX_WR_STATUS_SHIFT         31
+#define S_TX_DATA_SHIFT              0
+#define S_TX_DATA_MASK               0xff
+
+#define S_RX_OFFSET                  0x4c
+#define S_RX_STATUS_SHIFT            30
+#define S_RX_STATUS_MASK             0x03
+#define S_RX_PEC_ERR_SHIFT           29
+#define S_RX_DATA_SHIFT              0
+#define S_RX_DATA_MASK               0xff
+
 #define I2C_TIMEOUT_MSEC             50000
 #define M_TX_RX_FIFO_SIZE            64
 #define M_RX_FIFO_MAX_THLD_VALUE     (M_TX_RX_FIFO_SIZE - 1)
@@ -85,6 +143,30 @@
 #define M_RX_MAX_READ_LEN            255
 #define M_RX_FIFO_THLD_VALUE         50
 
+#define IE_M_ALL_INTERRUPT_SHIFT     27
+#define IE_M_ALL_INTERRUPT_MASK      0x1e
+
+#define SLAVE_READ_WRITE_BIT_MASK    0x1
+#define SLAVE_READ_WRITE_BIT_SHIFT   0x1
+#define SLAVE_MAX_SIZE_TRANSACTION   64
+#define SLAVE_CLOCK_STRETCH_TIME     25
+
+#define IE_S_ALL_INTERRUPT_SHIFT     21
+#define IE_S_ALL_INTERRUPT_MASK      0x3f
+
+enum i2c_slave_read_status {
+	I2C_SLAVE_RX_FIFO_EMPTY = 0,
+	I2C_SLAVE_RX_START,
+	I2C_SLAVE_RX_DATA,
+	I2C_SLAVE_RX_END,
+};
+
+enum i2c_slave_xfer_dir {
+	I2C_SLAVE_DIR_READ = 0,
+	I2C_SLAVE_DIR_WRITE,
+	I2C_SLAVE_DIR_NONE,
+};
+
 enum bus_speed_index {
 	I2C_SPD_100K = 0,
 	I2C_SPD_400K,
@@ -104,6 +186,9 @@ struct bcm_iproc_i2c_dev {
 
 	struct i2c_msg *msg;
 
+	struct i2c_client *slave;
+	enum i2c_slave_xfer_dir xfer_dir;
+
 	/* bytes that have been transferred */
 	unsigned int tx_bytes;
 	/* bytes that have been read */
@@ -117,6 +202,156 @@ struct bcm_iproc_i2c_dev {
 #define ISR_MASK (BIT(IS_M_START_BUSY_SHIFT) | BIT(IS_M_TX_UNDERRUN_SHIFT)\
 		| BIT(IS_M_RX_THLD_SHIFT))
 
+#define ISR_MASK_SLAVE (BIT(IS_S_START_BUSY_SHIFT)\
+		| BIT(IS_S_RX_EVENT_SHIFT) | BIT(IS_S_RD_EVENT_SHIFT))
+
+static int bcm_iproc_i2c_reg_slave(struct i2c_client *slave);
+static int bcm_iproc_i2c_unreg_slave(struct i2c_client *slave);
+static void bcm_iproc_i2c_enable_disable(struct bcm_iproc_i2c_dev *iproc_i2c,
+					 bool enable);
+
+static void bcm_iproc_i2c_slave_init(
+	struct bcm_iproc_i2c_dev *iproc_i2c, bool need_reset)
+{
+	u32 val;
+
+	if (need_reset) {
+		/* put controller in reset */
+		val = readl(iproc_i2c->base + CFG_OFFSET);
+		val |= BIT(CFG_RESET_SHIFT);
+		writel(val, iproc_i2c->base + CFG_OFFSET);
+
+		/* wait 100 usec per spec */
+		udelay(100);
+
+		/* bring controller out of reset */
+		val &= ~(BIT(CFG_RESET_SHIFT));
+		writel(val, iproc_i2c->base + CFG_OFFSET);
+	}
+
+	/* flush TX/RX FIFOs */
+	val = (BIT(S_FIFO_RX_FLUSH_SHIFT) | BIT(S_FIFO_TX_FLUSH_SHIFT));
+	writel(val, iproc_i2c->base + S_FIFO_CTRL_OFFSET);
+
+	/* Maximum slave stretch time */
+	val = readl(iproc_i2c->base + TIM_CFG_OFFSET);
+	val &= ~(TIM_RAND_SLAVE_STRETCH_MASK << TIM_RAND_SLAVE_STRETCH_SHIFT);
+	val |= (SLAVE_CLOCK_STRETCH_TIME << TIM_RAND_SLAVE_STRETCH_SHIFT);
+	writel(val, iproc_i2c->base + TIM_CFG_OFFSET);
+
+	/* Configure the slave address */
+	val = readl(iproc_i2c->base + S_CFG_SMBUS_ADDR_OFFSET);
+	val |= BIT(S_CFG_EN_NIC_SMB_ADDR3_SHIFT);
+	val &= ~(S_CFG_NIC_SMB_ADDR3_MASK << S_CFG_NIC_SMB_ADDR3_SHIFT);
+	val |= (iproc_i2c->slave->addr << S_CFG_NIC_SMB_ADDR3_SHIFT);
+	writel(val, iproc_i2c->base + S_CFG_SMBUS_ADDR_OFFSET);
+
+	/* clear all pending slave interrupts */
+	writel(ISR_MASK_SLAVE, iproc_i2c->base + IS_OFFSET);
+
+	/* Enable interrupt register for any READ event */
+	val = BIT(IE_S_RD_EVENT_SHIFT);
+	/* Enable interrupt register to indicate a valid byte in receive fifo */
+	val |= BIT(IE_S_RX_EVENT_SHIFT);
+	/* Enable interrupt register for the Slave BUSY command */
+	val |= BIT(IE_S_START_BUSY_SHIFT);
+	writel(val, iproc_i2c->base + IE_OFFSET);
+
+	iproc_i2c->xfer_dir = I2C_SLAVE_DIR_NONE;
+}
+
+static void bcm_iproc_i2c_check_slave_status(
+	struct bcm_iproc_i2c_dev *iproc_i2c)
+{
+	u32 val;
+
+	val = readl(iproc_i2c->base + S_CMD_OFFSET);
+	val = (val >> S_CMD_STATUS_SHIFT) & S_CMD_STATUS_MASK;
+
+	if (val == S_CMD_STATUS_TIMEOUT) {
+		dev_err(iproc_i2c->device, "slave random stretch time timeout\n");
+
+		/* re-initialize i2c for recovery */
+		bcm_iproc_i2c_enable_disable(iproc_i2c, false);
+		bcm_iproc_i2c_slave_init(iproc_i2c, true);
+		bcm_iproc_i2c_enable_disable(iproc_i2c, true);
+	}
+}
+
+static bool bcm_iproc_i2c_slave_isr(struct bcm_iproc_i2c_dev *iproc_i2c,
+				u32 status)
+{
+	u8 value;
+	u32 val;
+	u32 rd_status;
+	u32 tmp;
+
+	/* Start of transaction. check address and populate the direction */
+	if (iproc_i2c->xfer_dir == I2C_SLAVE_DIR_NONE) {
+		tmp = readl(iproc_i2c->base + S_RX_OFFSET);
+		rd_status = (tmp >> S_RX_STATUS_SHIFT) & S_RX_STATUS_MASK;
+		/* This condition checks whether the request is a new request */
+		if (((rd_status == I2C_SLAVE_RX_START) &&
+			(status & BIT(IS_S_RX_EVENT_SHIFT))) ||
+			((rd_status == I2C_SLAVE_RX_END) &&
+			(status & BIT(IS_S_RD_EVENT_SHIFT)))) {
+
+			/* Last bit is W/R bit.
+			 * If 1 then its a read request(by master).
+			 */
+			iproc_i2c->xfer_dir = tmp & SLAVE_READ_WRITE_BIT_MASK;
+			if (iproc_i2c->xfer_dir == I2C_SLAVE_DIR_WRITE)
+				i2c_slave_event(iproc_i2c->slave,
+					I2C_SLAVE_READ_REQUESTED, &value);
+			else
+				i2c_slave_event(iproc_i2c->slave,
+					I2C_SLAVE_WRITE_REQUESTED, &value);
+		}
+	}
+
+	/* read request from master */
+	if ((status & BIT(IS_S_RD_EVENT_SHIFT)) &&
+		(iproc_i2c->xfer_dir == I2C_SLAVE_DIR_WRITE)) {
+		i2c_slave_event(iproc_i2c->slave,
+			I2C_SLAVE_READ_PROCESSED, &value);
+		writel(value, iproc_i2c->base + S_TX_OFFSET);
+
+		val = BIT(S_CMD_START_BUSY_SHIFT);
+		writel(val, iproc_i2c->base + S_CMD_OFFSET);
+	}
+
+	/* write request from master */
+	if ((status & BIT(IS_S_RX_EVENT_SHIFT)) &&
+		(iproc_i2c->xfer_dir == I2C_SLAVE_DIR_READ)) {
+		val = readl(iproc_i2c->base + S_RX_OFFSET);
+		/* Its a write request by Master to Slave.
+		 * We read data present in receive FIFO
+		 */
+		value = (u8)((val >> S_RX_DATA_SHIFT) & S_RX_DATA_MASK);
+		i2c_slave_event(iproc_i2c->slave,
+			I2C_SLAVE_WRITE_RECEIVED, &value);
+
+		/* check the status for the last byte of the transaction */
+		rd_status = (val >> S_RX_STATUS_SHIFT) & S_RX_STATUS_MASK;
+		if (rd_status == I2C_SLAVE_RX_END)
+			iproc_i2c->xfer_dir = I2C_SLAVE_DIR_NONE;
+
+		dev_dbg(iproc_i2c->device, "\nread value = 0x%x\n", value);
+	}
+
+	/* Stop */
+	if (status & BIT(IS_S_START_BUSY_SHIFT)) {
+		i2c_slave_event(iproc_i2c->slave, I2C_SLAVE_STOP, &value);
+		iproc_i2c->xfer_dir = I2C_SLAVE_DIR_NONE;
+	}
+
+	/* clear interrupt status */
+	writel(status, iproc_i2c->base + IS_OFFSET);
+
+	bcm_iproc_i2c_check_slave_status(iproc_i2c);
+	return true;
+}
+
 static void bcm_iproc_i2c_read_valid_bytes(struct bcm_iproc_i2c_dev *iproc_i2c)
 {
 	struct i2c_msg *msg = iproc_i2c->msg;
@@ -140,6 +375,18 @@ static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
 	u32 status = readl(iproc_i2c->base + IS_OFFSET);
 	u32 tmp;
 
+
+	bool ret;
+	u32 sl_status = status & ISR_MASK_SLAVE;
+
+	if (sl_status) {
+		ret = bcm_iproc_i2c_slave_isr(iproc_i2c, sl_status);
+		if (ret)
+			return IRQ_HANDLED;
+		else
+			return IRQ_NONE;
+	}
+
 	status &= ISR_MASK;
 
 	if (!status)
@@ -222,22 +469,25 @@ static int bcm_iproc_i2c_init(struct bcm_iproc_i2c_dev *iproc_i2c)
 
 	/* put controller in reset */
 	val = readl(iproc_i2c->base + CFG_OFFSET);
-	val |= 1 << CFG_RESET_SHIFT;
-	val &= ~(1 << CFG_EN_SHIFT);
+	val |= BIT(CFG_RESET_SHIFT);
+	val &= ~(BIT(CFG_EN_SHIFT));
 	writel(val, iproc_i2c->base + CFG_OFFSET);
 
 	/* wait 100 usec per spec */
 	udelay(100);
 
 	/* bring controller out of reset */
-	val &= ~(1 << CFG_RESET_SHIFT);
+	val &= ~(BIT(CFG_RESET_SHIFT));
 	writel(val, iproc_i2c->base + CFG_OFFSET);
 
 	/* flush TX/RX FIFOs and set RX FIFO threshold to zero */
-	val = (1 << M_FIFO_RX_FLUSH_SHIFT) | (1 << M_FIFO_TX_FLUSH_SHIFT);
+	val = (BIT(M_FIFO_RX_FLUSH_SHIFT) | BIT(M_FIFO_TX_FLUSH_SHIFT));
 	writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
 	/* disable all interrupts */
-	writel(0, iproc_i2c->base + IE_OFFSET);
+	val = readl(iproc_i2c->base + IE_OFFSET);
+	val &= ~(IE_M_ALL_INTERRUPT_MASK <<
+			IE_M_ALL_INTERRUPT_SHIFT);
+	writel(val, iproc_i2c->base + IE_OFFSET);
 
 	/* clear all pending interrupts */
 	writel(0xffffffff, iproc_i2c->base + IS_OFFSET);
@@ -440,12 +690,14 @@ static int bcm_iproc_i2c_xfer(struct i2c_adapter *adapter,
 
 static uint32_t bcm_iproc_i2c_functionality(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SLAVE;
 }
 
 static const struct i2c_algorithm bcm_iproc_algo = {
 	.master_xfer = bcm_iproc_i2c_xfer,
 	.functionality = bcm_iproc_i2c_functionality,
+	.reg_slave = bcm_iproc_i2c_reg_slave,
+	.unreg_slave = bcm_iproc_i2c_unreg_slave,
 };
 
 static struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
@@ -610,6 +862,46 @@ static const struct dev_pm_ops bcm_iproc_i2c_pm_ops = {
 #define BCM_IPROC_I2C_PM_OPS NULL
 #endif /* CONFIG_PM_SLEEP */
 
+
+static int bcm_iproc_i2c_reg_slave(struct i2c_client *slave)
+{
+	struct bcm_iproc_i2c_dev *iproc_i2c = i2c_get_adapdata(slave->adapter);
+
+	if (iproc_i2c->slave)
+		return -EBUSY;
+
+	if (slave->flags & I2C_CLIENT_TEN)
+		return -EAFNOSUPPORT;
+
+	iproc_i2c->slave = slave;
+	bcm_iproc_i2c_slave_init(iproc_i2c, false);
+	return 0;
+}
+
+static int bcm_iproc_i2c_unreg_slave(struct i2c_client *slave)
+{
+	u32 tmp;
+	struct bcm_iproc_i2c_dev *iproc_i2c = i2c_get_adapdata(slave->adapter);
+
+	if (!iproc_i2c->slave)
+		return -EINVAL;
+
+	iproc_i2c->slave = NULL;
+
+	/* disable all slave interrupts */
+	tmp = readl(iproc_i2c->base + IE_OFFSET);
+	tmp &= ~(IE_S_ALL_INTERRUPT_MASK <<
+			IE_S_ALL_INTERRUPT_SHIFT);
+	writel(tmp, iproc_i2c->base + IE_OFFSET);
+
+	/* Erase the slave address programmed */
+	tmp = readl(iproc_i2c->base + S_CFG_SMBUS_ADDR_OFFSET);
+	tmp &= ~BIT(S_CFG_EN_NIC_SMB_ADDR3_SHIFT);
+	writel(tmp, iproc_i2c->base + S_CFG_SMBUS_ADDR_OFFSET);
+
+	return 0;
+}
+
 static const struct of_device_id bcm_iproc_i2c_of_match[] = {
 	{ .compatible = "brcm,iproc-i2c" },
 	{ /* sentinel */ }
-- 
2.17.1

