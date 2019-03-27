Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21778C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3C2206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714769;
	bh=aMdbIdmR17bFEJ9L/aFoLmBtGHOBEMRb9nqQy+1iJKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rDUggO7lvOvFAbZ+vJrNIL8r5eerhQ4fDgfjT8GLIOm24liIugUBy+GYpA7+Gluk9
	 jpQAnXyM3JhWro7lWq7KMG1u0UDLid7cW9tSDwDzeYQ7SPyCU4ogT3pfbraNYWK57n
	 aXB8RIZYuQXaet/g6xRjS9/T2rauKeb5bTcqjcig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfC0T0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387578AbfC0SFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:05:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3535B2063F;
        Wed, 27 Mar 2019 18:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709904;
        bh=aMdbIdmR17bFEJ9L/aFoLmBtGHOBEMRb9nqQy+1iJKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6LVxpOKbz1KB61YB5F1pcNYmaN45ob1ssXqxdnsYxaFs2r5D3YBNi/kpcCjdDVAP
         MnQ0C3NdY2/ye+8LoCLnTorkk2ndL2dcqF+ePJc+WVbtoxGpB1DKIv2Ya/xnMvuKdF
         yYhZC4pA6WdUwo3NJsE1GmcDhhQN2G+SGZCTQtgc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 102/262] i2c: designware: Do not allow i2c_dw_xfer() calls while suspended
Date:   Wed, 27 Mar 2019 13:59:17 -0400
Message-Id: <20190327180158.10245-102-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 2751541555382dfa7661bcfaac3ee0fac49f505d ]

On most Intel Bay- and Cherry-Trail systems the PMIC is connected over I2C
and the PMIC is accessed through various means by the _PS0 and _PS3 ACPI
methods (power on / off methods) of various devices.

This leads to suspend/resume ordering problems where a device may be
resumed and get its _PS0 method executed before the I2C controller is
resumed. On Cherry Trail this leads to errors like these:

     i2c_designware 808622C1:06: controller timed out
     ACPI Error: AE_ERROR, Returned by Handler for [UserDefinedRegion]
     ACPI Error: Method parse/execution failed \_SB.P18W._ON, AE_ERROR
     video LNXVIDEO:00: Failed to change power state to D0

But on Bay Trail this caused I2C reads to seem to succeed, but they end
up returning wrong data, which ends up getting written back by the typical
read-modify-write cycle done to turn on various power-resources.

Debugging the problems caused by this silent data corruption is quite
nasty. This commit adds a check which disallows i2c_dw_xfer() calls to
happen until the controller's resume method has completed.

Which turns the silent data corruption into getting these errors in
dmesg instead:

    i2c_designware 80860F41:04: Error i2c_dw_xfer call while suspended
    ACPI Error: AE_ERROR, Returned by Handler for [UserDefinedRegion]
    ACPI Error: Method parse/execution failed \_SB.PCI0.GFX0._PS0, AE_ERROR

Which is much better.

Note the above errors are an example of issues which this patch will
help to debug, the actual fix requires fixing the suspend order and
this has been fixed by a different commit.

Note the setting / clearing of the suspended flag in the suspend / resume
methods is NOT protected by i2c_lock_bus(). This is intentional as these
methods get called from i2c_dw_xfer() (through pm_runtime_get/put) a nd
i2c_dw_xfer() is called with the i2c_bus_lock held, so otherwise we would
deadlock. This means that there is a theoretical race between a non runtime
suspend and the suspended check in i2c_dw_xfer(), this is not a problem
since normally we should not hit the race and this check is primarily a
debugging tool so hitting the check if there are suspend/resume ordering
problems does not need to be 100% reliable.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-designware-core.h    | 2 ++
 drivers/i2c/busses/i2c-designware-master.c  | 6 ++++++
 drivers/i2c/busses/i2c-designware-pcidrv.c  | 7 ++++++-
 drivers/i2c/busses/i2c-designware-platdrv.c | 3 +++
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index b4a0b2b99a78..6b4ef1d38fb2 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -215,6 +215,7 @@
  * @disable_int: function to disable all interrupts
  * @init: function to initialize the I2C hardware
  * @mode: operation mode - DW_IC_MASTER or DW_IC_SLAVE
+ * @suspended: set to true if the controller is suspended
  *
  * HCNT and LCNT parameters can be used if the platform knows more accurate
  * values than the one computed based only on the input clock frequency.
@@ -270,6 +271,7 @@ struct dw_i2c_dev {
 	int			(*set_sda_hold_time)(struct dw_i2c_dev *dev);
 	int			mode;
 	struct i2c_bus_recovery_info rinfo;
+	bool			suspended;
 };
 
 #define ACCESS_SWAP		0x00000001
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 8d1bc44d2530..bb8e3f149979 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -426,6 +426,12 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 
 	pm_runtime_get_sync(dev->dev);
 
+	if (dev->suspended) {
+		dev_err(dev->dev, "Error %s call while suspended\n", __func__);
+		ret = -ESHUTDOWN;
+		goto done_nolock;
+	}
+
 	reinit_completion(&dev->cmd_complete);
 	dev->msgs = msgs;
 	dev->msgs_num = num;
diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index d50f80487214..76810deb2de6 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -176,6 +176,7 @@ static int i2c_dw_pci_suspend(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct dw_i2c_dev *i_dev = pci_get_drvdata(pdev);
 
+	i_dev->suspended = true;
 	i_dev->disable(i_dev);
 
 	return 0;
@@ -185,8 +186,12 @@ static int i2c_dw_pci_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct dw_i2c_dev *i_dev = pci_get_drvdata(pdev);
+	int ret;
 
-	return i_dev->init(i_dev);
+	ret = i_dev->init(i_dev);
+	i_dev->suspended = false;
+
+	return ret;
 }
 #endif
 
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 9eaac3be1f63..ead5e7de3e4d 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -454,6 +454,8 @@ static int dw_i2c_plat_suspend(struct device *dev)
 {
 	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
 
+	i_dev->suspended = true;
+
 	if (i_dev->shared_with_punit)
 		return 0;
 
@@ -471,6 +473,7 @@ static int dw_i2c_plat_resume(struct device *dev)
 		i2c_dw_prepare_clk(i_dev, true);
 
 	i_dev->init(i_dev);
+	i_dev->suspended = false;
 
 	return 0;
 }
-- 
2.19.1

