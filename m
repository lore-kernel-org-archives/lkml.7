Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AF2C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B9A206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153630;
	bh=2MMIIIvAcXHNDN1heVo/3Wg7DHlhW1YM8pWX9D4L4BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lqzy3OQCMr/OeYydPrZMiMBOhPFipt2jFUeYO6p97W5Jg4yVgY5DLGj02Zlso3TYW
	 NglgLyGP+ypfQbtSuxwgBzC+b5INEwij4cQhpLYwSLnnaS8SjEd1H/d7jQhCKu025q
	 7yrmvD+DKkr3c3vM4Sszo7nkKNrwDdLsT9n5OoU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfEFOk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbfEFOkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:40:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B85020449;
        Mon,  6 May 2019 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153623;
        bh=2MMIIIvAcXHNDN1heVo/3Wg7DHlhW1YM8pWX9D4L4BY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBGi9C1O7+AKPmwYnTJk0eolTgYE41ODKoIOBJNYNJzEElwnOOHM5xuWa++Hyg+fZ
         0fkMt8va9VhCugXwPB6hDOou85yKMs2VwpbZoik72cfDCyMLlS5hHDSBUU3NAYbWHM
         8qKwgNUm5fCM+sGS/RhRClAkvN4qqqNaM/YbNSNc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omri Kahalon <omrik@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 36/99] net/mlx5: E-Switch, Fix esw manager vport indication for more vport commands
Date:   Mon,  6 May 2019 16:32:09 +0200
Message-Id: <20190506143057.213753401@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.20.1



