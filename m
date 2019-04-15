Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CFDC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10B920880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355424;
	bh=tkhfKHIFzUFhpxxIxEk90KjameBSDhJpROuHmabU2ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0lQiCAa2NAJNc6WEH5RBVOrPif3MfkEfKLveCpkfw+t7s9CINyObydKSYqxydFZWY
	 I1g0AgOkzlazcYteSYY+mCPwz4v9HKIBHMEP/1j2VPnLVQqmqF+UUY3ABKpCl+6+ST
	 H5FpRAZNqW4XJKgkUQnjkzEA2WJszpz1KZRfCd5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbfDOTKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbfDOTKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:10:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C010E20651;
        Mon, 15 Apr 2019 19:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355419;
        bh=tkhfKHIFzUFhpxxIxEk90KjameBSDhJpROuHmabU2ds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nQBZg6pRPZrydnkKas1y5xjUUm8OohP8yP6X8539ua/2gDOscnHSVG+tqpizOEhJ4
         qXCbyj+0Y/OvviYv+1uBzWI5Xn38keWheeZ8k8ccg9ezaesPlx+6M0esEUo/zlF+tm
         5g2PPRIiHlet7z1DKENushqIlxzlD35dmP5W5UhQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 013/117] net-gro: Fix GRO flush when receiving a GSO packet.
Date:   Mon, 15 Apr 2019 20:59:43 +0200
Message-Id: <20190415183745.570773098@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0ab03f353d3613ea49d1f924faf98559003670a8 ]

Currently we may merge incorrectly a received GSO packet
or a packet with frag_list into a packet sitting in the
gro_hash list. skb_segment() may crash case because
the assumptions on the skb layout are not met.
The correct behaviour would be to flush the packet in the
gro_hash list and send the received GSO packet directly
afterwards. Commit d61d072e87c8e ("net-gro: avoid reorders")
sets NAPI_GRO_CB(skb)->flush in this case, but this is not
checked before merging. This patch makes sure to check this
flag and to not merge in that case.

Fixes: d61d072e87c8e ("net-gro: avoid reorders")
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2415d9cb9b89..ef2cd5712098 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3801,7 +3801,7 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	unsigned int delta_truesize;
 	struct sk_buff *lp;
 
-	if (unlikely(p->len + len >= 65536))
+	if (unlikely(p->len + len >= 65536 || NAPI_GRO_CB(skb)->flush))
 		return -E2BIG;
 
 	lp = NAPI_GRO_CB(p)->last;
-- 
2.19.1



