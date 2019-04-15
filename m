Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD4BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168A72087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355100;
	bh=H7rKdmFTc5qZBeuaO8rpSqLCLhvPVO44wOUlN+eUbfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=arJHHSuBP2Pt2z2LRkvDW/CPWPYL+HAf2pxA1dK2wOXDhC58rnbsc+TC8bAR+MifB
	 Vn+M+EXbgoyMhG97QGOgCNTywZnj7gcccYk5BS5NvjUa1xkQiINCnIBY43SFKbMbBz
	 9YF89S+PeUpIe84IvoW5sLey2ZCsvt5BYow0lTU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfDOTE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729640AbfDOTE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:04:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0491218A1;
        Mon, 15 Apr 2019 19:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355095;
        bh=H7rKdmFTc5qZBeuaO8rpSqLCLhvPVO44wOUlN+eUbfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N2sox8SCaeXZY0n4ae+SDkpzN1K4XBBqi9Gx62qismEr6aXMqN2Mzxn6NlAHQHaxv
         A+OB5y1ZPJJKo00KapXh/OuGYBK2w6oNIxfe24Xj9YDs/xbZtB+fY0fte3uPXkPjQ4
         4FXMP5y3VzLUa7K3NxZ0hrIWLlIW0bBax4RJQGYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 011/101] net-gro: Fix GRO flush when receiving a GSO packet.
Date:   Mon, 15 Apr 2019 20:58:09 +0200
Message-Id: <20190415183740.969100277@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
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
index 8656b1e20d35..ceee28e184af 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3832,7 +3832,7 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	unsigned int delta_truesize;
 	struct sk_buff *lp;
 
-	if (unlikely(p->len + len >= 65536))
+	if (unlikely(p->len + len >= 65536 || NAPI_GRO_CB(skb)->flush))
 		return -E2BIG;
 
 	lp = NAPI_GRO_CB(p)->last;
-- 
2.19.1



