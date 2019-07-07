Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A3BC48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 19:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BAB20659
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 19:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfGGTl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 15:41:26 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:57784 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727638AbfGGTiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 15:38:15 -0400
Received: from 94.197.121.43.threembb.co.uk ([94.197.121.43] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hkCzC-0006jV-FK; Sun, 07 Jul 2019 20:38:10 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hkCz8-0005ei-02; Sun, 07 Jul 2019 20:38:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Cornelia Huck" <cohuck@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Halil Pasic" <pasic@linux.ibm.com>
Date:   Sun, 07 Jul 2019 17:54:17 +0100
Message-ID: <lsq.1562518457.786680482@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 104/129] s390/virtio: handle find on invalid queue
 gracefully
In-Reply-To: <lsq.1562518456.876074874@decadent.org.uk>
X-SA-Exim-Connect-IP: 94.197.121.43
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.70-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Halil Pasic <pasic@linux.ibm.com>

commit 3438b2c039b4bf26881786a1f3450f016d66ad11 upstream.

A queue with a capacity of zero is clearly not a valid virtio queue.
Some emulators report zero queue size if queried with an invalid queue
index. Instead of crashing in this case let us just return -ENOENT. To
make that work properly, let us fix the notifier cleanup logic as well.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/kvm/virtio_ccw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -258,6 +258,8 @@ static void virtio_ccw_drop_indicators(s
 {
 	struct virtio_ccw_vq_info *info;
 
+	if (!vcdev->airq_info)
+		return;
 	list_for_each_entry(info, &vcdev->virtqueues, node)
 		drop_airq_indicator(info->vq, vcdev->airq_info);
 }
@@ -386,7 +388,7 @@ static int virtio_ccw_read_vq_conf(struc
 	ccw->count = sizeof(struct vq_config_block);
 	ccw->cda = (__u32)(unsigned long)(vcdev->config_block);
 	ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_READ_VQ_CONF);
-	return vcdev->config_block->num;
+	return vcdev->config_block->num ?: -ENOENT;
 }
 
 static void virtio_ccw_del_vq(struct virtqueue *vq, struct ccw1 *ccw)

