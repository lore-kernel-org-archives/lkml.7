Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFE2C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4456B2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127701;
	bh=VWHyxyeHkMiBtZhF6modxElnFJhNs2AJGlaG6pbAzsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YSwACHadrvx+Fs6ad4G7yGmB3er7QLqqqiwkLODSNINRw9BiusND29o5CIVpDLUrH
	 hu8N5C9h+V4oNewIpcUNSZwxROXw5hSei/mMuZFfutj7EgbcbWDqfVY8cR9OWIFu0j
	 PxAZaVQXMG6nZqWRWDAf9T/xSqx+RIR65fgccbqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404070AbfDXRlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392056AbfDXRgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:36:35 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37B222054F;
        Wed, 24 Apr 2019 17:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127394;
        bh=VWHyxyeHkMiBtZhF6modxElnFJhNs2AJGlaG6pbAzsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yZ05ty4N7t7Y77TTh0AFpec+GxGTQonAxQIuTJnPILQUbFdBMR4/VILAl3NJ9oEdy
         9GixJURfJZH4H8padGJR556MOXY7f0Ktx5rLg9Co3yPy0HSggQAWtJ702Oc7orWrWI
         sGkCB0wk7McK1A8gFfprW4vdVGi1dV2XxlGKHQSY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.0 031/115] net/mlx5e: Rx, Check ip headers sanity
Date:   Wed, 24 Apr 2019 19:09:27 +0200
Message-Id: <20190424170926.856272975@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saeed Mahameed <saeedm@mellanox.com>

[ Upstream commit 0318a7b7fcad9765931146efa7ca3a034194737c ]

In the two places is_last_ethertype_ip is being called, the caller will
be looking inside the ip header, to be safe, add ip{4,6} header sanity
check. And return true only on valid ip headers, i.e: the whole header
is contained in the linear part of the skb.

Note: Such situation is very rare and hard to reproduce, since mlx5e
allocates a large enough headroom to contain the largest header one can
imagine.

Fixes: fe1dc069990c ("net/mlx5e: don't set CHECKSUM_COMPLETE on SCTP packets")
Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -693,7 +693,14 @@ static inline bool is_last_ethertype_ip(
 {
 	*proto = ((struct ethhdr *)skb->data)->h_proto;
 	*proto = __vlan_get_protocol(skb, *proto, network_depth);
-	return (*proto == htons(ETH_P_IP) || *proto == htons(ETH_P_IPV6));
+
+	if (*proto == htons(ETH_P_IP))
+		return pskb_may_pull(skb, *network_depth + sizeof(struct iphdr));
+
+	if (*proto == htons(ETH_P_IPV6))
+		return pskb_may_pull(skb, *network_depth + sizeof(struct ipv6hdr));
+
+	return false;
 }
 
 static inline void mlx5e_enable_ecn(struct mlx5e_rq *rq, struct sk_buff *skb)


