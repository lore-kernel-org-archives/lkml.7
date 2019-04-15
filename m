Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCBDC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76276218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Tf3YDoEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfDOSrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:47:21 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:55724 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfDOSrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:47:19 -0400
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DA2B610C10A5;
        Mon, 15 Apr 2019 11:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555354038; bh=wX6fVVw/1LVztXtlfWLPbksI1sg7Ijps62PR35UWDH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Tf3YDoEFaEM57/P9KHDekoVA1rQVVTBAx4/0L7pq06HYMsLaAMKsDpha+zRymcvi6
         3RZAeAeZGEAWTyN/7Jf91NqGyMOX5nMhRbNBiDkggnxls8VkhxYq/cxhPY1ozym+F8
         K8UhUiyFAAIVtX74HRacydAej2hW9ZOMfDbF330V72ebMoiMilh03/rRsr6TEub9Ze
         u0iuO+VtY6tjG4NZIeP4mYIlgPpB4ZFm7T9+Y8Yq+UFedP/8bK+/c89O4a0zn8TP67
         Que30kRWjQjTw6zcpBR67HtJm08s0TawU1vZeIPCuXjgZVT/UdtjeE6VM/n2FBi3DV
         RrV9H8wHt6w+Q==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id 6CD965B70;
        Mon, 15 Apr 2019 11:46:47 -0700 (PDT)
From:   Vitor Soares <vitor.soares@synopsys.com>
To:     linux-i3c@lists.infradead.org
Cc:     joao.pinto@synopsys.com, Vitor Soares <vitor.soares@synopsys.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] i3c: fix i2c and i3c scl rate by bus mode
Date:   Mon, 15 Apr 2019 20:46:41 +0200
Message-Id:
 <05fdeea79db83970e9ecb0d7045b4dd98f206f06.1555350118.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1555350118.git.vitor.soares@synopsys.com>
References: <cover.1555350118.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1555350118.git.vitor.soares@synopsys.com>
References: <cover.1555350118.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415184641.bAAI5Q6tKBj64Am-zw5OjfIXDQfgGsI9NOu6vo6KUOo@z>

Currently in case of mixed slow bus topologie and all i2c devices
support FM+ speed, the i3c subsystem limite the SCL to FM speed.
Also in case on mixed slow bus mode the max speed for both
i2c or i3c transfers is FM or FM+.

This patch fix the definition of i2c and i3c scl rate based on bus
topologie and LVR[4] if no user input.
In case of mixed slow mode the i3c scl rate is overridden.

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: <stable@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
---
 drivers/i3c/master.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 909c2ad..1c4a86a 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -564,20 +564,30 @@ static const struct device_type i3c_masterdev_type = {
 	.groups	= i3c_masterdev_groups,
 };
 
-int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode)
+int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode,
+		     unsigned long i2c_scl_rate)
 {
 	i3cbus->mode = mode;
 
-	if (!i3cbus->scl_rate.i3c)
-		i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
-
-	if (!i3cbus->scl_rate.i2c) {
-		if (i3cbus->mode == I3C_BUS_MODE_MIXED_SLOW)
-			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_SCL_RATE;
-		else
-			i3cbus->scl_rate.i2c = I3C_BUS_I2C_FM_PLUS_SCL_RATE;
+	switch (i3cbus->mode) {
+	case I3C_BUS_MODE_PURE:
+		if (!i3cbus->scl_rate.i3c)
+			i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
+		break;
+	case I3C_BUS_MODE_MIXED_FAST:
+		if (!i3cbus->scl_rate.i3c)
+			i3cbus->scl_rate.i3c = I3C_BUS_TYP_I3C_SCL_RATE;
+		if (!i3cbus->scl_rate.i2c)
+			i3cbus->scl_rate.i2c = i2c_scl_rate;
+		break;
+	case I3C_BUS_MODE_MIXED_SLOW:
+		if (!i3cbus->scl_rate.i2c)
+			i3cbus->scl_rate.i2c = i2c_scl_rate;
+		i3cbus->scl_rate.i3c = i3cbus->scl_rate.i2c;
+		break;
+	default:
+		return -EINVAL;
 	}
-
 	/*
 	 * I3C/I2C frequency may have been overridden, check that user-provided
 	 * values are not exceeding max possible frequency.
@@ -1980,9 +1990,6 @@ of_i3c_master_add_i2c_boardinfo(struct i3c_master_controller *master,
 	/* LVR is encoded in reg[2]. */
 	boardinfo->lvr = reg[2];
 
-	if (boardinfo->lvr & I3C_LVR_I2C_FM_MODE)
-		master->bus.scl_rate.i2c = I3C_BUS_I2C_FM_SCL_RATE;
-
 	list_add_tail(&boardinfo->node, &master->boardinfo.i2c);
 	of_node_get(node);
 
@@ -2432,6 +2439,7 @@ int i3c_master_register(struct i3c_master_controller *master,
 			const struct i3c_master_controller_ops *ops,
 			bool secondary)
 {
+	unsigned long i2c_scl_rate = I3C_BUS_I2C_FM_PLUS_SCL_RATE;
 	struct i3c_bus *i3cbus = i3c_master_get_bus(master);
 	enum i3c_bus_mode mode = I3C_BUS_MODE_PURE;
 	struct i2c_dev_boardinfo *i2cbi;
@@ -2481,9 +2489,12 @@ int i3c_master_register(struct i3c_master_controller *master,
 			ret = -EINVAL;
 			goto err_put_dev;
 		}
+
+		if (i2cbi->lvr & I3C_LVR_I2C_FM_MODE)
+			i2c_scl_rate = I3C_BUS_I2C_FM_SCL_RATE;
 	}
 
-	ret = i3c_bus_set_mode(i3cbus, mode);
+	ret = i3c_bus_set_mode(i3cbus, mode, i2c_scl_rate);
 	if (ret)
 		goto err_put_dev;
 
-- 
2.7.4

