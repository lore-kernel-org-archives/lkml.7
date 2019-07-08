Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9DDC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1871F20659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfGHEzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 00:55:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55107 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfGHEzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 00:55:55 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hkLgs-00030u-6Z; Mon, 08 Jul 2019 04:55:50 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jeffrey.t.kirsher@intel.com
Cc:     sasha.neftin@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 1/2] e1000e: add workaround for possible stalled packet
Date:   Mon,  8 Jul 2019 12:55:45 +0800
Message-Id: <20190708045546.30160-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forwardport from http://mails.dpdk.org/archives/dev/2016-November/050657.html

This works around a possible stalled packet issue, which may occur due to
clock recovery from the PCH being too slow, when the LAN is transitioning
from K1 at 1G link speed.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=204057

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 10 ++++++++++
 drivers/net/ethernet/intel/e1000e/ich8lan.h |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 395b05701480..56f88a4e538c 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1429,6 +1429,16 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 			else
 				phy_reg |= 0xFA;
 			e1e_wphy_locked(hw, I217_PLL_CLOCK_GATE_REG, phy_reg);
+
+			if (speed == SPEED_1000) {
+				hw->phy.ops.read_reg_locked(hw, HV_PM_CTRL,
+						&phy_reg);
+
+				phy_reg |= HV_PM_CTRL_K1_CLK_REQ;
+
+				hw->phy.ops.write_reg_locked(hw, HV_PM_CTRL,
+						phy_reg);
+			}
 		}
 		hw->phy.ops.release(hw);
 
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
index eb09c755fa17..1502895eb45d 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
@@ -210,7 +210,7 @@
 
 /* PHY Power Management Control */
 #define HV_PM_CTRL		PHY_REG(770, 17)
-#define HV_PM_CTRL_PLL_STOP_IN_K1_GIGA	0x100
+#define HV_PM_CTRL_K1_CLK_REQ		0x200
 #define HV_PM_CTRL_K1_ENABLE		0x4000
 
 #define I217_PLL_CLOCK_GATE_REG	PHY_REG(772, 28)
-- 
2.17.1

