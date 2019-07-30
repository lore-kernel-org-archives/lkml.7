Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4C4C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53E6206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbfG3PoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:44:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732570AbfG3PoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:44:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E661A308403B;
        Tue, 30 Jul 2019 15:44:06 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-116-91.ams2.redhat.com [10.36.116.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C98362B9EF;
        Tue, 30 Jul 2019 15:44:04 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH net-next v5 5/5] vsock/virtio: change the maximum packet size allowed
Date:   Tue, 30 Jul 2019 17:43:34 +0200
Message-Id: <20190730154334.237789-6-sgarzare@redhat.com>
In-Reply-To: <20190730154334.237789-1-sgarzare@redhat.com>
References: <20190730154334.237789-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 30 Jul 2019 15:44:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since now we are able to split packets, we can avoid limiting
their sizes to VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE.
Instead, we can use VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max
packet size.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 56fab3f03d0e..94cc0fa3e848 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -181,8 +181,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	vvs = vsk->trans;
 
 	/* we can send less than pkt_len bytes */
-	if (pkt_len > VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE)
-		pkt_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
+	if (pkt_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE)
+		pkt_len = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
 
 	/* virtio_transport_get_credit might return less than pkt_len credit */
 	pkt_len = virtio_transport_get_credit(vvs, pkt_len);
-- 
2.20.1

