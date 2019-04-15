Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E78EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EF5218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355132;
	bh=gmku6RqsM67ebLOu6DxW0dwT4QGytn6flDHxHcH6T2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e559rUFNyOyLmGEkKY4hfFiVSUyoJ36vbuzeMEc/Aar2M9EWEr3tFFWl7o4iTqFoB
	 nWgXvbDRgsDa14Bc26dhTV/yudgVelqQ2zH/PsJqEbgcEkKMrYDqaL2fLrUToTqYBO
	 ZxY6ctwbiDWfLCX4IWMT+zaKXsLHstgDsqWuF2yE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfDOTFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729716AbfDOTFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:05:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44937218A1;
        Mon, 15 Apr 2019 19:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355124;
        bh=gmku6RqsM67ebLOu6DxW0dwT4QGytn6flDHxHcH6T2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z+oYnQfSNpd8EZqi88PLXVhwQtuynHNp+uDm3HRlpB1AZp5REtdzc/SZ+5qwoyPeb
         to9H4Lze4G9TpNUB9bdGkXAK/e+x5SSoyYFC1GlFEvCV5GzoZWUrvYEDBExMe9oYDy
         N5X6Dk03eJywG8Kg4PMCwgok7POsXNrjwx3VUWec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dust Li <dust.li@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 022/101] tcp: fix a potential NULL pointer dereference in tcp_sk_exit
Date:   Mon, 15 Apr 2019 20:58:20 +0200
Message-Id: <20190415183741.556302042@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b506bc975f60f06e13e74adb35e708a23dc4e87c ]

 When tcp_sk_init() failed in inet_ctl_sock_create(),
 'net->ipv4.tcp_congestion_control' will be left
 uninitialized, but tcp_sk_exit() hasn't check for
 that.

 This patch add checking on 'net->ipv4.tcp_congestion_control'
 in tcp_sk_exit() to prevent NULL-ptr dereference.

Fixes: 6670e1524477 ("tcp: Namespace-ify sysctl_tcp_default_congestion_control")
Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_ipv4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 30fdf891940b..11101cf8693b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2490,7 +2490,8 @@ static void __net_exit tcp_sk_exit(struct net *net)
 {
 	int cpu;
 
-	module_put(net->ipv4.tcp_congestion_control->owner);
+	if (net->ipv4.tcp_congestion_control)
+		module_put(net->ipv4.tcp_congestion_control->owner);
 
 	for_each_possible_cpu(cpu)
 		inet_ctl_sock_destroy(*per_cpu_ptr(net->ipv4.tcp_sk, cpu));
-- 
2.19.1



