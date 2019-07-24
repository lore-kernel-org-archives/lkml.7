Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6148CC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D7E20659
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996870;
	bh=ygFLybXWsTiWiLHn2WTDchSQO7+pJBrDXToVmNXhiuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S5LPdGwh8JZob+uWLYDEyiTarFlfHDHXgcV9Gkmmy2g5xOLFUdy8KNDftttXwia+t
	 D6yinOIeIXQNPeRzcnsnbzIoFhqhnH9E+qXBv55SYyrOxHsVR7SV77cezM7f4vds/Q
	 U8jz+7v5GRJswXPLduzZU/jxdyE9auAigXJe4T94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388421AbfGXTe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728165AbfGXTe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:34:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30EE9229FA;
        Wed, 24 Jul 2019 19:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996865;
        bh=ygFLybXWsTiWiLHn2WTDchSQO7+pJBrDXToVmNXhiuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nEFiAfjCkGpFV9eUXSn4IHXB5eGez69ZL0SvWEMZ4EYjqWGWI62LleSYnHRenUYkt
         iTDE5vXAusQRGfx9bnlkgmTr/4RLaFFI6NEzCxMqytvSI0wi6OzzQBlxFIC8gVHRbk
         ClpkC1luUargKc6cOL6IaRD76O86BrNSS5nhiiT8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Maximets <i.maximets@samsung.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        William Tu <u9012063@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 242/413] xdp: fix race on generic receive path
Date:   Wed, 24 Jul 2019 21:18:53 +0200
Message-Id: <20190724191752.727432609@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit bf0bdd1343efbbf65b4d53aef1fce14acbd79d50 ]

Unlike driver mode, generic xdp receive could be triggered
by different threads on different CPU cores at the same time
leading to the fill and rx queue breakage. For example, this
could happen while sending packets from two processes to the
first interface of veth pair while the second part of it is
open with AF_XDP socket.

Need to take a lock for each generic receive to avoid race.

Fixes: c497176cb2e4 ("xsk: add Rx receive functions and poll support")
Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Tested-by: William Tu <u9012063@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/xdp_sock.h |  2 ++
 net/xdp/xsk.c          | 31 ++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index d074b6d60f8a..ac3c047d058c 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -67,6 +67,8 @@ struct xdp_sock {
 	 * in the SKB destructor callback.
 	 */
 	spinlock_t tx_completion_lock;
+	/* Protects generic receive. */
+	spinlock_t rx_lock;
 	u64 rx_dropped;
 };
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index a14e8864e4fa..5e0637db92ea 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -123,13 +123,17 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 	u64 addr;
 	int err;
 
-	if (xs->dev != xdp->rxq->dev || xs->queue_id != xdp->rxq->queue_index)
-		return -EINVAL;
+	spin_lock_bh(&xs->rx_lock);
+
+	if (xs->dev != xdp->rxq->dev || xs->queue_id != xdp->rxq->queue_index) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
 
 	if (!xskq_peek_addr(xs->umem->fq, &addr) ||
 	    len > xs->umem->chunk_size_nohr - XDP_PACKET_HEADROOM) {
-		xs->rx_dropped++;
-		return -ENOSPC;
+		err = -ENOSPC;
+		goto out_drop;
 	}
 
 	addr += xs->umem->headroom;
@@ -138,13 +142,21 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
 	memcpy(buffer, xdp->data_meta, len + metalen);
 	addr += metalen;
 	err = xskq_produce_batch_desc(xs->rx, addr, len);
-	if (!err) {
-		xskq_discard_addr(xs->umem->fq);
-		xsk_flush(xs);
-		return 0;
-	}
+	if (err)
+		goto out_drop;
+
+	xskq_discard_addr(xs->umem->fq);
+	xskq_produce_flush_desc(xs->rx);
 
+	spin_unlock_bh(&xs->rx_lock);
+
+	xs->sk.sk_data_ready(&xs->sk);
+	return 0;
+
+out_drop:
 	xs->rx_dropped++;
+out_unlock:
+	spin_unlock_bh(&xs->rx_lock);
 	return err;
 }
 
@@ -765,6 +777,7 @@ static int xsk_create(struct net *net, struct socket *sock, int protocol,
 
 	xs = xdp_sk(sk);
 	mutex_init(&xs->mutex);
+	spin_lock_init(&xs->rx_lock);
 	spin_lock_init(&xs->tx_completion_lock);
 
 	mutex_lock(&net->xdp.lock);
-- 
2.20.1



