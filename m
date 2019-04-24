Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A6AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5164421903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127395;
	bh=DWshPyTanPz7yjHnBj+CVJAmQ0/yMichNX0e+OOO0nQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H8mpoIJ4BAqCp6f6eed9/zT5gn8hoxTRjI7x5J3JNH92nTXenTG+TVGsth90HxDvC
	 Z2L0Krgni3ufk+fFafwnoZtf9QcNWfSIiOZwxBuZiZBk0hwIysofEL2IKp59HR4abt
	 zlQFBs6zdtuZ5F56U1iMh4oub0XIEX7Skhvkyzcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392054AbfDXRgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403903AbfDXRgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:36:25 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C79642054F;
        Wed, 24 Apr 2019 17:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127384;
        bh=DWshPyTanPz7yjHnBj+CVJAmQ0/yMichNX0e+OOO0nQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dCaS9SdFWrUWShaP6D00bO003ns6PzlG7SWyeHag4dYELCRpwhs0OnULC5OjiFyW1
         kbo2DnJdcFQpUk7AHC06njcUvUbSLMQpSk66PGwrGJaE2ZN9UY+w//NKWs7iQ9lqmr
         CcEZXB09f/1R0uUjADIynWAXg67ftybsG0zOjFMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.0 027/115] net/mlx5e: XDP, Avoid checksum complete when XDP prog is loaded
Date:   Wed, 24 Apr 2019 19:09:23 +0200
Message-Id: <20190424170926.629932990@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saeed Mahameed <saeedm@mellanox.com>

[ Upstream commit 5d0bb3bac4b9f6c22280b04545626fdfd99edc6b ]

XDP programs might change packets data contents which will make the
reported skb checksum (checksum complete) invalid.

When XDP programs are loaded/unloaded set/clear rx RQs
MLX5E_RQ_STATE_NO_CSUM_COMPLETE flag.

Fixes: 86994156c736 ("net/mlx5e: XDP fast RX drop bpf programs support")
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c |    3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c    |    6 +++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c      |    3 ++-
 3 files changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1665,7 +1665,8 @@ static int set_pflag_rx_no_csum_complete
 	struct mlx5e_channel *c;
 	int i;
 
-	if (!test_bit(MLX5E_STATE_OPENED, &priv->state))
+	if (!test_bit(MLX5E_STATE_OPENED, &priv->state) ||
+	    priv->channels.params.xdp_prog)
 		return 0;
 
 	for (i = 0; i < channels->num; i++) {
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -950,7 +950,11 @@ static int mlx5e_open_rq(struct mlx5e_ch
 	if (params->rx_dim_enabled)
 		__set_bit(MLX5E_RQ_STATE_AM, &c->rq.state);
 
-	if (MLX5E_GET_PFLAG(params, MLX5E_PFLAG_RX_NO_CSUM_COMPLETE))
+	/* We disable csum_complete when XDP is enabled since
+	 * XDP programs might manipulate packets which will render
+	 * skb->checksum incorrect.
+	 */
+	if (MLX5E_GET_PFLAG(params, MLX5E_PFLAG_RX_NO_CSUM_COMPLETE) || c->xdp)
 		__set_bit(MLX5E_RQ_STATE_NO_CSUM_COMPLETE, &c->rq.state);
 
 	return 0;
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -753,7 +753,8 @@ static inline void mlx5e_handle_csum(str
 		return;
 	}
 
-	if (unlikely(test_bit(MLX5E_RQ_STATE_NO_CSUM_COMPLETE, &rq->state)))
+	/* True when explicitly set via priv flag, or XDP prog is loaded */
+	if (test_bit(MLX5E_RQ_STATE_NO_CSUM_COMPLETE, &rq->state))
 		goto csum_unnecessary;
 
 	/* CQE csum doesn't cover padding octets in short ethernet


