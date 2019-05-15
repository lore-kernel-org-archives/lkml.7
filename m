Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9364C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEFA20843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919507;
	bh=GlqbzxP1iKRD9SbG11QnA4E7zsVZc8ZExrGnkid4cR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QF48Znrr3pkQquHquUa6ccRPAFowXtAhf9KCiHyYoeZIXORX9vH6QFpEDYFqFpOug
	 RIrFp0pUqIzGdQIoPmst+eu8lf9Q7PMsuESUFkMBGCx7h52RJoMFL9nTElCGrdmL9O
	 Y5KAuC6MjEkMI6fH3Tq1gICkIIv2/rIUK3dvQRbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbfEOLZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729575AbfEOLZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:25:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B76B820818;
        Wed, 15 May 2019 11:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919504;
        bh=GlqbzxP1iKRD9SbG11QnA4E7zsVZc8ZExrGnkid4cR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gI3RTzhTIULFBRkfNRCx6Qa/E1UfvJ857CS1eAatPKbf/yzy0BGedHI69H19gNB+o
         lKVpM2EsumyBL4093dxFXdAk+Q43lRU9cZWuw0pGEOiGeUHutZ5Ne2TWR6U/UqMMlI
         XLwynICkKcUag0BnqGaz4n3Vhuw+nk8gFcZOdVFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Suryaputra <ssuryaextr@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 101/113] vrf: sit mtu should not be updated when vrf netdev is the link
Date:   Wed, 15 May 2019 12:56:32 +0200
Message-Id: <20190515090701.290309582@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090652.640988966@linuxfoundation.org>
References: <20190515090652.640988966@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Suryaputra <ssuryaextr@gmail.com>

[ Upstream commit ff6ab32bd4e073976e4d8797b4d514a172cfe6cb ]

VRF netdev mtu isn't typically set and have an mtu of 65536. When the
link of a tunnel is set, the tunnel mtu is changed from 1480 to the link
mtu minus tunnel header. In the case of VRF netdev is the link, then the
tunnel mtu becomes 65516. So, fix it by not setting the tunnel mtu in
this case.

Signed-off-by: Stephen Suryaputra <ssuryaextr@gmail.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/sit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1084,7 +1084,7 @@ static void ipip6_tunnel_bind_dev(struct
 	if (!tdev && tunnel->parms.link)
 		tdev = __dev_get_by_index(tunnel->net, tunnel->parms.link);
 
-	if (tdev) {
+	if (tdev && !netif_is_l3_master(tdev)) {
 		int t_hlen = tunnel->hlen + sizeof(struct iphdr);
 
 		dev->hard_header_len = tdev->hard_header_len + sizeof(struct iphdr);


