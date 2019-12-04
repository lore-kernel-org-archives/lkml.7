Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE33C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859512084B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482491;
	bh=OkQcdxTstU1Pzv002g0q7wkNAXVtWVcDMkq6fJScZ2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e9uNce68lm3c4Af6MDdvpl8dJEqc9bQ6xlIsryf0C/o9ZPpiaQoK7R1+SKApVVbmZ
	 yjmbHT8LQnzOm6eZ+9krN3pVFar7LGpN0etxZfyC9p/9Q4euIkoK5Sl5aCZIUt5QdG
	 iVaxPlOCxdROxeLV0bIxjOQvjFtE3BHQD0cCZjwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfLDSBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:01:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:41868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbfLDSB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:01:27 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 150C120675;
        Wed,  4 Dec 2019 18:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482486;
        bh=OkQcdxTstU1Pzv002g0q7wkNAXVtWVcDMkq6fJScZ2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=00Bb/EikrMWnZDpLyg9ZSvM/Z0l6HMSZwxxinLatlbI5TY0XNkh/1xComUDO4OXPb
         Wby33pfIBs1z+fbMnuirfRZw6Xxg/a8Tmev+o67H90LR+JJhWVZDz8i1I3b6UvsS0v
         iEXctOJXG4Bj9S+n45kcBT0QaGgS+XWxQXj+I8Wo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 016/209] can: c_can: D_CAN: c_can_chip_config(): perform a sofware reset on open
Date:   Wed,  4 Dec 2019 18:53:48 +0100
Message-Id: <20191204175322.669110118@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
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
index 9b61bfbea6cd1..24c6015f6c92b 100644
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



