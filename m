Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F9AC606C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5B720665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600530;
	bh=XVuAWszYVeibjwhmGPgW2IVQzZdDJVBK+SeBtBXbb9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Md8fomniW9EjNoTs2kJY8otdsN7hFknqmpVYMQUZdP//e/TWoo/iNJTeECa4s6N2k
	 W+cxHebHItZphWhKJtX5jqm5zMgpsZg4G1lSNOgGt6U8gkqXmbe4Zxh2lJzQ41ufVW
	 +ZelGQYbz/B9FAdNJUDNlKal1q5/xHi152TF8KJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388643AbfGHPZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388621AbfGHPZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:25:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49B83204EC;
        Mon,  8 Jul 2019 15:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599534;
        bh=XVuAWszYVeibjwhmGPgW2IVQzZdDJVBK+SeBtBXbb9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lzyUuYRU2paVRWcRwwVgEAw3Yo0jccYNNQ3YG9vVLsnLAQypmMqute3oNlHEgWgkG
         LM3h0MLWwwnz0r9ilWcN9Yl7C4hUSCeYhdPa+IWm+VPNIj8YkCntRJZoHK/eZFqpr8
         8Bsvx1sIIWMilFL5QytsvNKWiQ7W2XIaw4SsxR5E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Balbir Singh <sblbir@amzn.com>
Subject: [PATCH 4.14 46/56] vhost: vsock: add weight support
Date:   Mon,  8 Jul 2019 17:13:38 +0200
Message-Id: <20190708150523.850047024@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150514.376317156@linuxfoundation.org>
References: <20190708150514.376317156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Wang <jasowang@redhat.com>

commit e79b431fb901ba1106670bcc80b9b617b25def7d upstream.

This patch will check the weight and exit the loop if we exceeds the
weight. This is useful for preventing vsock kthread from hogging cpu
which is guest triggerable. The weight can help to avoid starving the
request from on direction while another direction is being processed.

The value of weight is picked from vhost-net.

This addresses CVE-2019-3900.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Balbir Singh <sblbir@amzn.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/vhost/vsock.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -86,6 +86,7 @@ vhost_transport_do_send_pkt(struct vhost
 			    struct vhost_virtqueue *vq)
 {
 	struct vhost_virtqueue *tx_vq = &vsock->vqs[VSOCK_VQ_TX];
+	int pkts = 0, total_len = 0;
 	bool added = false;
 	bool restart_tx = false;
 
@@ -97,7 +98,7 @@ vhost_transport_do_send_pkt(struct vhost
 	/* Avoid further vmexits, we're already processing the virtqueue */
 	vhost_disable_notify(&vsock->dev, vq);
 
-	for (;;) {
+	do {
 		struct virtio_vsock_pkt *pkt;
 		struct iov_iter iov_iter;
 		unsigned out, in;
@@ -182,8 +183,9 @@ vhost_transport_do_send_pkt(struct vhost
 		 */
 		virtio_transport_deliver_tap_pkt(pkt);
 
+		total_len += pkt->len;
 		virtio_transport_free_pkt(pkt);
-	}
+	} while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
 	if (added)
 		vhost_signal(&vsock->dev, vq);
 
@@ -358,7 +360,7 @@ static void vhost_vsock_handle_tx_kick(s
 	struct vhost_vsock *vsock = container_of(vq->dev, struct vhost_vsock,
 						 dev);
 	struct virtio_vsock_pkt *pkt;
-	int head;
+	int head, pkts = 0, total_len = 0;
 	unsigned int out, in;
 	bool added = false;
 
@@ -368,7 +370,7 @@ static void vhost_vsock_handle_tx_kick(s
 		goto out;
 
 	vhost_disable_notify(&vsock->dev, vq);
-	for (;;) {
+	do {
 		u32 len;
 
 		if (!vhost_vsock_more_replies(vsock)) {
@@ -409,9 +411,11 @@ static void vhost_vsock_handle_tx_kick(s
 		else
 			virtio_transport_free_pkt(pkt);
 
-		vhost_add_used(vq, head, sizeof(pkt->hdr) + len);
+		len += sizeof(pkt->hdr);
+		vhost_add_used(vq, head, len);
+		total_len += len;
 		added = true;
-	}
+	} while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
 
 no_more_replies:
 	if (added)


