Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E695CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49F121880
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbfHHLgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 07:36:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbfHHLgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:36:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 092BD309BDAA;
        Thu,  8 Aug 2019 11:36:19 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (unknown [10.65.16.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8631C61B61;
        Thu,  8 Aug 2019 11:36:16 +0000 (UTC)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     amit@kernel.org, mst@redhat.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        virtualization@lists.linux-foundation.org, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, pagupta@redhat.com
Subject: [PATCH v2 2/2] virtio_ring: packed ring: fix virtqueue_detach_unused_buf
Date:   Thu,  8 Aug 2019 17:06:06 +0530
Message-Id: <20190808113606.19504-3-pagupta@redhat.com>
In-Reply-To: <20190808113606.19504-1-pagupta@redhat.com>
References: <20190808113606.19504-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 08 Aug 2019 11:36:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes packed ring code compatible with split ring in function
'virtqueue_detach_unused_buf_*'.

Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 drivers/virtio/virtio_ring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c8be1c4f5b55..1b98a6777b7e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1534,6 +1534,11 @@ static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
 	for (i = 0; i < vq->packed.vring.num; i++) {
 		if (!vq->packed.desc_state[i].data)
 			continue;
+		vq->packed.next_avail_idx--;
+		if (vq->packed.next_avail_idx < 0) {
+			vq->packed.next_avail_idx = vq->packed.vring.num - 1;
+			vq->packed.avail_wrap_counter ^= 1;
+		}
 		/* detach_buf clears data, so grab it now. */
 		buf = vq->packed.desc_state[i].data;
 		detach_buf_packed(vq, i, NULL);
-- 
2.21.0

