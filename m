Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABDBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05F920879
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582384;
	bh=l69Nk4WVANOK1f5I+7ly/G7QnJMc5TiEO5alnkUNxD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D/jq6vX7SyY0l/bkdfgmJbO9AxOGqZljGw3P/zz/SZpdc2dsV6a5qA38bfWIG80T9
	 HdyfKv9PDE6hElQkxfHP+iSjdcPiJZEfFtgSSo8C7KNJ6ZhjUcwdToe9HeqCNCRr1Q
	 TmB1bdk2jdJY6bH4Ryk4XOaQM745eNLFU0/JhZLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732742AbfCZGjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:39:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732731AbfCZGjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:39:40 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB5E120879;
        Tue, 26 Mar 2019 06:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582379;
        bh=l69Nk4WVANOK1f5I+7ly/G7QnJMc5TiEO5alnkUNxD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AyTo/0UImWFzkdFoaqcePpTXLMQi32f2i69Rp75Bh1UfZI9+1XQ/PI3JF22uYlT5m
         OxWUf68eUarxXUXlYShlQnxlxXVmMErsMt3D0xW/RRBVtl9uIJEVlw3FLWSmcOua04
         S/CbgnRt5rzpM8LNNOe7K9C0ysipNAmsGhOtmtGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.0 19/52] net/mlx5: Fix DCT creation bad flow
Date:   Tue, 26 Mar 2019 15:30:06 +0900
Message-Id: <20190326042701.880117127@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
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

From: Yishai Hadas <yishaih@mellanox.com>

commit f84b66b9cce78e8f9d38204fdaa75f07c75f4911 upstream.

In case the DCT creation command has succeeded a DRAIN must be issued
before calling DESTROY.

In addition, the original code used the wrong parameter for the DESTROY
command, 'in' instead of 'din', which caused another creation try instead
of destroying.

Cc: <stable@vger.kernel.org> # 4.15
Fixes: 57cda166bbe0 ("net/mlx5: Add DCT command interface")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/mellanox/mlx5/core/qp.c |   66 ++++++++++++++-------------
 1 file changed, 36 insertions(+), 30 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/qp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/qp.c
@@ -40,6 +40,9 @@
 #include "mlx5_core.h"
 #include "lib/eq.h"
 
+static int mlx5_core_drain_dct(struct mlx5_core_dev *dev,
+			       struct mlx5_core_dct *dct);
+
 static struct mlx5_core_rsc_common *
 mlx5_get_rsc(struct mlx5_qp_table *table, u32 rsn)
 {
@@ -227,13 +230,42 @@ static void destroy_resource_common(stru
 	wait_for_completion(&qp->common.free);
 }
 
+static int _mlx5_core_destroy_dct(struct mlx5_core_dev *dev,
+				  struct mlx5_core_dct *dct, bool need_cleanup)
+{
+	u32 out[MLX5_ST_SZ_DW(destroy_dct_out)] = {0};
+	u32 in[MLX5_ST_SZ_DW(destroy_dct_in)]   = {0};
+	struct mlx5_core_qp *qp = &dct->mqp;
+	int err;
+
+	err = mlx5_core_drain_dct(dev, dct);
+	if (err) {
+		if (dev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR) {
+			goto destroy;
+		} else {
+			mlx5_core_warn(
+				dev, "failed drain DCT 0x%x with error 0x%x\n",
+				qp->qpn, err);
+			return err;
+		}
+	}
+	wait_for_completion(&dct->drained);
+destroy:
+	if (need_cleanup)
+		destroy_resource_common(dev, &dct->mqp);
+	MLX5_SET(destroy_dct_in, in, opcode, MLX5_CMD_OP_DESTROY_DCT);
+	MLX5_SET(destroy_dct_in, in, dctn, qp->qpn);
+	MLX5_SET(destroy_dct_in, in, uid, qp->uid);
+	err = mlx5_cmd_exec(dev, (void *)&in, sizeof(in),
+			    (void *)&out, sizeof(out));
+	return err;
+}
+
 int mlx5_core_create_dct(struct mlx5_core_dev *dev,
 			 struct mlx5_core_dct *dct,
 			 u32 *in, int inlen)
 {
 	u32 out[MLX5_ST_SZ_DW(create_dct_out)]   = {0};
-	u32 din[MLX5_ST_SZ_DW(destroy_dct_in)]   = {0};
-	u32 dout[MLX5_ST_SZ_DW(destroy_dct_out)] = {0};
 	struct mlx5_core_qp *qp = &dct->mqp;
 	int err;
 
@@ -254,11 +286,7 @@ int mlx5_core_create_dct(struct mlx5_cor
 
 	return 0;
 err_cmd:
-	MLX5_SET(destroy_dct_in, din, opcode, MLX5_CMD_OP_DESTROY_DCT);
-	MLX5_SET(destroy_dct_in, din, dctn, qp->qpn);
-	MLX5_SET(destroy_dct_in, din, uid, qp->uid);
-	mlx5_cmd_exec(dev, (void *)&in, sizeof(din),
-		      (void *)&out, sizeof(dout));
+	_mlx5_core_destroy_dct(dev, dct, false);
 	return err;
 }
 EXPORT_SYMBOL_GPL(mlx5_core_create_dct);
@@ -323,29 +351,7 @@ static int mlx5_core_drain_dct(struct ml
 int mlx5_core_destroy_dct(struct mlx5_core_dev *dev,
 			  struct mlx5_core_dct *dct)
 {
-	u32 out[MLX5_ST_SZ_DW(destroy_dct_out)] = {0};
-	u32 in[MLX5_ST_SZ_DW(destroy_dct_in)]   = {0};
-	struct mlx5_core_qp *qp = &dct->mqp;
-	int err;
-
-	err = mlx5_core_drain_dct(dev, dct);
-	if (err) {
-		if (dev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR) {
-			goto destroy;
-		} else {
-			mlx5_core_warn(dev, "failed drain DCT 0x%x with error 0x%x\n", qp->qpn, err);
-			return err;
-		}
-	}
-	wait_for_completion(&dct->drained);
-destroy:
-	destroy_resource_common(dev, &dct->mqp);
-	MLX5_SET(destroy_dct_in, in, opcode, MLX5_CMD_OP_DESTROY_DCT);
-	MLX5_SET(destroy_dct_in, in, dctn, qp->qpn);
-	MLX5_SET(destroy_dct_in, in, uid, qp->uid);
-	err = mlx5_cmd_exec(dev, (void *)&in, sizeof(in),
-			    (void *)&out, sizeof(out));
-	return err;
+	return _mlx5_core_destroy_dct(dev, dct, true);
 }
 EXPORT_SYMBOL_GPL(mlx5_core_destroy_dct);
 


