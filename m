Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3409C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC38B2089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380186;
	bh=qmIDS1RUIUlk4PqP13Ji4FuXvckwkFyjkjtsRyDYu4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dIAiMvBuxGkBrrLXMjPHCf0wZ6naEl6T5nlvn00ExPvgjh2FC8ny+jtvR6+v0KRdp
	 Owpn//hmkT7JtjxNI5zNiFw1RcotI4dVOJv1p+hbGZ+Lo8wqLzwPiA4tISKYN5DaEN
	 VhWbz/cQEKT65oYNqNWt8oMm7L5gsjjZ9W2JGyuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbfIMNJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388571AbfIMNJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:09:41 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D611F206BB;
        Fri, 13 Sep 2019 13:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380181;
        bh=qmIDS1RUIUlk4PqP13Ji4FuXvckwkFyjkjtsRyDYu4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ek4Voz31ieF6pI3PW2p9NPczwIDUBaaPehp1dwKS2zyGC4Utd8fhiL9z9UAnKLESK
         hD3cVhKJMYlMKDKcIdKDNsyDIO3WXS4YvBnfoQY+E9ubBaGZzrIlI3peGUcW2aFKSV
         FsWdt9wtJ+qx7MPq8FYj4qfm39HqiS2Lf5+8hkik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tiwei Bie <tiwei.bie@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH 4.9 08/14] vhost/test: fix build for vhost test
Date:   Fri, 13 Sep 2019 14:07:01 +0100
Message-Id: <20190913130445.124834201@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130440.264749443@linuxfoundation.org>
References: <20190913130440.264749443@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiwei Bie <tiwei.bie@intel.com>

commit 264b563b8675771834419057cbe076c1a41fb666 upstream.

Since vhost_exceeds_weight() was introduced, callers need to specify
the packet weight and byte weight in vhost_dev_init(). Note that, the
packet weight isn't counted in this patch to keep the original behavior
unchanged.

Fixes: e82b9b0727ff ("vhost: introduce vhost_exceeds_weight()")
Cc: stable@vger.kernel.org
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/vhost/test.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -23,6 +23,12 @@
  * Using this limit prevents one virtqueue from starving others. */
 #define VHOST_TEST_WEIGHT 0x80000
 
+/* Max number of packets transferred before requeueing the job.
+ * Using this limit prevents one virtqueue from starving others with
+ * pkts.
+ */
+#define VHOST_TEST_PKT_WEIGHT 256
+
 enum {
 	VHOST_TEST_VQ = 0,
 	VHOST_TEST_VQ_MAX = 1,
@@ -81,10 +87,8 @@ static void handle_vq(struct vhost_test
 		}
 		vhost_add_used_and_signal(&n->dev, vq, head, 0);
 		total_len += len;
-		if (unlikely(total_len >= VHOST_TEST_WEIGHT)) {
-			vhost_poll_queue(&vq->poll);
+		if (unlikely(vhost_exceeds_weight(vq, 0, total_len)))
 			break;
-		}
 	}
 
 	mutex_unlock(&vq->mutex);
@@ -116,7 +120,8 @@ static int vhost_test_open(struct inode
 	dev = &n->dev;
 	vqs[VHOST_TEST_VQ] = &n->vqs[VHOST_TEST_VQ];
 	n->vqs[VHOST_TEST_VQ].handle_kick = handle_vq_kick;
-	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX);
+	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX,
+		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT);
 
 	f->private_data = n;
 


