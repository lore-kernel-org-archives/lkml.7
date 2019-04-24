Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3D4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDA321905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126904;
	bh=3QSmPWTTFLyM3UhpPRdBhpNELUK98UsXtjcpVDVuTKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H6f4EUvGs9fSLLly3eJAWTPc30GulzbkU3LfMOH1NJr4MQzf91ZcjM/toY3l7y5fW
	 vxTYh3JuWoAhVp8Q2InnmM9MejDa7msE06LDGRFdhmvJUh7tYgJryy42k7ite425DU
	 SJ2HHdukFf3Rk3oJ9M9JYcUR/YTmi7Omf0qpta6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390675AbfDXR2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390647AbfDXR2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:28:18 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8EA1205ED;
        Wed, 24 Apr 2019 17:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126897;
        bh=3QSmPWTTFLyM3UhpPRdBhpNELUK98UsXtjcpVDVuTKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LjKYUUGQriKX8B2PgHtTX6DYWBqy2MWbA683PDac0twSg29Jz6nGwG2WluUlLSOaI
         6k5jPKCOyXxujre8CVvW3iigXJerQmOTyl21457iQA8ETaO3NhrQk4egqY+dNxAtHW
         kHdCH/VjcqxxMTrtHvn7UiNjRqLkumZ1Xrk1pkMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 55/70] ipv6: frags: fix a lockdep false positive
Date:   Wed, 24 Apr 2019 19:10:15 +0200
Message-Id: <20190424170917.536456319@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 415787d7799f4fccbe8d49cb0b8e5811be6b0389 ]

lockdep does not know that the locks used by IPv4 defrag
and IPv6 reassembly units are of different classes.

It complains because of following chains :

1) sch_direct_xmit()        (lock txq->_xmit_lock)
    dev_hard_start_xmit()
     xmit_one()
      dev_queue_xmit_nit()
       packet_rcv_fanout()
        ip_check_defrag()
         ip_defrag()
          spin_lock()     (lock frag queue spinlock)

2) ip6_input_finish()
    ipv6_frag_rcv()       (lock frag queue spinlock)
     ip6_frag_queue()
      icmpv6_param_prob() (lock txq->_xmit_lock at some point)

We could add lockdep annotations, but we also can make sure IPv6
calls icmpv6_param_prob() only after the release of the frag queue spinlock,
since this naturally makes frag queue spinlock a leaf in lock hierarchy.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/reassembly.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 2a8c680b67cd..f75e9e711c31 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -170,7 +170,8 @@ fq_find(struct net *net, __be32 id, const struct ipv6hdr *hdr, int iif)
 }
 
 static int ip6_frag_queue(struct frag_queue *fq, struct sk_buff *skb,
-			   struct frag_hdr *fhdr, int nhoff)
+			  struct frag_hdr *fhdr, int nhoff,
+			  u32 *prob_offset)
 {
 	struct sk_buff *prev, *next;
 	struct net_device *dev;
@@ -186,11 +187,7 @@ static int ip6_frag_queue(struct frag_queue *fq, struct sk_buff *skb,
 			((u8 *)(fhdr + 1) - (u8 *)(ipv6_hdr(skb) + 1)));
 
 	if ((unsigned int)end > IPV6_MAXPLEN) {
-		__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
-				IPSTATS_MIB_INHDRERRORS);
-		icmpv6_param_prob(skb, ICMPV6_HDR_FIELD,
-				  ((u8 *)&fhdr->frag_off -
-				   skb_network_header(skb)));
+		*prob_offset = (u8 *)&fhdr->frag_off - skb_network_header(skb);
 		return -1;
 	}
 
@@ -221,10 +218,7 @@ static int ip6_frag_queue(struct frag_queue *fq, struct sk_buff *skb,
 			/* RFC2460 says always send parameter problem in
 			 * this case. -DaveM
 			 */
-			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
-					IPSTATS_MIB_INHDRERRORS);
-			icmpv6_param_prob(skb, ICMPV6_HDR_FIELD,
-					  offsetof(struct ipv6hdr, payload_len));
+			*prob_offset = offsetof(struct ipv6hdr, payload_len);
 			return -1;
 		}
 		if (end > fq->q.len) {
@@ -536,15 +530,22 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 	iif = skb->dev ? skb->dev->ifindex : 0;
 	fq = fq_find(net, fhdr->identification, hdr, iif);
 	if (fq) {
+		u32 prob_offset = 0;
 		int ret;
 
 		spin_lock(&fq->q.lock);
 
 		fq->iif = iif;
-		ret = ip6_frag_queue(fq, skb, fhdr, IP6CB(skb)->nhoff);
+		ret = ip6_frag_queue(fq, skb, fhdr, IP6CB(skb)->nhoff,
+				     &prob_offset);
 
 		spin_unlock(&fq->q.lock);
 		inet_frag_put(&fq->q);
+		if (prob_offset) {
+			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
+					IPSTATS_MIB_INHDRERRORS);
+			icmpv6_param_prob(skb, ICMPV6_HDR_FIELD, prob_offset);
+		}
 		return ret;
 	}
 
-- 
2.19.1



