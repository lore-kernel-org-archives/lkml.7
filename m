Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFE8C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665C5206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 19:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKMTsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 14:48:16 -0500
Received: from smtp.uniroma2.it ([160.80.6.16]:57695 "EHLO smtp.uniroma2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfKMTsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 14:48:13 -0500
X-Greylist: delayed 1019 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Nov 2019 14:47:58 EST
Received: from localhost.localdomain ([160.80.103.126])
        by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id xADJTimn023525
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Nov 2019 20:31:38 +0100
From:   Andrea Mayer <andrea.mayer@uniroma2.it>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Lebrun <dav.lebrun@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [net-next, 3/3] seg6: allow local packet processing for SRv6 End.DT6 behavior
Date:   Wed, 13 Nov 2019 20:29:12 +0100
Message-Id: <20191113192912.17546-4-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113192912.17546-1-andrea.mayer@uniroma2.it>
References: <20191113192912.17546-1-andrea.mayer@uniroma2.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

End.DT6 behavior makes use of seg6_lookup_nexthop function which drops all
packets that are destined to be locally processed. However, DT* should be
able to delivery decapsulated packets that are destined to local addresses.
Function seg6_lookup_nexthop is also used by DX6, so in order to maintain
compatibility I created another routing helper function which is called
seg6_lookup_any_nexthop.
This function is able to take in to account both packets that have to be
processed locally and the ones that are destined to be forwarded directly
to another machine. Hence, seg6_lookup_any_nexthop is used in DT6 rather
than seg6_lookup_nexthop to allow local delivery.

Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/seg6_local.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 948a4c2a59f2..8a723ab3d29c 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -148,8 +148,9 @@ static void advance_nextseg(struct ipv6_sr_hdr *srh, struct in6_addr *daddr)
 	*daddr = *addr;
 }
 
-int seg6_lookup_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
-			u32 tbl_id)
+static int
+seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
+			u32 tbl_id, int local_delivery)
 {
 	struct net *net = dev_net(skb->dev);
 	struct ipv6hdr *hdr = ipv6_hdr(skb);
@@ -157,6 +158,7 @@ int seg6_lookup_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
 	struct dst_entry *dst = NULL;
 	struct rt6_info *rt;
 	struct flowi6 fl6;
+	int dev_flags = 0;
 
 	fl6.flowi6_iif = skb->dev->ifindex;
 	fl6.daddr = nhaddr ? *nhaddr : hdr->daddr;
@@ -181,7 +183,13 @@ int seg6_lookup_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
 		dst = &rt->dst;
 	}
 
-	if (dst && dst->dev->flags & IFF_LOOPBACK && !dst->error) {
+	/* we want to discard traffic destined for local packet processing,
+	 * if @local_delivery is set to false.
+	 */
+	if (!local_delivery)
+		dev_flags |= IFF_LOOPBACK;
+
+	if (dst && (dst->dev->flags & dev_flags) && !dst->error) {
 		dst_release(dst);
 		dst = NULL;
 	}
@@ -198,6 +206,12 @@ int seg6_lookup_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
 	return dst->error;
 }
 
+inline int seg6_lookup_nexthop(struct sk_buff *skb,
+			       struct in6_addr *nhaddr, u32 tbl_id)
+{
+	return seg6_lookup_any_nexthop(skb, nhaddr, tbl_id, false);
+}
+
 /* regular endpoint function */
 static int input_action_end(struct sk_buff *skb, struct seg6_local_lwt *slwt)
 {
@@ -395,7 +409,7 @@ static int input_action_end_dt6(struct sk_buff *skb,
 
 	skb_set_transport_header(skb, sizeof(struct ipv6hdr));
 
-	seg6_lookup_nexthop(skb, NULL, slwt->table);
+	seg6_lookup_any_nexthop(skb, NULL, slwt->table, true);
 
 	return dst_input(skb);
 
-- 
2.20.1

