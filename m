Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D81BC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B1821872
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419659;
	bh=9+0YbwFH7Y+Dix671mMXtS+EpIOTOpMOjdQI2OI22RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CIi/HkhztAZPZOoxCJRutzbqMYk6UnDe22T2TVUVwfAyloCBC4Lgmyb6HYuPpOcNq
	 ZB6K+ocn5++mDi5hC5+i0FJ/bpuwY+SicrxjGxyQA6jt5R0eHqIkKqNvN0IeATkrAg
	 VCDqsZdFxJJmxQvPBu9g7hd/72g0bNcBLWIHsFuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391747AbfGRDOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:14:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391724AbfGRDOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:14:15 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EFF421851;
        Thu, 18 Jul 2019 03:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419654;
        bh=9+0YbwFH7Y+Dix671mMXtS+EpIOTOpMOjdQI2OI22RU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aZ3IH+MTPN2/LoofN7iS0LlKAC34i+ffiuvz4zDKpvue6DfCL++HxVoQUh0NtCPP1
         mna60FIYyflwYQzvHLQJ89DP+Bmnz4vpOdTfZn7eav37wxVLBahPz2tGjl7Ohhi9kK
         66Q3JtYO6CyUAk+/HWU8fG7k0ROzhc/F/p3cbras=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Joseph Yasi <joe.yasi@gmail.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: [PATCH 4.9 40/54] Revert "e1000e: fix cyclic resets at link up with active tx"
Date:   Thu, 18 Jul 2019 12:02:10 +0900
Message-Id: <20190718030052.585548548@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030048.392549994@linuxfoundation.org>
References: <20190718030048.392549994@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

commit caff422ea81e144842bc44bab408d85ac449377b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/intel/e1000e/netdev.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5291,13 +5291,8 @@ static void e1000_watchdog_task(struct w
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
@@ -5320,6 +5315,14 @@ link_up:
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


