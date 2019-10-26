Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016FFCA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFF5206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096038;
	bh=XieehLMI9ijgk/aQ2IMhJQtqYpIgGUTBAsCbAggIvp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dPwLq1mhgs2/lwR/Q7OaIlQcLPxkGJ9y+QnthTW5/hy+teT7Fmebn+nGa46o+EbP7
	 BxSUIlK8Xw7ByJZuXuIMjZKA0IMO8aOQlWMmmVJszZidhP/L6oQeajvP0DBJbUH9kl
	 qQoGaoNhRAmbDBjbOQr0yfWq2GjPM/vAg9VKUFEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfJZNUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728580AbfJZNUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:20:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EF6B21E6F;
        Sat, 26 Oct 2019 13:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572096023;
        bh=XieehLMI9ijgk/aQ2IMhJQtqYpIgGUTBAsCbAggIvp0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MuweaUD9HrA+FWo0bkxy8aRM8P03XqXXoXV6r6ZXwjJyDdiYfWZaUy8dd8ii1h97k
         zwFVo9XYaN3l1a14gqe3r44mXktLTukD3zQ7yHR+tjLBjv6ivxKbwl88vCVnwO6eIV
         JTP2vkadUnVNipYcW0yqE+h9GgnCb0laAoo4oNjA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Karsten Graul <kgraul@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 36/59] net/smc: receive returns without data
Date:   Sat, 26 Oct 2019 09:18:47 -0400
Message-Id: <20191026131910.3435-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131910.3435-1-sashal@kernel.org>
References: <20191026131910.3435-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Karsten Graul <kgraul@linux.ibm.com>

[ Upstream commit 882dcfe5a1785c20f45820cbe6fec4b8b647c946 ]

smc_cdc_rxed_any_close_or_senddone() is used as an end condition for the
receive loop. This conflicts with smc_cdc_msg_recv_action() which could
run in parallel and set the bits checked by
smc_cdc_rxed_any_close_or_senddone() before the receive is processed.
In that case we could return from receive with no data, although data is
available. The same applies to smc_rx_wait().
Fix this by checking for RCV_SHUTDOWN only, which is set in
smc_cdc_msg_recv_action() after the receive was actually processed.

Fixes: 952310ccf2d8 ("smc: receive data from RMBE")
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_rx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
index bbcf0fe4ae10f..1ee5fdbf8284e 100644
--- a/net/smc/smc_rx.c
+++ b/net/smc/smc_rx.c
@@ -212,8 +212,7 @@ int smc_rx_wait(struct smc_sock *smc, long *timeo,
 	rc = sk_wait_event(sk, timeo,
 			   sk->sk_err ||
 			   sk->sk_shutdown & RCV_SHUTDOWN ||
-			   fcrit(conn) ||
-			   smc_cdc_rxed_any_close_or_senddone(conn),
+			   fcrit(conn),
 			   &wait);
 	remove_wait_queue(sk_sleep(sk), &wait);
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
@@ -311,7 +310,6 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msghdr *msg,
 			smc_rx_update_cons(smc, 0);
 
 		if (sk->sk_shutdown & RCV_SHUTDOWN ||
-		    smc_cdc_rxed_any_close_or_senddone(conn) ||
 		    conn->local_tx_ctrl.conn_state_flags.peer_conn_abort)
 			break;
 
-- 
2.20.1

