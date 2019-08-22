Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E871C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A50233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495018;
	bh=rEuce7MorVCTzG9uSs4zdJ9r9FIRLf/x4SAQiswLbYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xAVKNviVVfS/l6dPPnBCIbtb2EZBntBwQlmb7ppLNrA6DdKh3ET2JhSbxFRrST/Gf
	 d/YdgpCQL/fCMjzDAOIBDz4Vxw25Au2/qpUO6TffqU6a0UD0vbzRdM8BFDZ0d+faJA
	 aEhVCunQ3lCg5gJhHREWhQFbNUfZfsmbV2FwOAf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392127AbfHVRaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404655AbfHVR0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:26:12 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF7A3206DD;
        Thu, 22 Aug 2019 17:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494771;
        bh=rEuce7MorVCTzG9uSs4zdJ9r9FIRLf/x4SAQiswLbYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G3s178QyqOGvgw4w4sCzek+5kd2Papd+iCH3c+9/9C00VDCUHR9oisgA7onbZzQFx
         aavL8ML6RG/5+AOh6pF5U0L373lOdKBfCShuFL4EMXUv/4T1LENZKheGwOqFcF+M8K
         fuEutsQDuUwbaf9gGH2jWhu1lod2NjRPlUk4OYZ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH 4.19 76/85] net/mlx4_en: fix a memory leak bug
Date:   Thu, 22 Aug 2019 10:19:49 -0700
Message-Id: <20190822171734.411724415@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171731.012687054@linuxfoundation.org>
References: <20190822171731.012687054@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit 48ec7014c56e5eb2fbf6f479896143622d834f3b ]

In mlx4_en_config_rss_steer(), 'rss_map->indir_qp' is allocated through
kzalloc(). After that, mlx4_qp_alloc() is invoked to configure RSS
indirection. However, if mlx4_qp_alloc() fails, the allocated
'rss_map->indir_qp' is not deallocated, leading to a memory leak bug.

To fix the above issue, add the 'qp_alloc_err' label to free
'rss_map->indir_qp'.

Fixes: 4931c6ef04b4 ("net/mlx4_en: Optimized single ring steering")
Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_rx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -1190,7 +1190,7 @@ int mlx4_en_config_rss_steer(struct mlx4
 	err = mlx4_qp_alloc(mdev->dev, priv->base_qpn, rss_map->indir_qp);
 	if (err) {
 		en_err(priv, "Failed to allocate RSS indirection QP\n");
-		goto rss_err;
+		goto qp_alloc_err;
 	}
 
 	rss_map->indir_qp->event = mlx4_en_sqp_event;
@@ -1244,6 +1244,7 @@ indir_err:
 		       MLX4_QP_STATE_RST, NULL, 0, 0, rss_map->indir_qp);
 	mlx4_qp_remove(mdev->dev, rss_map->indir_qp);
 	mlx4_qp_free(mdev->dev, rss_map->indir_qp);
+qp_alloc_err:
 	kfree(rss_map->indir_qp);
 	rss_map->indir_qp = NULL;
 rss_err:


