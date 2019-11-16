Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A17C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252D121479
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920899;
	bh=Z8WLsowTzZsW31wmmoVRggCv92659igdD967f0ESUVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GjfLJK7Hu1KiKChq5NpY5x6PvSKCv3zZnpx88NpS29RtWnX04PHjjQbOTAsb5d5Hq
	 tbPG3uMUd4VwaWEFjyjiSfR8WPHNu1tiz45+5cUY+rusy/MFjAytsBTSY4tZclXL4/
	 Wjpyc23Hh4Fgr/bzqnEG3R5WYXEFmq+Uk8tHVQh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbfKPPrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:47:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:53618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728955AbfKPPq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:46:57 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 038872089D;
        Sat, 16 Nov 2019 15:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919217;
        bh=Z8WLsowTzZsW31wmmoVRggCv92659igdD967f0ESUVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWIyHEquPUXFgYDcoVSyE28wOmC8nNbTrqYA0TwYMzYjBylw9Fyh/Ncu+d/Z5gOdC
         bCHENy52frZTcZzWAL/ccvmcN6+Df33dzZi7GNczsHAwewi3MN6wV+e134q7Oz+PAc
         ygsXKfzUf4XB2Zb2p56D7pISpJB9DGLpx0z3tjwA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Barmann <david.barmann@stackpath.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 222/237] sock: Reset dst when changing sk_mark via setsockopt
Date:   Sat, 16 Nov 2019 10:40:57 -0500
Message-Id: <20191116154113.7417-222-sashal@kernel.org>
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

From: David Barmann <david.barmann@stackpath.com>

[ Upstream commit 50254256f382c56bde87d970f3d0d02fdb76ec70 ]

When setting the SO_MARK socket option, if the mark changes, the dst
needs to be reset so that a new route lookup is performed.

This fixes the case where an application wants to change routing by
setting a new sk_mark.  If this is done after some packets have already
been sent, the dst is cached and has no effect.

Signed-off-by: David Barmann <david.barmann@stackpath.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index ba4f843cdd1d1..948fd687292a6 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -951,10 +951,12 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 			clear_bit(SOCK_PASSSEC, &sock->flags);
 		break;
 	case SO_MARK:
-		if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
+		if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
 			ret = -EPERM;
-		else
+		} else if (val != sk->sk_mark) {
 			sk->sk_mark = val;
+			sk_dst_reset(sk);
+		}
 		break;
 
 	case SO_RXQ_OVFL:
-- 
2.20.1

