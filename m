Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8235DC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572552075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505054;
	bh=Bq6F9tt2o6us38xY/YIAhG3s4ovIBMWYDP4SFSXPKe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VSRtJ8TGg77x/23nuRsEFkCw8tIgl7K2WSWPvZEClm6LoTQUE/CeX/hzh/So876Ij
	 KYWkNJQem8uiqOPp2xNfGclLuIYCP+ijtJ8zH03aUxjyk6k8XaX/hur55MxNYKc9PH
	 s7bG8eAgbEQ6dcnUE3B9s2wZdG10fTxC0voHqkew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfCMTQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:16:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728680AbfCMTQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:16:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35FA3213A2;
        Wed, 13 Mar 2019 19:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504590;
        bh=Bq6F9tt2o6us38xY/YIAhG3s4ovIBMWYDP4SFSXPKe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6JyJ9Jp36zECRaY0QU7gm2WG6/k45TW2LLvOtkbJGKpAyk3Ha93WzURnADZwTuWe
         KihAPp0vYj/sZVaUdEPNERStYXPkteoaUkhN/ZZU94kGkWiojxYnfrayDSiROqx9kW
         hBN6yknNxDhzI0Uc7G447uIqwPG7p6sEpdUSgjOo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 27/33] phonet: fix building with clang
Date:   Wed, 13 Mar 2019 15:15:00 -0400
Message-Id: <20190313191506.159677-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191506.159677-1-sashal@kernel.org>
References: <20190313191506.159677-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 6321aa197547da397753757bd84c6ce64b3e3d89 ]

clang warns about overflowing the data[] member in the struct pnpipehdr:

net/phonet/pep.c:295:8: warning: array index 4 is past the end of the array (which contains 1 element) [-Warray-bounds]
                        if (hdr->data[4] == PEP_IND_READY)
                            ^         ~
include/net/phonet/pep.h:66:3: note: array 'data' declared here
                u8              data[1];

Using a flexible array member at the end of the struct avoids the
warning, but since we cannot have a flexible array member inside
of the union, each index now has to be moved back by one, which
makes it a little uglier.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Rémi Denis-Courmont <remi@remlab.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/phonet/pep.h |  5 +++--
 net/phonet/pep.c         | 32 ++++++++++++++++----------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/net/phonet/pep.h b/include/net/phonet/pep.h
index b669fe6dbc3b..98f31c7ea23d 100644
--- a/include/net/phonet/pep.h
+++ b/include/net/phonet/pep.h
@@ -63,10 +63,11 @@ struct pnpipehdr {
 		u8		state_after_reset;	/* reset request */
 		u8		error_code;		/* any response */
 		u8		pep_type;		/* status indication */
-		u8		data[1];
+		u8		data0;			/* anything else */
 	};
+	u8			data[];
 };
-#define other_pep_type		data[1]
+#define other_pep_type		data[0]
 
 static inline struct pnpipehdr *pnp_hdr(struct sk_buff *skb)
 {
diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index e81537991ddf..bffcef58ebf5 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -132,7 +132,7 @@ static int pep_indicate(struct sock *sk, u8 id, u8 code,
 	ph->utid = 0;
 	ph->message_id = id;
 	ph->pipe_handle = pn->pipe_handle;
-	ph->data[0] = code;
+	ph->error_code = code;
 	return pn_skb_send(sk, skb, NULL);
 }
 
@@ -153,7 +153,7 @@ static int pipe_handler_request(struct sock *sk, u8 id, u8 code,
 	ph->utid = id; /* whatever */
 	ph->message_id = id;
 	ph->pipe_handle = pn->pipe_handle;
-	ph->data[0] = code;
+	ph->error_code = code;
 	return pn_skb_send(sk, skb, NULL);
 }
 
@@ -208,7 +208,7 @@ static int pep_ctrlreq_error(struct sock *sk, struct sk_buff *oskb, u8 code,
 	struct pnpipehdr *ph;
 	struct sockaddr_pn dst;
 	u8 data[4] = {
-		oph->data[0], /* PEP type */
+		oph->pep_type, /* PEP type */
 		code, /* error code, at an unusual offset */
 		PAD, PAD,
 	};
@@ -221,7 +221,7 @@ static int pep_ctrlreq_error(struct sock *sk, struct sk_buff *oskb, u8 code,
 	ph->utid = oph->utid;
 	ph->message_id = PNS_PEP_CTRL_RESP;
 	ph->pipe_handle = oph->pipe_handle;
-	ph->data[0] = oph->data[1]; /* CTRL id */
+	ph->data0 = oph->data[0]; /* CTRL id */
 
 	pn_skb_get_src_sockaddr(oskb, &dst);
 	return pn_skb_send(sk, skb, &dst);
@@ -272,17 +272,17 @@ static int pipe_rcv_status(struct sock *sk, struct sk_buff *skb)
 		return -EINVAL;
 
 	hdr = pnp_hdr(skb);
-	if (hdr->data[0] != PN_PEP_TYPE_COMMON) {
+	if (hdr->pep_type != PN_PEP_TYPE_COMMON) {
 		net_dbg_ratelimited("Phonet unknown PEP type: %u\n",
-				    (unsigned int)hdr->data[0]);
+				    (unsigned int)hdr->pep_type);
 		return -EOPNOTSUPP;
 	}
 
-	switch (hdr->data[1]) {
+	switch (hdr->data[0]) {
 	case PN_PEP_IND_FLOW_CONTROL:
 		switch (pn->tx_fc) {
 		case PN_LEGACY_FLOW_CONTROL:
-			switch (hdr->data[4]) {
+			switch (hdr->data[3]) {
 			case PEP_IND_BUSY:
 				atomic_set(&pn->tx_credits, 0);
 				break;
@@ -292,7 +292,7 @@ static int pipe_rcv_status(struct sock *sk, struct sk_buff *skb)
 			}
 			break;
 		case PN_ONE_CREDIT_FLOW_CONTROL:
-			if (hdr->data[4] == PEP_IND_READY)
+			if (hdr->data[3] == PEP_IND_READY)
 				atomic_set(&pn->tx_credits, wake = 1);
 			break;
 		}
@@ -301,12 +301,12 @@ static int pipe_rcv_status(struct sock *sk, struct sk_buff *skb)
 	case PN_PEP_IND_ID_MCFC_GRANT_CREDITS:
 		if (pn->tx_fc != PN_MULTI_CREDIT_FLOW_CONTROL)
 			break;
-		atomic_add(wake = hdr->data[4], &pn->tx_credits);
+		atomic_add(wake = hdr->data[3], &pn->tx_credits);
 		break;
 
 	default:
 		net_dbg_ratelimited("Phonet unknown PEP indication: %u\n",
-				    (unsigned int)hdr->data[1]);
+				    (unsigned int)hdr->data[0]);
 		return -EOPNOTSUPP;
 	}
 	if (wake)
@@ -318,7 +318,7 @@ static int pipe_rcv_created(struct sock *sk, struct sk_buff *skb)
 {
 	struct pep_sock *pn = pep_sk(sk);
 	struct pnpipehdr *hdr = pnp_hdr(skb);
-	u8 n_sb = hdr->data[0];
+	u8 n_sb = hdr->data0;
 
 	pn->rx_fc = pn->tx_fc = PN_LEGACY_FLOW_CONTROL;
 	__skb_pull(skb, sizeof(*hdr));
@@ -506,7 +506,7 @@ static int pep_connresp_rcv(struct sock *sk, struct sk_buff *skb)
 		return -ECONNREFUSED;
 
 	/* Parse sub-blocks */
-	n_sb = hdr->data[4];
+	n_sb = hdr->data[3];
 	while (n_sb > 0) {
 		u8 type, buf[6], len = sizeof(buf);
 		const u8 *data = pep_get_sb(skb, &type, &len, buf);
@@ -739,7 +739,7 @@ static int pipe_do_remove(struct sock *sk)
 	ph->utid = 0;
 	ph->message_id = PNS_PIPE_REMOVE_REQ;
 	ph->pipe_handle = pn->pipe_handle;
-	ph->data[0] = PAD;
+	ph->data0 = PAD;
 	return pn_skb_send(sk, skb, NULL);
 }
 
@@ -817,7 +817,7 @@ static struct sock *pep_sock_accept(struct sock *sk, int flags, int *errp,
 	peer_type = hdr->other_pep_type << 8;
 
 	/* Parse sub-blocks (options) */
-	n_sb = hdr->data[4];
+	n_sb = hdr->data[3];
 	while (n_sb > 0) {
 		u8 type, buf[1], len = sizeof(buf);
 		const u8 *data = pep_get_sb(skb, &type, &len, buf);
@@ -1109,7 +1109,7 @@ static int pipe_skb_send(struct sock *sk, struct sk_buff *skb)
 	ph->utid = 0;
 	if (pn->aligned) {
 		ph->message_id = PNS_PIPE_ALIGNED_DATA;
-		ph->data[0] = 0; /* padding */
+		ph->data0 = 0; /* padding */
 	} else
 		ph->message_id = PNS_PIPE_DATA;
 	ph->pipe_handle = pn->pipe_handle;
-- 
2.19.1

