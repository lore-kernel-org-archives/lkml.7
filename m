Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEED8C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A824A255C0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190621;
	bh=B0kkcBhPPymQtbiVsDOq5fIlhZphzUPVBtAroCUNc0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Q76MDDBAZCoD1ZD1qWh0QGPuM9gMWOoJrEgvODTvGH8IbOfu+Ewv42z59PsvCln7
	 UBjr02rWHZylL1dJ4hDOnRmP4Ln0WDIt/vcPNVF4B9GEcTeRdlOddMGA4uekbW/W76
	 FtcQL+pcOePG6Sk6/NJsVLo7meljb/FFjMaWxMHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388085AbfE3EaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:30:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbfE3DN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:13:56 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5415124570;
        Thu, 30 May 2019 03:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186035;
        bh=B0kkcBhPPymQtbiVsDOq5fIlhZphzUPVBtAroCUNc0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uvByfgqNMJ08zI2yoh++BZ44mdkXCvG8wI8OU1LFweC3hNJZt9BG+0g1oaC3u0G9+
         +HfY8PUyQcqWPvNevY8TipZqBckPQv0Z0nvmq9zrCJ36PJjsHV5vjkEWNPSpst4Xql
         SHeMWmviQ4OTahSHEbwYa56irmExjJ6n1XZubJjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 121/346] RDMA/cma: Consider scope_id while binding to ipv6 ll address
Date:   Wed, 29 May 2019 20:03:14 -0700
Message-Id: <20190530030547.206456234@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5d7ed2f27bbd482fd29e6b2e204b1a1ee8a0b268 ]

When two netdev have same link local addresses (such as vlan and non
vlan), two rdma cm listen id should be able to bind to following different
addresses.

listener-1: addr=lla, scope_id=A, port=X
listener-2: addr=lla, scope_id=B, port=X

However while comparing the addresses only addr and port are considered,
due to which 2nd listener fails to listen.

In below example of two listeners, 2nd listener is failing with address in
use error.

$ rping -sv -a fe80::268a:7ff:feb3:d113%ens2f1 -p 4545&

$ rping -sv -a fe80::268a:7ff:feb3:d113%ens2f1.200 -p 4545
rdma_bind_addr: Address already in use

To overcome this, consider the scope_ids as well which forms the accurate
IPv6 link local address.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/cma.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 81bded0d37d1e..cb482f3389504 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1170,18 +1170,31 @@ static inline bool cma_any_addr(const struct sockaddr *addr)
 	return cma_zero_addr(addr) || cma_loopback_addr(addr);
 }
 
-static int cma_addr_cmp(struct sockaddr *src, struct sockaddr *dst)
+static int cma_addr_cmp(const struct sockaddr *src, const struct sockaddr *dst)
 {
 	if (src->sa_family != dst->sa_family)
 		return -1;
 
 	switch (src->sa_family) {
 	case AF_INET:
-		return ((struct sockaddr_in *) src)->sin_addr.s_addr !=
-		       ((struct sockaddr_in *) dst)->sin_addr.s_addr;
-	case AF_INET6:
-		return ipv6_addr_cmp(&((struct sockaddr_in6 *) src)->sin6_addr,
-				     &((struct sockaddr_in6 *) dst)->sin6_addr);
+		return ((struct sockaddr_in *)src)->sin_addr.s_addr !=
+		       ((struct sockaddr_in *)dst)->sin_addr.s_addr;
+	case AF_INET6: {
+		struct sockaddr_in6 *src_addr6 = (struct sockaddr_in6 *)src;
+		struct sockaddr_in6 *dst_addr6 = (struct sockaddr_in6 *)dst;
+		bool link_local;
+
+		if (ipv6_addr_cmp(&src_addr6->sin6_addr,
+					  &dst_addr6->sin6_addr))
+			return 1;
+		link_local = ipv6_addr_type(&dst_addr6->sin6_addr) &
+			     IPV6_ADDR_LINKLOCAL;
+		/* Link local must match their scope_ids */
+		return link_local ? (src_addr6->sin6_scope_id !=
+				     dst_addr6->sin6_scope_id) :
+				    0;
+	}
+
 	default:
 		return ib_addr_cmp(&((struct sockaddr_ib *) src)->sib_addr,
 				   &((struct sockaddr_ib *) dst)->sib_addr);
-- 
2.20.1



