Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5497C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD4A20818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919892;
	bh=oIQEaM9ehbUGjQp2n7XmPHer5wa2e7e8ImVmL2y+yzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qJ3c7Yhii9QA3h+RkOze6j4n3dr5Qhxlp1WFwgUWkeA8Q4Xga3p8z1WLZtVfWPgnk
	 hsaoObtag5o67RP/ZXa0LHWl57JCp/dC4S3ogXzb21YLBIHCvZWG7+ghwV1aYcqyrx
	 Zr9Y/7LjMdph+mpCDvt7ocfoiTQdTUIvB36NmXKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732608AbfEOLbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731386AbfEOLb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:31:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B34EE20818;
        Wed, 15 May 2019 11:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919889;
        bh=oIQEaM9ehbUGjQp2n7XmPHer5wa2e7e8ImVmL2y+yzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4KBKLSrNRZjSq8tND2BrWyA4cuhsiDY/TCITx3AyM+fGuQMI39lIQ95OVZHDVYCK
         wJDYN4UN6tE1i25IPk5CryqmMQu22+TBNsAYMjZF0mhXoHS0cdXXJYOkzcN/xVxkE0
         uDdawZuPnJb/D1Ixzb7Kz+zf7fiikzPBv3BoR55k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH 5.0 133/137] virtio_ring: Fix potential mem leak in virtqueue_add_indirect_packed
Date:   Wed, 15 May 2019 12:56:54 +0200
Message-Id: <20190515090703.537212784@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

commit df0bfe7501e9319546ea380d39674a4179e059c3 upstream.

'desc' should be freed before leaving from err handing path.

Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virtio/virtio_ring.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -993,6 +993,7 @@ static int virtqueue_add_indirect_packed
 
 	if (unlikely(vq->vq.num_free < 1)) {
 		pr_debug("Can't add buf len 1 - avail = 0\n");
+		kfree(desc);
 		END_USE(vq);
 		return -ENOSPC;
 	}


