Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ADBC04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D135E217F9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427564;
	bh=jeZ0AcsDyNIgmsDK4DCsbg9/qtGgmB05LsiGMG5X+H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XaYOPPzSP33zWVeTBeZu66k/yhMEyw8CdhKkpb0e2EMNPOaN9L6U8cZx0JWkip2NN
	 +9I7BknCbRpfAqeTFPFuQ11FJbOiJVQZUi01QajiijoqaO3mjzxAdK/fQNfEMClouu
	 4VcWAqZMsy3XpYkndxxwd9LbnifvIwPYaYCgvjh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfEISqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:46:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbfEISqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:46:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 136412183F;
        Thu,  9 May 2019 18:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427560;
        bh=jeZ0AcsDyNIgmsDK4DCsbg9/qtGgmB05LsiGMG5X+H4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NGPvu+qqEmVEUukKxaIOjTnQalJK80+YBjYNz+sp1TiTQR9fz95sBTWL+NOorvbB1
         HJ9+bpNQRnD5jdGZWEG5fr0xA3Q3lxUP6dDVRSKA+y4zBsFDgAo+joPsS3BoI2nQSH
         APOe2Ou7Y1wxGSltGC2wpbngtV9UEPvt77vCNjrc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 27/42] virtio-blk: limit number of hw queues by nr_cpu_ids
Date:   Thu,  9 May 2019 20:42:16 +0200
Message-Id: <20190509181258.110952471@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181252.616018683@linuxfoundation.org>
References: <20190509181252.616018683@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit bf348f9b78d413e75bb079462751a1d86b6de36c ]

When tag_set->nr_maps is 1, the block layer limits the number of hw queues
by nr_cpu_ids. No matter how many hw queues are used by virtio-blk, as it
has (tag_set->nr_maps == 1), it can use at most nr_cpu_ids hw queues.

In addition, specifically for pci scenario, when the 'num-queues' specified
by qemu is more than maxcpus, virtio-blk would not be able to allocate more
than maxcpus vectors in order to have a vector for each queue. As a result,
it falls back into MSI-X with one vector for config and one shared for
queues.

Considering above reasons, this patch limits the number of hw queues used
by virtio-blk by nr_cpu_ids.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/virtio_blk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 68846897d2139..8767401f75e04 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -437,6 +437,8 @@ static int init_vq(struct virtio_blk *vblk)
 	if (err)
 		num_vqs = 1;
 
+	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
+
 	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
 	if (!vblk->vqs)
 		return -ENOMEM;
-- 
2.20.1



