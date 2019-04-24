Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77324C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EE621901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116796;
	bh=JznK8yfehFSu1q9yF6oJNADqIKwcHxYt1SCzpGdLLxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yw9INx+rHT9M/cGyQ+djUrOA/fHEhUfgmjPFUNwooXln06xHFhmHn7Ki9DyTxMu6T
	 wGYdWO9otWa1Snpxp4PECAjPhwyLwcsG15XVNDmx1x+YcIhTV9tkc03oPqpJcwI7qw
	 CfbWrShNIk/0/x00V6LVfdbYhdnKJGjHfA6Hm8xk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbfDXOjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:39:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731064AbfDXOjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:39:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4472E218FE;
        Wed, 24 Apr 2019 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116792;
        bh=JznK8yfehFSu1q9yF6oJNADqIKwcHxYt1SCzpGdLLxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vg6NBYh9bLz7nNEX2I5kK/nyjxv9nf0E1B/FR4HGYAtaBKRWDu/IPaOJyokrM4Skb
         2lESVhKc1AeQQ4Gp7raXv2etsp/2b95DIw62cbA3xPxzdal0j1Yu7GZ/s/EB4V2Cl8
         sWUAYqVIeTFNvS4219MTQBcowlii8KTkmnN0OKPg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Omri Kahalon <omrik@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 17/52] net/mlx5: E-Switch, Fix esw manager vport indication for more vport commands
Date:   Wed, 24 Apr 2019 10:38:35 -0400
Message-Id: <20190424143911.28890-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143911.28890-1-sashal@kernel.org>
References: <20190424143911.28890-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omri Kahalon <omrik@mellanox.com>

[ Upstream commit eca4a928585ac08147e5cc8e2111ecbc6279ee31 ]

Traditionally, the PF (Physical Function) which resides on vport 0 was
the E-switch manager. Since the ECPF (Embedded CPU Physical Function),
which resides on vport 0xfffe, was introduced as the E-Switch manager,
the assumption that the E-switch manager is on vport 0 is incorrect.

Since the eswitch code already uses the actual vport value, all we
need is to always set other_vport=1.

Signed-off-by: Omri Kahalon <omrik@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 26c9f9421901..55ccd90beeb0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -80,8 +80,7 @@ static int arm_vport_context_events_cmd(struct mlx5_core_dev *dev, u16 vport,
 		 opcode, MLX5_CMD_OP_MODIFY_NIC_VPORT_CONTEXT);
 	MLX5_SET(modify_nic_vport_context_in, in, field_select.change_event, 1);
 	MLX5_SET(modify_nic_vport_context_in, in, vport_number, vport);
-	if (vport)
-		MLX5_SET(modify_nic_vport_context_in, in, other_vport, 1);
+	MLX5_SET(modify_nic_vport_context_in, in, other_vport, 1);
 	nic_vport_ctx = MLX5_ADDR_OF(modify_nic_vport_context_in,
 				     in, nic_vport_context);
 
@@ -109,8 +108,7 @@ static int modify_esw_vport_context_cmd(struct mlx5_core_dev *dev, u16 vport,
 	MLX5_SET(modify_esw_vport_context_in, in, opcode,
 		 MLX5_CMD_OP_MODIFY_ESW_VPORT_CONTEXT);
 	MLX5_SET(modify_esw_vport_context_in, in, vport_number, vport);
-	if (vport)
-		MLX5_SET(modify_esw_vport_context_in, in, other_vport, 1);
+	MLX5_SET(modify_esw_vport_context_in, in, other_vport, 1);
 	return mlx5_cmd_exec(dev, in, inlen, out, sizeof(out));
 }
 
-- 
2.19.1

