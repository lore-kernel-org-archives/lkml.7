Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE310C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD25D2082C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947447;
	bh=8svUIhnehzzECOzI2oNIKP/CjJxUGqIVc4hLamT4NC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s/mXud90qe76wY9UF3lxAzWmedB5qMQGtOZ0adCLC+Xmw179ud/pMDq7nSUaiV7HK
	 t/TWUkoDzEvXS6UbsQm5Z5Q5D41iKPjSYLXeZJ5dJyLZqk9AOSt2Oc1NOJpC3uvbwg
	 L1/ejnjE5iIDj6+9ibcGZ5jh125yahOIaQAPYxX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfIHM50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730985AbfIHMsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:48:22 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7022B2190F;
        Sun,  8 Sep 2019 12:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946902;
        bh=8svUIhnehzzECOzI2oNIKP/CjJxUGqIVc4hLamT4NC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k7KhGZ0ZrzoznRRSvlezVlNBUJ39nKwXScAEpXUqcf2MFvvEX2p6I44KMD1OY61CL
         yYe0Gg1dIuDK8Sa2J/u/sAMqmyx1oJ4qkdC90J7EFuSnof3cOHq1IK45bBRpZDDS82
         shYZ16x1rPVGtfOUqwmQ0MCPUinrDcnVNg9Klqao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 44/57] IB/mlx4: Fix memory leaks
Date:   Sun,  8 Sep 2019 13:42:08 +0100
Message-Id: <20190908121145.131812089@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121125.608195329@linuxfoundation.org>
References: <20190908121125.608195329@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5c1baaa82cea2c815a5180ded402a7cd455d1810 ]

In mlx4_ib_alloc_pv_bufs(), 'tun_qp->tx_ring' is allocated through
kcalloc(). However, it is not always deallocated in the following execution
if an error occurs, leading to memory leaks. To fix this issue, free
'tun_qp->tx_ring' whenever an error occurs.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Acked-by: Leon Romanovsky <leonro@mellanox.com>
Link: https://lore.kernel.org/r/1566159781-4642-1-git-send-email-wenwen@cs.uga.edu
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx4/mad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index e5466d786bb1e..5aaa2a6c431b6 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -1668,8 +1668,6 @@ tx_err:
 				    tx_buf_size, DMA_TO_DEVICE);
 		kfree(tun_qp->tx_ring[i].buf.addr);
 	}
-	kfree(tun_qp->tx_ring);
-	tun_qp->tx_ring = NULL;
 	i = MLX4_NUM_TUNNEL_BUFS;
 err:
 	while (i > 0) {
@@ -1678,6 +1676,8 @@ err:
 				    rx_buf_size, DMA_FROM_DEVICE);
 		kfree(tun_qp->ring[i].addr);
 	}
+	kfree(tun_qp->tx_ring);
+	tun_qp->tx_ring = NULL;
 	kfree(tun_qp->ring);
 	tun_qp->ring = NULL;
 	return -ENOMEM;
-- 
2.20.1



