Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFF6C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9904217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199565;
	bh=WZBqGEIMhE0Uex1jDnxC4nvxvLmwIk3xxMhYqrczuSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tFnHp34SsW0QSovr4DJuIUJFa5T+zT221nuZarT/Moe1eoCRufVYFUD43WQN7u1f1
	 f/xizGcjv5YnYu4GWrVATc67BEqDB8ROmjWthSADIabcal+20Kvo4G/yBsxVJTzlk0
	 qbWHEyO767vfqcQ4/D7uJt1aeDvDts99XOLtCcQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbfGOOGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388211AbfGOOF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:05:58 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71EA1206B8;
        Mon, 15 Jul 2019 14:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199557;
        bh=WZBqGEIMhE0Uex1jDnxC4nvxvLmwIk3xxMhYqrczuSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rgq+lIYjCdSM2UylscxHlVwUh78lBzZYh+rIHPAMk2oRVLgXiXENE26/VHfUD+frK
         EAIM9G/HGisHfMvUH0DWtJP1CEo4/hYPfxuLW4BWUJH9WRiRS0Fu3LNki5LKA7Am27
         jUl5As1W2Pxiow2lK9BMcuvodsxHVTXCJwO8Hbrs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Joseph Yasi <joe.yasi@gmail.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 042/219] Revert "e1000e: fix cyclic resets at link up with active tx"
Date:   Mon, 15 Jul 2019 10:00:43 -0400
Message-Id: <20190715140341.6443-42-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

[ Upstream commit caff422ea81e144842bc44bab408d85ac449377b ]

This reverts commit 0f9e980bf5ee1a97e2e401c846b2af989eb21c61.

That change cased false-positive warning about hardware hang:

e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
e1000e 0000:00:1f.6 eth0: Detected Hardware Unit Hang:
   TDH                  <0>
   TDT                  <1>
   next_to_use          <1>
   next_to_clean        <0>
buffer_info[next_to_clean]:
   time_stamp           <fffba7a7>
   next_to_watch        <0>
   jiffies              <fffbb140>
   next_to_watch.status <0>
MAC Status             <40080080>
PHY Status             <7949>
PHY 1000BASE-T Status  <0>
PHY Extended Status    <3000>
PCI Status             <10>
e1000e: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx

Besides warning everything works fine.
Original issue will be fixed property in following patch.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reported-by: Joseph Yasi <joe.yasi@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=203175
Tested-by: Joseph Yasi <joe.yasi@gmail.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Tested-by: Oleksandr Natalenko <oleksandr@redhat.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index c10c9d7eadaa..6230b4bb1699 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5309,13 +5309,8 @@ static void e1000_watchdog_task(struct work_struct *work)
 			/* 8000ES2LAN requires a Rx packet buffer work-around
 			 * on link down event; reset the controller to flush
 			 * the Rx packet buffer.
-			 *
-			 * If the link is lost the controller stops DMA, but
-			 * if there is queued Tx work it cannot be done.  So
-			 * reset the controller to flush the Tx packet buffers.
 			 */
-			if ((adapter->flags & FLAG_RX_NEEDS_RESTART) ||
-			    e1000_desc_unused(tx_ring) + 1 < tx_ring->count)
+			if (adapter->flags & FLAG_RX_NEEDS_RESTART)
 				adapter->flags |= FLAG_RESTART_NOW;
 			else
 				pm_schedule_suspend(netdev->dev.parent,
@@ -5338,6 +5333,14 @@ static void e1000_watchdog_task(struct work_struct *work)
 	adapter->gotc_old = adapter->stats.gotc;
 	spin_unlock(&adapter->stats64_lock);
 
+	/* If the link is lost the controller stops DMA, but
+	 * if there is queued Tx work it cannot be done.  So
+	 * reset the controller to flush the Tx packet buffers.
+	 */
+	if (!netif_carrier_ok(netdev) &&
+	    (e1000_desc_unused(tx_ring) + 1 < tx_ring->count))
+		adapter->flags |= FLAG_RESTART_NOW;
+
 	/* If reset is necessary, do it outside of interrupt context. */
 	if (adapter->flags & FLAG_RESTART_NOW) {
 		schedule_work(&adapter->reset_task);
-- 
2.20.1

