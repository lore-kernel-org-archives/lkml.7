Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E05C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD482068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402409;
	bh=gsezTrwdiq3nD9JRIcpdArOxVKjnR8lRYMoWPJV6N7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iZCT2p6CljtT81HjSt5K0pOBf3AWDZIuOKpPObj2oaAbKeGr2JZBvK13DRLy6FB+f
	 v1ZgDtoqkaMg0AE4GQaHzHxyGofv3/xevoCA4H3PMqWC8ggYB3Ht/3hMGNPOr5TC8H
	 nfF/kzKHei3NRJscsEVJfUAJM8tAeU4zWCKecmL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfKVGAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:00:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729501AbfKVF5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:57:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0AE820659;
        Fri, 22 Nov 2019 05:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402261;
        bh=gsezTrwdiq3nD9JRIcpdArOxVKjnR8lRYMoWPJV6N7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjI/M3ZnrMaVThiggMMJ1DzY06krp9IY3UAPu+3mguRnfJYmEjEwqiXQDPSbmCd7q
         LaJHHnFQ8dMcq3l6LX4JCBTyqk+dEY8+7Nf4q1OXHX50p4v0o4CLGYpmnVIaI/aVv/
         8CfOXXEN8ADpRZDGvMVtzdTmJav3ak4wsxor3t34=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 102/127] net/core/neighbour: fix kmemleak minimal reference count for hash tables
Date:   Fri, 22 Nov 2019 00:55:20 -0500
Message-Id: <20191122055544.3299-101-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

[ Upstream commit 01b833ab44c9e484060aad72267fc7e71beb559b ]

This should be 1 for normal allocations, 0 disables leak reporting.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
Fixes: 85704cb8dcfd ("net/core/neighbour: tell kmemleak about hash tables")
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/neighbour.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 9a28a21a51f05..2664ad58e5c01 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -368,7 +368,7 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
 		buckets = (struct neighbour __rcu **)
 			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
 					   get_order(size));
-		kmemleak_alloc(buckets, size, 0, GFP_ATOMIC);
+		kmemleak_alloc(buckets, size, 1, GFP_ATOMIC);
 	}
 	if (!buckets) {
 		kfree(ret);
-- 
2.20.1

