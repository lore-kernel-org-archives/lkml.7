Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B34C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE5120665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600378;
	bh=Q8vouGM5vsmu2Gk6qMx0tbjHgKc3tJmIJHR34gP7v/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hjxv7v8fzfP+wTS0XjE7snAk7ksGRjmeJQNnJ8ZYlBZiGgpMhe/iO0XhkqRNNUKT9
	 PqsYd7uq3nxPixtMooIDY55e9Ze2l63Q2Vv3PtqGzvsdBSK/egQ1TcZ/zonFOfFMWY
	 N91SQkEFQyj4x2sicmnsNOtGpvN+v4OHoeS3EbNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389468AbfGHP3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389437AbfGHP3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:29:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5344220645;
        Mon,  8 Jul 2019 15:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599749;
        bh=Q8vouGM5vsmu2Gk6qMx0tbjHgKc3tJmIJHR34gP7v/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yz1Y1KP9aTzKBKtiQ+pfj3vVV98MvJz7LT4cI05yq6f47eOQ0AJrryCfpp4t4H8FF
         lgieLd1P43AeQa+faRn15//n0S6/SEBhyifLw/5iwi0d95zUntqAQT/Awtkew+Y8ZE
         vA0h+yziCyq2+jsIYfCZrHFWj6Qh0/BtROchBY7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 65/90] net/smc: move unhash before release of clcsock
Date:   Mon,  8 Jul 2019 17:13:32 +0200
Message-Id: <20190708150525.660982245@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150521.829733162@linuxfoundation.org>
References: <20190708150521.829733162@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f61bca58f6c36e666c2b807697f25e5e98708162 ]

Commit <26d92e951fe0>
("net/smc: move unhash as early as possible in smc_release()")
fixes one occurrence in the smc code, but the same pattern exists
in other places. This patch covers the remaining occurrences and
makes sure, the unhash operation is done before the smc->clcsock is
released. This avoids a potential use-after-free in smc_diag_dump().

Reviewed-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/af_smc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index e6e506b2db99..9bbab6ba2dab 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -848,11 +848,11 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 	if  (rc < 0)
 		lsk->sk_err = -rc;
 	if (rc < 0 || lsk->sk_state == SMC_CLOSED) {
+		new_sk->sk_prot->unhash(new_sk);
 		if (new_clcsock)
 			sock_release(new_clcsock);
 		new_sk->sk_state = SMC_CLOSED;
 		sock_set_flag(new_sk, SOCK_DEAD);
-		new_sk->sk_prot->unhash(new_sk);
 		sock_put(new_sk); /* final */
 		*new_smc = NULL;
 		goto out;
@@ -903,11 +903,11 @@ struct sock *smc_accept_dequeue(struct sock *parent,
 
 		smc_accept_unlink(new_sk);
 		if (new_sk->sk_state == SMC_CLOSED) {
+			new_sk->sk_prot->unhash(new_sk);
 			if (isk->clcsock) {
 				sock_release(isk->clcsock);
 				isk->clcsock = NULL;
 			}
-			new_sk->sk_prot->unhash(new_sk);
 			sock_put(new_sk); /* final */
 			continue;
 		}
@@ -932,6 +932,7 @@ void smc_close_non_accepted(struct sock *sk)
 		sock_set_flag(sk, SOCK_DEAD);
 		sk->sk_shutdown |= SHUTDOWN_MASK;
 	}
+	sk->sk_prot->unhash(sk);
 	if (smc->clcsock) {
 		struct socket *tcp;
 
@@ -947,7 +948,6 @@ void smc_close_non_accepted(struct sock *sk)
 			smc_conn_free(&smc->conn);
 	}
 	release_sock(sk);
-	sk->sk_prot->unhash(sk);
 	sock_put(sk); /* final sock_put */
 }
 
-- 
2.20.1



