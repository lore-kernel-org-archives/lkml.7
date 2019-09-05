Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85242C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B61C2184B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PdMj4KCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbfIEKBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:01:06 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:44214 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387712AbfIEKAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:00:52 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CCDC1C0DD7;
        Thu,  5 Sep 2019 10:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1567677652; bh=BF0fO1lkWmGVWqAZwytCEmVAOVHGSZEiz4u6292OEiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=PdMj4KCr4t+WQs1GDpf71NtnzhALi5k+FVw9LavtU1rUGMFqn2iBcB0iDjay96qqg
         zRrlj1a04S0x7l1I7Ot0GCXfzKFHJf47EbNbDfWrF4SmYzFQ6zpg7aq834fPigQOji
         whSF7xo1crEvXh3mhf5VU9GghyhDAVpo2BBdZW1H6zCckppJT6Sz88St/W4Xw/2Ucf
         DgXot/ykSRC38Yq3twCAdWGMAHOOHn3cMI+vy/QdcuO+yOuh9VQ19QSwc0K03obS8J
         WFlhLn3X+yy9PoJd+p/M4JoPwvhe/csHslkO9Ap37EAMwXwe5TlQ6nGX9AxHesH1j0
         93OvBHXLfnI2g==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 63DCEA005C;
        Thu,  5 Sep 2019 10:00:49 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 47ECF3F3B2;
        Thu,  5 Sep 2019 12:00:49 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i3c@lists.infradead.org
Cc:     bbrezillon@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pgaj@cadence.com, Joao.Pinto@synopsys.com,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v3 1/5] i3c: master: detach/free devices fail on pre_assign_dyn_addr()
Date:   Thu,  5 Sep 2019 12:00:34 +0200
Message-Id: <d16914bbe06cf82cdbf9a0480310bd9cc2e4d8a9.1567608245.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1567608245.git.vitor.soares@synopsys.com>
References: <cover.1567608245.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1567608245.git.vitor.soares@synopsys.com>
References: <cover.1567608245.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As for today, the I3C framework is keeping in memory and master->bus.devs
list the devices that fail during pre_assign_dyn_addr() and send them on
DEFSLVS command.

According to MIPI I3C Bus spec the DEFSLVS command is used to inform any
Secondary Master about the Dynamic Addresses that were assigned to I3C
devices and the I2C devices present on the bus.

This issue could be fixed by changing i3c_master_defslvs_locked() to
ignore unaddressed i3c devices but the i3c_dev_desc would be allocated and
attached to HC unnecessarily. This can cause that some HC aren't able to
do DAA for HJ capable devices due to lack of space in controller.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
Changes in v3:
  - Change commit message

Changes in v2:
  - Move out detach/free the i3c_dev_desc from pre_assign_dyn_addr()
  - Convert i3c_master_pre_assign_dyn_addr() to return an int

 drivers/i3c/master.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 5f4bd52..586e34f 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1426,19 +1426,19 @@ static void i3c_master_detach_i2c_dev(struct i2c_dev_desc *dev)
 		master->ops->detach_i2c_dev(dev);
 }
 
-static void i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
+static int i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
 {
 	struct i3c_master_controller *master = i3c_dev_get_master(dev);
 	int ret;
 
 	if (!dev->boardinfo || !dev->boardinfo->init_dyn_addr ||
 	    !dev->boardinfo->static_addr)
-		return;
+		return 0;
 
 	ret = i3c_master_setdasa_locked(master, dev->info.static_addr,
 					dev->boardinfo->init_dyn_addr);
 	if (ret)
-		return;
+		return ret;
 
 	dev->info.dyn_addr = dev->boardinfo->init_dyn_addr;
 	ret = i3c_master_reattach_i3c_dev(dev, 0);
@@ -1449,10 +1449,12 @@ static void i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
 	if (ret)
 		goto err_rstdaa;
 
-	return;
+	return 0;
 
 err_rstdaa:
 	i3c_master_rstdaa_locked(master, dev->boardinfo->init_dyn_addr);
+
+	return ret;
 }
 
 static void
@@ -1647,7 +1649,7 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	enum i3c_addr_slot_status status;
 	struct i2c_dev_boardinfo *i2cboardinfo;
 	struct i3c_dev_boardinfo *i3cboardinfo;
-	struct i3c_dev_desc *i3cdev;
+	struct i3c_dev_desc *i3cdev, *i3ctmp;
 	struct i2c_dev_desc *i2cdev;
 	int ret;
 
@@ -1746,8 +1748,14 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	 * Pre-assign dynamic address and retrieve device information if
 	 * needed.
 	 */
-	i3c_bus_for_each_i3cdev(&master->bus, i3cdev)
-		i3c_master_pre_assign_dyn_addr(i3cdev);
+	list_for_each_entry_safe(i3cdev, i3ctmp, &master->bus.devs.i3c,
+				 common.node) {
+		ret = i3c_master_pre_assign_dyn_addr(i3cdev);
+		if (ret) {
+			i3c_master_detach_i3c_dev(i3cdev);
+			i3c_master_free_i3c_dev(i3cdev);
+		}
+	}
 
 	ret = i3c_master_do_daa(master);
 	if (ret)
-- 
2.7.4

