Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5977C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAF62082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576522109;
	bh=o3x2+YKwEjeXAK7UbwlJ/GR/Df7W8HFP/A1Hw0pWe6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bBly8vClANEy/x1RLQgH7Z7Rljz2qPu40IthsA9ui5usHw5Hqx2wROFEYtMVeGc6l
	 fQMqdOP0o5ovFvQaEM7j9xScpmupllHXVjMyUougK/ALhGPVrQXK8LEzKjUPue8iBT
	 XI1xw5glkQ+f+SdiZcKzb4/KkotKPX5LT0NV76Sw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfLPSs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:48:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727472AbfLPRyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:54:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C075E20733;
        Mon, 16 Dec 2019 17:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518857;
        bh=o3x2+YKwEjeXAK7UbwlJ/GR/Df7W8HFP/A1Hw0pWe6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n+dhXbwK9nuOPhTxv+PL+JSCliXHGHdmR8g5ZtREVs0fhkMpwX9QY9ym9+1pOKgMb
         gk/oA/8qstoA64W4JFRERfO7dDCBEb7uGJP2BWxwWaEhwyIzFrAtimZJfRw97ZpWry
         hxr0+jmGAW+ePiCuRcEK6vg6mo9dEZTUL/HIqvVo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 094/267] tcp: fix SNMP TCP timeout under-estimation
Date:   Mon, 16 Dec 2019 18:47:00 +0100
Message-Id: <20191216174900.743422112@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuchung Cheng <ycheng@google.com>

[ Upstream commit e1561fe2dd69dc5dddd69bd73aa65355bdfb048b ]

Previously the SNMP TCPTIMEOUTS counter has inconsistent accounting:
1. It counts all SYN and SYN-ACK timeouts
2. It counts timeouts in other states except recurring timeouts and
   timeouts after fast recovery or disorder state.

Such selective accounting makes analysis difficult and complicated. For
example the monitoring system needs to collect many other SNMP counters
to infer the total amount of timeout events. This patch makes TCPTIMEOUTS
counter simply counts all the retransmit timeout (SYN or data or FIN).

Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_timer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 04e2c43a43a5a..65f66bd585e62 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -464,11 +464,12 @@ void tcp_retransmit_timer(struct sock *sk)
 		goto out_reset_timer;
 	}
 
+	__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTIMEOUTS);
 	if (tcp_write_timeout(sk))
 		goto out;
 
 	if (icsk->icsk_retransmits == 0) {
-		int mib_idx;
+		int mib_idx = 0;
 
 		if (icsk->icsk_ca_state == TCP_CA_Recovery) {
 			if (tcp_is_sack(tp))
@@ -483,10 +484,9 @@ void tcp_retransmit_timer(struct sock *sk)
 				mib_idx = LINUX_MIB_TCPSACKFAILURES;
 			else
 				mib_idx = LINUX_MIB_TCPRENOFAILURES;
-		} else {
-			mib_idx = LINUX_MIB_TCPTIMEOUTS;
 		}
-		__NET_INC_STATS(sock_net(sk), mib_idx);
+		if (mib_idx)
+			__NET_INC_STATS(sock_net(sk), mib_idx);
 	}
 
 	tcp_enter_loss(sk);
-- 
2.20.1



