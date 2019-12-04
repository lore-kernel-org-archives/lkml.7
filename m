Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E50BC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC85B205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483982;
	bh=5h0OygXDoZNLicE0SwzE2o2UOc4LtmIgD5yjgZUBFkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M4sZYbW5yBknakcc4s4xCqi12ok1n7MeUD0YI5yYMAg8x+YJ1k0P2yJc5Tux00NH4
	 JZFTrH15xr6Izqi45sJv7Kt0lq3qS4srbJ+otrTqAgvTnn+lyOrHeMfGG8m6RL/XMw
	 jOaTFcKvY/EsUFpdtWWwhB59EJ3JcE86VhiA2mfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbfLDS0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:26:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:36698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729167AbfLDR7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:59:42 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E699E20866;
        Wed,  4 Dec 2019 17:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482382;
        bh=5h0OygXDoZNLicE0SwzE2o2UOc4LtmIgD5yjgZUBFkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kKA0vYGNpeL8Q1RnEwx1hTtHjbY1noQljRX8+hE9bwV++qqUdwY2nWbjcYgWzkG8I
         Cz6S+eT6w1XY4NWZHvL98qm3q5BAxQJSfFk04KBT+kWdnjqiYvfzIxuQ/Qr5IDc4N/
         8PIob6EoT/SD+38v6IhRW7hfmGf9j6rC2ChLgfeQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 65/92] net/core/neighbour: fix kmemleak minimal reference count for hash tables
Date:   Wed,  4 Dec 2019 18:50:05 +0100
Message-Id: <20191204174334.256959625@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index bba672482a0ef..8aef689b8f32d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -332,7 +332,7 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
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



