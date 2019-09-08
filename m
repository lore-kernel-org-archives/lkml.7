Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDB9C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A75B2081B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946648;
	bh=HM9I2ffD9LQJGexsoxHofaVsblIDD/6Fu2IluB17Fco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k+KrhUTxAnJ5P2pPOzodGLJbJndtRiWhx16cp1hHNbs+t/bA/nJqrWJzFm6M8VgAu
	 arBJrM55dLgvuz+VigCapeUyUWpgELkS6Ns0OPWfBtm0soJV+6L1nGg5zYZQun9FCw
	 GIBwYg17BB41QC3RB9dprgr4qfhi3mnZ/7zqZLo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfIHMoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729665AbfIHMoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:44:05 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B22B32081B;
        Sun,  8 Sep 2019 12:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946644;
        bh=HM9I2ffD9LQJGexsoxHofaVsblIDD/6Fu2IluB17Fco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kaBpULwFupqoa9dQmEIqsJjQfCMzx42P7IxDhUXTtOgY7cyz0KJ/OqXDZI3qyBf1G
         XHZJ0NQrNmkY+cDU+E1XpHGPEt7kpQ6T4K1BFruVhEBisUoXjQCQkdIoWC03hJT1lR
         8n90SHqYU0DAprmr9XIXk+ZMr0Bh7xxuauj35464=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 13/26] IB/mlx4: Fix memory leaks
Date:   Sun,  8 Sep 2019 13:41:52 +0100
Message-Id: <20190908121103.480232305@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121057.216802689@linuxfoundation.org>
References: <20190908121057.216802689@linuxfoundation.org>
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
index d9323d7c479c3..f32ffd74ec476 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -1643,8 +1643,6 @@ tx_err:
 				    tx_buf_size, DMA_TO_DEVICE);
 		kfree(tun_qp->tx_ring[i].buf.addr);
 	}
-	kfree(tun_qp->tx_ring);
-	tun_qp->tx_ring = NULL;
 	i = MLX4_NUM_TUNNEL_BUFS;
 err:
 	while (i > 0) {
@@ -1653,6 +1651,8 @@ err:
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



