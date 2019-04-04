Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA963C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8002D20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfDDK6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:58:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfDDK6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:58:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 480ED3164992;
        Thu,  4 Apr 2019 10:58:49 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-25.ams2.redhat.com [10.36.117.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45CFB1001DC9;
        Thu,  4 Apr 2019 10:58:47 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH RFC 1/4] vsock/virtio: reduce credit update messages
Date:   Thu,  4 Apr 2019 12:58:35 +0200
Message-Id: <20190404105838.101559-2-sgarzare@redhat.com>
In-Reply-To: <20190404105838.101559-1-sgarzare@redhat.com>
References: <20190404105838.101559-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 04 Apr 2019 10:58:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reduce the number of credit update messages,
we send them only when the space available seen by the
transmitter is less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/virtio_vsock.h            |  1 +
 net/vmw_vsock/virtio_transport_common.c | 14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index e223e2632edd..6d7a22cc20bf 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -37,6 +37,7 @@ struct virtio_vsock_sock {
 	u32 tx_cnt;
 	u32 buf_alloc;
 	u32 peer_fwd_cnt;
+	u32 last_fwd_cnt;
 	u32 peer_buf_alloc;
 
 	/* Protected by rx_lock */
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 602715fc9a75..f32301d823f5 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -206,6 +206,7 @@ static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
 void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct virtio_vsock_pkt *pkt)
 {
 	spin_lock_bh(&vvs->tx_lock);
+	vvs->last_fwd_cnt = vvs->fwd_cnt;
 	pkt->hdr.fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
 	pkt->hdr.buf_alloc = cpu_to_le32(vvs->buf_alloc);
 	spin_unlock_bh(&vvs->tx_lock);
@@ -256,6 +257,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 	struct virtio_vsock_sock *vvs = vsk->trans;
 	struct virtio_vsock_pkt *pkt;
 	size_t bytes, total = 0;
+	s64 free_space;
 	int err = -EFAULT;
 
 	spin_lock_bh(&vvs->rx_lock);
@@ -288,9 +290,15 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 	}
 	spin_unlock_bh(&vvs->rx_lock);
 
-	/* Send a credit pkt to peer */
-	virtio_transport_send_credit_update(vsk, VIRTIO_VSOCK_TYPE_STREAM,
-					    NULL);
+	/* We send a credit update only when the space available seen
+	 * by the transmitter is less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE
+	 */
+	free_space = vvs->buf_alloc - (vvs->fwd_cnt - vvs->last_fwd_cnt);
+	if (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE) {
+		virtio_transport_send_credit_update(vsk,
+						    VIRTIO_VSOCK_TYPE_STREAM,
+						    NULL);
+	}
 
 	return total;
 
-- 
2.20.1

