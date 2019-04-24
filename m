Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A35CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460A9218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117934;
	bh=TuKkPAUL6Lff6a0yCAHJQDWkX2mj5WWnkQirgLTE62Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ix+BPmVcngr0b42SKyUvLbPn/mhAN+NeNsf4l/6EvmguInPDQRu/GYioNhltfE4rn
	 UiCW3Q3JC21h3ouM5E3vkXfqTlHPcoGWTZHHkOqwh51030U4oG13KUpBzMhhETKcnb
	 KDdHBTAH0wNxxGXU3oqiSo6XCxQaFZkfIYuI9DVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbfDXO6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731480AbfDXOre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:47:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAAFF218FD;
        Wed, 24 Apr 2019 14:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117253;
        bh=TuKkPAUL6Lff6a0yCAHJQDWkX2mj5WWnkQirgLTE62Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ZGQs6K4+MpeD2JJbVLFKoCe+lSfKGB86VadYZC1YEjEcptKZihNrQDKQLQRKZNFP
         ht1PW/A94AMov3bDBmBnoVx7FClMl+bdamPiHiGsT7GvFnM+KwrY8PvfDnfKnlT9wr
         X5CVISjn6Q09+XDX6xuh7T4A9ka5v80xNQGyRL+k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Omri Kahalon <omrik@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 10/35] net/mlx5: E-Switch, Fix esw manager vport indication for more vport commands
Date:   Wed, 24 Apr 2019 10:46:44 -0400
Message-Id: <20190424144709.30215-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424144709.30215-1-sashal@kernel.org>
References: <20190424144709.30215-1-sashal@kernel.org>
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
index d2914116af8e..090d54275a7d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -79,8 +79,7 @@ static int arm_vport_context_events_cmd(struct mlx5_core_dev *dev, u16 vport,
 		 opcode, MLX5_CMD_OP_MODIFY_NIC_VPORT_CONTEXT);
 	MLX5_SET(modify_nic_vport_context_in, in, field_select.change_event, 1);
 	MLX5_SET(modify_nic_vport_context_in, in, vport_number, vport);
-	if (vport)
-		MLX5_SET(modify_nic_vport_context_in, in, other_vport, 1);
+	MLX5_SET(modify_nic_vport_context_in, in, other_vport, 1);
 	nic_vport_ctx = MLX5_ADDR_OF(modify_nic_vport_context_in,
 				     in, nic_vport_context);
 
@@ -108,8 +107,7 @@ static int modify_esw_vport_context_cmd(struct mlx5_core_dev *dev, u16 vport,
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

