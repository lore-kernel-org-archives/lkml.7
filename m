Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3603C28CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFB327ECE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559553212;
	bh=Yag5q5aS2+NS59gLAB7BzUtRjUWKTMRecEygGQgq704=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C4s0xWkbHQGI492lwLVxVvC/fzriBfX0YNKFhQDcScV28OPqMBCSNF8q3nK/Mh3xw
	 CSXs+WxgGkoY8kxUtvHCBAiAhER5q6O8K7QJQZxq+iRTPdnX70Z4nr5Um2JLIOBjTf
	 vxjtQgHylkwf1nzD48KIf8P7M4IMJqFvjYxzSRMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbfFCJNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:13:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbfFCJNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:13:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 120F527EB0;
        Mon,  3 Jun 2019 09:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559553210;
        bh=Yag5q5aS2+NS59gLAB7BzUtRjUWKTMRecEygGQgq704=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IzR/gxP9heK5dAlsGHPE5me+POsCCBghX2v9IkHO8o5D3QCZkSGdLoz20jU1UIVNE
         IQuDVlFsjp8KbLKe5M1kyrb0ilI1bNyI0j7u9Z3U2klFGDVun6xErkd8i0vO3YduT0
         1ks6Q38e3RmpjzzD1Jajdjql1TgLBXJ3jm72DmNw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.1 24/40] net/mlx5e: Disable rxhash when CQE compress is enabled
Date:   Mon,  3 Jun 2019 11:09:17 +0200
Message-Id: <20190603090524.096682349@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603090522.617635820@linuxfoundation.org>
References: <20190603090522.617635820@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saeed Mahameed <saeedm@mellanox.com>

[ Upstream commit c0194e2d0ef0e5ce5e21a35640d23a706827ae28 ]

When CQE compression is enabled (Multi-host systems), compressed CQEs
might arrive to the driver rx, compressed CQEs don't have a valid hash
offload and the driver already reports a hash value of 0 and invalid hash
type on the skb for compressed CQEs, but this is not good enough.

On a congested PCIe, where CQE compression will kick in aggressively,
gro will deliver lots of out of order packets due to the invalid hash
and this might cause a serious performance drop.

The only valid solution, is to disable rxhash offload at all when CQE
compression is favorable (Multi-host systems).

Fixes: 7219ab34f184 ("net/mlx5e: CQE compression")
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3750,6 +3750,12 @@ static netdev_features_t mlx5e_fix_featu
 			netdev_warn(netdev, "Disabling LRO, not supported in legacy RQ\n");
 	}
 
+	if (MLX5E_GET_PFLAG(params, MLX5E_PFLAG_RX_CQE_COMPRESS)) {
+		features &= ~NETIF_F_RXHASH;
+		if (netdev->features & NETIF_F_RXHASH)
+			netdev_warn(netdev, "Disabling rxhash, not supported when CQE compress is active\n");
+	}
+
 	mutex_unlock(&priv->state_lock);
 
 	return features;
@@ -3875,6 +3881,9 @@ int mlx5e_hwstamp_set(struct mlx5e_priv
 	memcpy(&priv->tstamp, &config, sizeof(config));
 	mutex_unlock(&priv->state_lock);
 
+	/* might need to fix some features */
+	netdev_update_features(priv->netdev);
+
 	return copy_to_user(ifr->ifr_data, &config,
 			    sizeof(config)) ? -EFAULT : 0;
 }
@@ -4734,6 +4743,10 @@ static void mlx5e_build_nic_netdev(struc
 	if (!priv->channels.params.scatter_fcs_en)
 		netdev->features  &= ~NETIF_F_RXFCS;
 
+	/* prefere CQE compression over rxhash */
+	if (MLX5E_GET_PFLAG(&priv->channels.params, MLX5E_PFLAG_RX_CQE_COMPRESS))
+		netdev->features &= ~NETIF_F_RXHASH;
+
 #define FT_CAP(f) MLX5_CAP_FLOWTABLE(mdev, flow_table_properties_nic_receive.f)
 	if (FT_CAP(flow_modify_en) &&
 	    FT_CAP(modify_root) &&


