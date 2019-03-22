Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85366C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498B72083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256930;
	bh=gHGntNJt/stXc4iHKNLnLM8N0sWEFi1C81vGv30TzVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z+K5Ass8Jh+gm35t7az+jTJCe+3tUXpWoCLYBTif2IlBw6h2uo5ol9O3lgF6uhFK6
	 ayR7uksij86s337R1L8NbaEDl0I7hLO8BPwDB/QQwHetY8ylrNKDHdDVUE/XlkSAvx
	 exgl1Q1zpqN+PI61KRvCNPYmpDUZ+ERIBHv2wPJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390071AbfCVMP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:15:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390061AbfCVMP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:15:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C43D2082C;
        Fri, 22 Mar 2019 12:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256925;
        bh=gHGntNJt/stXc4iHKNLnLM8N0sWEFi1C81vGv30TzVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hpBwJDPuzl80qjBkN9pj6JJ+/ZDM+1MDzHB5b5JeGrYGqWkJ/ezdT3BivvVmCzm8s
         2WcrNg+tBAEFRFN1KnypX+qnF66OhmXkrSgNwk7ffl79xh3gWDP9am3Tnxt6fdqGSK
         8KKzRAXgCKvhliMM+4pZS/H6JrqElb+7cY9kANSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 5.0 078/238] s390/virtio: handle find on invalid queue gracefully
Date:   Fri, 22 Mar 2019 12:14:57 +0100
Message-Id: <20190322111303.204758711@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -272,6 +272,8 @@ static void virtio_ccw_drop_indicators(s
 {
 	struct virtio_ccw_vq_info *info;
 
+	if (!vcdev->airq_info)
+		return;
 	list_for_each_entry(info, &vcdev->virtqueues, node)
 		drop_airq_indicator(info->vq, vcdev->airq_info);
 }
@@ -413,7 +415,7 @@ static int virtio_ccw_read_vq_conf(struc
 	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_READ_VQ_CONF);
 	if (ret)
 		return ret;
-	return vcdev->config_block->num;
+	return vcdev->config_block->num ?: -ENOENT;
 }
 
 static void virtio_ccw_del_vq(struct virtqueue *vq, struct ccw1 *ccw)


