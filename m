Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FE0C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2638C2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355684;
	bh=jPh/LBMZd5CCRnp+pjxE6K4YrEXRxU1+eqjr84U295c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fWUU0AZxH9ePvpg/Q9+8VA6icQnCzCYOjtLpKXipQkumBOY34+MTVSU3YqLSQ+Ddi
	 Id/p1g5z4oDtHr0IlOzYQdCNQH+m0mhla0ZYaOOF3YwuvzYlQMmaHWWnJAZ9vHOkbA
	 GirNQrCLUFGcfpcBfmp3vL4lk1pbLULqtx3rCYrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbfDOTOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:14:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbfDOTOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:14:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58FEB2075B;
        Mon, 15 Apr 2019 19:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355679;
        bh=jPh/LBMZd5CCRnp+pjxE6K4YrEXRxU1+eqjr84U295c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ec85/QWgueuKNS4RkymYsN0m4lWI5H5EAYWJMUebmNPRFwozuZadkCblsybOMWqOH
         qRG3gs5c5eK2DirZ9FaOYxRIse3me51mraivxM7RbfoIn4+Qmv6mMr2E4z6QuWwfnC
         DGPxvS7qBxws4nQ7J8xt5J+Qqzhq/+QGwd9og4FI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huy Nguyen <huyn@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 036/101] net/mlx5e: Update xon formula
Date:   Mon, 15 Apr 2019 20:58:34 +0200
Message-Id: <20190415183742.362329879@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e28408e98bced123038857b6e3c81fa12a2e3e68 ]

Set xon = xoff - netdev's max_mtu.
netdev's max_mtu will give enough time for the pause frame to
arrive at the sender.

Fixes: 0696d60853d5 ("net/mlx5e: Receive buffer configuration")
Signed-off-by: Huy Nguyen <huyn@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlx5/core/en/port_buffer.c       | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
index f00de0c987cd..4ab0d030b544 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
@@ -143,7 +143,7 @@ static u32 calculate_xoff(struct mlx5e_priv *priv, unsigned int mtu)
 }
 
 static int update_xoff_threshold(struct mlx5e_port_buffer *port_buffer,
-				 u32 xoff, unsigned int mtu)
+				 u32 xoff, unsigned int max_mtu)
 {
 	int i;
 
@@ -155,11 +155,12 @@ static int update_xoff_threshold(struct mlx5e_port_buffer *port_buffer,
 		}
 
 		if (port_buffer->buffer[i].size <
-		    (xoff + mtu + (1 << MLX5E_BUFFER_CELL_SHIFT)))
+		    (xoff + max_mtu + (1 << MLX5E_BUFFER_CELL_SHIFT)))
 			return -ENOMEM;
 
 		port_buffer->buffer[i].xoff = port_buffer->buffer[i].size - xoff;
-		port_buffer->buffer[i].xon  = port_buffer->buffer[i].xoff - mtu;
+		port_buffer->buffer[i].xon  =
+			port_buffer->buffer[i].xoff - max_mtu;
 	}
 
 	return 0;
@@ -167,7 +168,7 @@ static int update_xoff_threshold(struct mlx5e_port_buffer *port_buffer,
 
 /**
  * update_buffer_lossy()
- *   mtu: device's MTU
+ *   max_mtu: netdev's max_mtu
  *   pfc_en: <input> current pfc configuration
  *   buffer: <input> current prio to buffer mapping
  *   xoff:   <input> xoff value
@@ -184,7 +185,7 @@ static int update_xoff_threshold(struct mlx5e_port_buffer *port_buffer,
  *     Return 0 if no error.
  *     Set change to true if buffer configuration is modified.
  */
-static int update_buffer_lossy(unsigned int mtu,
+static int update_buffer_lossy(unsigned int max_mtu,
 			       u8 pfc_en, u8 *buffer, u32 xoff,
 			       struct mlx5e_port_buffer *port_buffer,
 			       bool *change)
@@ -221,7 +222,7 @@ static int update_buffer_lossy(unsigned int mtu,
 	}
 
 	if (changed) {
-		err = update_xoff_threshold(port_buffer, xoff, mtu);
+		err = update_xoff_threshold(port_buffer, xoff, max_mtu);
 		if (err)
 			return err;
 
@@ -231,6 +232,7 @@ static int update_buffer_lossy(unsigned int mtu,
 	return 0;
 }
 
+#define MINIMUM_MAX_MTU 9216
 int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 				    u32 change, unsigned int mtu,
 				    struct ieee_pfc *pfc,
@@ -242,12 +244,14 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 	bool update_prio2buffer = false;
 	u8 buffer[MLX5E_MAX_PRIORITY];
 	bool update_buffer = false;
+	unsigned int max_mtu;
 	u32 total_used = 0;
 	u8 curr_pfc_en;
 	int err;
 	int i;
 
 	mlx5e_dbg(HW, priv, "%s: change=%x\n", __func__, change);
+	max_mtu = max_t(unsigned int, priv->netdev->max_mtu, MINIMUM_MAX_MTU);
 
 	err = mlx5e_port_query_buffer(priv, &port_buffer);
 	if (err)
@@ -255,7 +259,7 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 
 	if (change & MLX5E_PORT_BUFFER_CABLE_LEN) {
 		update_buffer = true;
-		err = update_xoff_threshold(&port_buffer, xoff, mtu);
+		err = update_xoff_threshold(&port_buffer, xoff, max_mtu);
 		if (err)
 			return err;
 	}
@@ -265,7 +269,7 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 		if (err)
 			return err;
 
-		err = update_buffer_lossy(mtu, pfc->pfc_en, buffer, xoff,
+		err = update_buffer_lossy(max_mtu, pfc->pfc_en, buffer, xoff,
 					  &port_buffer, &update_buffer);
 		if (err)
 			return err;
@@ -277,8 +281,8 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 		if (err)
 			return err;
 
-		err = update_buffer_lossy(mtu, curr_pfc_en, prio2buffer, xoff,
-					  &port_buffer, &update_buffer);
+		err = update_buffer_lossy(max_mtu, curr_pfc_en, prio2buffer,
+					  xoff, &port_buffer, &update_buffer);
 		if (err)
 			return err;
 	}
@@ -302,7 +306,7 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 			return -EINVAL;
 
 		update_buffer = true;
-		err = update_xoff_threshold(&port_buffer, xoff, mtu);
+		err = update_xoff_threshold(&port_buffer, xoff, max_mtu);
 		if (err)
 			return err;
 	}
@@ -310,7 +314,7 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 	/* Need to update buffer configuration if xoff value is changed */
 	if (!update_buffer && xoff != priv->dcbx.xoff) {
 		update_buffer = true;
-		err = update_xoff_threshold(&port_buffer, xoff, mtu);
+		err = update_xoff_threshold(&port_buffer, xoff, max_mtu);
 		if (err)
 			return err;
 	}
-- 
2.19.1



