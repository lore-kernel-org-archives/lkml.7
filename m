Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95927C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5827F20643
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553715239;
	bh=fTJ5sigosUFcvXFovi0MUeq7sBYVYoNRN8gRAjPn7kU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OlGYVW15TOHRFWxYRwlM6aevo0ZNb2OOefP9JkqjiI8pl4JqvAcek5/StpUb5CPqL
	 4WSvl5XKS5JS5GKhPOetWsNLeWFjgV+6mxm+cIXX7Dq1uYgaESgZhXMPbk3fjd+hEv
	 3UzBOsmCh23H94bZdY/FCGrjTP7N8EV6B889v5g0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732755AbfC0Td6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:33:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729816AbfC0SCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:02:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCA5F21734;
        Wed, 27 Mar 2019 18:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709736;
        bh=fTJ5sigosUFcvXFovi0MUeq7sBYVYoNRN8gRAjPn7kU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSmiaLcTb2L6kbyRKtV/KUOIEu/HRM+SC+c13XQcZHKbBklk36R3IIYrwWe0yNE9B
         ubwAtucadd+ioz3TpUjcBxzTwhDcW5CxDQwtikpYF52oOBIcAt/x8HBu8HA2BTtAok
         e/tqXpffdBfzK12ZDHRMbq96A8Y/uOmqu9Bn5wdE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 012/262] net/mlx5e: Fix access to non-existing receive queue
Date:   Wed, 27 Mar 2019 13:57:47 -0400
Message-Id: <20190327180158.10245-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tariq Toukan <tariqt@mellanox.com>

[ Upstream commit c475e11e82d16133304321bae285c5c1d4cfc856 ]

In case number of channels is changed while interface is down,
RSS indirection table is mistakenly not modified accordingly,
causing access to out-of-range non-existing object.

Fix by updating the RSS indireciton table also in the early
return flow of interface down.

Fixes: fb35c534b788 ("net/mlx5e: Fix NULL pointer derefernce in set channels error flow")
Fixes: bbeb53b8b2c9 ("net/mlx5e: Move RSS params to a dedicated struct")
Reported-by: Or Gerlitz <ogerlitz@mellanox.com>
Tested-by: Maria Pasechnik <mariap@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Reviewed-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 47233b9a4f81..e6099f51d25f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -357,6 +357,9 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
 
 	if (!test_bit(MLX5E_STATE_OPENED, &priv->state)) {
 		priv->channels.params = new_channels.params;
+		if (!netif_is_rxfh_configured(priv->netdev))
+			mlx5e_build_default_indir_rqt(priv->rss_params.indirection_rqt,
+						      MLX5E_INDIR_RQT_SIZE, count);
 		goto out;
 	}
 
-- 
2.19.1

