Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6066C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BB52184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291730;
	bh=JlsdFF+rTujpTeteY5qHKbbkRpYmIm/m2uadIpqBI/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ViJjE7hv+k0/nevZsHMx8Nawx9UuyKUxLb45ItNFs0/1tFfvt3MU8qbGXGYXqF0Iu
	 DcpF9JQGaL3V2rGF16QrnFhZG2uJrBXWCGQ68hVXr8UiEVwuWyG3VDq6bcUe1tElpT
	 eF4Q9XsvNVuLKQ8JiF5xqjZdtBXmZbRMkE5v9o7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405302AbfHHTP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404572AbfHHTHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:07:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD6DE21880;
        Thu,  8 Aug 2019 19:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291223;
        bh=JlsdFF+rTujpTeteY5qHKbbkRpYmIm/m2uadIpqBI/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NgxZfih4qHCYaHs078gMGMdBe1SB1vhFYEWeYKaE6NjwBnxlCoK+x9o/5meqQqy96
         m2fxBiPvyw2DZZ8twixmhn07Q/SQ6EC0TenzSS8Qp1JhiZEtq4WAwplfd64dPdh/kh
         v27yOKE+5JzIcjI7hHt86yUDHbeZRFJ1XP9CLQbE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+92209502e7aab127c75f@syzkaller.appspotmail.com,
        syzbot+b972214bb803a343f4fe@syzkaller.appspotmail.com,
        Ursula Braun <ubraun@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 32/56] net/smc: do not schedule tx_work in SMC_CLOSED state
Date:   Thu,  8 Aug 2019 21:04:58 +0200
Message-Id: <20190808190454.250528963@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190452.867062037@linuxfoundation.org>
References: <20190808190452.867062037@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun <ubraun@linux.ibm.com>

[ Upstream commit f9cedf1a9b1cdcfb0c52edb391d01771e43994a4 ]

The setsockopts options TCP_NODELAY and TCP_CORK may schedule the
tx worker. Make sure the socket is not yet moved into SMC_CLOSED
state (for instance by a shutdown SHUT_RDWR call).

Reported-by: syzbot+92209502e7aab127c75f@syzkaller.appspotmail.com
Reported-by: syzbot+b972214bb803a343f4fe@syzkaller.appspotmail.com
Fixes: 01d2f7e2cdd31 ("net/smc: sockopts TCP_NODELAY and TCP_CORK")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/af_smc.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1741,14 +1741,18 @@ static int smc_setsockopt(struct socket
 		}
 		break;
 	case TCP_NODELAY:
-		if (sk->sk_state != SMC_INIT && sk->sk_state != SMC_LISTEN) {
+		if (sk->sk_state != SMC_INIT &&
+		    sk->sk_state != SMC_LISTEN &&
+		    sk->sk_state != SMC_CLOSED) {
 			if (val && !smc->use_fallback)
 				mod_delayed_work(system_wq, &smc->conn.tx_work,
 						 0);
 		}
 		break;
 	case TCP_CORK:
-		if (sk->sk_state != SMC_INIT && sk->sk_state != SMC_LISTEN) {
+		if (sk->sk_state != SMC_INIT &&
+		    sk->sk_state != SMC_LISTEN &&
+		    sk->sk_state != SMC_CLOSED) {
 			if (!val && !smc->use_fallback)
 				mod_delayed_work(system_wq, &smc->conn.tx_work,
 						 0);


