Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5489AC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0EE208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919257;
	bh=cY1lYufDsOuH9eYiHBsjkA1HrylGeF39ZhwcLFZxWqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BEJ5D4z4/0xTcNKKuFYTtNMwLNijDNj1aUY3IXzr8VTeXkp66Hcv3Askce1IhpsZH
	 27ydP/l64/rQ4+j/EZR/w1pl6FiZswAN81WtA8vZIycnLC/PdBZr0e/VQlQUJDe0H6
	 1sCywy2seYr+UQ8JyeN0CoFmfJjCb2d9FYOslXOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfKPPrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:47:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbfKPPqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:46:52 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A746C20B7C;
        Sat, 16 Nov 2019 15:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919212;
        bh=cY1lYufDsOuH9eYiHBsjkA1HrylGeF39ZhwcLFZxWqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQi3bC73I2Y1JkuJH8bXDR21JNgeEGeqAFOmAEui+TwxlA3OQfaAYhueRq0ou6I6k
         /tQpRjpcU04EpDUjLbnG9uzTeIBGZpaw4sCc0JnBvp/G7gr9X6AvfJ4i5uaL+W/zT2
         wq61dK2ONFjvmmcO1YH5WQOgGR7evs4NEw/3m1+s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Manning <mmanning@vyatta.att-mail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 218/237] vrf: mark skb for multicast or link-local as enslaved to VRF
Date:   Sat, 16 Nov 2019 10:40:53 -0500
Message-Id: <20191116154113.7417-218-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

