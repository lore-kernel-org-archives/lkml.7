Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32604C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE91E2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="eDOFkQw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbfDQINX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:13:23 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:33472 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727569AbfDQINX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:13:23 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 8F64C2E146A;
        Wed, 17 Apr 2019 11:13:19 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id DjTnSs4Kr0-DGMW1YLO;
        Wed, 17 Apr 2019 11:13:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1555488799; bh=nU/UyANuJr7HaL5b4DzuWw7Mi4MpXvT5ArjGHc26ZUU=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=eDOFkQw2KbaFmgJC4QJ8beBbcBd6cjadfmrWNd5Ld3mE8SPeO0Md+UhRZaccZ9unE
         Xl0LMS19Nd6euyFVBPUd3zsFCYNf3DiphdLWHQzi0wuIARaUKQ6qv1BZs+YMDtLYo5
         kGmCP4+fto5Y6uoKT1sW34LjDVgflUT+fHH6DEXc=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:f5ec:9361:ed45:768f])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id rHSB8NUiqu-DGYGUY2o;
        Wed, 17 Apr 2019 11:13:16 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 1/2] Revert "e1000e: fix cyclic resets at link up with
 active tx"
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     Sasha Levin <sashal@kernel.org>, Joseph Yasi <joe.yasi@gmail.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        e1000-devel@lists.sourceforge.net
Date:   Wed, 17 Apr 2019 11:13:16 +0300
Message-ID: <155548879651.3454.13167784936351314661.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/net/ethernet/intel/e1000e/netdev.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 7acc61e4f645..ba96e52aa8d1 100644
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

