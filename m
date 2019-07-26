Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645E5C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A73122CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564155035;
	bh=K0NW8k+vUkkJ6hAz7S04FBZH5elkC1pGGaaqnabEz9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y9LoG2cnYgtEeYIOJbhGUKlfa8/HONvP0T2hT4gd+RILnu3eRLenfW33rY1+a7V1Q
	 XshobETwFbI5+H1I1rPKqvDc+oFVAnEXYv1vr4udk06j7dmhn8vPoAh0yj1Ax6Ojuz
	 GtEp/dly/xvofNntfiKLOUObPliFP/QuySdTjbuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389105AbfGZPad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389088AbfGZPab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:30:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8912218D4;
        Fri, 26 Jul 2019 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564155030;
        bh=K0NW8k+vUkkJ6hAz7S04FBZH5elkC1pGGaaqnabEz9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTksjKL3Q6dFqoT9QYlFcs68aC3pozIKcJhwdiOYsX1svDcwCCkARtHqnfRsgtEdJ
         NMkvQ181JBSwvBBKioE8rhM/We5DDubYDb14qiZhWndcuoyzszoWhOTVFVf6hCZIHj
         XBoh7w3laHKkcBZRR3sEHu5SkaiEz+Pkal8MGfwU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aya Levin <ayal@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.1 41/62] net/mlx5e: Fix return value from timeout recover function
Date:   Fri, 26 Jul 2019 17:24:53 +0200
Message-Id: <20190726152306.273886859@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.720139286@linuxfoundation.org>
References: <20190726152301.720139286@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aya Levin <ayal@mellanox.com>

[ Upstream commit 39825350ae2a52f8513741b36e42118bd80dd689 ]

Fix timeout recover function to return a meaningful return value.
When an interrupt was not sent by the FW, return IO error instead of
'true'.

Fixes: c7981bea48fb ("net/mlx5e: Fix return status of TX reporter timeout recover")
Signed-off-by: Aya Levin <ayal@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -142,22 +142,20 @@ static int mlx5e_tx_reporter_timeout_rec
 {
 	struct mlx5_eq_comp *eq = sq->cq.mcq.eq;
 	u32 eqe_count;
-	int ret;
 
 	netdev_err(sq->channel->netdev, "EQ 0x%x: Cons = 0x%x, irqn = 0x%x\n",
 		   eq->core.eqn, eq->core.cons_index, eq->core.irqn);
 
 	eqe_count = mlx5_eq_poll_irq_disabled(eq);
-	ret = eqe_count ? false : true;
 	if (!eqe_count) {
 		clear_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
-		return ret;
+		return -EIO;
 	}
 
 	netdev_err(sq->channel->netdev, "Recover %d eqes on EQ 0x%x\n",
 		   eqe_count, eq->core.eqn);
 	sq->channel->stats->eq_rearm++;
-	return ret;
+	return 0;
 }
 
 int mlx5e_tx_reporter_timeout(struct mlx5e_txqsq *sq)


