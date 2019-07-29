Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9629C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8179C20657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564431066;
	bh=12MB2UsBIr1bw8DUZkqPqk0bQzWqiWONwTykxzZqE1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ulPbeGhUynDeVt4SzBD1bo1IGOpxlYaSyEXQRrIgQ+4Jk3F1HaD9aQ5kUToWoIu2c
	 ft58zSbQFKaPbXc9XBVH56nM5A2AC2GPku3a18CRzM5wpXrH38o6n7wiXa6Tp3cAMC
	 KP9gdcdPH6ZKiyl0OyI7ub3p/JJmTvv0VssHuxvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfG2ULF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387868AbfG2Tdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:33:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 392A521773;
        Mon, 29 Jul 2019 19:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428831;
        bh=12MB2UsBIr1bw8DUZkqPqk0bQzWqiWONwTykxzZqE1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=unbBEz3lJakNUoWDw7g//8/bsmZtU9G4WO73AEIuD0vSKtG7Y8GgjAIg69Um/pKA/
         PKmZT+groHnaDteYJt3vqektfWO3f4C7CyiDBaHjhU4bWSabLS+recFgyNv5N1VxoI
         5Dh+xU5qPKIwWZxZAA1O4r1Ms/SvSN1o2r2PA/bU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Christoph Paasch <cpaasch@apple.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 201/293] tcp: Reset bytes_acked and bytes_received when disconnecting
Date:   Mon, 29 Jul 2019 21:21:32 +0200
Message-Id: <20190729190839.889480843@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Paasch <cpaasch@apple.com>

[ Upstream commit e858faf556d4e14c750ba1e8852783c6f9520a0e ]

If an app is playing tricks to reuse a socket via tcp_disconnect(),
bytes_acked/received needs to be reset to 0. Otherwise tcp_info will
report the sum of the current and the old connection..

Cc: Eric Dumazet <edumazet@google.com>
Fixes: 0df48c26d841 ("tcp: add tcpi_bytes_acked to tcp_info")
Fixes: bdd1f9edacb5 ("tcp: add tcpi_bytes_received to tcp_info")
Signed-off-by: Christoph Paasch <cpaasch@apple.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2366,6 +2366,8 @@ int tcp_disconnect(struct sock *sk, int
 	dst_release(sk->sk_rx_dst);
 	sk->sk_rx_dst = NULL;
 	tcp_saved_syn_free(tp);
+	tp->bytes_acked = 0;
+	tp->bytes_received = 0;
 
 	/* Clean up fastopen related fields */
 	tcp_free_fastopen_req(tp);


