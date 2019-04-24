Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F35C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACF121773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbfDXPcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:32:00 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.171]:29981 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728609AbfDXPcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:32:00 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 1AD248D7C1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 10:31:59 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id JJsNhwjtP90onJJsNh6S0v; Wed, 24 Apr 2019 10:31:59 -0500
X-Authority-Reason: nr=8
Received: from [189.250.127.223] (port=38824 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hJJsM-002brF-0m; Wed, 24 Apr 2019 10:31:58 -0500
Date:   Wed, 24 Apr 2019 10:31:24 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] net: socket: Fix missing break in switch statement
Message-ID: <20190424153124.GA9475@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.127.223
X-Source-L: No
X-Exim-ID: 1hJJsM-002brF-0m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.223]:38824
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing break statement in order to prevent the code from falling
through to cases SIOCGSTAMP_NEW and SIOCGSTAMPNS_NEW.

This bug was found thanks to the ongoing efforts to enable
-Wimplicit-fallthrough.

Fixes: 0768e17073dc ("net: socket: implement 64-bit timestamps")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/socket.c b/net/socket.c
index 8d9d4fc7d962..a180e1a9ff23 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1173,6 +1173,7 @@ static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 			err = sock->ops->gettstamp(sock, argp,
 						   cmd == SIOCGSTAMP_OLD,
 						   !IS_ENABLED(CONFIG_64BIT));
+			break;
 		case SIOCGSTAMP_NEW:
 		case SIOCGSTAMPNS_NEW:
 			if (!sock->ops->gettstamp) {
-- 
2.21.0

