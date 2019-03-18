Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31313C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01194214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901629;
	bh=43q9644GxKPtucTiDffZGvk9fkNf+G4w4PxfEwQD5qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OF/0rZE16TQ28pq3YVzA9a6+7SQpLx5wcPkHUgR8IL/YXEsuyP3+I77MFGVwzu9ER
	 4DPo1JxjKRC8s3LlOcu5XsCtkWjj5CFJaCFTVKL2cfoMQM0Nb5DX+AMs1JpNvrPfMS
	 h6rxPvZJxjYYxmVyUG9uCSMOn3ax/NFqkIkooDOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfCRJdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728574AbfCRJdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:33:41 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C15AC2083D;
        Mon, 18 Mar 2019 09:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901620;
        bh=43q9644GxKPtucTiDffZGvk9fkNf+G4w4PxfEwQD5qI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HbawI2iLePX98pYMdHnu4WgMfVyED12S1vE8UlSWc27kjdqYJjOf5DzmFbIZjtwBf
         vrzqpnJLHqAHSxOoU6zlp7b2rje/N6D61ji2TdpY0JjpT4T/1IFhSZN8ykEuJJ79z3
         NFQWPOTOEJ9VCwOjOFwRbaOtjIX3KUhzl9BjRFtc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Emeric Brun <ebrun@haproxy.com>
Subject: [PATCH 4.19 51/52] i40e: report correct statistics when XDP is enabled
Date:   Mon, 18 Mar 2019 10:25:48 +0100
Message-Id: <20190318084019.553098290@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
References: <20190318084013.532280682@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Björn Töpel <bjorn.topel@intel.com>

commit cdec2141c24ef177d929765c5a6f95549c266fb3 upstream.

When XDP is enabled, the driver will report incorrect
statistics. Received frames will reported as transmitted frames.

This commits fixes the i40e implementation of ndo_get_stats64 (struct
net_device_ops), so that iproute2 will report correct statistics
(e.g. when running "ip -stats link show dev eth0") even when XDP is
enabled.

Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
Fixes: 74608d17fe29 ("i40e: add support for XDP_TX action")
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Emeric Brun <ebrun@haproxy.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/intel/i40e/i40e_main.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -424,9 +424,9 @@ static void i40e_get_netdev_stats_struct
 				  struct rtnl_link_stats64 *stats)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
-	struct i40e_ring *tx_ring, *rx_ring;
 	struct i40e_vsi *vsi = np->vsi;
 	struct rtnl_link_stats64 *vsi_stats = i40e_get_vsi_stats_struct(vsi);
+	struct i40e_ring *ring;
 	int i;
 
 	if (test_bit(__I40E_VSI_DOWN, vsi->state))
@@ -440,24 +440,26 @@ static void i40e_get_netdev_stats_struct
 		u64 bytes, packets;
 		unsigned int start;
 
-		tx_ring = READ_ONCE(vsi->tx_rings[i]);
-		if (!tx_ring)
+		ring = READ_ONCE(vsi->tx_rings[i]);
+		if (!ring)
 			continue;
-		i40e_get_netdev_stats_struct_tx(tx_ring, stats);
+		i40e_get_netdev_stats_struct_tx(ring, stats);
 
-		rx_ring = &tx_ring[1];
+		if (i40e_enabled_xdp_vsi(vsi)) {
+			ring++;
+			i40e_get_netdev_stats_struct_tx(ring, stats);
+		}
 
+		ring++;
 		do {
-			start = u64_stats_fetch_begin_irq(&rx_ring->syncp);
-			packets = rx_ring->stats.packets;
-			bytes   = rx_ring->stats.bytes;
-		} while (u64_stats_fetch_retry_irq(&rx_ring->syncp, start));
+			start   = u64_stats_fetch_begin_irq(&ring->syncp);
+			packets = ring->stats.packets;
+			bytes   = ring->stats.bytes;
+		} while (u64_stats_fetch_retry_irq(&ring->syncp, start));
 
 		stats->rx_packets += packets;
 		stats->rx_bytes   += bytes;
 
-		if (i40e_enabled_xdp_vsi(vsi))
-			i40e_get_netdev_stats_struct_tx(&rx_ring[1], stats);
 	}
 	rcu_read_unlock();
 


