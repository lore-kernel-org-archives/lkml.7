Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59043C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDBB2339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 10:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ob27sl4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfH2KTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 06:19:47 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:36174 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726723AbfH2KTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:19:41 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1C23FC038F;
        Thu, 29 Aug 2019 10:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1567073980; bh=Baay742tAmtR5eF4AQp0vztAEFyf6Mwi4Geo9IdjYUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Ob27sl4WyAP8VveUFpL+BxYV3wSUBnBadJam5pTzL2cVkD73KfEnXxbdjRK+7pIeL
         /7g2h+HmO2JSAsO5r15VgxLXoYP0GEHnR+i7TLfEofhn0FY7eMj19EcHHsNQX23p/g
         uXRzszdyzLILHmDcGmTEZ2rdkzy0U0kOoAS0VqXh+/Mcjpx8wWWCNUt+uDEUrQEFOR
         KKQnynSv4tWE/5/WvCWDRWXhT7p/QaO2j5s0JnCdOFs0jk5kuC7l4dXMGKJTZwBwVF
         iwXFhvhv/TbG3frCH7RGPsu6MM57qMrQPFSD/eexsoNLCW2jnv/yjnEvJm1O6/X4vR
         SyTHBitjKVRYw==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3D23EA0061;
        Thu, 29 Aug 2019 10:19:38 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 236CC3B643;
        Thu, 29 Aug 2019 12:19:38 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i3c@lists.infradead.org
Cc:     bbrezillon@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Joao.Pinto@synopsys.com, Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH 1/4] i3c: master: detach and free device if pre_assign_dyn_addr() fails
Date:   Thu, 29 Aug 2019 12:19:32 +0200
Message-Id: <e26948eaaf765f683d8fe0618a31a98e2ecc0e65.1567071213.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1567071213.git.vitor.soares@synopsys.com>
References: <cover.1567071213.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1567071213.git.vitor.soares@synopsys.com>
References: <cover.1567071213.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On pre_assing_dyn_addr() the devices that fail:
  i3c_master_setdasa_locked()
  i3c_master_reattach_i3c_dev()
  i3c_master_retrieve_dev_info()

are kept in memory and master->bus.devs list. This makes the i3c devices
without a dynamic address are sent on DEFSLVS CCC command. Fix this by
detaching and freeing the devices that fail on pre_assign_dyn_addr().

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 drivers/i3c/master.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 5f4bd52..4d29e1f 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1438,7 +1438,7 @@ static void i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
 	ret = i3c_master_setdasa_locked(master, dev->info.static_addr,
 					dev->boardinfo->init_dyn_addr);
 	if (ret)
-		return;
+		goto err_detach_dev;
 
 	dev->info.dyn_addr = dev->boardinfo->init_dyn_addr;
 	ret = i3c_master_reattach_i3c_dev(dev, 0);
@@ -1453,6 +1453,10 @@ static void i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
 
 err_rstdaa:
 	i3c_master_rstdaa_locked(master, dev->boardinfo->init_dyn_addr);
+
+err_detach_dev:
+	i3c_master_detach_i3c_dev(dev);
+	i3c_master_free_i3c_dev(dev);
 }
 
 static void
@@ -1647,7 +1651,7 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	enum i3c_addr_slot_status status;
 	struct i2c_dev_boardinfo *i2cboardinfo;
 	struct i3c_dev_boardinfo *i3cboardinfo;
-	struct i3c_dev_desc *i3cdev;
+	struct i3c_dev_desc *i3cdev, *i3ctmp;
 	struct i2c_dev_desc *i2cdev;
 	int ret;
 
@@ -1746,7 +1750,8 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	 * Pre-assign dynamic address and retrieve device information if
 	 * needed.
 	 */
-	i3c_bus_for_each_i3cdev(&master->bus, i3cdev)
+	list_for_each_entry_safe(i3cdev, i3ctmp, &master->bus.devs.i3c,
+				 common.node)
 		i3c_master_pre_assign_dyn_addr(i3cdev);
 
 	ret = i3c_master_do_daa(master);
-- 
2.7.4

