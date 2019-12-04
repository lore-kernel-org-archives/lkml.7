Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909ADC2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5C3206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483388;
	bh=8rpbA/I/vOJX++ZcZmL05DkRyFxZUOMgDCs+tabDovA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FAabsTVTF0JkG7VbUdGmm01GSAYIrKbuWDYshc90RDlHXQ8tiOvmaFQI2y1tL2cd9
	 1BqhCENvlYIEmTn5qQL1BrcW+kAKL2Zh763KCnaG0JogzC0wx2ZhhpmgASrxyk9l4I
	 niT4Nd+PVtji4LyZFFK5DWkHRbxXmlfymq5pvPfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfLDSNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:13:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731353AbfLDSNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:13:01 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B353620674;
        Wed,  4 Dec 2019 18:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483181;
        bh=8rpbA/I/vOJX++ZcZmL05DkRyFxZUOMgDCs+tabDovA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qxtoLOQYsZEEfzdJMyW5qo9N+kbdSmVza8qC2b/z56s9kTlAL/TTPojVvbOQEEzmF
         84WdD7hkSMqiNPNgHdRxcvUx8gzy7jlguCgvM6Eu7pBlPr4lzGKZJHuVsg1FiD4GMz
         IyW6w2SLgSdOJtdjfZErDJasvdEYdfLTm0IAhvdg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 040/125] net/mlx5: Continue driver initialization despite debugfs failure
Date:   Wed,  4 Dec 2019 18:55:45 +0100
Message-Id: <20191204175321.407733280@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

[ Upstream commit 199fa087dc6b503baad06712716fac645a983e8a ]

The failure to create debugfs entry is unpleasant event, but not enough
to abort drier initialization. Align the mlx5_core code to debugfs design
and continue execution whenever debugfs_create_dir() successes or not.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Reviewed-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index d676088512cf8..c9fb589690ee9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -786,11 +786,9 @@ static int mlx5_pci_init(struct mlx5_core_dev *dev, struct mlx5_priv *priv)
 
 	priv->numa_node = dev_to_node(&dev->pdev->dev);
 
-	priv->dbg_root = debugfs_create_dir(dev_name(&pdev->dev), mlx5_debugfs_root);
-	if (!priv->dbg_root) {
-		dev_err(&pdev->dev, "Cannot create debugfs dir, aborting\n");
-		return -ENOMEM;
-	}
+	if (mlx5_debugfs_root)
+		priv->dbg_root =
+			debugfs_create_dir(pci_name(pdev), mlx5_debugfs_root);
 
 	err = mlx5_pci_enable_device(dev);
 	if (err) {
-- 
2.20.1



