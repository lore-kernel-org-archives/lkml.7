Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54382C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9E2205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430531;
	bh=fQxvfeb8Oau7nGkThdwi/x3SxOWcDMjxQ9XNvSRw1Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vhwivTyEDkTMlrmG1YNtnnGsZpshifDLqdxf6geRnK27buGAG8etJoA+QyqRqboW1
	 Iy4uIumIuXTjceW6NdMkw/rDuZzQcX1LO3RKjaq4KsWlHWWuLBSxI3nGlF4BXu92F3
	 i2DyEltlpGEZf7Gx30T9gCzMKr02bqsmyKZVaS/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390876AbfG2UBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390800AbfG2Tvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:51:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C88E204EC;
        Mon, 29 Jul 2019 19:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429896;
        bh=fQxvfeb8Oau7nGkThdwi/x3SxOWcDMjxQ9XNvSRw1Rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=znLvocsgLa9YSqIBZTMG5DIwbdEQu2vO7gOaMz+iJnqak2jh3qNxfOfHGjlEutkkW
         pgPHPbAQp435CD8rtpfRawQfzKtP9AbDCLqykotzOuLnnFsN7CTPGRW79//28N1Gsl
         xlnxbGUfEBnlqCpRkLos9VKrvll72odLbvWj2aJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dag Moxnes <dag.moxnes@oracle.com>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 131/215] RDMA/core: Fix race when resolving IP address
Date:   Mon, 29 Jul 2019 21:22:07 +0200
Message-Id: <20190729190802.158910889@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d8d9ec7dc5abbb3f11d866e983c4984f5c2de9d6 ]

Use the neighbour lock when copying the MAC address from the neighbour
data struct in dst_fetch_ha.

When not using the lock, it is possible for the function to race with
neigh_update(), causing it to copy an torn MAC address:

rdma_resolve_addr()
  rdma_resolve_ip()
    addr_resolve()
      addr_resolve_neigh()
        fetch_ha()
          dst_fetch_ha()
	     memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN)

and

net_ioctl()
  arp_ioctl()
    arp_rec_delete()
      arp_invalidate()
        neigh_update()
          __neigh_update()
	    memcpy(&neigh->ha, lladdr, dev->addr_len)

It is possible to provoke this error by calling rdma_resolve_addr() in a
tight loop, while deleting the corresponding ARP entry in another tight
loop.

Fixes: 51d45974515c ("infiniband: addr: Consolidate code to fetch neighbour hardware address from dst.")
Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 2f7d14159841..9b76a8fcdd24 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -337,7 +337,7 @@ static int dst_fetch_ha(const struct dst_entry *dst,
 		neigh_event_send(n, NULL);
 		ret = -ENODATA;
 	} else {
-		memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN);
+		neigh_ha_snapshot(dev_addr->dst_dev_addr, n, dst->dev);
 	}
 
 	neigh_release(n);
-- 
2.20.1



