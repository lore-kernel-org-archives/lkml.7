Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4B3C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29628208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932602;
	bh=gD4UllbfZ6AEB9mEPmsWhkhD7I5khRQJyueK5GvjFEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=touIFE6z48LSN4Et4fuGbG02qFH4tSbVaeUgrMMyQNPI/OGC5axP0n8fnWUI/eFf3
	 /Lz/pC3+5Rd7loxZQlN5Gw3IdW22Awl+BAb5wiV1DwsOz+oA6xtmzzK0iflFODd7yo
	 vTwVUA4jYWFsF08DT49f63V+IwhgmkpgQu/0XgS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405117AbfISWGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:06:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405063AbfISWFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:05:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E396D21920;
        Thu, 19 Sep 2019 22:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568930754;
        bh=gD4UllbfZ6AEB9mEPmsWhkhD7I5khRQJyueK5GvjFEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TkjedJ9ph8sbt44xAKJ1VQ8IhBUz/L8UMCPLr8t6LhlOSFa4zdSNySDG07Bq1suCQ
         Gpf1IvpAIj9YKAXBbWOaVQJjdndwjxyvHHsMiIfce6gavS+o0amo/jXatXMfXIKaXH
         fGsi/DsMI5ho6oma/odIiJo4imo0d34aA+Hmdh18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        William Tu <u9012063@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 04/21] ip6_gre: fix a dst leak in ip6erspan_tunnel_xmit
Date:   Fri, 20 Sep 2019 00:03:05 +0200
Message-Id: <20190919214701.367021508@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214657.842130855@linuxfoundation.org>
References: <20190919214657.842130855@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 28e486037747c2180470b77c290d4090ad42f259 ]

In ip6erspan_tunnel_xmit(), if the skb will not be sent out, it has to
be freed on the tx_err path. Otherwise when deleting a netns, it would
cause dst/dev to leak, and dmesg shows:

  unregister_netdevice: waiting for lo to become free. Usage count = 1

Fixes: ef7baf5e083c ("ip6_gre: add ip6 erspan collect_md mode")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: William Tu <u9012063@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_gre.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -968,7 +968,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit
 		if (unlikely(!tun_info ||
 			     !(tun_info->mode & IP_TUNNEL_INFO_TX) ||
 			     ip_tunnel_info_af(tun_info) != AF_INET6))
-			return -EINVAL;
+			goto tx_err;
 
 		key = &tun_info->key;
 		memset(&fl6, 0, sizeof(fl6));


