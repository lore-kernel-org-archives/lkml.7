Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9C6C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 05:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC802070E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 05:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yG5p0DxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgAGFsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 00:48:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43303 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgAGFr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 00:47:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id k197so27950252pga.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 21:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dp7a/ozyZfwB+kP9dnZlOFXZoCwRQSjpD5T5pIZB/8Q=;
        b=yG5p0DxGkRBjp/72mUW+KHkkmfaqAG3dRkQk/K8otpNmmxqbbHXTuqI3PI88MWL98a
         aH57NWaxfTAQLfjE05VRrzeS/XqFqlyvsOfBB6Q/zs0WEM2VqFWCQ/m7bx7OOp4TT2Wn
         9Ju9v4nCwRJsqeEY4Rz4eg8o6Vznol5Hn+pF/f0r6UNZyolE2ioBWiP90HgXTDuDpG9n
         raS1ofswapv74TCZDwb3CQ46mUNg71E4OGWxNAqmgZReQc48uSIbGb8xM3fqfd7Hdc3Q
         8k66w1JR8ImNTIdnzSmEQf3kILOH0JDy9Mlq3swvZj2VJnDZhZnhXFavf2aQYP86YYCB
         tPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dp7a/ozyZfwB+kP9dnZlOFXZoCwRQSjpD5T5pIZB/8Q=;
        b=p87r2zwCPvFW4rgrlPeRQYrxuVo0YW5H4Nj4j7uPkzK7QNen7vDuQV7s8yWMAtM1PO
         urTpaIJMCp0u3TUtqGagbvp3Z7kZvwO2f98xC4hnOXEtsCpf0fxYXhl9VBtKa1xg9UDd
         USqu3/DPbxTrohbpZWiz9XIl6f1JhAH37gLeHngc0cvMFXQ96h7btCTy3kz0WIIFJFSO
         0GslGu6/GifjdHCFXighTH9Q8xrBu8TTSHJa7LCWp3+s0xPvLCi/ibp5Bu8N0OkiuNl0
         fGaSPkF4mm6sEn8Tm+sCFk9R2e7l5XNWGzEtSMhiL4LoEWNNSP/JgE1JKIMkzIg3/uub
         zpIQ==
X-Gm-Message-State: APjAAAUDEqtkjqhpD4RizqUYXZNFZwTOWmp2ID04ONNtj9JrPFjAC6Sc
        +Q1lD7uRx1n0SMiT6Jm39ycBjQ==
X-Google-Smtp-Source: APXvYqxL6g+CoprISrZRW8EQIhr/95irjbEu71b+reVIWVK02C3ShkAlq/3bL3LoeYxiH57cIRzzMw==
X-Received: by 2002:a63:e17:: with SMTP id d23mr115992276pgl.173.1578376077643;
        Mon, 06 Jan 2020 21:47:57 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k21sm67129177pfa.63.2020.01.06.21.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 21:47:57 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Chris Lew <clew@codeaurora.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 1/5] net: qrtr: Move resume-tx transmission to recvmsg
Date:   Mon,  6 Jan 2020 21:47:09 -0800
Message-Id: <20200107054713.3909260-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200107054713.3909260-1-bjorn.andersson@linaro.org>
References: <20200107054713.3909260-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The confirm-rx bit is used to implement a per port flow control, in
order to make sure that no messages are dropped due to resource
exhaustion. Move the resume-tx transmission to recvmsg to only confirm
messages as they are consumed by the application.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- None

 net/qrtr/qrtr.c | 60 +++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
index 88f98f27ad88..6c56a8ce83ef 100644
--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -362,22 +362,11 @@ static void qrtr_port_put(struct qrtr_sock *ipc);
 static void qrtr_node_rx_work(struct work_struct *work)
 {
 	struct qrtr_node *node = container_of(work, struct qrtr_node, work);
-	struct qrtr_ctrl_pkt *pkt;
-	struct sockaddr_qrtr dst;
-	struct sockaddr_qrtr src;
 	struct sk_buff *skb;
 
 	while ((skb = skb_dequeue(&node->rx_queue)) != NULL) {
 		struct qrtr_sock *ipc;
-		struct qrtr_cb *cb;
-		int confirm;
-
-		cb = (struct qrtr_cb *)skb->cb;
-		src.sq_node = cb->src_node;
-		src.sq_port = cb->src_port;
-		dst.sq_node = cb->dst_node;
-		dst.sq_port = cb->dst_port;
-		confirm = !!cb->confirm_rx;
+		struct qrtr_cb *cb = (struct qrtr_cb *)skb->cb;
 
 		qrtr_node_assign(node, cb->src_node);
 
@@ -390,20 +379,6 @@ static void qrtr_node_rx_work(struct work_struct *work)
 
 			qrtr_port_put(ipc);
 		}
-
-		if (confirm) {
-			skb = qrtr_alloc_ctrl_packet(&pkt);
-			if (!skb)
-				break;
-
-			pkt->cmd = cpu_to_le32(QRTR_TYPE_RESUME_TX);
-			pkt->client.node = cpu_to_le32(dst.sq_node);
-			pkt->client.port = cpu_to_le32(dst.sq_port);
-
-			if (qrtr_node_enqueue(node, skb, QRTR_TYPE_RESUME_TX,
-					      &dst, &src))
-				break;
-		}
 	}
 }
 
@@ -816,6 +791,34 @@ static int qrtr_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	return rc;
 }
 
+static int qrtr_send_resume_tx(struct qrtr_cb *cb)
+{
+	struct sockaddr_qrtr remote = { AF_QIPCRTR, cb->src_node, cb->src_port };
+	struct sockaddr_qrtr local = { AF_QIPCRTR, cb->dst_node, cb->dst_port };
+	struct qrtr_ctrl_pkt *pkt;
+	struct qrtr_node *node;
+	struct sk_buff *skb;
+	int ret;
+
+	node = qrtr_node_lookup(remote.sq_node);
+	if (!node)
+		return -EINVAL;
+
+	skb = qrtr_alloc_ctrl_packet(&pkt);
+	if (!skb)
+		return -ENOMEM;
+
+	pkt->cmd = cpu_to_le32(QRTR_TYPE_RESUME_TX);
+	pkt->client.node = cpu_to_le32(cb->dst_node);
+	pkt->client.port = cpu_to_le32(cb->dst_port);
+
+	ret = qrtr_node_enqueue(node, skb, QRTR_TYPE_RESUME_TX, &local, &remote);
+
+	qrtr_node_release(node);
+
+	return ret;
+}
+
 static int qrtr_recvmsg(struct socket *sock, struct msghdr *msg,
 			size_t size, int flags)
 {
@@ -838,6 +841,7 @@ static int qrtr_recvmsg(struct socket *sock, struct msghdr *msg,
 		release_sock(sk);
 		return rc;
 	}
+	cb = (struct qrtr_cb *)skb->cb;
 
 	copied = skb->len;
 	if (copied > size) {
@@ -851,7 +855,6 @@ static int qrtr_recvmsg(struct socket *sock, struct msghdr *msg,
 	rc = copied;
 
 	if (addr) {
-		cb = (struct qrtr_cb *)skb->cb;
 		addr->sq_family = AF_QIPCRTR;
 		addr->sq_node = cb->src_node;
 		addr->sq_port = cb->src_port;
@@ -859,6 +862,9 @@ static int qrtr_recvmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 out:
+	if (cb->confirm_rx)
+		qrtr_send_resume_tx(cb);
+
 	skb_free_datagram(sk, skb);
 	release_sock(sk);
 
-- 
2.24.0

