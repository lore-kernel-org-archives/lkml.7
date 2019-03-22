Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738EFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350352075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259643;
	bh=N4O/7PxreP7ZpVqk/9PpC6mT2DIdQzNcjQxNqNM5p00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=09NZeNor1hWvY2moX4gRYxHh/oJidlJB8VS98mBdxZvLZx+2+oJxVhC82Scs5nqce
	 piUP118Qx1jGN2zR1rfQlBn42xXoowKKySsWnbouo8gmjYaigtIZAIdi4yL5LHwpE5
	 1vsAjEOYOb70g+9n1nBWIG/6ZXK+hjRL/CTj9+Fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731987AbfCVNAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731551AbfCVLn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:43:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65468204FD;
        Fri, 22 Mar 2019 11:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255036;
        bh=N4O/7PxreP7ZpVqk/9PpC6mT2DIdQzNcjQxNqNM5p00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aO79Ar6UJeui4OutiJxPhQmmeREjqGf0g+OOLQMSFYTQ4HZ3wOJce3T9IuCs26rQd
         DNnbeX+AoeN3hkHmBZrq2fhjV80suUik3RlZ71vdEYpWhkZMIAF23SEP89uELI+j6M
         pVuXzt9urn9kGlBeG53kLshTmsYDkpvjV4XQroos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.9 059/118] s390/virtio: handle find on invalid queue gracefully
Date:   Fri, 22 Mar 2019 12:15:31 +0100
Message-Id: <20190322111220.713821771@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Halil Pasic <pasic@linux.ibm.com>

commit 3438b2c039b4bf26881786a1f3450f016d66ad11 upstream.

A queue with a capacity of zero is clearly not a valid virtio queue.
Some emulators report zero queue size if queried with an invalid queue
index. Instead of crashing in this case let us just return -ENOENT. To
make that work properly, let us fix the notifier cleanup logic as well.

Cc: stable@vger.kernel.org
Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/virtio/virtio_ccw.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -283,6 +283,8 @@ static void virtio_ccw_drop_indicators(s
 {
 	struct virtio_ccw_vq_info *info;
 
+	if (!vcdev->airq_info)
+		return;
 	list_for_each_entry(info, &vcdev->virtqueues, node)
 		drop_airq_indicator(info->vq, vcdev->airq_info);
 }
@@ -424,7 +426,7 @@ static int virtio_ccw_read_vq_conf(struc
 	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_READ_VQ_CONF);
 	if (ret)
 		return ret;
-	return vcdev->config_block->num;
+	return vcdev->config_block->num ?: -ENOENT;
 }
 
 static void virtio_ccw_del_vq(struct virtqueue *vq, struct ccw1 *ccw)


