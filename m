Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0605BC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C347E20673
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384657;
	bh=W/HA4aCiOQ96V+GxcHWL51sEqCOsrOsL55HJKU5MTXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NR2YhSArJX+uCgVFEqG2Sj28lM+OsF3wEjGsYt0k/eAkgcE6GeAeDDGdB95RD3kxj
	 D0b4FUavurY8hA9SpOoLlp0/u4gH4zSiMbTGlK4gpLe6FBVP8ZNMynwY2S92l0ma7T
	 lcVu/CQTE+3JQzAZKGxDq5eNjOZKaCfdnosh39i0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfJFRdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:33:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728564AbfJFRdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:33:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D4EF2087E;
        Sun,  6 Oct 2019 17:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383197;
        bh=W/HA4aCiOQ96V+GxcHWL51sEqCOsrOsL55HJKU5MTXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XICHSPnzJL0Obho2PLdcRnnr5omrMfJ1IeZI7S3WNO+hZbefd3C0GgwFZIZTDzJyF
         DYXZCm6yIrhNZcOcGnxQA5fP84bWWINrBKwu0aEPTbSrtjY1XGyyQ9mQxS52Ub6U5f
         MuNVZh6Uddth86VMuXbRg9qPPrsMaLbNXvV3Wnlc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Hunt <johunt@akamai.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 016/137] udp: fix gso_segs calculations
Date:   Sun,  6 Oct 2019 19:20:00 +0200
Message-Id: <20191006171210.790390947@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Hunt <johunt@akamai.com>

[ Upstream commit 44b321e5020d782ad6e8ae8183f09b163be6e6e2 ]

Commit dfec0ee22c0a ("udp: Record gso_segs when supporting UDP segmentation offload")
added gso_segs calculation, but incorrectly got sizeof() the pointer and
not the underlying data type. In addition let's fix the v6 case.

Fixes: bec1f6f69736 ("udp: generate gso with UDP_SEGMENT")
Fixes: dfec0ee22c0a ("udp: Record gso_segs when supporting UDP segmentation offload")
Signed-off-by: Josh Hunt <johunt@akamai.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/udp.c |    2 +-
 net/ipv6/udp.c |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -868,7 +868,7 @@ static int udp_send_skb(struct sk_buff *
 
 		skb_shinfo(skb)->gso_size = cork->gso_size;
 		skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
-		skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(len - sizeof(uh),
+		skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(len - sizeof(*uh),
 							 cork->gso_size);
 		goto csum_partial;
 	}
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1156,6 +1156,8 @@ static int udp_v6_send_skb(struct sk_buf
 
 		skb_shinfo(skb)->gso_size = cork->gso_size;
 		skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
+		skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(len - sizeof(*uh),
+							 cork->gso_size);
 		goto csum_partial;
 	}
 


