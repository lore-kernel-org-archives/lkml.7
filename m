Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87901C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5456A262A5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="migBA7G0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfEaBSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 21:18:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38923 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfEaBSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 21:18:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id j2so5074090pfe.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 18:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4uHEAa5GeZzr2h0opAabsUuB1kTv1SagFVuFPuo6Vy4=;
        b=migBA7G0X8TRyWt+AlogD9HOesTE9MlGY/VHdPuOv2b4R05pmowj823gTs5tiG2Pov
         sSM2x9XvzPtsJczvx912e+oBwNoeY01DDuG3j1RTintQIw2Z9zKUXgRya/xSQ3WAfMA/
         mz9V6ymLT0qqERhwb6SQDuwBuWSZmUFu23sOd+OfIGIM2E1HKn1jxxJoUSIEytKr0Sm4
         6rKrQhG8WyFbNg6SsnzSfWvGTpgn4kRZRqxjg9Cz+Si6LvJBNtliij/XI3FjAmHk9+xs
         q6SB7k1FJaoPMpQ7Xk71ak8xHKrI/uWpJv3i6+MtXEV5OABRTwdwkHziRE60+tfrSbzA
         xdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4uHEAa5GeZzr2h0opAabsUuB1kTv1SagFVuFPuo6Vy4=;
        b=WeiyGOc1EUhbUd+zVh/pVg5Tdpj+eb9SoIIeBqQY1jK3GwDeKKmgEDGI4YDW4DcNss
         uXXNAgSZLSTciKV649mulOpgM2imc1C69R89EBJ/+uKkscoiS6cY12g9HK3zFNNS9qYd
         gThm99CJpJUR7qj/n96K82d8/nq6RRWthoWa0h6A2DR8obTXLX4TsWQ63Kkwe+P6xCR3
         gmRCzs2TNANcirMRHENTzLsfGJ8c4xfi3tbcVWJzMHJKoYePe9m07jjjr2QztAu9Iw+j
         UeTeW0yhyQiMbf3JQo8k2+GpYgX7ogPXqg06JAeQnJW+BkCMkWnJlU0XrZSCqK0mDGCO
         x1sQ==
X-Gm-Message-State: APjAAAW9VEAb3nZ0PRyZv8gX5Rs1urw4T6hoiQ3TPu2EqR3GwcvjVOjI
        d9s/ANDEAi/UyzhDUlIG37EBgw==
X-Google-Smtp-Source: APXvYqyzIj6Pm1KfV/B4BT/7El4cJiSWB3kByoiUQxMfNJ3vK96ay9Q4JTPnEheGYvM+SrTLPr/mRg==
X-Received: by 2002:a63:ea42:: with SMTP id l2mr5875093pgk.19.1559265482268;
        Thu, 30 May 2019 18:18:02 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j20sm1819042pff.183.2019.05.30.18.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 18:18:01 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Chris Lew <clew@codeaurora.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 5/5] net: qrtr: Remove receive worker
Date:   Thu, 30 May 2019 18:17:53 -0700
Message-Id: <20190531011753.11840-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190531011753.11840-1-bjorn.andersson@linaro.org>
References: <20190531011753.11840-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than enqueuing messages and scheduling a worker to deliver them
to the individual sockets we can now, thanks to the previous work, move
this directly into the endpoint callback.

This saves us a context switch per incoming message and removes the
possibility of an opportunistic suspend to happen between the message is
coming from the endpoint until it ends up in the socket's receive
buffer.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 net/qrtr/qrtr.c | 54 ++++++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
index 7f048b9e02fb..782a3e8c5f93 100644
--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -165,6 +165,8 @@ static int qrtr_local_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 static int qrtr_bcast_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 			      int type, struct sockaddr_qrtr *from,
 			      struct sockaddr_qrtr *to);
+static struct qrtr_sock *qrtr_port_lookup(int port);
+static void qrtr_port_put(struct qrtr_sock *ipc);
 
 /* Release node resources and free the node.
  *
@@ -429,6 +431,7 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
 	struct qrtr_node *node = ep->node;
 	const struct qrtr_hdr_v1 *v1;
 	const struct qrtr_hdr_v2 *v2;
+	struct qrtr_sock *ipc;
 	struct sk_buff *skb;
 	struct qrtr_cb *cb;
 	unsigned int size;
@@ -493,8 +496,20 @@ int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len)
 
 	skb_put_data(skb, data + hdrlen, size);
 
-	skb_queue_tail(&node->rx_queue, skb);
-	schedule_work(&node->work);
+	qrtr_node_assign(node, cb->src_node);
+
+	if (cb->type == QRTR_TYPE_RESUME_TX) {
+		qrtr_tx_resume(node, skb);
+	} else {
+		ipc = qrtr_port_lookup(cb->dst_port);
+		if (!ipc)
+			goto err;
+
+		if (sock_queue_rcv_skb(&ipc->sk, skb))
+			goto err;
+
+		qrtr_port_put(ipc);
+	}
 
 	return 0;
 
@@ -529,40 +544,6 @@ static struct sk_buff *qrtr_alloc_ctrl_packet(struct qrtr_ctrl_pkt **pkt)
 	return skb;
 }
 
-static struct qrtr_sock *qrtr_port_lookup(int port);
-static void qrtr_port_put(struct qrtr_sock *ipc);
-
-/* Handle and route a received packet.
- *
- * This will auto-reply with resume-tx packet as necessary.
- */
-static void qrtr_node_rx_work(struct work_struct *work)
-{
-	struct qrtr_node *node = container_of(work, struct qrtr_node, work);
-	struct sk_buff *skb;
-
-	while ((skb = skb_dequeue(&node->rx_queue)) != NULL) {
-		struct qrtr_sock *ipc;
-		struct qrtr_cb *cb = (struct qrtr_cb *)skb->cb;
-
-		qrtr_node_assign(node, cb->src_node);
-
-		if (cb->type == QRTR_TYPE_RESUME_TX) {
-			qrtr_tx_resume(node, skb);
-		} else {
-			ipc = qrtr_port_lookup(cb->dst_port);
-			if (!ipc) {
-				kfree_skb(skb);
-			} else {
-				if (sock_queue_rcv_skb(&ipc->sk, skb))
-					kfree_skb(skb);
-
-				qrtr_port_put(ipc);
-			}
-		}
-	}
-}
-
 /**
  * qrtr_endpoint_register() - register a new endpoint
  * @ep: endpoint to register
@@ -582,7 +563,6 @@ int qrtr_endpoint_register(struct qrtr_endpoint *ep, unsigned int nid)
 	if (!node)
 		return -ENOMEM;
 
-	INIT_WORK(&node->work, qrtr_node_rx_work);
 	kref_init(&node->ref);
 	mutex_init(&node->ep_lock);
 	skb_queue_head_init(&node->rx_queue);
-- 
2.18.0

