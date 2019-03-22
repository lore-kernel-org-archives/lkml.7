Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC56C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3C62082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254871;
	bh=2kN8J0svXVpFI991ONjSqpEeehHvQ6b9UqO5XrCvHeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jg7RyZEttbr/UAGWAwKJY9BJB2ALWtt/hDrRHErBasTH6RnNRtiZRrb4zLp827c44
	 H4D4dzYz/x8TCrXFMoHq8bDtgspD6Yjy6Lyc6T7B3kc6zcHNUOnxdK0rNJmTa6szg4
	 Gwp/rvr9ozCHJvESRYoBWmO6Oii7o06g+rSCJ3Q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbfCVLlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:41:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730560AbfCVLlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:41:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADF1B2082C;
        Fri, 22 Mar 2019 11:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254866;
        bh=2kN8J0svXVpFI991ONjSqpEeehHvQ6b9UqO5XrCvHeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMZ4VUrzaCYpxwMREjEaNKArgoCy+xl9Pw2VN+gByuysgz92W3vldp2+eD2FQaCiI
         q9YZQOGbvDq9Nf2Sj9AZFJX1lGAjIn3DQFxCn1w2ipCWbiv7HesjCkdaY/RnpIJVXe
         wcLjneTRf7OyRCTxbYgU0Z5nHrGFbivXsBeBmZtI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 035/118] phonet: fix building with clang
Date:   Fri, 22 Mar 2019 12:15:07 +0100
Message-Id: <20190322111218.678483824@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 850a86cde0b3..f6aa532bcbf6 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -131,7 +131,7 @@ static int pep_indicate(struct sock *sk, u8 id, u8 code,
 	ph->utid = 0;
 	ph->message_id = id;
 	ph->pipe_handle = pn->pipe_handle;
-	ph->data[0] = code;
+	ph->error_code = code;
 	return pn_skb_send(sk, skb, NULL);
 }
 
@@ -152,7 +152,7 @@ static int pipe_handler_request(struct sock *sk, u8 id, u8 code,
 	ph->utid = id; /* whatever */
 	ph->message_id = id;
 	ph->pipe_handle = pn->pipe_handle;
-	ph->data[0] = code;
+	ph->error_code = code;
 	return pn_skb_send(sk, skb, NULL);
 }
 
@@ -207,7 +207,7 @@ static int pep_ctrlreq_error(struct sock *sk, struct sk_buff *oskb, u8 code,
 	struct pnpipehdr *ph;
 	struct sockaddr_pn dst;
 	u8 data[4] = {
-		oph->data[0], /* PEP type */
+		oph->pep_type, /* PEP type */
 		code, /* error code, at an unusual offset */
 		PAD, PAD,
 	};
@@ -220,7 +220,7 @@ static int pep_ctrlreq_error(struct sock *sk, struct sk_buff *oskb, u8 code,
 	ph->utid = oph->utid;
 	ph->message_id = PNS_PEP_CTRL_RESP;
 	ph->pipe_handle = oph->pipe_handle;
-	ph->data[0] = oph->data[1]; /* CTRL id */
+	ph->data0 = oph->data[0]; /* CTRL id */
 
 	pn_skb_get_src_sockaddr(oskb, &dst);
 	return pn_skb_send(sk, skb, &dst);
@@ -271,17 +271,17 @@ static int pipe_rcv_status(struct sock *sk, struct sk_buff *skb)
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
@@ -291,7 +291,7 @@ static int pipe_rcv_status(struct sock *sk, struct sk_buff *skb)
 			}
 			break;
 		case PN_ONE_CREDIT_FLOW_CONTROL:
-			if (hdr->data[4] == PEP_IND_READY)
+			if (hdr->data[3] == PEP_IND_READY)
 				atomic_set(&pn->tx_credits, wake = 1);
 			break;
 		}
@@ -300,12 +300,12 @@ static int pipe_rcv_status(struct sock *sk, struct sk_buff *skb)
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
@@ -317,7 +317,7 @@ static int pipe_rcv_created(struct sock *sk, struct sk_buff *skb)
 {
 	struct pep_sock *pn = pep_sk(sk);
 	struct pnpipehdr *hdr = pnp_hdr(skb);
-	u8 n_sb = hdr->data[0];
+	u8 n_sb = hdr->data0;
 
 	pn->rx_fc = pn->tx_fc = PN_LEGACY_FLOW_CONTROL;
 	__skb_pull(skb, sizeof(*hdr));
@@ -505,7 +505,7 @@ static int pep_connresp_rcv(struct sock *sk, struct sk_buff *skb)
 		return -ECONNREFUSED;
 
 	/* Parse sub-blocks */
-	n_sb = hdr->data[4];
+	n_sb = hdr->data[3];
 	while (n_sb > 0) {
 		u8 type, buf[6], len = sizeof(buf);
 		const u8 *data = pep_get_sb(skb, &type, &len, buf);
@@ -738,7 +738,7 @@ static int pipe_do_remove(struct sock *sk)
 	ph->utid = 0;
 	ph->message_id = PNS_PIPE_REMOVE_REQ;
 	ph->pipe_handle = pn->pipe_handle;
-	ph->data[0] = PAD;
+	ph->data0 = PAD;
 	return pn_skb_send(sk, skb, NULL);
 }
 
@@ -815,7 +815,7 @@ static struct sock *pep_sock_accept(struct sock *sk, int flags, int *errp)
 	peer_type = hdr->other_pep_type << 8;
 
 	/* Parse sub-blocks (options) */
-	n_sb = hdr->data[4];
+	n_sb = hdr->data[3];
 	while (n_sb > 0) {
 		u8 type, buf[1], len = sizeof(buf);
 		const u8 *data = pep_get_sb(skb, &type, &len, buf);
@@ -1106,7 +1106,7 @@ static int pipe_skb_send(struct sock *sk, struct sk_buff *skb)
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



