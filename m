Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2434C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F4A218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117434;
	bh=0PHgBy0B9muHpVQBYUcGnR85e754DfDpkw8c1Wtm+aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tLCGee2cHnc878giVW62UKTkSAumbk5UZSn3LEwaD6dG6NzLI+xEq61egM5mqNPvD
	 vBW+u1mFAtFLycnjXotTwMdbQvGIHnyUhwosp+Ki9if1natVsahTNzJWLsOGjqCkbH
	 BciQp8hlCTwRfTGeH0omRiSUrfQp8cS6qVZqudBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbfDXOue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732574AbfDXOua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:50:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3E4A218FD;
        Wed, 24 Apr 2019 14:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117429;
        bh=0PHgBy0B9muHpVQBYUcGnR85e754DfDpkw8c1Wtm+aI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CuWpCT7ukJVbWoCcGKwZrXPOOyLNZARnWCVwaJhg0otmMP1bxTMZd80LyPYdXGiUI
         q6rO4AKlq4eB68JrNvMv2hUKmDI1ML7SqK2oPXgoWKZkyXrAipHNaYazFiGtsOkYYq
         G5rzOifyvfYPAK4CBs3+V19b8URTU7NSioNF3+eM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arvind Sankar <niveditas98@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 07/28] igb: Fix WARN_ONCE on runtime suspend
Date:   Wed, 24 Apr 2019 10:49:51 -0400
Message-Id: <20190424145012.30886-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424145012.30886-1-sashal@kernel.org>
References: <20190424145012.30886-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Sankar <niveditas98@gmail.com>

[ Upstream commit dabb8338be533c18f50255cf39ff4f66d4dabdbe ]

The runtime_suspend device callbacks are not supposed to save
configuration state or change the power state. Commit fb29f76cc566
("igb: Fix an issue that PME is not enabled during runtime suspend")
changed the driver to not save configuration state during runtime
suspend, however the driver callback still put the device into a
low-power state. This causes a warning in the pci pm core and results in
pci_pm_runtime_suspend not calling pci_save_state or pci_finish_runtime_suspend.

Fix this by not changing the power state either, leaving that to pci pm
core, and make the same change for suspend callback as well.

Also move a couple of defines into the appropriate header file instead
of inline in the .c file.

Fixes: fb29f76cc566 ("igb: Fix an issue that PME is not enabled during runtime suspend")
Signed-off-by: Arvind Sankar <niveditas98@gmail.com>
Reviewed-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/intel/igb/e1000_defines.h    |  2 +
 drivers/net/ethernet/intel/igb/igb_main.c     | 57 +++----------------
 2 files changed, 10 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
index 2688180a7acd..f948eec7b35f 100644
--- a/drivers/net/ethernet/intel/igb/e1000_defines.h
+++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
@@ -193,6 +193,8 @@
 /* enable link status from external LINK_0 and LINK_1 pins */
 #define E1000_CTRL_SWDPIN0  0x00040000  /* SWDPIN 0 value */
 #define E1000_CTRL_SWDPIN1  0x00080000  /* SWDPIN 1 value */
+#define E1000_CTRL_ADVD3WUC 0x00100000  /* D3 WUC */
+#define E1000_CTRL_EN_PHY_PWR_MGMT 0x00200000 /* PHY PM enable */
 #define E1000_CTRL_SDP0_DIR 0x00400000  /* SDP0 Data direction */
 #define E1000_CTRL_SDP1_DIR 0x00800000  /* SDP1 Data direction */
 #define E1000_CTRL_RST      0x04000000  /* Global reset */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 82e48e355fb9..7956176c2c73 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7548,9 +7548,7 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
 	struct e1000_hw *hw = &adapter->hw;
 	u32 ctrl, rctl, status;
 	u32 wufc = runtime ? E1000_WUFC_LNKC : adapter->wol;
-#ifdef CONFIG_PM
-	int retval = 0;
-#endif
+	bool wake;
 
 	rtnl_lock();
 	netif_device_detach(netdev);
@@ -7563,14 +7561,6 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
 	igb_clear_interrupt_scheme(adapter);
 	rtnl_unlock();
 
-#ifdef CONFIG_PM
-	if (!runtime) {
-		retval = pci_save_state(pdev);
-		if (retval)
-			return retval;
-	}
-#endif
-
 	status = rd32(E1000_STATUS);
 	if (status & E1000_STATUS_LU)
 		wufc &= ~E1000_WUFC_LNKC;
@@ -7587,10 +7577,6 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
 		}
 
 		ctrl = rd32(E1000_CTRL);
-		/* advertise wake from D3Cold */
-		#define E1000_CTRL_ADVD3WUC 0x00100000
-		/* phy power management enable */
-		#define E1000_CTRL_EN_PHY_PWR_MGMT 0x00200000
 		ctrl |= E1000_CTRL_ADVD3WUC;
 		wr32(E1000_CTRL, ctrl);
 
@@ -7604,12 +7590,15 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
 		wr32(E1000_WUFC, 0);
 	}
 
-	*enable_wake = wufc || adapter->en_mng_pt;
-	if (!*enable_wake)
+	wake = wufc || adapter->en_mng_pt;
+	if (!wake)
 		igb_power_down_link(adapter);
 	else
 		igb_power_up_link(adapter);
 
+	if (enable_wake)
+		*enable_wake = wake;
+
 	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
 	 * would have already happened in close and is redundant.
 	 */
@@ -7624,22 +7613,7 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
 #ifdef CONFIG_PM_SLEEP
 static int igb_suspend(struct device *dev)
 {
-	int retval;
-	bool wake;
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	retval = __igb_shutdown(pdev, &wake, 0);
-	if (retval)
-		return retval;
-
-	if (wake) {
-		pci_prepare_to_sleep(pdev);
-	} else {
-		pci_wake_from_d3(pdev, false);
-		pci_set_power_state(pdev, PCI_D3hot);
-	}
-
-	return 0;
+	return __igb_shutdown(to_pci_dev(dev), NULL, 0);
 }
 #endif /* CONFIG_PM_SLEEP */
 
@@ -7707,22 +7681,7 @@ static int igb_runtime_idle(struct device *dev)
 
 static int igb_runtime_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	int retval;
-	bool wake;
-
-	retval = __igb_shutdown(pdev, &wake, 1);
-	if (retval)
-		return retval;
-
-	if (wake) {
-		pci_prepare_to_sleep(pdev);
-	} else {
-		pci_wake_from_d3(pdev, false);
-		pci_set_power_state(pdev, PCI_D3hot);
-	}
-
-	return 0;
+	return __igb_shutdown(to_pci_dev(dev), NULL, 1);
 }
 
 static int igb_runtime_resume(struct device *dev)
-- 
2.19.1

