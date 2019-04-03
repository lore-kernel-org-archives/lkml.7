Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0609C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9307520830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XilDYbNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfDCBTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:19:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42083 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfDCBTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 21:19:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id cv12so7148363plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 18:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mS9RC9bQ7HGbKLDI0eFIMx9AuPi+28D39D6SdQFqmaw=;
        b=XilDYbNKVC+li380iKpO9emCX9eUABns4oap/dQdGHG3q9wDW3jZam+IwE5yyHsrw7
         39ElK6uP8KtQTPu9fr4Oc2YqPibCxAXgnH50xZP1q96Sr2kX784a+dF0GolzhX5Vj940
         39fSPkhH3sVOeHm0H5OSe9BWPd/Ft9gnljZLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mS9RC9bQ7HGbKLDI0eFIMx9AuPi+28D39D6SdQFqmaw=;
        b=Xy1ACRYJclQUs6x9VeRfd2aNABcQMkWJr+cUY6HADTQeve4MtmlurTZ/DctCm4M8oN
         NyV0XTX9D7tj5eB58Zmke2MuYI2upl2/gP8uFFmTDLkj0I0bkidH+t/j7QWqGkMULM6z
         t2r8bTOs1X/n7GeIroZ7ohqiBus65a+MhdqbwG/R3xANtm/6LseDHfAnn3X+b+dbQHzl
         Gt0rn/Bq9LeYcHC3Rm6DOkM5q/EkNLujR8+JN1Yq/65ct6w0czopPIZrxcXUns4ttyfb
         wyVFtQuaW8diWX9NFBlstj4crydJlsheisTeVJh1F5o05vaj5rJzT/GqZLDsry3X1Erh
         nY7A==
X-Gm-Message-State: APjAAAXklFeSoi1gNhqD1IGN20mTXyKcnZgjHfuVyxRXHZ2t2UgFTIV8
        uM/ZQY9P2e1Gkz8qpjMfWDVp+w==
X-Google-Smtp-Source: APXvYqz9zy4QDTyy1AsNtv+q2sre13FbbDiqCZLktsSCvz3tS0TPPT/39PaZV/SO9Iw9kd1IrgSmWg==
X-Received: by 2002:a17:902:6b48:: with SMTP id g8mr73270177plt.21.1554254352092;
        Tue, 02 Apr 2019 18:19:12 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 4sm19589046pfn.159.2019.04.02.18.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 18:19:11 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v6 8/9] i2c: iproc: add NIC I2C support
Date:   Tue,  2 Apr 2019 18:18:29 -0700
Message-Id: <20190403011830.3254-9-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403011830.3254-1-ray.jui@broadcom.com>
References: <20190403011830.3254-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Add NIC I2C support to the iProc I2C driver. Access to the NIC I2C base
registers requires going through the IDM wrapper to map into the NIC's
address space

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 80 ++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index dba1a9d925b2..562942d0c05c 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -17,9 +17,11 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#define IDM_CTRL_DIRECT_OFFSET       0x00
 #define CFG_OFFSET                   0x00
 #define CFG_RESET_SHIFT              31
 #define CFG_EN_SHIFT                 30
@@ -174,11 +176,23 @@ enum bus_speed_index {
 	I2C_SPD_400K,
 };
 
+enum bcm_iproc_i2c_type {
+	IPROC_I2C,
+	IPROC_I2C_NIC
+};
+
 struct bcm_iproc_i2c_dev {
 	struct device *device;
+	enum bcm_iproc_i2c_type type;
 	int irq;
 
 	void __iomem *base;
+	void __iomem *idm_base;
+
+	u32 ape_addr_mask;
+
+	/* lock for indirect access through IDM */
+	spinlock_t idm_lock;
 
 	struct i2c_adapter adapter;
 	unsigned int bus_speed;
@@ -215,13 +229,33 @@ static void bcm_iproc_i2c_enable_disable(struct bcm_iproc_i2c_dev *iproc_i2c,
 static inline u32 iproc_i2c_rd_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
 				   u32 offset)
 {
-	return readl(iproc_i2c->base + offset);
+	u32 val;
+
+	if (iproc_i2c->idm_base) {
+		spin_lock(&iproc_i2c->idm_lock);
+		writel(iproc_i2c->ape_addr_mask,
+		       iproc_i2c->idm_base + IDM_CTRL_DIRECT_OFFSET);
+		val = readl(iproc_i2c->base + offset);
+		spin_unlock(&iproc_i2c->idm_lock);
+	} else {
+		val = readl(iproc_i2c->base + offset);
+	}
+
+	return val;
 }
 
 static inline void iproc_i2c_wr_reg(struct bcm_iproc_i2c_dev *iproc_i2c,
 				    u32 offset, u32 val)
 {
-	writel(val, iproc_i2c->base + offset);
+	if (iproc_i2c->idm_base) {
+		spin_lock(&iproc_i2c->idm_lock);
+		writel(iproc_i2c->ape_addr_mask,
+		       iproc_i2c->idm_base + IDM_CTRL_DIRECT_OFFSET);
+		writel(val, iproc_i2c->base + offset);
+		spin_unlock(&iproc_i2c->idm_lock);
+	} else {
+		writel(val, iproc_i2c->base + offset);
+	}
 }
 
 static void bcm_iproc_i2c_slave_init(
@@ -765,10 +799,15 @@ static int bcm_iproc_i2c_xfer(struct i2c_adapter *adapter,
 
 static uint32_t bcm_iproc_i2c_functionality(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SLAVE;
+	u32 val = I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+
+	if (adap->algo->reg_slave)
+		val |= I2C_FUNC_SLAVE;
+
+	return val;
 }
 
-static const struct i2c_algorithm bcm_iproc_algo = {
+static struct i2c_algorithm bcm_iproc_algo = {
 	.master_xfer = bcm_iproc_i2c_xfer,
 	.functionality = bcm_iproc_i2c_functionality,
 	.reg_slave = bcm_iproc_i2c_reg_slave,
@@ -828,6 +867,8 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, iproc_i2c);
 	iproc_i2c->device = &pdev->dev;
+	iproc_i2c->type =
+		(enum bcm_iproc_i2c_type)of_device_get_match_data(&pdev->dev);
 	init_completion(&iproc_i2c->done);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -835,6 +876,29 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(iproc_i2c->base))
 		return PTR_ERR(iproc_i2c->base);
 
+	if (iproc_i2c->type == IPROC_I2C_NIC) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		iproc_i2c->idm_base = devm_ioremap_resource(iproc_i2c->device,
+							    res);
+		if (IS_ERR(iproc_i2c->idm_base))
+			return PTR_ERR(iproc_i2c->idm_base);
+
+		ret = of_property_read_u32(iproc_i2c->device->of_node,
+					   "brcm,ape-hsls-addr-mask",
+					   &iproc_i2c->ape_addr_mask);
+		if (ret < 0) {
+			dev_err(iproc_i2c->device,
+				"'brcm,ape-hsls-addr-mask' missing\n");
+			return -EINVAL;
+		}
+
+		spin_lock_init(&iproc_i2c->idm_lock);
+
+		/* no slave support */
+		bcm_iproc_algo.reg_slave = NULL;
+		bcm_iproc_algo.unreg_slave = NULL;
+	}
+
 	ret = bcm_iproc_i2c_init(iproc_i2c);
 	if (ret)
 		return ret;
@@ -991,7 +1055,13 @@ static int bcm_iproc_i2c_unreg_slave(struct i2c_client *slave)
 }
 
 static const struct of_device_id bcm_iproc_i2c_of_match[] = {
-	{ .compatible = "brcm,iproc-i2c" },
+	{
+		.compatible = "brcm,iproc-i2c",
+		.data = (int *)IPROC_I2C,
+	}, {
+		.compatible = "brcm,iproc-nic-i2c",
+		.data = (int *)IPROC_I2C_NIC,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, bcm_iproc_i2c_of_match);
-- 
2.17.1

