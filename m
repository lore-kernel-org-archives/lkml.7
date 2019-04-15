Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5181C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660CF20643
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355995;
	bh=sMahWOwmUFF9acIl8i18xYNKXfJ8R5+rBXa+ycUy6JY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SeFliNXzrDQ8oYWjP0qArYSt2ZVy8eGGeRAqyGBNH1iv+e6HSx76MH/EwTwwH7jfn
	 J7lJUw7jdmoqO4Uu5/LOa2FJcNf64WHqX/K6zQHwR5AHPy9EnS3OEah3MRgdeLwKaF
	 jrMXAUYAGcTfDsPTYFJmvB8bGN+daCnJRuZhODIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbfDOTTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728091AbfDOTKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:10:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 456A620651;
        Mon, 15 Apr 2019 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355408;
        bh=sMahWOwmUFF9acIl8i18xYNKXfJ8R5+rBXa+ycUy6JY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dpMZtfZ5kANGyAxlOg8AuIP6SHt2uiY+tzriH/4N892l0pWQkn2RtAcTIFO8gZiyo
         yAHIHEoWHh6a1mtbxuKM9gwSpi0+4dxjKL2ufjynhQVQeYDHMZqOiU6QsuWU1UpQU9
         9T7c/u2B4+L69qdjLV0wWyd8S12E/OxCxD1C10P8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dust Li <dust.li@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 024/117] tcp: fix a potential NULL pointer dereference in tcp_sk_exit
Date:   Mon, 15 Apr 2019 20:59:54 +0200
Message-Id: <20190415183746.121651049@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
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
index 1aae9ab57fe9..00852f47a73d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2578,7 +2578,8 @@ static void __net_exit tcp_sk_exit(struct net *net)
 {
 	int cpu;
 
-	module_put(net->ipv4.tcp_congestion_control->owner);
+	if (net->ipv4.tcp_congestion_control)
+		module_put(net->ipv4.tcp_congestion_control->owner);
 
 	for_each_possible_cpu(cpu)
 		inet_ctl_sock_destroy(*per_cpu_ptr(net->ipv4.tcp_sk, cpu));
-- 
2.19.1



