Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3396C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0539218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556125944;
	bh=i0avyjdc7BRjN5sP6H3zfIYgmub0qmSMDargV6/F/gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=blcIKTRFlVkqyzw0FbPNKsxS8kRz2tkMhD5xmovoPJFr462gZUlEEwkFBbA/r89/l
	 fgQ3i696cEhkEu997mG9wxVkDAjhwKMji+gUnzoZXoKKb11pPAk0eocsgMVFN3rA/y
	 b4fEWbSpi0oALHf2EfQPdsxcFIC1PXVy5SdptNj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbfDXRMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387614AbfDXRMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:12:22 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A045218B0;
        Wed, 24 Apr 2019 17:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556125941;
        bh=i0avyjdc7BRjN5sP6H3zfIYgmub0qmSMDargV6/F/gM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LfumCpI2as8ZlVF5SiqJ37YF7je/o8WkS2kU3u2HZfiOwxcxjejWbboCx933ifRRT
         6XMytYtexQTUoY7Paxh5ggHvwaKjTL0CVhJgB07t1UDMCUUWlcDazxo7Gaq/XFRDws
         ijAqawD0KUe7gwojV1iN7hWOncQxjc66b1t2IX54=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 030/104] e1000e: fix cyclic resets at link up with active tx
Date:   Wed, 24 Apr 2019 19:08:47 +0200
Message-Id: <20190424170856.543535142@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
@@ -5097,14 +5102,6 @@ link_up:
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



