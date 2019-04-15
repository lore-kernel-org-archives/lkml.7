Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADB6C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB8320651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355350;
	bh=MuWSN6d9k3a76+0XIDz9vmfjWYJOuzSLm1pEe0R5Mek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ikCsCF5TxaK16Zl29Ugj2x9Oz1jI+umIhbItFCXKVsCoWm7fQC02i9NAYwlNsq4MM
	 O/G1jj5NWkD49ubf9TOcvmbSc2CVI89hFytPsNkOzY0xJMdC+elvH7DycfeqKNEuUw
	 jXgkCD7wqqSIDiTjsb4iKUAelXG0NJk9/y6wACzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbfDOTJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730649AbfDOTJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:09:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0A0021900;
        Mon, 15 Apr 2019 19:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355345;
        bh=MuWSN6d9k3a76+0XIDz9vmfjWYJOuzSLm1pEe0R5Mek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TDWKNGAVt2Tl+lC4PlXy+EyRaw6jBFZy0qNCMqvso5+Nhq/QUtqQkQ2S44MS5B3yz
         PUKeTyEUjjEB6rDUiN8cSyDR6drPWqlMLfxJPBuZTV/Ja6Tfwy0fyBUpRs0gxA7KpT
         VEv7oHnmsheqlkfDJJwRbj21D9yRnmIKRbwChgAA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jens Freimann <jfreimann@redhat.com>
Subject: [PATCH 4.19 075/101] virtio: Honour may_reduce_num in vring_create_virtqueue
Date:   Mon, 15 Apr 2019 20:59:13 +0200
Message-Id: <20190415183744.420914642@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cohuck@redhat.com>

commit cf94db21905333e610e479688add629397a4b384 upstream.

vring_create_virtqueue() allows the caller to specify via the
may_reduce_num parameter whether the vring code is allowed to
allocate a smaller ring than specified.

However, the split ring allocation code tries to allocate a
smaller ring on allocation failure regardless of what the
caller specified. This may cause trouble for e.g. virtio-pci
in legacy mode, which does not support ring resizing. (The
packed ring code does not resize in any case.)

Let's fix this by bailing out immediately in the split ring code
if the requested size cannot be allocated and may_reduce_num has
not been specified.

While at it, fix a typo in the usage instructions.

Fixes: 2a2d1382fe9d ("virtio: Add improved queue allocation API")
Cc: stable@vger.kernel.org # v4.6+
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Jens Freimann <jfreimann@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virtio/virtio_ring.c |    2 ++
 include/linux/virtio_ring.h  |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1086,6 +1086,8 @@ struct virtqueue *vring_create_virtqueue
 					  GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 		if (queue)
 			break;
+		if (!may_reduce_num)
+			return NULL;
 	}
 
 	if (!num)
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -63,7 +63,7 @@ struct virtqueue;
 /*
  * Creates a virtqueue and allocates the descriptor ring.  If
  * may_reduce_num is set, then this may allocate a smaller ring than
- * expected.  The caller should query virtqueue_get_ring_size to learn
+ * expected.  The caller should query virtqueue_get_vring_size to learn
  * the actual size of the ring.
  */
 struct virtqueue *vring_create_virtqueue(unsigned int index,


