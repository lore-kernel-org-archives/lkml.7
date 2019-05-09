Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD326C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 04:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5F9216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 04:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OgWLtWdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfEIEXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 00:23:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39799 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfEIEXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 00:23:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id z26so591253pfg.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 21:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rcSJ7jMxGzSyHBuvTtybXntBxEii0S3igF/TJN9iQIM=;
        b=OgWLtWdzXyiFLfdZWXjU6oUQyEbWzNrIBgpaNF2imc3orAYhSfxENDT/pQIrWt2LXs
         lX4jIbDxCZeAURP5vw1tPE/9VkATES4l2airRsgDJDa1SHhMhVNvkZjQOW4yTDoizpVt
         zpxsvy1YPBHntCWQtWgdf6xw/LOHPo+EdfZn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rcSJ7jMxGzSyHBuvTtybXntBxEii0S3igF/TJN9iQIM=;
        b=E9eqkuFq1A4eixDLLr16iyF6f8BaVAWty2sn6aNG2L1r3gvIga6re/dZHZ/JYo8Kvp
         Aj11YhMNuCujGHGgnLGZW5CAl69t/d6tmM6j86knuvz/VBjw+CxqD6dVBesDPk3Vm5Cr
         B7Yddcdny6372JnrFtd0Qyg2J2Fnrql3dCv+3g/XYO/ZZFauwAFUITNwj2UUnsDTffiH
         sC93M7ITEGiII/kLGEeP7haXVxrnQJHHAkO7f8hXpeCr0a9V9ok4LaVNPgc9GWBrfwk9
         Fs2y+cccDaDscpIq9+iJIj2AmVbS3vlFEe6fkWkowfD2di0eFCb3FnTQWFIQkX4TY5H2
         mcLQ==
X-Gm-Message-State: APjAAAWpn0iiodzuCu1YkIITQzrW/JqPFP3PXtL2Ztxxyw3Vr4VpEx27
        JICjjEQpRdni+a0HlSEYPZuBCA==
X-Google-Smtp-Source: APXvYqwpelRZDsRfFPpgs0RyfRJ//3WYRBNMvrKAp2Xdj+PZigfjMW7TqYieOosXHwh4cqCL7lawQw==
X-Received: by 2002:a65:64d9:: with SMTP id t25mr2813367pgv.130.1557375826686;
        Wed, 08 May 2019 21:23:46 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l65sm1313352pfb.7.2019.05.08.21.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 May 2019 21:23:45 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Cheng <ccheng@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 1/1] i2c: iproc: Add multi byte read-write support for slave mode
Date:   Thu,  9 May 2019 09:51:48 +0530
Message-Id: <1557375708-14830-1-git-send-email-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add multiple byte read-write support for slave mode.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 117 +++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 64 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index a845b8d..2c7f145 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -165,12 +165,6 @@ enum i2c_slave_read_status {
 	I2C_SLAVE_RX_END,
 };
 
-enum i2c_slave_xfer_dir {
-	I2C_SLAVE_DIR_READ = 0,
-	I2C_SLAVE_DIR_WRITE,
-	I2C_SLAVE_DIR_NONE,
-};
-
 enum bus_speed_index {
 	I2C_SPD_100K = 0,
 	I2C_SPD_400K,
@@ -203,7 +197,6 @@ struct bcm_iproc_i2c_dev {
 	struct i2c_msg *msg;
 
 	struct i2c_client *slave;
-	enum i2c_slave_xfer_dir xfer_dir;
 
 	/* bytes that have been transferred */
 	unsigned int tx_bytes;
@@ -219,7 +212,8 @@ struct bcm_iproc_i2c_dev {
 		| BIT(IS_M_RX_THLD_SHIFT))
 
 #define ISR_MASK_SLAVE (BIT(IS_S_START_BUSY_SHIFT)\
-		| BIT(IS_S_RX_EVENT_SHIFT) | BIT(IS_S_RD_EVENT_SHIFT))
+		| BIT(IS_S_RX_EVENT_SHIFT) | BIT(IS_S_RD_EVENT_SHIFT)\
+		| BIT(IS_S_TX_UNDERRUN_SHIFT))
 
 static int bcm_iproc_i2c_reg_slave(struct i2c_client *slave);
 static int bcm_iproc_i2c_unreg_slave(struct i2c_client *slave);
@@ -297,15 +291,11 @@ static void bcm_iproc_i2c_slave_init(
 	/* clear all pending slave interrupts */
 	iproc_i2c_wr_reg(iproc_i2c, IS_OFFSET, ISR_MASK_SLAVE);
 
-	/* Enable interrupt register for any READ event */
-	val = BIT(IE_S_RD_EVENT_SHIFT);
 	/* Enable interrupt register to indicate a valid byte in receive fifo */
-	val |= BIT(IE_S_RX_EVENT_SHIFT);
+	val = BIT(IE_S_RX_EVENT_SHIFT);
 	/* Enable interrupt register for the Slave BUSY command */
 	val |= BIT(IE_S_START_BUSY_SHIFT);
 	iproc_i2c_wr_reg(iproc_i2c, IE_OFFSET, val);
-
-	iproc_i2c->xfer_dir = I2C_SLAVE_DIR_NONE;
 }
 
 static void bcm_iproc_i2c_check_slave_status(
@@ -314,8 +304,11 @@ static void bcm_iproc_i2c_check_slave_status(
 	u32 val;
 
 	val = iproc_i2c_rd_reg(iproc_i2c, S_CMD_OFFSET);
-	val = (val >> S_CMD_STATUS_SHIFT) & S_CMD_STATUS_MASK;
+	/* status is valid only when START_BUSY is cleared after it was set */
+	if (val & BIT(S_CMD_START_BUSY_SHIFT))
+		return;
 
+	val = (val >> S_CMD_STATUS_SHIFT) & S_CMD_STATUS_MASK;
 	if (val == S_CMD_STATUS_TIMEOUT) {
 		dev_err(iproc_i2c->device, "slave random stretch time timeout\n");
 
@@ -327,70 +320,66 @@ static void bcm_iproc_i2c_check_slave_status(
 }
 
 static bool bcm_iproc_i2c_slave_isr(struct bcm_iproc_i2c_dev *iproc_i2c,
-				u32 status)
+				    u32 status)
 {
-	u8 value;
 	u32 val;
-	u32 rd_status;
-	u32 tmp;
+	u8 value, rx_status;
 
-	/* Start of transaction. check address and populate the direction */
-	if (iproc_i2c->xfer_dir == I2C_SLAVE_DIR_NONE) {
-		tmp = iproc_i2c_rd_reg(iproc_i2c, S_RX_OFFSET);
-		rd_status = (tmp >> S_RX_STATUS_SHIFT) & S_RX_STATUS_MASK;
-		/* This condition checks whether the request is a new request */
-		if (((rd_status == I2C_SLAVE_RX_START) &&
-			(status & BIT(IS_S_RX_EVENT_SHIFT))) ||
-			((rd_status == I2C_SLAVE_RX_END) &&
-			(status & BIT(IS_S_RD_EVENT_SHIFT)))) {
-
-			/* Last bit is W/R bit.
-			 * If 1 then its a read request(by master).
-			 */
-			iproc_i2c->xfer_dir = tmp & SLAVE_READ_WRITE_BIT_MASK;
-			if (iproc_i2c->xfer_dir == I2C_SLAVE_DIR_WRITE)
-				i2c_slave_event(iproc_i2c->slave,
-					I2C_SLAVE_READ_REQUESTED, &value);
-			else
-				i2c_slave_event(iproc_i2c->slave,
+	/* Slave RX byte receive */
+	if (status & BIT(IS_S_RX_EVENT_SHIFT)) {
+		val = iproc_i2c_rd_reg(iproc_i2c, S_RX_OFFSET);
+		rx_status = (val >> S_RX_STATUS_SHIFT) & S_RX_STATUS_MASK;
+		if (rx_status == I2C_SLAVE_RX_START) {
+			/* Start of SMBUS for Master write */
+			i2c_slave_event(iproc_i2c->slave,
 					I2C_SLAVE_WRITE_REQUESTED, &value);
-		}
-	}
 
-	/* read request from master */
-	if ((status & BIT(IS_S_RD_EVENT_SHIFT)) &&
-		(iproc_i2c->xfer_dir == I2C_SLAVE_DIR_WRITE)) {
-		i2c_slave_event(iproc_i2c->slave,
-			I2C_SLAVE_READ_PROCESSED, &value);
-		iproc_i2c_wr_reg(iproc_i2c, S_TX_OFFSET, value);
+			val = iproc_i2c_rd_reg(iproc_i2c, S_RX_OFFSET);
+			value = (u8)((val >> S_RX_DATA_SHIFT) & S_RX_DATA_MASK);
+			i2c_slave_event(iproc_i2c->slave,
+					I2C_SLAVE_WRITE_RECEIVED, &value);
+		} else if (status & BIT(IS_S_RD_EVENT_SHIFT)) {
+			/* Start of SMBUS for Master Read */
+			i2c_slave_event(iproc_i2c->slave,
+					I2C_SLAVE_READ_REQUESTED, &value);
+			iproc_i2c_wr_reg(iproc_i2c, S_TX_OFFSET, value);
 
-		val = BIT(S_CMD_START_BUSY_SHIFT);
-		iproc_i2c_wr_reg(iproc_i2c, S_CMD_OFFSET, val);
-	}
+			val = BIT(S_CMD_START_BUSY_SHIFT);
+			iproc_i2c_wr_reg(iproc_i2c, S_CMD_OFFSET, val);
 
-	/* write request from master */
-	if ((status & BIT(IS_S_RX_EVENT_SHIFT)) &&
-		(iproc_i2c->xfer_dir == I2C_SLAVE_DIR_READ)) {
-		val = iproc_i2c_rd_reg(iproc_i2c, S_RX_OFFSET);
-		/* Its a write request by Master to Slave.
-		 * We read data present in receive FIFO
-		 */
-		value = (u8)((val >> S_RX_DATA_SHIFT) & S_RX_DATA_MASK);
+			/*
+			 * Enable interrupt for TX FIFO becomes empty and
+			 * less than PKT_LENGTH bytes were output on the SMBUS
+			 */
+			val = iproc_i2c_rd_reg(iproc_i2c, IE_OFFSET);
+			val |= BIT(IE_S_TX_UNDERRUN_SHIFT);
+			iproc_i2c_wr_reg(iproc_i2c, IE_OFFSET, val);
+		} else {
+			/* Master write other than start */
+			value = (u8)((val >> S_RX_DATA_SHIFT) & S_RX_DATA_MASK);
+			i2c_slave_event(iproc_i2c->slave,
+					I2C_SLAVE_WRITE_RECEIVED, &value);
+		}
+	} else if (status & BIT(IS_S_TX_UNDERRUN_SHIFT)) {
+		/* Master read other than start */
 		i2c_slave_event(iproc_i2c->slave,
-			I2C_SLAVE_WRITE_RECEIVED, &value);
-
-		/* check the status for the last byte of the transaction */
-		rd_status = (val >> S_RX_STATUS_SHIFT) & S_RX_STATUS_MASK;
-		if (rd_status == I2C_SLAVE_RX_END)
-			iproc_i2c->xfer_dir = I2C_SLAVE_DIR_NONE;
+				I2C_SLAVE_READ_PROCESSED, &value);
 
-		dev_dbg(iproc_i2c->device, "\nread value = 0x%x\n", value);
+		iproc_i2c_wr_reg(iproc_i2c, S_TX_OFFSET, value);
+		val = BIT(S_CMD_START_BUSY_SHIFT);
+		iproc_i2c_wr_reg(iproc_i2c, S_CMD_OFFSET, val);
 	}
 
 	/* Stop */
 	if (status & BIT(IS_S_START_BUSY_SHIFT)) {
 		i2c_slave_event(iproc_i2c->slave, I2C_SLAVE_STOP, &value);
-		iproc_i2c->xfer_dir = I2C_SLAVE_DIR_NONE;
+		/*
+		 * Enable interrupt for TX FIFO becomes empty and
+		 * less than PKT_LENGTH bytes were output on the SMBUS
+		 */
+		val = iproc_i2c_rd_reg(iproc_i2c, IE_OFFSET);
+		val &= ~BIT(IE_S_TX_UNDERRUN_SHIFT);
+		iproc_i2c_wr_reg(iproc_i2c, IE_OFFSET, val);
 	}
 
 	/* clear interrupt status */
-- 
1.9.1

