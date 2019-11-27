Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B91EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D898220869
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890737;
	bh=/3L86ahHxWFk9TwhhR+R4fiBFcsOQCKIJhLpCrEHvCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P+e+y/quNUcWJRjZoBppZs70NxvV0sAba4T1evMxYzYN+eMfA65ienhVK38HCXQO/
	 L9Kfp7Bvdr5x78yuOFEXm8k+8gXjib8K3CLrmBMY8xT5vltq6sneRxxDBshOc05009
	 P3xfxOZsBgjw2y1XcfO8wo9U+w0cFmG3ndbMU4v4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbfK0Vi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:38:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:55146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbfK0Uo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:44:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC5DF2178F;
        Wed, 27 Nov 2019 20:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887499;
        bh=/3L86ahHxWFk9TwhhR+R4fiBFcsOQCKIJhLpCrEHvCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w5t1ggNTlPqnzd5ARqJdgKRixGiiNuflQr49CVBkMKsImKHleeBwFLHOvokwsHUVl
         01HIclFjYzXuuaIkYIuF0oG4qG5UZtLYl2a6G6WGFSnjAKYYKpEWPBzrzbXyDFPRgG
         cmzQCg7BywC1KCa79uNIc+0octLbFV+Q1f8/iYJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Michael Mueller <mimu@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 135/151] virtio_ring: fix return code on DMA mapping fails
Date:   Wed, 27 Nov 2019 21:31:58 +0100
Message-Id: <20191127203046.747863171@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Halil Pasic <pasic@linux.ibm.com>

[ Upstream commit f7728002c1c7bfa787b276a31c3ef458739b8e7c ]

Commit 780bc7903a32 ("virtio_ring: Support DMA APIs")  makes
virtqueue_add() return -EIO when we fail to map our I/O buffers. This is
a very realistic scenario for guests with encrypted memory, as swiotlb
may run out of space, depending on it's size and the I/O load.

The virtio-blk driver interprets -EIO form virtqueue_add() as an IO
error, despite the fact that swiotlb full is in absence of bugs a
recoverable condition.

Let us change the return code to -ENOMEM, and make the block layer
recover form these failures when virtio-blk encounters the condition
described above.

Cc: stable@vger.kernel.org
Fixes: 780bc7903a32 ("virtio_ring: Support DMA APIs")
Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2f09294c59460..e459cd7302e27 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -427,7 +427,7 @@ unmap_release:
 		kfree(desc);
 
 	END_USE(vq);
-	return -EIO;
+	return -ENOMEM;
 }
 
 /**
-- 
2.20.1



