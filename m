Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAB8C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8473A218AC
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765456;
	bh=+OYwP19RhWuLwdi9dWYB9JjNHhAy3RS3munsabWWZF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MuMMvLFko8+hajYFcF6SnJU3aC2D5G9UtqE7RwVLeUmqwNqqoJh8oZI9XnRtduJh4
	 SU1kTHN4QBVME3BAoc192CVeam1nTb1mTXsu1H2N6FkApeSnbnueAjXk3TVIQzwUj0
	 5/3b3I2h8JD6JN5P41CTMP05yXIKeh0SfwldnQu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfI2N5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 09:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729240AbfI2N5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 09:57:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0868421835;
        Sun, 29 Sep 2019 13:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765451;
        bh=+OYwP19RhWuLwdi9dWYB9JjNHhAy3RS3munsabWWZF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HJRGuQPD4a5sxU58X4qA1t/dtPAMnFID+Rj7SNEb9W+Lv0ZaYTjEWbzmHBMn5GVKT
         0R82pvGVvarc+o2D3XFRoJkOk2RN+Bu5aAgRAtNfhIaxMNvZP62iwRBQ7GMjuGNVC+
         oyeXmQexiHFIlj4g0RzkU7VV+i39BOJdJAyh4ON0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alaa Hleihel <alaa@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 16/63] net/mlx5e: dont set CHECKSUM_COMPLETE on SCTP packets
Date:   Sun, 29 Sep 2019 15:53:49 +0200
Message-Id: <20190929135035.043739528@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135031.382429403@linuxfoundation.org>
References: <20190929135031.382429403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alaa Hleihel <alaa@mellanox.com>

[ Upstream commit fe1dc069990c1f290ef6b99adb46332c03258f38 ]

CHECKSUM_COMPLETE is not applicable to SCTP protocol.
Setting it for SCTP packets leads to CRC32c validation failure.

Fixes: bbceefce9adf ("net/mlx5e: Support RX CHECKSUM_COMPLETE")
Signed-off-by: Alaa Hleihel <alaa@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -725,6 +725,14 @@ static u32 mlx5e_get_fcs(const struct sk
 	return __get_unaligned_cpu32(fcs_bytes);
 }
 
+static u8 get_ip_proto(struct sk_buff *skb, __be16 proto)
+{
+	void *ip_p = skb->data + sizeof(struct ethhdr);
+
+	return (proto == htons(ETH_P_IP)) ? ((struct iphdr *)ip_p)->protocol :
+					    ((struct ipv6hdr *)ip_p)->nexthdr;
+}
+
 #define short_frame(size) ((size) <= ETH_ZLEN + ETH_FCS_LEN)
 
 static inline void mlx5e_handle_csum(struct net_device *netdev,
@@ -758,6 +766,9 @@ static inline void mlx5e_handle_csum(str
 		goto csum_unnecessary;
 
 	if (likely(is_last_ethertype_ip(skb, &network_depth, &proto))) {
+		if (unlikely(get_ip_proto(skb, proto) == IPPROTO_SCTP))
+			goto csum_unnecessary;
+
 		skb->ip_summed = CHECKSUM_COMPLETE;
 		skb->csum = csum_unfold((__force __sum16)cqe->check_sum);
 		if (network_depth > ETH_HLEN)


