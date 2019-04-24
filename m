Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B59CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAC12148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128221;
	bh=9YyNmXdL+K5Hjf73e7LqoccMK22hsKc0hgo/nNom030=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u4+IZDANxSupzGc0UyDH4xES7PettkUvgqyUrScopEvX24fy6YhMUm9vUgiK8Xvz8
	 ixP+OGCxrday1coOrVwo0oDckWp0L1r0gt6+7EqzBX5ExmzDu8IcDTzxHuV5w3GyLl
	 JMs3vwZH6YpDYeDdgHqGCdRBztDsSQ/T71thnoKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390876AbfDXR3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:29:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390853AbfDXR3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:29:45 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A2D321904;
        Wed, 24 Apr 2019 17:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126983;
        bh=9YyNmXdL+K5Hjf73e7LqoccMK22hsKc0hgo/nNom030=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MoJufxRpYftoK67xiy2I/RE6OBE7Shm9NN7aDJJKMSEJRB9ACKjDluJ/Y7iay6LdO
         qG4TvHQ2j9qY8i9cIUouDqJJ+TsuqPH0qVodhRMsY5GnklTzoCWrYwp1C7kTTK+mHt
         jJbQhsoPUePvck7Fk4luGRVv2sEHsBrMZbQEzXCc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 18/96] net/mlx5: FPGA, tls, idr remove on flow delete
Date:   Wed, 24 Apr 2019 19:09:23 +0200
Message-Id: <20190424170921.023712698@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saeed Mahameed <saeedm@mellanox.com>

[ Upstream commit df3a8344d404a810b4aadbf19b08c8232fbaa715 ]

Flow is kfreed on mlx5_fpga_tls_del_flow but kept in the idr data
structure, this is risky and can cause use-after-free, since the
idr_remove is delayed until tls_send_teardown_cmd completion.

Instead of delaying idr_remove, in this patch we do it on
mlx5_fpga_tls_del_flow, before actually kfree(flow).

Added synchronize_rcu before kfree(flow)

Fixes: ab412e1dd7db ("net/mlx5: Accel, add TLS rx offload routines")
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c |   43 +++++++--------------
 1 file changed, 15 insertions(+), 28 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
@@ -148,14 +148,16 @@ static int mlx5_fpga_tls_alloc_swid(stru
 	return ret;
 }
 
-static void mlx5_fpga_tls_release_swid(struct idr *idr,
-				       spinlock_t *idr_spinlock, u32 swid)
+static void *mlx5_fpga_tls_release_swid(struct idr *idr,
+					spinlock_t *idr_spinlock, u32 swid)
 {
 	unsigned long flags;
+	void *ptr;
 
 	spin_lock_irqsave(idr_spinlock, flags);
-	idr_remove(idr, swid);
+	ptr = idr_remove(idr, swid);
 	spin_unlock_irqrestore(idr_spinlock, flags);
+	return ptr;
 }
 
 static void mlx_tls_kfree_complete(struct mlx5_fpga_conn *conn,
@@ -165,20 +167,12 @@ static void mlx_tls_kfree_complete(struc
 	kfree(buf);
 }
 
-struct mlx5_teardown_stream_context {
-	struct mlx5_fpga_tls_command_context cmd;
-	u32 swid;
-};
-
 static void
 mlx5_fpga_tls_teardown_completion(struct mlx5_fpga_conn *conn,
 				  struct mlx5_fpga_device *fdev,
 				  struct mlx5_fpga_tls_command_context *cmd,
 				  struct mlx5_fpga_dma_buf *resp)
 {
-	struct mlx5_teardown_stream_context *ctx =
-		    container_of(cmd, struct mlx5_teardown_stream_context, cmd);
-
 	if (resp) {
 		u32 syndrome = MLX5_GET(tls_resp, resp->sg[0].data, syndrome);
 
@@ -186,14 +180,6 @@ mlx5_fpga_tls_teardown_completion(struct
 			mlx5_fpga_err(fdev,
 				      "Teardown stream failed with syndrome = %d",
 				      syndrome);
-		else if (MLX5_GET(tls_cmd, cmd->buf.sg[0].data, direction_sx))
-			mlx5_fpga_tls_release_swid(&fdev->tls->tx_idr,
-						   &fdev->tls->tx_idr_spinlock,
-						   ctx->swid);
-		else
-			mlx5_fpga_tls_release_swid(&fdev->tls->rx_idr,
-						   &fdev->tls->rx_idr_spinlock,
-						   ctx->swid);
 	}
 	mlx5_fpga_tls_put_command_ctx(cmd);
 }
@@ -253,7 +239,7 @@ int mlx5_fpga_tls_resync_rx(struct mlx5_
 static void mlx5_fpga_tls_send_teardown_cmd(struct mlx5_core_dev *mdev,
 					    void *flow, u32 swid, gfp_t flags)
 {
-	struct mlx5_teardown_stream_context *ctx;
+	struct mlx5_fpga_tls_command_context *ctx;
 	struct mlx5_fpga_dma_buf *buf;
 	void *cmd;
 
@@ -261,7 +247,7 @@ static void mlx5_fpga_tls_send_teardown_
 	if (!ctx)
 		return;
 
-	buf = &ctx->cmd.buf;
+	buf = &ctx->buf;
 	cmd = (ctx + 1);
 	MLX5_SET(tls_cmd, cmd, command_type, CMD_TEARDOWN_STREAM);
 	MLX5_SET(tls_cmd, cmd, swid, swid);
@@ -272,8 +258,7 @@ static void mlx5_fpga_tls_send_teardown_
 	buf->sg[0].data = cmd;
 	buf->sg[0].size = MLX5_TLS_COMMAND_SIZE;
 
-	ctx->swid = swid;
-	mlx5_fpga_tls_cmd_send(mdev->fpga, &ctx->cmd,
+	mlx5_fpga_tls_cmd_send(mdev->fpga, ctx,
 			       mlx5_fpga_tls_teardown_completion);
 }
 
@@ -283,13 +268,14 @@ void mlx5_fpga_tls_del_flow(struct mlx5_
 	struct mlx5_fpga_tls *tls = mdev->fpga->tls;
 	void *flow;
 
-	rcu_read_lock();
 	if (direction_sx)
-		flow = idr_find(&tls->tx_idr, swid);
+		flow = mlx5_fpga_tls_release_swid(&tls->tx_idr,
+						  &tls->tx_idr_spinlock,
+						  swid);
 	else
-		flow = idr_find(&tls->rx_idr, swid);
-
-	rcu_read_unlock();
+		flow = mlx5_fpga_tls_release_swid(&tls->rx_idr,
+						  &tls->rx_idr_spinlock,
+						  swid);
 
 	if (!flow) {
 		mlx5_fpga_err(mdev->fpga, "No flow information for swid %u\n",
@@ -297,6 +283,7 @@ void mlx5_fpga_tls_del_flow(struct mlx5_
 		return;
 	}
 
+	synchronize_rcu(); /* before kfree(flow) */
 	mlx5_fpga_tls_send_teardown_cmd(mdev, flow, swid, flags);
 }
 


