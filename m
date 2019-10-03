Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE0DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A19421848
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570118615;
	bh=mmWPrIMQY5HC+KXwMDe+KB/L7jXsFlmhH41jsezBSxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KRZXOogw/Ivsb4ILzhLXj0986PA3u6cKDJvzLtCpBRq2GsR2fIg7Ietpo2r8nuPxj
	 giEccBHFpW2ycarXaWtr7x9Cln5yzvU13K7dTVRdlc3+jUCLlnFw08dqif5AgEgvMQ
	 EkfuCnN4Ro5ha+0zgBMw4LCBishBVT+dSyirUj9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbfJCQDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730903AbfJCQDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:03:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE2A621A4C;
        Thu,  3 Oct 2019 16:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118609;
        bh=mmWPrIMQY5HC+KXwMDe+KB/L7jXsFlmhH41jsezBSxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dGRCs/cSxVqk2pXEnJX0CoGlN4zMeq9syhD8PrLVPV1pFK/Bgm+0WK1RwcgmbTGMf
         3/UOVW3wMwVtLVJYKySrWdaUXaY9ZYVvelqelRiFhTz/ENQu0g7uq4TcOKGO081/4y
         9M/0jfpMpVq9bUomPJkO91Ul7rZ1TS1uQkbaySZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ori Nimron <orinimron123@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 037/129] ieee802154: enforce CAP_NET_RAW for raw sockets
Date:   Thu,  3 Oct 2019 17:52:40 +0200
Message-Id: <20191003154335.063208007@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154318.081116689@linuxfoundation.org>
References: <20191003154318.081116689@linuxfoundation.org>
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
@@ -1003,6 +1003,9 @@ static int ieee802154_create(struct net
 
 	switch (sock->type) {
 	case SOCK_RAW:
+		rc = -EPERM;
+		if (!capable(CAP_NET_RAW))
+			goto out;
 		proto = &ieee802154_raw_prot;
 		ops = &ieee802154_raw_ops;
 		break;


