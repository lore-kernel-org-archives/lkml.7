Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8366C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790002084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117775;
	bh=4+jyzTu6K3qHJTdmixFoQ2l7n20cmKN50JvfRQNKS2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wz3fgQ39sut0eF+E9yXBQAkf0AV6OGlOOhTzVM5m5VJMbI1AIw7z38oQSfy3vTE8a
	 F7R6qN7OKxW6cIiz8tvKAkh5FgcXPGfgNb47DA82L3RsiZwuZl12yJ1ADXKE9kWsh6
	 IkUUVQWXFiRsXYckc7OvYHjpbseQ3NXx1bd8H6kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732634AbfDXOuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:50:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731114AbfDXOug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:50:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72C3D218FC;
        Wed, 24 Apr 2019 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117435;
        bh=4+jyzTu6K3qHJTdmixFoQ2l7n20cmKN50JvfRQNKS2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bnQk40VOYfIl/l0l4OpepBG4DOoVc90dYHlFHGhbsCI24+Q9QvsFY8vS5tqeXMRha
         LP4TARpm+ImRhl4IWX0uqima0UwLgIhxhoY4+l8e7lUct8lm5+kgI0mdNPutlJ7K9s
         ne6+ED2eEvkrbTmG9o/9qQaROrShh7EtGTZkiot8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Omri Kahalon <omrik@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 09/28] net/mlx5: E-Switch, Fix esw manager vport indication for more vport commands
Date:   Wed, 24 Apr 2019 10:49:53 -0400
Message-Id: <20190424145012.30886-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424145012.30886-1-sashal@kernel.org>
References: <20190424145012.30886-1-sashal@kernel.org>
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
index da9246f6c31e..d1a3a35ba87b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -92,8 +92,7 @@ static int arm_vport_context_events_cmd(struct mlx5_core_dev *dev, u16 vport,
 		 opcode, MLX5_CMD_OP_MODIFY_NIC_VPORT_CONTEXT);
 	MLX5_SET(modify_nic_vport_context_in, in, field_select.change_event, 1);
 	MLX5_SET(modify_nic_vport_context_in, in, vport_number, vport);
-	if (vport)
-		MLX5_SET(modify_nic_vport_context_in, in, other_vport, 1);
+	MLX5_SET(modify_nic_vport_context_in, in, other_vport, 1);
 	nic_vport_ctx = MLX5_ADDR_OF(modify_nic_vport_context_in,
 				     in, nic_vport_context);
 
@@ -121,8 +120,7 @@ static int modify_esw_vport_context_cmd(struct mlx5_core_dev *dev, u16 vport,
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

