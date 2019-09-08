Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB2BC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24F621920
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947005;
	bh=3xjWE/CDpSvOEYtD7JEvHbVT4suqGXx9Vnx3kvvBiMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=isGhsIlUQUG+I9dYh1SOncZlBm0kaeDsBnSkB3nhoURgsfBOQR3qWjN1L9eJgm0T1
	 bDqU8pPiuSRoCnFAcFIgB8Alquku52asQUwtVTIPyS9UawaNa5csqBgS7fBC6awPCs
	 rSP1/Fk67KZT52fN+NH+Gr6fJ2CxW6zxeFpIRRyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbfIHMuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731900AbfIHMuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:50:01 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97EC721920;
        Sun,  8 Sep 2019 12:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947001;
        bh=3xjWE/CDpSvOEYtD7JEvHbVT4suqGXx9Vnx3kvvBiMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zLgvVGoQi1wjl6Kw5/ZOeBlOfsIBudylTrupU8ak0Wp2OAl93BAiMKDrgWj4EyS3N
         9X3ZrTCONKgvGgu4ZJHWIuBHB9LZJG6Bz/H428M1p9iDx/R8pt+DhXTkenUh4tEsm0
         e/qgACV6Z+E3vSAnv/X0zvok9hHZeW5pduoyhxr8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aya Levin <ayal@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 24/94] net/mlx5e: Fix error flow of CQE recovery on tx reporter
Date:   Sun,  8 Sep 2019 13:41:20 +0100
Message-Id: <20190908121151.131522925@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 276d197e70bcc47153592f4384675b51c7d83aba ]

CQE recovery function begins with test and set of recovery bit. Add an
error flow which ensures clearing of this bit when leaving the recovery
function, to allow further recoveries to take place. This allows removal
of clearing recovery bit on sq activate.

Fixes: de8650a82071 ("net/mlx5e: Add tx reporter support")
Signed-off-by: Aya Levin <ayal@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/en/reporter_tx.c | 12 ++++++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c    |  1 -
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index c1caf14bc3346..c7f86453c6384 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -80,17 +80,17 @@ static int mlx5e_tx_reporter_err_cqe_recover(struct mlx5e_txqsq *sq)
 	if (err) {
 		netdev_err(dev, "Failed to query SQ 0x%x state. err = %d\n",
 			   sq->sqn, err);
-		return err;
+		goto out;
 	}
 
 	if (state != MLX5_SQC_STATE_ERR)
-		return 0;
+		goto out;
 
 	mlx5e_tx_disable_queue(sq->txq);
 
 	err = mlx5e_wait_for_sq_flush(sq);
 	if (err)
-		return err;
+		goto out;
 
 	/* At this point, no new packets will arrive from the stack as TXQ is
 	 * marked with QUEUE_STATE_DRV_XOFF. In addition, NAPI cleared all
@@ -99,13 +99,17 @@ static int mlx5e_tx_reporter_err_cqe_recover(struct mlx5e_txqsq *sq)
 
 	err = mlx5e_sq_to_ready(sq, state);
 	if (err)
-		return err;
+		goto out;
 
 	mlx5e_reset_txqsq_cc_pc(sq);
 	sq->stats->recover++;
+	clear_bit(MLX5E_SQ_STATE_RECOVERING, &sq->state);
 	mlx5e_activate_txqsq(sq);
 
 	return 0;
+out:
+	clear_bit(MLX5E_SQ_STATE_RECOVERING, &sq->state);
+	return err;
 }
 
 static int mlx5_tx_health_report(struct devlink_health_reporter *tx_reporter,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 882d26b8095da..bbdfdaf06391a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1279,7 +1279,6 @@ err_free_txqsq:
 void mlx5e_activate_txqsq(struct mlx5e_txqsq *sq)
 {
 	sq->txq = netdev_get_tx_queue(sq->channel->netdev, sq->txq_ix);
-	clear_bit(MLX5E_SQ_STATE_RECOVERING, &sq->state);
 	set_bit(MLX5E_SQ_STATE_ENABLED, &sq->state);
 	netdev_tx_reset_queue(sq->txq);
 	netif_tx_start_queue(sq->txq);
-- 
2.20.1



