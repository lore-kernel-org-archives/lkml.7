Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929EBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6420D20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711198;
	bh=/pH4zZYlc0BWQ1TfawHbkZe5KAVeNbC1loGu3hyaHNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hwWC6qUr+ul81/aM1U78iKIbZ5tkXcFVtawxvZt98zlcffYotwiH9JZoyPHuZEnO2
	 sqzXOe06LjscLTaATlDX1R6Xya0HL2NxmKvoBY04ThetVgBjQb1XoCTnH9P1CTYkQb
	 L6ZRu+YQMDnZgEYpV3vIvRvWqHkofjLa1q90YUlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391732AbfC0S0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:26:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390135AbfC0S0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:26:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A03802147C;
        Wed, 27 Mar 2019 18:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711174;
        bh=/pH4zZYlc0BWQ1TfawHbkZe5KAVeNbC1loGu3hyaHNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vARNbBdmaH6GyObTUorxhKDjtCufG+4rm8e+h1t35kA3kDxGRjhBf8yt1ev4kZnS/
         COqpJEyPM2cwQkrsIXt3Lt/TUwpOC20i89bjnWgh9qGdGw0rNYgqXvPleeON9yXNNu
         QUWvzDcxo4dA6BQ4IUUoW5Yr6uDOqPL8I/42W9R0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 29/41] e1000e: fix cyclic resets at link up with active tx
Date:   Wed, 27 Mar 2019 14:25:06 -0400
Message-Id: <20190327182518.19394-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182518.19394-1-sashal@kernel.org>
References: <20190327182518.19394-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

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
index ef5699103ec2..52920d036f49 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5073,8 +5073,13 @@ static void e1000_watchdog_task(struct work_struct *work)
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
@@ -5097,14 +5102,6 @@ static void e1000_watchdog_task(struct work_struct *work)
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

