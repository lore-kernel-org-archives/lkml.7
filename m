Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2572ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DC42054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbfJOPBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:01:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfJOPA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:00:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C47B9308A98C;
        Tue, 15 Oct 2019 15:00:59 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-116-56.ams2.redhat.com [10.36.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CE31194BE;
        Tue, 15 Oct 2019 15:00:52 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] vsock/virtio: remove unused 'work' field from 'struct virtio_vsock_pkt'
Date:   Tue, 15 Oct 2019 17:00:51 +0200
Message-Id: <20191015150051.104631-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 15 Oct 2019 15:00:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'work' field was introduced with commit 06a8fc78367d0
("VSOCK: Introduce virtio_vsock_common.ko")
but it is never used in the code, so we can remove it to save
memory allocated in the per-packet 'struct virtio_vsock_pkt'

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/virtio_vsock.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 4c7781f4b29b..07875ccc7bb5 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -48,7 +48,6 @@ struct virtio_vsock_sock {
 
 struct virtio_vsock_pkt {
 	struct virtio_vsock_hdr	hdr;
-	struct work_struct work;
 	struct list_head list;
 	/* socket refcnt not held, only use for cancellation */
 	struct vsock_sock *vsk;
-- 
2.21.0

