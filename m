Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D261C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40C02081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482312;
	bh=SW33faG0QdwdMLwIaMIhaWkEIxY3MQr5swYVYVOmzg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ap1PpTEosXG92lSyOUunEVoBSaXEqwiS6waflWFCP2ZwTOJT+NmKE5xFpBGwkIhTx
	 vEPTCNgcDRmAzXo7DXR7EHZIjPGqcWcxn9raOqckrRzyGFf/JXPlAcnGj/SXY0w8op
	 jD87fU11wwJIKJUyy2BlBCAG1pI18FqATcsJYBgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfLDR6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:58:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:32896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbfLDR6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:58:25 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E9A620675;
        Wed,  4 Dec 2019 17:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482305;
        bh=SW33faG0QdwdMLwIaMIhaWkEIxY3MQr5swYVYVOmzg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fq/EFgZLha7gnUG5jvl/V6YIdfg0V0xEj0UZ97I6jRWFpLzqk2Hj9ru2hdi2XvvCS
         el32U5W9tDIOUYQ7hsyL+JFB9dqA+gkMHQsGfvPxS9cXeeWYbuYEUGlVZjxf6CLL2W
         KLe4/5Eg6cBcdp7kOzmdl1pEd49iydXhz9k0JCIs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 06/92] can: c_can: D_CAN: c_can_chip_config(): perform a sofware reset on open
Date:   Wed,  4 Dec 2019 18:49:06 +0100
Message-Id: <20191204174329.171128563@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeroen Hofstee <jhofstee@victronenergy.com>

[ Upstream commit 23c5a9488f076bab336177cd1d1a366bd8ddf087 ]

When the CAN interface is closed it the hardwre is put in power down
mode, but does not reset the error counters / state. Reset the D_CAN on
open, so the reported state and the actual state match.

According to [1], the C_CAN module doesn't have the software reset.

[1] http://www.bosch-semiconductors.com/media/ip_modules/pdf_2/c_can_fd8/users_manual_c_can_fd8_r210_1.pdf

Signed-off-by: Jeroen Hofstee <jhofstee@victronenergy.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/c_can/c_can.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index 7d35f6737499c..4ead5a18b7940 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -52,6 +52,7 @@
 #define CONTROL_EX_PDR		BIT(8)
 
 /* control register */
+#define CONTROL_SWR		BIT(15)
 #define CONTROL_TEST		BIT(7)
 #define CONTROL_CCE		BIT(6)
 #define CONTROL_DISABLE_AR	BIT(5)
@@ -572,6 +573,26 @@ static void c_can_configure_msg_objects(struct net_device *dev)
 				   IF_MCONT_RCV_EOB);
 }
 
+static int c_can_software_reset(struct net_device *dev)
+{
+	struct c_can_priv *priv = netdev_priv(dev);
+	int retry = 0;
+
+	if (priv->type != BOSCH_D_CAN)
+		return 0;
+
+	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_SWR | CONTROL_INIT);
+	while (priv->read_reg(priv, C_CAN_CTRL_REG) & CONTROL_SWR) {
+		msleep(20);
+		if (retry++ > 100) {
+			netdev_err(dev, "CCTRL: software reset failed\n");
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Configure C_CAN chip:
  * - enable/disable auto-retransmission
@@ -581,6 +602,11 @@ static void c_can_configure_msg_objects(struct net_device *dev)
 static int c_can_chip_config(struct net_device *dev)
 {
 	struct c_can_priv *priv = netdev_priv(dev);
+	int err;
+
+	err = c_can_software_reset(dev);
+	if (err)
+		return err;
 
 	/* enable automatic retransmission */
 	priv->write_reg(priv, C_CAN_CTRL_REG, CONTROL_ENABLE_AR);
-- 
2.20.1



