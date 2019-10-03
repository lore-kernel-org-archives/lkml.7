Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAFFC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D4020865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119327;
	bh=3D7JlMLXuSw8WycHbvY81UgjIJZwL4MmJMz3WIxlpkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WYLepeaO+tZiSqh+igoMn9SYex96dyvD1FkLtnRv2koha5ZCoyQWvwZ1HTNOEHh9v
	 Fp8/MtJQ3nQkXWV3AKTuQp8cmOI/FSR7UXbbxJeSKHp2lcYG1+g7VXF9KpN2V3P6kK
	 8GWYsH/vV5toRukCayldK5ZQheYJDy1BjCtFfB10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388255AbfJCQP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387847AbfJCQPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:15:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03956215EA;
        Thu,  3 Oct 2019 16:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119322;
        bh=3D7JlMLXuSw8WycHbvY81UgjIJZwL4MmJMz3WIxlpkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E7mzv9ygmQaAIITIbkOXsuKnWyaQ80kPRZnUmm3TcwFZdHwQSrILQ/ZZhWXVq4a7c
         v2gb7JVhEps04E8/wkWBPMg8urKcvEQZRDAJph1sXDR9+5s2ARAL0k7EDOhPRv5tWY
         vr88JHsfBExCTis9oTKLtlFd6+YI0iT+R7un/ucE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ori Nimron <orinimron123@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 022/211] nfc: enforce CAP_NET_RAW for raw sockets
Date:   Thu,  3 Oct 2019 17:51:28 +0200
Message-Id: <20191003154452.134676115@linuxfoundation.org>
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

[ Upstream commit 3a359798b176183ef09efb7a3dc59abad1cc7104 ]

When creating a raw AF_NFC socket, CAP_NET_RAW needs to be checked
first.

Signed-off-by: Ori Nimron <orinimron123@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/nfc/llcp_sock.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -1011,10 +1011,13 @@ static int llcp_sock_create(struct net *
 	    sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
 
-	if (sock->type == SOCK_RAW)
+	if (sock->type == SOCK_RAW) {
+		if (!capable(CAP_NET_RAW))
+			return -EPERM;
 		sock->ops = &llcp_rawsock_ops;
-	else
+	} else {
 		sock->ops = &llcp_sock_ops;
+	}
 
 	sk = nfc_llcp_sock_alloc(sock, sock->type, GFP_ATOMIC, kern);
 	if (sk == NULL)


