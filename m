Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED01C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 00:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8112053B
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 00:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfJMAbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 20:31:00 -0400
Received: from shells.gnugeneration.com ([66.240.222.126]:51144 "EHLO
        shells.gnugeneration.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbfJMAax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 20:30:53 -0400
Received: by shells.gnugeneration.com (Postfix, from userid 1000)
        id 7DE911A40556; Sat, 12 Oct 2019 17:30:53 -0700 (PDT)
Date:   Sat, 12 Oct 2019 17:30:53 -0700
From:   Vito Caputo <vcaputo@pengaru.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: core: skbuff: skb_checksum_setup() drop err
Message-ID: <20191013003053.tmdc3hs73ik3asxq@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return directly from all switch cases, no point in storing in err.

Signed-off-by: Vito Caputo <vcaputo@pengaru.com>
---
 net/core/skbuff.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f5f904f46893..c59b68a413b5 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4888,23 +4888,14 @@ static int skb_checksum_setup_ipv6(struct sk_buff *skb, bool recalculate)
  */
 int skb_checksum_setup(struct sk_buff *skb, bool recalculate)
 {
-	int err;
-
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
-		err = skb_checksum_setup_ipv4(skb, recalculate);
-		break;
-
+		return skb_checksum_setup_ipv4(skb, recalculate);
 	case htons(ETH_P_IPV6):
-		err = skb_checksum_setup_ipv6(skb, recalculate);
-		break;
-
+		return skb_checksum_setup_ipv6(skb, recalculate);
 	default:
-		err = -EPROTO;
-		break;
+		return -EPROTO;
 	}
-
-	return err;
 }
 EXPORT_SYMBOL(skb_checksum_setup);
 
-- 
2.11.0

