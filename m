Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA442C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D2B21917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254148;
	bh=Tuh43H7lY/8v9UFO6LIA+0i0DxTd/pkKVNmkxOsvEzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IS5zqGZeQoVBBxC8cjrMl2AXOZrFt6ZLvaWKYd5Wy0ylj62Y5Yf8ZrbCr8LxTwApP
	 yMvzUH2n6muaY+Dlhp9ey3HpQ322YhBk1R65E5qqCNmXx4gHOvkBlOrWIF4M2lGwwC
	 AssauS7QSll4WzfvXHScXrH47v75SaYFeZAcp6k8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfCVL3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:29:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728509AbfCVL26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:28:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8CDC21917;
        Fri, 22 Mar 2019 11:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254137;
        bh=Tuh43H7lY/8v9UFO6LIA+0i0DxTd/pkKVNmkxOsvEzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fgngpEJ6tcb6oqnD/e0m9yE6MAJuC1FMBuFs2G+rkp78/f3pBDAtR803LrT+ds6Uz
         k70JMPVfcaWejsN8ZVZFWcajJWBtB0m5fobi3qBPLi6KCldNVVu2KrSKNSUdr6Lh4t
         9VhSBHgJFcg7KBwyjPT1w7dfFSoVSWmr7nWhWR60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 027/230] net/mlx4_en: Force CHECKSUM_NONE for short ethernet frames
Date:   Fri, 22 Mar 2019 12:12:45 +0100
Message-Id: <20190322111238.593288935@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Saeed Mahameed <saeedm@mellanox.com>

[ Upstream commit 29dded89e80e3fff61efb34f07a8a3fba3ea146d ]

When an ethernet frame is padded to meet the minimum ethernet frame
size, the padding octets are not covered by the hardware checksum.
Fortunately the padding octets are usually zero's, which don't affect
checksum. However, it is not guaranteed. For example, switches might
choose to make other use of these octets.
This repeatedly causes kernel hardware checksum fault.

Prior to the cited commit below, skb checksum was forced to be
CHECKSUM_NONE when padding is detected. After it, we need to keep
skb->csum updated. However, fixing up CHECKSUM_COMPLETE requires to
verify and parse IP headers, it does not worth the effort as the packets
are so small that CHECKSUM_COMPLETE has no significant advantage.

Future work: when reporting checksum complete is not an option for
IP non-TCP/UDP packets, we can actually fallback to report checksum
unnecessary, by looking at cqe IPOK bit.

Fixes: 88078d98d1bb ("net: pskb_trim_rcsum() and CHECKSUM_COMPLETE are friends")
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -725,13 +725,27 @@ static int get_fixed_ipv6_csum(__wsum hw
 	return 0;
 }
 #endif
+
+#define short_frame(size) ((size) <= ETH_ZLEN + ETH_FCS_LEN)
+
 static int check_csum(struct mlx4_cqe *cqe, struct sk_buff *skb, void *va,
 		      netdev_features_t dev_features)
 {
 	__wsum hw_checksum = 0;
+	void *hdr;
 
-	void *hdr = (u8 *)va + sizeof(struct ethhdr);
+	/* CQE csum doesn't cover padding octets in short ethernet
+	 * frames. And the pad field is appended prior to calculating
+	 * and appending the FCS field.
+	 *
+	 * Detecting these padded frames requires to verify and parse
+	 * IP headers, so we simply force all those small frames to skip
+	 * checksum complete.
+	 */
+	if (short_frame(skb->len))
+		return -EINVAL;
 
+	hdr = (u8 *)va + sizeof(struct ethhdr);
 	hw_checksum = csum_unfold((__force __sum16)cqe->checksum);
 
 	if (cqe->vlan_my_qpn & cpu_to_be32(MLX4_CQE_CVLAN_PRESENT_MASK) &&
@@ -851,6 +865,11 @@ int mlx4_en_process_rx_cq(struct net_dev
 			(cqe->vlan_my_qpn & cpu_to_be32(MLX4_CQE_L2_TUNNEL));
 
 		if (likely(dev->features & NETIF_F_RXCSUM)) {
+			/* TODO: For IP non TCP/UDP packets when csum complete is
+			 * not an option (not supported or any other reason) we can
+			 * actually check cqe IPOK status bit and report
+			 * CHECKSUM_UNNECESSARY rather than CHECKSUM_NONE
+			 */
 			if (cqe->status & cpu_to_be16(MLX4_CQE_STATUS_TCP |
 						      MLX4_CQE_STATUS_UDP)) {
 				if ((cqe->status & cpu_to_be16(MLX4_CQE_STATUS_IPOK)) &&


