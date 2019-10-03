Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C2CC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF78420700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119323;
	bh=5E7e2HVF4nFAfnMAASpJMM+BCKfYI87ZtTiS03Yvpd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uuvJAJBsJJNr6D5ZfBgmitwlWApNM3zhM4BtvQvxb6klWcTkam0uz5KGgkAWlV/64
	 pmuUf/30ERZe7B5dFtBvTQ4NzJmJY3HPUFwSr0kxEyU/fL0Smmy5fqRhCkevZQhVZc
	 jhrK3lpO1PRM1wmzEDC99qbmBney0FeQmNRYtxg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733141AbfJCQPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732149AbfJCQPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:15:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5158A20700;
        Thu,  3 Oct 2019 16:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119319;
        bh=5E7e2HVF4nFAfnMAASpJMM+BCKfYI87ZtTiS03Yvpd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zca8ZirMMJFoo9nRskSmMVmHJWocErZW0Tqe9+6H84zWXhsSyh6Unh7Kb77kR8Q3l
         Aui5FcBUfa1eXfpz2iMraVaKqvIT+dcq0IcDZt+P0UUbuxNP69hu5Wz7EuE63vgczq
         p0duKpZGF/V32nKZIepy2UAShO7HU1SgsH7uCnJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ori Nimron <orinimron123@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 021/211] ieee802154: enforce CAP_NET_RAW for raw sockets
Date:   Thu,  3 Oct 2019 17:51:27 +0200
Message-Id: <20191003154452.025649940@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ori Nimron <orinimron123@gmail.com>

[ Upstream commit e69dbd4619e7674c1679cba49afd9dd9ac347eef ]

When creating a raw AF_IEEE802154 socket, CAP_NET_RAW needs to be
checked first.

Signed-off-by: Ori Nimron <orinimron123@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ieee802154/socket.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -1018,6 +1018,9 @@ static int ieee802154_create(struct net
 
 	switch (sock->type) {
 	case SOCK_RAW:
+		rc = -EPERM;
+		if (!capable(CAP_NET_RAW))
+			goto out;
 		proto = &ieee802154_raw_prot;
 		ops = &ieee802154_raw_ops;
 		break;


