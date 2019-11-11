Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0110FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C988320818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498404;
	bh=64P3u1I9IYWoIH5xLvh5UpOW0F2thnlvtB9s/Seq0yU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0aVzxJhLbrlk1ctyvtYSgiAz1JX8bMWosMM+6ehjx+fyvzylav/ilvjMoIS7lMq1H
	 6iB23JZeKE1KMvQEtjpiWfKgfF+AjHUOEp8rqv2ljJJGLla64ZKoIPx7MFJhl4fDX0
	 KjAyQBK4XR62F+dWhoYIe4/QKzHPgsb6ahQx9mU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfKKSxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:53:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729782AbfKKSxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:53:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2B60204EC;
        Mon, 11 Nov 2019 18:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498398;
        bh=64P3u1I9IYWoIH5xLvh5UpOW0F2thnlvtB9s/Seq0yU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dhEkc+RipZHZ42UisXDEWRMYo1uZFsNofM4mjTtc9QgJzPJC+B32NVxPED59VC+9r
         LPI+dS+/a9MxlLkHqVQoJfl95tBzsYk8vlUrCEMBOOBrC+VkQdc2FPAu1GWCOIlG+G
         C9DVIDqs1LVv5ynAX+ZYUystqHh7hiPZ2j/g7HGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 106/193] net/mlx5e: TX, Fix consumer index of error cqe dump
Date:   Mon, 11 Nov 2019 19:28:08 +0100
Message-Id: <20191111181508.948427516@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tariq Toukan <tariqt@mellanox.com>

[ Upstream commit 61ea02d2c13106116c6e4916ac5d9dd41151c959 ]

The completion queue consumer index increments upon a call to
mlx5_cqwq_pop().
When dumping an error CQE, the index is already incremented.
Decrease one for the print command.

Fixes: 16cc14d81733 ("net/mlx5e: Dump xmit error completions")
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 4eebf7946aca1..d5d2b1af3dbcc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -404,7 +404,10 @@ netdev_tx_t mlx5e_xmit(struct sk_buff *skb, struct net_device *dev)
 static void mlx5e_dump_error_cqe(struct mlx5e_txqsq *sq,
 				 struct mlx5_err_cqe *err_cqe)
 {
-	u32 ci = mlx5_cqwq_get_ci(&sq->cq.wq);
+	struct mlx5_cqwq *wq = &sq->cq.wq;
+	u32 ci;
+
+	ci = mlx5_cqwq_ctr2ix(wq, wq->cc - 1);
 
 	netdev_err(sq->channel->netdev,
 		   "Error cqe on cqn 0x%x, ci 0x%x, sqn 0x%x, opcode 0x%x, syndrome 0x%x, vendor syndrome 0x%x\n",
-- 
2.20.1



