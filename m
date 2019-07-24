Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001DFC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72BC204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000261;
	bh=Z7z6ZNVQ/aEopwbVD8Am1CrqyHr6ZMa+mZxXvPrDdAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cmiwl7JySEArBwheMiH1Jt5+c3Em2QwPvf1PZOHuXRpSxI+d3ecvBX/ry8I4yXQ7t
	 NFlak2+0ifr2tqpKvgdOqXWceLrqJe1ELF02ZfTgI55bshAMntT4vBMLWnP0Yp1M3o
	 Y7KfKybvclVtLSaBUGW+odT5yWxuaZ2/k4lAncEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389895AbfGXUbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388325AbfGXTbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:31:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6377720659;
        Wed, 24 Jul 2019 19:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996671;
        bh=Z7z6ZNVQ/aEopwbVD8Am1CrqyHr6ZMa+mZxXvPrDdAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HYr5C4rNHilbX4kQax77mkO32KNtIxVWUXtRxcJtosZol9GtNFA3EmjVVQ2+zv7s4
         zSiuxnZBMZDJ8MWlBkSuZLuUsudH9q+tDy/8S7lJjnXjGNz/5UsM97oi5zgD9pnWj4
         fNliRCbQkSmauB5L4jJpe4etbyf2CpT711MaNxV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianbo Liu <jianbol@mellanox.com>,
        Oz Shlomo <ozsh@mellanox.com>,
        Eli Britstein <elibr@mellanox.com>,
        Roi Dayan <roid@mellanox.com>, Mark Bloch <markb@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 178/413] net/mlx5: Get vport ACL namespace by vport index
Date:   Wed, 24 Jul 2019 21:17:49 +0200
Message-Id: <20190724191747.598534516@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f53297d67800feb5fafd94abd926c889aefee690 ]

The ingress and egress ACL root namespaces are created per vport and
stored into arrays. However, the vport number is not the same as the
index. Passing the array index, instead of vport number, to get the
correct ingress and egress acl namespace.

Fixes: 9b93ab981e3b ("net/mlx5: Separate ingress/egress namespaces for each vport")
Signed-off-by: Jianbo Liu <jianbol@mellanox.com>
Reviewed-by: Oz Shlomo <ozsh@mellanox.com>
Reviewed-by: Eli Britstein <elibr@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 6a921e24cd5e..acab26b88261 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -939,7 +939,7 @@ int esw_vport_enable_egress_acl(struct mlx5_eswitch *esw,
 		  vport->vport, MLX5_CAP_ESW_EGRESS_ACL(dev, log_max_ft_size));
 
 	root_ns = mlx5_get_flow_vport_acl_namespace(dev, MLX5_FLOW_NAMESPACE_ESW_EGRESS,
-						    vport->vport);
+			mlx5_eswitch_vport_num_to_index(esw, vport->vport));
 	if (!root_ns) {
 		esw_warn(dev, "Failed to get E-Switch egress flow namespace for vport (%d)\n", vport->vport);
 		return -EOPNOTSUPP;
@@ -1057,7 +1057,7 @@ int esw_vport_enable_ingress_acl(struct mlx5_eswitch *esw,
 		  vport->vport, MLX5_CAP_ESW_INGRESS_ACL(dev, log_max_ft_size));
 
 	root_ns = mlx5_get_flow_vport_acl_namespace(dev, MLX5_FLOW_NAMESPACE_ESW_INGRESS,
-						    vport->vport);
+			mlx5_eswitch_vport_num_to_index(esw, vport->vport));
 	if (!root_ns) {
 		esw_warn(dev, "Failed to get E-Switch ingress flow namespace for vport (%d)\n", vport->vport);
 		return -EOPNOTSUPP;
-- 
2.20.1



