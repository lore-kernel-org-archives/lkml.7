Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DCDC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E1A22BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564154923;
	bh=RDQfSpX0t1h4UabJWi0ujY6Wdg6GrR7VHDOe+NgHGR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tXtqP2wYa9OEmvZz+DR3y0rb++Nqs0FroT33g7QR6FlQstXcBzsUkXGeG3uE0s9fI
	 ekv4jvwl2eaqDNIp4eQBcGJa8m2iv/7QcAHvzswS36P2ksjfCDyH6HsQaxFmGRRVYP
	 ybyYU3/Uiz6veRhcSHPRIrkIrG975MKm+EUsTJE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388568AbfGZP2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:28:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388524AbfGZP2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:28:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74F9622BF5;
        Fri, 26 Jul 2019 15:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564154920;
        bh=RDQfSpX0t1h4UabJWi0ujY6Wdg6GrR7VHDOe+NgHGR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v2nJkI+/IlLc5wY6Wf4foRm6i7ebiC7Ch7hdsD/HIk+PeP6gqJs7pdDyV5cC5KXNb
         MrbAFHwBpY6Q9fvmnAuHxGexM/Go61kbk40j1aMYbZ0nMyplBZJb8uhHfdDmtw4JhJ
         JVTZmflhzUhhIGjKDETGH9gfYANc7BJmbeJ4Lv3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.2 45/66] net/mlx5: E-Switch, Fix default encap mode
Date:   Fri, 26 Jul 2019 17:24:44 +0200
Message-Id: <20190726152306.844604566@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.936055394@linuxfoundation.org>
References: <20190726152301.936055394@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

[ Upstream commit 9a64144d683a4395f57562d90247c61a0bf5105f ]

Encap mode is related to switchdev mode only. Move the init of
the encap mode to eswitch_offloads. Before this change, we reported
that eswitch supports encap, even tough the device was in non
SRIOV mode.

Fixes: 7768d1971de67 ('net/mlx5: E-Switch, Add control for encapsulation')
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c          |    5 -----
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c |    7 +++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1882,11 +1882,6 @@ int mlx5_eswitch_init(struct mlx5_core_d
 	esw->enabled_vports = 0;
 	esw->mode = SRIOV_NONE;
 	esw->offloads.inline_mode = MLX5_INLINE_MODE_NONE;
-	if (MLX5_CAP_ESW_FLOWTABLE_FDB(dev, reformat) &&
-	    MLX5_CAP_ESW_FLOWTABLE_FDB(dev, decap))
-		esw->offloads.encap = DEVLINK_ESWITCH_ENCAP_MODE_BASIC;
-	else
-		esw->offloads.encap = DEVLINK_ESWITCH_ENCAP_MODE_NONE;
 
 	dev->priv.eswitch = esw;
 	return 0;
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1840,6 +1840,12 @@ int esw_offloads_init(struct mlx5_eswitc
 {
 	int err;
 
+	if (MLX5_CAP_ESW_FLOWTABLE_FDB(esw->dev, reformat) &&
+	    MLX5_CAP_ESW_FLOWTABLE_FDB(esw->dev, decap))
+		esw->offloads.encap = DEVLINK_ESWITCH_ENCAP_MODE_BASIC;
+	else
+		esw->offloads.encap = DEVLINK_ESWITCH_ENCAP_MODE_NONE;
+
 	err = esw_offloads_steering_init(esw, vf_nvports, total_nvports);
 	if (err)
 		return err;
@@ -1901,6 +1907,7 @@ void esw_offloads_cleanup(struct mlx5_es
 	esw_offloads_devcom_cleanup(esw);
 	esw_offloads_unload_all_reps(esw, num_vfs);
 	esw_offloads_steering_cleanup(esw);
+	esw->offloads.encap = DEVLINK_ESWITCH_ENCAP_MODE_NONE;
 }
 
 static int esw_mode_from_devlink(u16 mode, u16 *mlx5_mode)


