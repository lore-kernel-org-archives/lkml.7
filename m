Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18968C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000A42133F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbfJBTKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:10:17 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35944 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729334AbfJBTIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:08:17 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1iFjyx-00035t-RV; Wed, 02 Oct 2019 20:08:15 +0100
Received: from ben by deadeye with local (Exim 4.92.1)
        (envelope-from <ben@decadent.org.uk>)
        id 1iFjyp-0003fZ-OB; Wed, 02 Oct 2019 20:08:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Hendrik Brueckner" <brueckner@linux.ibm.com>,
        "Ursula Braun" <ubraun@linux.ibm.com>,
        "Julian Wiedmann" <jwi@linux.ibm.com>
Date:   Wed, 02 Oct 2019 20:06:51 +0100
Message-ID: <lsq.1570043211.678252578@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 71/87] net/af_iucv: remove GFP_DMA restriction for
 HiperTransport
In-Reply-To: <lsq.1570043210.379046399@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.75-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.ibm.com>

commit fdbf6326912d578a31ac4ca0933c919eadf1d54c upstream.

af_iucv sockets over z/VM IUCV require that their skbs are allocated
in DMA memory. This restriction doesn't apply to connections over
HiperSockets. So only set this limit for z/VM IUCV sockets, thereby
increasing the likelihood that the large (and linear!) allocations for
HiperTransport messages succeed.

Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/iucv/af_iucv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -568,7 +568,6 @@ static struct sock *iucv_sock_alloc(stru
 
 	sk->sk_destruct = iucv_sock_destruct;
 	sk->sk_sndtimeo = IUCV_CONN_TIMEOUT;
-	sk->sk_allocation = GFP_DMA;
 
 	sock_reset_flag(sk, SOCK_ZAPPED);
 
@@ -762,6 +761,7 @@ vm_bind:
 		memcpy(iucv->src_user_id, iucv_userid, 8);
 		sk->sk_state = IUCV_BOUND;
 		iucv->transport = AF_IUCV_TRANS_IUCV;
+		sk->sk_allocation |= GFP_DMA;
 		if (!iucv->msglimit)
 			iucv->msglimit = IUCV_QUEUELEN_DEFAULT;
 		goto done_unlock;
@@ -786,6 +786,8 @@ static int iucv_sock_autobind(struct soc
 		return -EPROTO;
 
 	memcpy(iucv->src_user_id, iucv_userid, 8);
+	iucv->transport = AF_IUCV_TRANS_IUCV;
+	sk->sk_allocation |= GFP_DMA;
 
 	write_lock_bh(&iucv_sk_list.lock);
 	__iucv_auto_name(iucv);
@@ -1737,6 +1739,8 @@ static int iucv_callback_connreq(struct
 
 	niucv = iucv_sk(nsk);
 	iucv_sock_init(nsk, sk);
+	niucv->transport = AF_IUCV_TRANS_IUCV;
+	nsk->sk_allocation |= GFP_DMA;
 
 	/* Set the new iucv_sock */
 	memcpy(niucv->dst_name, ipuser + 8, 8);

