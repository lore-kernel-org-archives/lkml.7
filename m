Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C6EC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C9E218AE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919611;
	bh=6Kd/tfrrNhSL81XqFWKVL0xFPS9h+4dt6mIGsLvIxQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b4YiShwpG/Sep5/c33eaN9Gw8Fwx+ObpgpC6l1xLBWDsWp9JhYlCg0Zwyeu9it7Uz
	 kuBGrPDPNLo67tqWr2w9k1UmiQbR//bIJNWKz7ochFi4ZWs/B9SRFmc+uwv/Vtfd8y
	 82yoPw5GJQGCNRIjPdaUYnm8UIrQzJIpPDD+Z+dY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbfKPPx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:53:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731230AbfKPPx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:53:26 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20DCC2186D;
        Sat, 16 Nov 2019 15:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919605;
        bh=6Kd/tfrrNhSL81XqFWKVL0xFPS9h+4dt6mIGsLvIxQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WpogaeNoEuPxSsx3g8WxhygJ3MLkqF7rGGRY19XgOxJPWv7pskGZleGjobj+bbJ27
         EgLoaKIEg2xWe3Vn79xSB8i6luMtd03UARYU5Ko/IpiuKZzhl2wb9sNx5aGI3dghEr
         eD8ZeQAzgHl20k45dmTwS2wmyaqVpGgb6s44SrLs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Barmann <david.barmann@stackpath.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 92/99] sock: Reset dst when changing sk_mark via setsockopt
Date:   Sat, 16 Nov 2019 10:50:55 -0500
Message-Id: <20191116155103.10971-92-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155103.10971-1-sashal@kernel.org>
References: <20191116155103.10971-1-sashal@kernel.org>
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
index d224933514074..9178c16543758 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -945,10 +945,12 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
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

