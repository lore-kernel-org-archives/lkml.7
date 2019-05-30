Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEACFC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986CE26022
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559192329;
	bh=2tai9SaB6+Ar6w+cqsaRceMO4vIi6bU87Bu09RCKnFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oKDwS0pR9A6hO6NJf7H1+qfmWZzNok7CJPClvEx9eGu+7ggdNezZD9kBHmaVwhNqk
	 06XV4lZGdarDdDWpLKUetG0X44VdGCkfN82xKCYnhQrAGapQsmwltvhSB9kGAY4aHl
	 i/im2RqngA3JJyM7c89V78KRU+wl6cGKB4csHKtc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389164AbfE3E6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:58:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfE3DJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:09:48 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D02E24490;
        Thu, 30 May 2019 03:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185787;
        bh=2tai9SaB6+Ar6w+cqsaRceMO4vIi6bU87Bu09RCKnFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q/m9O0ehO2r+mXMoyULQ401E3QUN6I+3SluOr5EsSJb2lpQ/n4NVGSKb8kp9M+z6G
         IdrbYGL04VUlkL9tVokFDG8UKlte0uoYYvBr78dG58jlmle7Fk1JHvebI3zFPTzmCl
         ZjS/aEDRtZuWMsFAmT6jeoXNYJwwBbZfrbeT/ync=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, William Tu <u9012063@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 056/405] libbpf: fix invalid munmap call
Date:   Wed, 29 May 2019 20:00:54 -0700
Message-Id: <20190530030543.695689262@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0e6741f092979535d159d5a851f12c88bfb7cb9a ]

When unmapping the AF_XDP memory regions used for the rings, an
invalid address was passed to the munmap() calls. Instead of passing
the beginning of the memory region, the descriptor region was passed
to munmap.

When the userspace application tried to tear down an AF_XDP socket,
the operation failed and the application would still have a reference
to socket it wished to get rid of.

Reported-by: William Tu <u9012063@gmail.com>
Fixes: 1cad07884239 ("libbpf: add support for using AF_XDP sockets")
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
Tested-by: William Tu <u9012063@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/xsk.c | 77 +++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index 8d0078b65486f..af5f310ecca1c 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -248,8 +248,7 @@ int xsk_umem__create(struct xsk_umem **umem_ptr, void *umem_area, __u64 size,
 	return 0;
 
 out_mmap:
-	munmap(umem->fill,
-	       off.fr.desc + umem->config.fill_size * sizeof(__u64));
+	munmap(map, off.fr.desc + umem->config.fill_size * sizeof(__u64));
 out_socket:
 	close(umem->fd);
 out_umem_alloc:
@@ -523,11 +522,11 @@ int xsk_socket__create(struct xsk_socket **xsk_ptr, const char *ifname,
 		       struct xsk_ring_cons *rx, struct xsk_ring_prod *tx,
 		       const struct xsk_socket_config *usr_config)
 {
+	void *rx_map = NULL, *tx_map = NULL;
 	struct sockaddr_xdp sxdp = {};
 	struct xdp_mmap_offsets off;
 	struct xsk_socket *xsk;
 	socklen_t optlen;
-	void *map;
 	int err;
 
 	if (!umem || !xsk_ptr || !rx || !tx)
@@ -593,40 +592,40 @@ int xsk_socket__create(struct xsk_socket **xsk_ptr, const char *ifname,
 	}
 
 	if (rx) {
-		map = xsk_mmap(NULL, off.rx.desc +
-			       xsk->config.rx_size * sizeof(struct xdp_desc),
-			       PROT_READ | PROT_WRITE,
-			       MAP_SHARED | MAP_POPULATE,
-			       xsk->fd, XDP_PGOFF_RX_RING);
-		if (map == MAP_FAILED) {
+		rx_map = xsk_mmap(NULL, off.rx.desc +
+				  xsk->config.rx_size * sizeof(struct xdp_desc),
+				  PROT_READ | PROT_WRITE,
+				  MAP_SHARED | MAP_POPULATE,
+				  xsk->fd, XDP_PGOFF_RX_RING);
+		if (rx_map == MAP_FAILED) {
 			err = -errno;
 			goto out_socket;
 		}
 
 		rx->mask = xsk->config.rx_size - 1;
 		rx->size = xsk->config.rx_size;
-		rx->producer = map + off.rx.producer;
-		rx->consumer = map + off.rx.consumer;
-		rx->ring = map + off.rx.desc;
+		rx->producer = rx_map + off.rx.producer;
+		rx->consumer = rx_map + off.rx.consumer;
+		rx->ring = rx_map + off.rx.desc;
 	}
 	xsk->rx = rx;
 
 	if (tx) {
-		map = xsk_mmap(NULL, off.tx.desc +
-			       xsk->config.tx_size * sizeof(struct xdp_desc),
-			       PROT_READ | PROT_WRITE,
-			       MAP_SHARED | MAP_POPULATE,
-			       xsk->fd, XDP_PGOFF_TX_RING);
-		if (map == MAP_FAILED) {
+		tx_map = xsk_mmap(NULL, off.tx.desc +
+				  xsk->config.tx_size * sizeof(struct xdp_desc),
+				  PROT_READ | PROT_WRITE,
+				  MAP_SHARED | MAP_POPULATE,
+				  xsk->fd, XDP_PGOFF_TX_RING);
+		if (tx_map == MAP_FAILED) {
 			err = -errno;
 			goto out_mmap_rx;
 		}
 
 		tx->mask = xsk->config.tx_size - 1;
 		tx->size = xsk->config.tx_size;
-		tx->producer = map + off.tx.producer;
-		tx->consumer = map + off.tx.consumer;
-		tx->ring = map + off.tx.desc;
+		tx->producer = tx_map + off.tx.producer;
+		tx->consumer = tx_map + off.tx.consumer;
+		tx->ring = tx_map + off.tx.desc;
 		tx->cached_cons = xsk->config.tx_size;
 	}
 	xsk->tx = tx;
@@ -653,13 +652,11 @@ int xsk_socket__create(struct xsk_socket **xsk_ptr, const char *ifname,
 
 out_mmap_tx:
 	if (tx)
-		munmap(xsk->tx,
-		       off.tx.desc +
+		munmap(tx_map, off.tx.desc +
 		       xsk->config.tx_size * sizeof(struct xdp_desc));
 out_mmap_rx:
 	if (rx)
-		munmap(xsk->rx,
-		       off.rx.desc +
+		munmap(rx_map, off.rx.desc +
 		       xsk->config.rx_size * sizeof(struct xdp_desc));
 out_socket:
 	if (--umem->refcount)
@@ -684,10 +681,12 @@ int xsk_umem__delete(struct xsk_umem *umem)
 	optlen = sizeof(off);
 	err = getsockopt(umem->fd, SOL_XDP, XDP_MMAP_OFFSETS, &off, &optlen);
 	if (!err) {
-		munmap(umem->fill->ring,
-		       off.fr.desc + umem->config.fill_size * sizeof(__u64));
-		munmap(umem->comp->ring,
-		       off.cr.desc + umem->config.comp_size * sizeof(__u64));
+		(void)munmap(umem->fill->ring - off.fr.desc,
+			     off.fr.desc +
+			     umem->config.fill_size * sizeof(__u64));
+		(void)munmap(umem->comp->ring - off.cr.desc,
+			     off.cr.desc +
+			     umem->config.comp_size * sizeof(__u64));
 	}
 
 	close(umem->fd);
@@ -698,6 +697,7 @@ int xsk_umem__delete(struct xsk_umem *umem)
 
 void xsk_socket__delete(struct xsk_socket *xsk)
 {
+	size_t desc_sz = sizeof(struct xdp_desc);
 	struct xdp_mmap_offsets off;
 	socklen_t optlen;
 	int err;
@@ -710,14 +710,17 @@ void xsk_socket__delete(struct xsk_socket *xsk)
 	optlen = sizeof(off);
 	err = getsockopt(xsk->fd, SOL_XDP, XDP_MMAP_OFFSETS, &off, &optlen);
 	if (!err) {
-		if (xsk->rx)
-			munmap(xsk->rx->ring,
-			       off.rx.desc +
-			       xsk->config.rx_size * sizeof(struct xdp_desc));
-		if (xsk->tx)
-			munmap(xsk->tx->ring,
-			       off.tx.desc +
-			       xsk->config.tx_size * sizeof(struct xdp_desc));
+		if (xsk->rx) {
+			(void)munmap(xsk->rx->ring - off.rx.desc,
+				     off.rx.desc +
+				     xsk->config.rx_size * desc_sz);
+		}
+		if (xsk->tx) {
+			(void)munmap(xsk->tx->ring - off.tx.desc,
+				     off.tx.desc +
+				     xsk->config.tx_size * desc_sz);
+		}
+
 	}
 
 	xsk->umem->refcount--;
-- 
2.20.1



