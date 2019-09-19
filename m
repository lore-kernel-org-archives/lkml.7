Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB9CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA16208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932590;
	bh=gD4UllbfZ6AEB9mEPmsWhkhD7I5khRQJyueK5GvjFEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iVUPg4MZpSQanwoYewI3R+IvERVfKDfSSLqVzoiwo6VNS7L9sp6uvkflQa+DHGcht
	 CK99GvPzfNS+IPZjJmS8GFLTit0qNHo710kX86e1cXnf1QSXSP+Tlegoh9G29lZjfK
	 YL6jAEP5SrcFJoIMu1XB7Mcz43Um5UnMMAx26uwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406808AbfISWg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405217AbfISWGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:06:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 380A621924;
        Thu, 19 Sep 2019 22:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568930789;
        bh=gD4UllbfZ6AEB9mEPmsWhkhD7I5khRQJyueK5GvjFEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fgnbDvyQsDJbvUoyFa9l9LwF6GO7eSNSNYsghsrZUOrnXruwM/VBcmbw5JYP1f+yx
         m8JTB2NfQAfO8d2P3++x5ldkLlkLX8d/hiC+kpCzB1VCBHxhpeab50mpIUGjfXspJF
         Y+N6e2sK8voLaWTVod0uzUZg+GysDme7HmkgyPuA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        William Tu <u9012063@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 015/124] ip6_gre: fix a dst leak in ip6erspan_tunnel_xmit
Date:   Fri, 20 Sep 2019 00:01:43 +0200
Message-Id: <20190919214819.683832195@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
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


