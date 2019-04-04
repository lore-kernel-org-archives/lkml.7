Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770F4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0CF205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370333;
	bh=Hj34u3/0pv314SOZkFWb1szz80gnqtK8v134ZUy9+3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AtWUQ/g8eWtHsdcrP1z0j8u0jToi8T+2MRyFOJJspil0bYkyttYFui99CII6c9bPu
	 Wa/SOuREY8wc1j5/ujfc92vYwYbos+njzrQ3eF0sb87lJq/fhl4abvMM0MBpApm35P
	 du5NixVenColfksV7Fg18gFG9fM8hcLZJBKf925g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbfDDJJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:09:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732735AbfDDJI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:08:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B41B621741;
        Thu,  4 Apr 2019 09:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368936;
        bh=Hj34u3/0pv314SOZkFWb1szz80gnqtK8v134ZUy9+3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CE/dKzqIzIn1pZk5q6JfKZCYFO/ye7TbHLNzX5K4nIF1IhMGqsiIVEeV/gKtF6kjo
         h6VncDFqGonWzkLNR6/5qId+0uX8kxd+e38Qx47Ugb84x9wP+LPOLyVLvUWIVUaoc3
         n0dRZ3Toabo7RouvxQNNYJpPJMZeu55ooQ7DPTRs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
        Maria Pasechnik <mariap@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 010/246] net/mlx5e: Fix access to non-existing receive queue
Date:   Thu,  4 Apr 2019 10:45:10 +0200
Message-Id: <20190404084619.571911772@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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



