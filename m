Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171ECC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0427205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564155420;
	bh=YFQL1Pzr8VccqE6s74auw0DJ9yQhIgPRYDfdxRobNmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mpWD8ag4Hv8uFqGbJHxnQH9uq4OSt0Kr5aiOG3NsiWhYPywHbB9Oa9JisAmKEpXli
	 nfdTSiyj0czAmTN6VaJIzdf8xCb1G/gQ2qbQo3UgLGJK60XIPCgp/2i7pY+dDnM3Fe
	 WBGK3s15Kmhbsa5AApOTdc6/CC1DNMHia1hsrlQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388688AbfGZPg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388315AbfGZPa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:30:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17D5E205F4;
        Fri, 26 Jul 2019 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564155027;
        bh=YFQL1Pzr8VccqE6s74auw0DJ9yQhIgPRYDfdxRobNmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j5uF4zVyA6lrj4Y2boD1Eu7Y4DMKhj+49sXDHJuuJ1LppRPYIKlTiCTIGSPGb7vDg
         5HnEPA8JaiBujLkdnu2mAfEt8apgtZTBAhPRkDPLkP66rb4K4fcdTcaygG3HBLErSR
         NCOyeIzaR8B5irRt6WPJdWNtlZ1I283PYB9fAZIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.1 40/62] net/mlx5e: Rx, Fix checksum calculation for new hardware
Date:   Fri, 26 Jul 2019 17:24:52 +0200
Message-Id: <20190726152306.179800031@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.720139286@linuxfoundation.org>
References: <20190726152301.720139286@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saeed Mahameed <saeedm@mellanox.com>

[ Upstream commit db849faa9bef993a1379dc510623f750a72fa7ce ]

CQE checksum full mode in new HW, provides a full checksum of rx frame.
Covering bytes starting from eth protocol up to last byte in the received
frame (frame_size - ETH_HLEN), as expected by the stack.

Fixing up skb->csum by the driver is not required in such case. This fix
is to avoid wrong checksum calculation in drivers which already support
the new hardware with the new checksum mode.

Fixes: 85327a9c4150 ("net/mlx5: Update the list of the PCI supported devices")
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |    3 +++
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c   |    7 ++++++-
 include/linux/mlx5/mlx5_ifc.h                     |    3 ++-
 4 files changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -294,6 +294,7 @@ enum {
 	MLX5E_RQ_STATE_ENABLED,
 	MLX5E_RQ_STATE_AM,
 	MLX5E_RQ_STATE_NO_CSUM_COMPLETE,
+	MLX5E_RQ_STATE_CSUM_FULL, /* cqe_csum_full hw bit is set */
 };
 
 struct mlx5e_cq {
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -948,6 +948,9 @@ static int mlx5e_open_rq(struct mlx5e_ch
 	if (err)
 		goto err_destroy_rq;
 
+	if (MLX5_CAP_ETH(c->mdev, cqe_checksum_full))
+		__set_bit(MLX5E_RQ_STATE_CSUM_FULL, &c->rq.state);
+
 	if (params->rx_dim_enabled)
 		__set_bit(MLX5E_RQ_STATE_AM, &c->rq.state);
 
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -829,8 +829,14 @@ static inline void mlx5e_handle_csum(str
 		if (unlikely(get_ip_proto(skb, network_depth, proto) == IPPROTO_SCTP))
 			goto csum_unnecessary;
 
+		stats->csum_complete++;
 		skb->ip_summed = CHECKSUM_COMPLETE;
 		skb->csum = csum_unfold((__force __sum16)cqe->check_sum);
+
+		if (test_bit(MLX5E_RQ_STATE_CSUM_FULL, &rq->state))
+			return; /* CQE csum covers all received bytes */
+
+		/* csum might need some fixups ...*/
 		if (network_depth > ETH_HLEN)
 			/* CQE csum is calculated from the IP header and does
 			 * not cover VLAN headers (if present). This will add
@@ -841,7 +847,6 @@ static inline void mlx5e_handle_csum(str
 						 skb->csum);
 
 		mlx5e_skb_padding_csum(skb, network_depth, proto, stats);
-		stats->csum_complete++;
 		return;
 	}
 
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -716,7 +716,8 @@ struct mlx5_ifc_per_protocol_networking_
 	u8         swp[0x1];
 	u8         swp_csum[0x1];
 	u8         swp_lso[0x1];
-	u8         reserved_at_23[0xd];
+	u8         cqe_checksum_full[0x1];
+	u8         reserved_at_24[0xc];
 	u8         max_vxlan_udp_ports[0x8];
 	u8         reserved_at_38[0x6];
 	u8         max_geneve_opt_len[0x1];


