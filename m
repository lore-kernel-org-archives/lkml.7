Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46039C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1514720856
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495942;
	bh=LGNaU8+gwT1lUJF7Cp5Zz30pkN0Csrayl+Ce2Av5jlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T5E/rMwZEg9VWzVEyKCWn1ymn4Uz6epKphaV3e+bBdmYdNgmBPnBqZ5h7Mr+GqQtz
	 KxUXelh7P/mZyF4rGcmt5Ns1TnlMSbz1VaEL1P3PXBh0cTF0ghLPekEtGtxYr7H6bk
	 Z3Hsy1uYwtuIoclNpn9l7NNd38aJ2t+ngO6rkRqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393013AbfHVRpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403790AbfHVRXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:23:03 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6423223407;
        Thu, 22 Aug 2019 17:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494583;
        bh=LGNaU8+gwT1lUJF7Cp5Zz30pkN0Csrayl+Ce2Av5jlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tQikkChu+K0GEplOeLzSLtok/mZtftLp2ngnYhRiKV2+O4VoXdQlDewzQudpzviEh
         XEuddMqT1B+rTt2ydMdHNlFwYUr55+wqbDMphbXvFa9hH2KoXU8Xq612zjFRG2E7/G
         xC11c2FHyZpHRu0JIe+ZuGd8Q6PPcCc8QAX0m57U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huy Nguyen <huyn@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.4 76/78] net/mlx5e: Only support tx/rx pause setting for port owner
Date:   Thu, 22 Aug 2019 10:19:20 -0700
Message-Id: <20190822171834.232407289@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171832.012773482@linuxfoundation.org>
References: <20190822171832.012773482@linuxfoundation.org>
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
@@ -855,6 +855,9 @@ static int mlx5e_set_pauseparam(struct n
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int err;
 
+	if (!MLX5_CAP_GEN(mdev, vport_group_manager))
+		return -EOPNOTSUPP;
+
 	if (pauseparam->autoneg)
 		return -EINVAL;
 


