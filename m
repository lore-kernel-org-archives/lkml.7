Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB473C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B532184E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554367932;
	bh=tJ03g0SYAhCCB7/L6VkRipaYNr5/JUICkgNXfs5nrDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Co1YOjZODQUx7ZE7vJbAWmaC659OeG/LPoPwzjXKkrF6eu1I3+otyDbPNfu5JSiOZ
	 /EHRR7JjSs9+3s5ptJGnMhHXO8pkx20712Hgmn7zmbiKz6ohO5QMaqlr5piMOkf7K8
	 5YRxVrGvfQeLuMfCdj849qe9mCFeAh38KBHY6dPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbfDDIwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:52:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729533AbfDDIwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:52:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE4382184B;
        Thu,  4 Apr 2019 08:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367927;
        bh=tJ03g0SYAhCCB7/L6VkRipaYNr5/JUICkgNXfs5nrDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wpNlvmI7i9GkNpwnUI9kOWIPL5Q6cVZONbHyA5ZPz+AcJkWenqY7Q1IJctksbRCsg
         BWDujcUu0PwxpT+WaeiRVhnbxrMSSMiaZt1yqrHnMR0QyJSWpkqvdJNPYjcmDGpB7/
         3zj2h93lBWB8w72TWfjCXc73dflAXlQb7/bxOQps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 65/91] e1000e: fix cyclic resets at link up with active tx
Date:   Thu,  4 Apr 2019 10:47:49 +0200
Message-Id: <20190404084539.214010149@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084535.450029272@linuxfoundation.org>
References: <20190404084535.450029272@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0f9e980bf5ee1a97e2e401c846b2af989eb21c61 ]

I'm seeing series of e1000e resets (sometimes endless) at system boot
if something generates tx traffic at this time. In my case this is
netconsole who sends message "e1000e 0000:02:00.0: Some CPU C-states
have been disabled in order to enable jumbo frames" from e1000e itself.
As result e1000_watchdog_task sees used tx buffer while carrier is off
and start this reset cycle again.

[   17.794359] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   17.794714] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   22.936455] e1000e 0000:02:00.0 eth1: changing MTU from 1500 to 9000
[   23.033336] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   26.102364] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   27.174495] 8021q: 802.1Q VLAN Support v1.8
[   27.174513] 8021q: adding VLAN 0 to HW filter on device eth1
[   30.671724] cgroup: cgroup: disabling cgroup2 socket matching due to net_prio or net_cls activation
[   30.898564] netpoll: netconsole: local port 6666
[   30.898566] netpoll: netconsole: local IPv6 address 2a02:6b8:0:80b:beae:c5ff:fe28:23f8
[   30.898567] netpoll: netconsole: interface 'eth1'
[   30.898568] netpoll: netconsole: remote port 6666
[   30.898568] netpoll: netconsole: remote IPv6 address 2a02:6b8:b000:605c:e61d:2dff:fe03:3790
[   30.898569] netpoll: netconsole: remote ethernet address b0:a8:6e:f4:ff:c0
[   30.917747] console [netcon0] enabled
[   30.917749] netconsole: network logging started
[   31.453353] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   34.185730] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   34.321840] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   34.465822] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   34.597423] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   34.745417] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   34.877356] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   35.005441] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   35.157376] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   35.289362] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   35.417441] e1000e 0000:02:00.0: Some CPU C-states have been disabled in order to enable jumbo frames
[   37.790342] e1000e: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None

This patch flushes tx buffers only once when carrier is off
rather than at each watchdog iteration.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index f56f8b6e2378..8bbedfc9c48f 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5291,8 +5291,13 @@ static void e1000_watchdog_task(struct work_struct *work)
 			/* 8000ES2LAN requires a Rx packet buffer work-around
 			 * on link down event; reset the controller to flush
 			 * the Rx packet buffer.
+			 *
+			 * If the link is lost the controller stops DMA, but
+			 * if there is queued Tx work it cannot be done.  So
+			 * reset the controller to flush the Tx packet buffers.
 			 */
-			if (adapter->flags & FLAG_RX_NEEDS_RESTART)
+			if ((adapter->flags & FLAG_RX_NEEDS_RESTART) ||
+			    e1000_desc_unused(tx_ring) + 1 < tx_ring->count)
 				adapter->flags |= FLAG_RESTART_NOW;
 			else
 				pm_schedule_suspend(netdev->dev.parent,
@@ -5315,14 +5320,6 @@ link_up:
 	adapter->gotc_old = adapter->stats.gotc;
 	spin_unlock(&adapter->stats64_lock);
 
-	/* If the link is lost the controller stops DMA, but
-	 * if there is queued Tx work it cannot be done.  So
-	 * reset the controller to flush the Tx packet buffers.
-	 */
-	if (!netif_carrier_ok(netdev) &&
-	    (e1000_desc_unused(tx_ring) + 1 < tx_ring->count))
-		adapter->flags |= FLAG_RESTART_NOW;
-
 	/* If reset is necessary, do it outside of interrupt context. */
 	if (adapter->flags & FLAG_RESTART_NOW) {
 		schedule_work(&adapter->reset_task);
-- 
2.19.1



