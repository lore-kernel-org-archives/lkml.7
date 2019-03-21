Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66305C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A2E21900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="nf8moiDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfCUXgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:36:55 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:33342 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfCUXgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:36:54 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 60691886BF;
        Fri, 22 Mar 2019 12:36:52 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1553211412;
        bh=6aa8aom5JJbNfaSvPO56KINp0SlakFObdkJ/6cl3uZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=nf8moiDwGPD9fPsxqWMBci0jVjzDObahsNN4AWWGbQ+Ihf80T3KR2bQtCty5sh9B+
         O7jcjJ0G7WgL3nVDCLkCZzVDpH/dBcJbFyLY/lDmo+xMN3i9lcvwhEIAvVuxdCOWgt
         j6xFsNIcfVMjzO/8aUE80Nurocl3mfePxt+VfqmeP5vNDlJ9nFmBo6RYaaqnhAck1B
         VkNuZ236OciANqukhHYC04VfjWSlCBweyh14tPELQ9seyfSHjMy417VIzcH2ugQZMV
         3jQa1eykDNYCx8Oj18UC4WltBD3miSsID/8S0kyUnAzRcZA6Fr8oqSxeIemTLfRFk/
         vywyEzkcK5m4A==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c9420120000>; Fri, 22 Mar 2019 12:36:50 +1300
Received: from richardl-dl.ws.atlnz.lc (richardl-dl.ws.atlnz.lc [10.33.23.10])
        by smtp (Postfix) with ESMTP id EFFD913EC40;
        Fri, 22 Mar 2019 12:36:51 +1300 (NZDT)
Received: by richardl-dl.ws.atlnz.lc (Postfix, from userid 1481)
        id CA4EA4C05D3; Fri, 22 Mar 2019 12:36:51 +1300 (NZDT)
From:   Richard Laing <richard.laing@alliedtelesis.co.nz>
To:     rjui@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc:     linux-kernel@vger.kernel.org,
        Richard Laing <richard.laing@alliedtelesis.co.nz>
Subject: [PATCH] Add i2c recovery handling for bcm-iproc based devices.
Date:   Fri, 22 Mar 2019 12:35:28 +1300
Message-Id: <20190321233528.16568-2-richard.laing@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190321233528.16568-1-richard.laing@alliedtelesis.co.nz>
References: <20190321233528.16568-1-richard.laing@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible for the i2c bus to become locked up preventing
communication with devices on the bus, add the hooks required to
allow the existing i2c recovery code to be used to clear the lock up.

Before the recovery can be perfored the device needs to be configured in
the bit-bang mode allow the clock line to be controlled directly by the
i2c_generic_recovery() in i2c-core.c. Access routines are provided to get
and set the clock line state and on completion the device is returned to
normal operations and initialised.

Signed-off-by: Richard Laing <richard.laing@alliedtelesis.co.nz>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 120 +++++++++++++++++++++++++++++++=
++++++
 1 file changed, 120 insertions(+)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-=
bcm-iproc.c
index 4c8c3bc..4cd041b 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -23,6 +23,7 @@
 #define CFG_OFFSET                   0x00
 #define CFG_RESET_SHIFT              31
 #define CFG_EN_SHIFT                 30
+#define CFG_BIT_BANG_SHIFT           29
 #define CFG_M_RETRY_CNT_SHIFT        16
 #define CFG_M_RETRY_CNT_MASK         0x0f
=20
@@ -78,6 +79,11 @@
 #define M_RX_DATA_SHIFT              0
 #define M_RX_DATA_MASK               0xff
=20
+#define M_BB_CTRL_OFFSET             0x14
+#define M_BB_CTRL_CLK_IN_SHIFT       31
+#define M_BB_CTRL_CLK_SHIFT          30
+#define M_BB_CTRL_DATA_SHIFT         29
+
 #define I2C_TIMEOUT_MSEC             50000
 #define M_TX_RX_FIFO_SIZE            64
=20
@@ -208,6 +214,117 @@ static void bcm_iproc_i2c_enable_disable(struct bcm=
_iproc_i2c_dev *iproc_i2c,
 	writel(val, iproc_i2c->base + CFG_OFFSET);
 }
=20
+/*
+ * Put the i2c controller into reset.
+ */
+static void bcm_iproc_i2c_reset(struct bcm_iproc_i2c_dev *iproc_i2c)
+{
+	u32 tmp;
+
+	tmp =3D readl(iproc_i2c->base + CFG_OFFSET);
+	tmp |=3D BIT(CFG_RESET_SHIFT);
+	writel(tmp, iproc_i2c->base + CFG_OFFSET);
+	udelay(100);
+}
+
+/*
+ * Switch to bit bang mode to prepare for i2c generic recovery.
+ */
+static void bcm_iproc_i2c_prepare_recovery(struct i2c_adapter *adap)
+{
+	struct bcm_iproc_i2c_dev *iproc_i2c =3D i2c_get_adapdata(adap);
+	u32 tmp;
+
+	dev_dbg(iproc_i2c->device, "Prepare recovery\n");
+
+	/* Disable interrupts */
+	writel(0, iproc_i2c->base + IE_OFFSET);
+	readl(iproc_i2c->base + IE_OFFSET);
+	synchronize_irq(iproc_i2c->irq);
+
+	bcm_iproc_i2c_reset(iproc_i2c);
+
+	/* Switch to bit-bang mode */
+	tmp =3D readl(iproc_i2c->base + CFG_OFFSET);
+	tmp |=3D BIT(CFG_BIT_BANG_SHIFT);
+	writel(tmp, iproc_i2c->base + CFG_OFFSET);
+}
+
+/*
+ * Return to normal i2c operation following recovery.
+ */
+static void bcm_iproc_i2c_unprepare_recovery(struct i2c_adapter *adap)
+{
+	struct bcm_iproc_i2c_dev *iproc_i2c =3D i2c_get_adapdata(adap);
+	u32 tmp;
+
+	/* Switch to normal mode */
+	tmp =3D readl(iproc_i2c->base + CFG_OFFSET);
+	tmp &=3D ~BIT(CFG_BIT_BANG_SHIFT);
+	writel(tmp, iproc_i2c->base + CFG_OFFSET);
+	udelay(100);
+
+	bcm_iproc_i2c_init(iproc_i2c);
+	bcm_iproc_i2c_enable_disable(iproc_i2c, true);
+
+	dev_dbg(iproc_i2c->device, "Recovery complete\n");
+}
+
+/*
+ * Return the SCL state, we must be configured in bit bang mode for this
+ * to work.
+ */
+static int bcm_iproc_i2c_get_scl(struct i2c_adapter *adap)
+{
+	struct bcm_iproc_i2c_dev *iproc_i2c =3D i2c_get_adapdata(adap);
+	u32 tmp;
+
+	tmp =3D readl(iproc_i2c->base + M_BB_CTRL_OFFSET);
+
+	return tmp & BIT(M_BB_CTRL_CLK_IN_SHIFT);
+}
+
+/*
+ * Set the SCL state, we must be configured in bit bang mode for this
+ * to work.
+ */
+static void bcm_iproc_i2c_set_scl(struct i2c_adapter *adap, int val)
+{
+	struct bcm_iproc_i2c_dev *iproc_i2c =3D i2c_get_adapdata(adap);
+	u32 tmp;
+
+	tmp =3D readl(iproc_i2c->base + M_BB_CTRL_OFFSET);
+	if (val)
+		tmp |=3D BIT(M_BB_CTRL_CLK_SHIFT);
+	else
+		tmp &=3D ~BIT(M_BB_CTRL_CLK_SHIFT);
+
+	writel(tmp, iproc_i2c->base + M_BB_CTRL_OFFSET);
+}
+
+/*
+ * Return the SDA state, we must be configured in bit bang mode for this
+ * to work.
+ */
+static int bcm_iproc_i2c_get_sda(struct i2c_adapter *adap)
+{
+	struct bcm_iproc_i2c_dev *iproc_i2c =3D i2c_get_adapdata(adap);
+	u32 tmp;
+
+	tmp =3D readl(iproc_i2c->base + M_BB_CTRL_OFFSET);
+
+	return tmp & BIT(M_BB_CTRL_DATA_SHIFT);
+}
+
+static struct i2c_bus_recovery_info bcm_iproc_recovery_info =3D {
+	.recover_bus =3D i2c_generic_scl_recovery,
+	.prepare_recovery =3D bcm_iproc_i2c_prepare_recovery,
+	.unprepare_recovery =3D bcm_iproc_i2c_unprepare_recovery,
+	.set_scl =3D bcm_iproc_i2c_set_scl,
+	.get_scl =3D bcm_iproc_i2c_get_scl,
+	.get_sda =3D bcm_iproc_i2c_get_sda,
+};
+
 static int bcm_iproc_i2c_check_status(struct bcm_iproc_i2c_dev *iproc_i2=
c,
 				      struct i2c_msg *msg)
 {
@@ -261,6 +378,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_i=
proc_i2c_dev *iproc_i2c,
 	if (!!(readl(iproc_i2c->base + M_CMD_OFFSET) &
 	       BIT(M_CMD_START_BUSY_SHIFT))) {
 		dev_warn(iproc_i2c->device, "bus is busy\n");
+		i2c_recover_bus(&iproc_i2c->adapter);
 		return -EBUSY;
 	}
=20
@@ -341,6 +459,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_i=
proc_i2c_dev *iproc_i2c,
 		val =3D (1 << M_FIFO_RX_FLUSH_SHIFT) |
 		      (1 << M_FIFO_TX_FLUSH_SHIFT);
 		writel(val, iproc_i2c->base + M_FIFO_CTRL_OFFSET);
+		i2c_recover_bus(&iproc_i2c->adapter);
 		return -ETIMEDOUT;
 	}
=20
@@ -487,6 +606,7 @@ static int bcm_iproc_i2c_probe(struct platform_device=
 *pdev)
 	adap->quirks =3D &bcm_iproc_i2c_quirks;
 	adap->dev.parent =3D &pdev->dev;
 	adap->dev.of_node =3D pdev->dev.of_node;
+	adap->bus_recovery_info =3D &bcm_iproc_recovery_info;
=20
 	return i2c_add_adapter(adap);
 }
--=20
2.1.4

