Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C18AC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A25A2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639601;
	bh=xiHFEhuKAhDe7yRHFzhu6xZ4kSRtH6LVk5ab6mrIEPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eXSYs1AtHLdT/b7bkTIbymu8rreKUZNSNkVV75CMNfO8Zi1Y3TO2R3ouqUQmVCF/6
	 TwCLDOQpcttKHHZXC359HoCQgccCvliX4oS+KpT2Cg+jDWDYTwaluty0LFjWVJTBZW
	 YOyus2JARpzIyqbRfeVG/rmyY39+YBHnsAwsVFpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391388AbfEWT0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391018AbfEWT0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:26:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D5542054F;
        Thu, 23 May 2019 19:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639594;
        bh=xiHFEhuKAhDe7yRHFzhu6xZ4kSRtH6LVk5ab6mrIEPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qvApkFuJN9rpoCtuAMz9keQXkVDlVM+BnJmqsHd8KxA5GqtAFrvbT4Ysd9zLihGnR
         qp8CtyKz0PkXghyX5DoLO/f8HDD+/8haNxtUNz/1YJc0I8D6nHY51y+a6T1Fg8FJKo
         LV7srY/kD/QThaS0GtjHLT82DPuXEk+Viry6DIvo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 006/122] net: test nouarg before dereferencing zerocopy pointers
Date:   Thu, 23 May 2019 21:05:28 +0200
Message-Id: <20190523181705.892932071@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 185ce5c38ea76f29b6bd9c7c8c7a5e5408834920 ]

Zerocopy skbs without completion notification were added for packet
sockets with PACKET_TX_RING user buffers. Those signal completion
through the TP_STATUS_USER bit in the ring. Zerocopy annotation was
added only to avoid premature notification after clone or orphan, by
triggering a copy on these paths for these packets.

The mechanism had to define a special "no-uarg" mode because packet
sockets already use skb_uarg(skb) == skb_shinfo(skb)->destructor_arg
for a different pointer.

Before deferencing skb_uarg(skb), verify that it is a real pointer.

Fixes: 5cd8d46ea1562 ("packet: copy user buffers before orphan or clone")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1425,10 +1425,12 @@ static inline void skb_zcopy_clear(struc
 	struct ubuf_info *uarg = skb_zcopy(skb);
 
 	if (uarg) {
-		if (uarg->callback == sock_zerocopy_callback) {
+		if (skb_zcopy_is_nouarg(skb)) {
+			/* no notification callback */
+		} else if (uarg->callback == sock_zerocopy_callback) {
 			uarg->zerocopy = uarg->zerocopy && zerocopy;
 			sock_zerocopy_put(uarg);
-		} else if (!skb_zcopy_is_nouarg(skb)) {
+		} else {
 			uarg->callback(uarg, zerocopy);
 		}
 
@@ -2683,7 +2685,8 @@ static inline int skb_orphan_frags(struc
 {
 	if (likely(!skb_zcopy(skb)))
 		return 0;
-	if (skb_uarg(skb)->callback == sock_zerocopy_callback)
+	if (!skb_zcopy_is_nouarg(skb) &&
+	    skb_uarg(skb)->callback == sock_zerocopy_callback)
 		return 0;
 	return skb_copy_ubufs(skb, gfp_mask);
 }


