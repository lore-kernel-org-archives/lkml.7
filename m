Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1B9C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD1721479
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921268;
	bh=hiiQw4GIooAvk2r6v2UyMwi5UDbrlJKGpCYFPYlAAqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vRSkVTBcFl+o6qdFTn5gNgpLUTJzD7EbKHyR2iXJcdDajg8dn2hWqGuKsIwUrMrPP
	 afc6TXJi4AyOM1B5ukQ0TIaNiTIMyvxOki+Y+Yg5O8sviS7B7Dmemz4WY4JDf9Fl30
	 8XaQiOSsrxByge23JWkYZ4mNdwbN6z352nOXZPM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbfKPQVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:21:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728816AbfKPPno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:43:44 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DC0F20740;
        Sat, 16 Nov 2019 15:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919024;
        bh=hiiQw4GIooAvk2r6v2UyMwi5UDbrlJKGpCYFPYlAAqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkbYshN3qeXODHbeQSkKwdd7wxf4sga0yF2Jolw5/QP5tTAroyy57ZHWI6R9U6RTX
         QxwixILjYsygYR8aNErn5IFiZpWFOx0wAMlI7rsS1kjvIJlXwogvOZ5NOjgfVUG+Yw
         0uUBkqz3Qob3eVMuu87gKT2Eh8zu8aZsYW7P7/Z0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tristram Ha <Tristram.Ha@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 123/237] net: ethernet: cadence: fix socket buffer corruption problem
Date:   Sat, 16 Nov 2019 10:39:18 -0500
Message-Id: <20191116154113.7417-123-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tristram Ha <Tristram.Ha@microchip.com>

[ Upstream commit 899ecaedd15599c22553d158f53b127cc1632dc2 ]

Socket buffer is not re-created when headroom is 2 and tailroom is 1.

Signed-off-by: Tristram Ha <Tristram.Ha@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 74eeb3a985bf1..f175b20ac510a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1721,7 +1721,7 @@ static int macb_pad_and_fcs(struct sk_buff **skb, struct net_device *ndev)
 			padlen = 0;
 		/* No room for FCS, need to reallocate skb. */
 		else
-			padlen = ETH_FCS_LEN - tailroom;
+			padlen = ETH_FCS_LEN;
 	} else {
 		/* Add room for FCS. */
 		padlen += ETH_FCS_LEN;
-- 
2.20.1

