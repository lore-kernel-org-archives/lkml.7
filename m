Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C656AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9361A2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494775;
	bh=lWiXdrFpPl+47r/41TiMavfsdsKGVAwGSJYGPTvESsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0xb6FFZiiE3qWavfEUx90gtD2cDPRnDjdp08BL4u2aOtvVO/8xNDIh6oIYCU81PyQ
	 JglxJcX1Gy0izn/uYTNmuXW2SuZOtW9ahjXiTJLgm4utLvjplaHu8nq6+uoaot3KLF
	 eZ5rAFCIC45maEi7BzxHSiB6kVV06N45N6MaopVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404671AbfHVR0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404341AbfHVRZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:25:11 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABC5923426;
        Thu, 22 Aug 2019 17:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494710;
        bh=lWiXdrFpPl+47r/41TiMavfsdsKGVAwGSJYGPTvESsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xaTAXD96acXN2YWsryEW5H38MZyXpXxqbVZ01QOrgcftw/H3QhOkjM1aPO1B7SL/l
         A0SE6WMaqEfSh/YzZRW20QRA9JfT1ZWfac/DqXo/CNXADwC0BzRJqpV9NOTZzM6UE4
         y92H/2kdT87z+HVL8Cb78WpTjB2oKO6xbeu5MkvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huy Nguyen <huyn@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 66/71] net/mlx5e: Only support tx/rx pause setting for port owner
Date:   Thu, 22 Aug 2019 10:19:41 -0700
Message-Id: <20190822171730.590818002@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171726.131957995@linuxfoundation.org>
References: <20190822171726.131957995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huy Nguyen <huyn@mellanox.com>

[ Upstream commit 466df6eb4a9e813b3cfc674363316450c57a89c5 ]

Only support changing tx/rx pause frame setting if the net device
is the vport group manager.

Fixes: 3c2d18ef22df ("net/mlx5e: Support ethtool get/set_pauseparam")
Signed-off-by: Huy Nguyen <huyn@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1400,6 +1400,9 @@ static int mlx5e_set_pauseparam(struct n
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int err;
 
+	if (!MLX5_CAP_GEN(mdev, vport_group_manager))
+		return -EOPNOTSUPP;
+
 	if (pauseparam->autoneg)
 		return -EINVAL;
 


