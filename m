Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C29C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2935F21556
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889752;
	bh=cY1lYufDsOuH9eYiHBsjkA1HrylGeF39ZhwcLFZxWqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iKAnzlHewKSVWOWKI+rCMeZSK2uq+wt9FmfkqCflcBq3PxOCKYjGrCs63rKlwuuZ+
	 YiZEl+FKlDL7nzqvZunEol2en0qmNa9EHctqbz16cp65u+yiyx7omiogWyGHc2KxQY
	 zOnHNH1qtal8MZCbqp+A6CmknmEJClff1pB0s/BE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbfK0VFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:05:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbfK0VFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:05:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B92F21741;
        Wed, 27 Nov 2019 21:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888742;
        bh=cY1lYufDsOuH9eYiHBsjkA1HrylGeF39ZhwcLFZxWqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c8sW0VMiH2xnpLeOpGcZjQ2WpdnLR6lK91dlvkTZi8G4JX1XYcQAmP7x2IFpQXxSz
         Zo2avjEj6swz3f0c2aL3NEbWZYFdEc5LKpaBPhP1c4CZ2rsE8Ru6+kWTbEl3hdtJ9P
         HvOKjEC1BDwVHoLjHvrkjWjlM8fnBnwU1RUggz6o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Manning <mmanning@vyatta.att-mail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 235/306] vrf: mark skb for multicast or link-local as enslaved to VRF
Date:   Wed, 27 Nov 2019 21:31:25 +0100
Message-Id: <20191127203132.178090957@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Manning <mmanning@vyatta.att-mail.com>

[ Upstream commit 6f12fa775530195a501fb090d092c637f32d0cc5 ]

The skb for packets that are multicast or to a link-local address are
not marked as being enslaved to a VRF, if they are received on a socket
bound to the VRF. This is needed for ND and it is preferable for the
kernel not to have to deal with the additional use-cases if ll or mcast
packets are handled as enslaved. However, this does not allow service
instances listening on unbound and bound to VRF sockets to distinguish
the VRF used, if packets are sent as multicast or to a link-local
address. The fix is for the VRF driver to also mark these skb as being
enslaved to the VRF.

Signed-off-by: Mike Manning <mmanning@vyatta.att-mail.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Tested-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vrf.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 9f895083bc0aa..7f5ee6bb44300 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -993,24 +993,23 @@ static struct sk_buff *vrf_ip6_rcv(struct net_device *vrf_dev,
 				   struct sk_buff *skb)
 {
 	int orig_iif = skb->skb_iif;
-	bool need_strict;
+	bool need_strict = rt6_need_strict(&ipv6_hdr(skb)->daddr);
+	bool is_ndisc = ipv6_ndisc_frame(skb);
 
-	/* loopback traffic; do not push through packet taps again.
-	 * Reset pkt_type for upper layers to process skb
+	/* loopback, multicast & non-ND link-local traffic; do not push through
+	 * packet taps again. Reset pkt_type for upper layers to process skb
 	 */
-	if (skb->pkt_type == PACKET_LOOPBACK) {
+	if (skb->pkt_type == PACKET_LOOPBACK || (need_strict && !is_ndisc)) {
 		skb->dev = vrf_dev;
 		skb->skb_iif = vrf_dev->ifindex;
 		IP6CB(skb)->flags |= IP6SKB_L3SLAVE;
-		skb->pkt_type = PACKET_HOST;
+		if (skb->pkt_type == PACKET_LOOPBACK)
+			skb->pkt_type = PACKET_HOST;
 		goto out;
 	}
 
-	/* if packet is NDISC or addressed to multicast or link-local
-	 * then keep the ingress interface
-	 */
-	need_strict = rt6_need_strict(&ipv6_hdr(skb)->daddr);
-	if (!ipv6_ndisc_frame(skb) && !need_strict) {
+	/* if packet is NDISC then keep the ingress interface */
+	if (!is_ndisc) {
 		vrf_rx_stats(vrf_dev, skb->len);
 		skb->dev = vrf_dev;
 		skb->skb_iif = vrf_dev->ifindex;
-- 
2.20.1



