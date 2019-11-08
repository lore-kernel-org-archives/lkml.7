Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F20AC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF9E206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240155;
	bh=bFVV/iIHpHr3hvUTYGoxW8Qv37Qz2Fo++BWXnU1I4B4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JClNqQxY0m25lb9zpwTqfBFmwVhp6sv4gH+fbtrEDB/fm6rz7BGk3L1NkwEjCP4oK
	 GPHx/WMpk1Zp3zq62XpHMNzx/DBppRVZYCNc5qJ62IRflyM5DUj3Mpbi4hJNOlu9PV
	 x4lEEhry0+bbhychgwJzHmWZzyIlADPhiJ+TNdL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391759AbfKHTJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:09:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391265AbfKHTJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:09:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE28620673;
        Fri,  8 Nov 2019 19:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573240151;
        bh=bFVV/iIHpHr3hvUTYGoxW8Qv37Qz2Fo++BWXnU1I4B4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uReeluiVI6mJtytiBbi+WcGBr+82VT2hD+23tKVb8IIrXabtnZB2oBZB1yoxhCw7E
         NhSFomFuvKGLqsKfzJzPPUsoHsJ2697mDkRahVuNUrv4jnYyrkRDRHEXM3W3ZkTu/s
         e6NEbG+KVludph1aCmPEkluU349CJqvi8ZNdRxDc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 105/140] net/smc: fix closing of fallback SMC sockets
Date:   Fri,  8 Nov 2019 19:50:33 +0100
Message-Id: <20191108174911.545592682@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ursula Braun <ubraun@linux.ibm.com>

[ Upstream commit f536dffc0b79738c3104af999318279dccbaa261 ]

For SMC sockets forced to fallback to TCP, the file is propagated
from the outer SMC to the internal TCP socket. When closing the SMC
socket, the internal TCP socket file pointer must be restored to the
original NULL value, otherwise memory leaks may show up (found with
CONFIG_DEBUG_KMEMLEAK).

The internal TCP socket is released in smc_clcsock_release(), which
calls __sock_release() function in net/socket.c. This calls the
needed iput(SOCK_INODE(sock)) only, if the file pointer has been reset
to the original NULL-value.

Fixes: 07603b230895 ("net/smc: propagate file from SMC to TCP socket")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/af_smc.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -123,6 +123,12 @@ struct proto smc_proto6 = {
 };
 EXPORT_SYMBOL_GPL(smc_proto6);
 
+static void smc_restore_fallback_changes(struct smc_sock *smc)
+{
+	smc->clcsock->file->private_data = smc->sk.sk_socket;
+	smc->clcsock->file = NULL;
+}
+
 static int __smc_release(struct smc_sock *smc)
 {
 	struct sock *sk = &smc->sk;
@@ -141,6 +147,7 @@ static int __smc_release(struct smc_sock
 		}
 		sk->sk_state = SMC_CLOSED;
 		sk->sk_state_change(sk);
+		smc_restore_fallback_changes(smc);
 	}
 
 	sk->sk_prot->unhash(sk);


