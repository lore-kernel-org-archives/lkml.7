Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AFBC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E78217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383213;
	bh=UGUU/8QyejhUdLsO3Qp6xSfeNn8zrabgD53ZEOe+6Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WQ78amV2lejRrL59gniQDVHhqiDf3Don2fyTAS4XUDVW9xwFqWD8eSmuRohxVBagC
	 iz57WnZvN0y8yqAYCIvDcfD1vJSvttVNHUE4024Ukmmc5jDFQG3kM+VpVrlhyTrCu5
	 WSh44aHarxjK5xVOw+0/SV6hrfC3SZzh2cUzndf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbfJFRdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbfJFRd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:33:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06C7D2087E;
        Sun,  6 Oct 2019 17:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383208;
        bh=UGUU/8QyejhUdLsO3Qp6xSfeNn8zrabgD53ZEOe+6Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zq/EeK9OSeTLQycDP9B4GlHKOcTmWTSSdqmSTIc4QjEbZIjWrrjFuYMhzCny7POQf
         jIZm9FNcV5IjXz8Rv1H46z1vPVXcT5FFMHkUtCepE/oUqS05bYqY7x1lK3KxAeeLLM
         TsLferWlH3FXR8rQSwUFTma/EcSxiO8seNHfcf3s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 002/137] erspan: remove the incorrect mtu limit for erspan
Date:   Sun,  6 Oct 2019 19:19:46 +0200
Message-Id: <20191006171209.761851478@linuxfoundation.org>
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

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

[ Upstream commit 0e141f757b2c78c983df893e9993313e2dc21e38 ]

erspan driver calls ether_setup(), after commit 61e84623ace3
("net: centralize net_device min/max MTU checking"), the range
of mtu is [min_mtu, max_mtu], which is [68, 1500] by default.

It causes the dev mtu of the erspan device to not be greater
than 1500, this limit value is not correct for ipgre tap device.

Tested:
Before patch:
# ip link set erspan0 mtu 1600
Error: mtu greater than device maximum.
After patch:
# ip link set erspan0 mtu 1600
# ip -d link show erspan0
21: erspan0@NONE: <BROADCAST,MULTICAST> mtu 1600 qdisc noop state DOWN
mode DEFAULT group default qlen 1000
    link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff promiscuity 0 minmtu 68 maxmtu 0

Fixes: 61e84623ace3 ("net: centralize net_device min/max MTU checking")
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_gre.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1446,6 +1446,7 @@ static void erspan_setup(struct net_devi
 	struct ip_tunnel *t = netdev_priv(dev);
 
 	ether_setup(dev);
+	dev->max_mtu = 0;
 	dev->netdev_ops = &erspan_netdev_ops;
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;


