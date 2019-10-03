Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E51C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6658721A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119929;
	bh=egfPkjQleP3+sm+wRrMFBlYgRWbRB8K/Z1RhaImosww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XK5jN2QhMF/g/nelFz4tCVTJILIl1DiaDP9kDwIaBfPbtvfuN2P5datwHRMqj38zm
	 f1u96K8aDS4BSrkaOI8hxsSv1q9UnDRQjmUr1ZOVf53Pal2Jk2oUJtgZDKBhT6RPIT
	 T9h0wklpw6SqHj4iEQzEPMiUHBDJtC32Elfxx/hI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390911AbfJCQZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390472AbfJCQZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:25:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6331620867;
        Thu,  3 Oct 2019 16:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119925;
        bh=egfPkjQleP3+sm+wRrMFBlYgRWbRB8K/Z1RhaImosww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PKLUqmNGrpDzSknhSz2CKMd61wP8ULLG+qmyEk9aJlAv6ftZJ0TmisPq3r3T5vECZ
         tmGYNAV9PH5M57mY3bkeW4MBVMiJBt7FfrwM3TjVlbONPwSLoRQYcoZBsiADm3t8WF
         d3QYeF9Ono1jhKMIrYIV3E/c4PIYYgcAq+nh+p4Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ori Nimron <orinimron123@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 031/313] ieee802154: enforce CAP_NET_RAW for raw sockets
Date:   Thu,  3 Oct 2019 17:50:09 +0200
Message-Id: <20191003154536.377514147@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
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
@@ -1008,6 +1008,9 @@ static int ieee802154_create(struct net
 
 	switch (sock->type) {
 	case SOCK_RAW:
+		rc = -EPERM;
+		if (!capable(CAP_NET_RAW))
+			goto out;
 		proto = &ieee802154_raw_prot;
 		ops = &ieee802154_raw_ops;
 		break;


