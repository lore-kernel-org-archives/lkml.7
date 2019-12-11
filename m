Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA66BC2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FC524654
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077536;
	bh=CUUNtVqEczqRgKcODEIbCiRwjHTUcTYe5MQwpXHF1vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GTv68Jm2jb2DRdQDPNyIqSiAG/uMAlUOXIK29YnJDf3XdsiiYIzf4RoRE57SH/4xR
	 Ssb6lZRpuG6XmcRqoT8IiBK2ufbYT2KfUvipWbJmK5DluZtKTYJ2f89RdiFq2I2ARB
	 1nh+gsHkziHRnMQ3Edsen8lc8yengoNVXeSFAgAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbfLKPSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:18:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732028AbfLKPSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:18:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 760342073D;
        Wed, 11 Dec 2019 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077528;
        bh=CUUNtVqEczqRgKcODEIbCiRwjHTUcTYe5MQwpXHF1vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vrYGPHykGu8qoSG2b8gkKyO00WW56oieUZpcdLm7qGKSZAWC0kHBIrwESHMuMTfl6
         xwHRvetlxn0qa64fkP88qSYIoMUd0admHbTUMAPkrddJ2ZWOWAX8/7zlsOL9vzinIu
         A2V0vVOTVaLfw4yCtVG0a2ThBjagMw8HEraQvEKI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moni Shoua <monis@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 036/243] net/mlx5: Release resource on error flow
Date:   Wed, 11 Dec 2019 16:03:18 +0100
Message-Id: <20191211150341.665418764@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moni Shoua <monis@mellanox.com>

[ Upstream commit 698114968a22f6c0c9f42e983ba033cc36bb7217 ]

Fix reference counting leakage when the event handler aborts due to an
unsupported event for the resource type.

Fixes: a14c2d4beee5 ("net/mlx5_core: Warn on unsupported events of QP/RQ/SQ")
Signed-off-by: Moni Shoua <monis@mellanox.com>
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/qp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/qp.c b/drivers/net/ethernet/mellanox/mlx5/core/qp.c
index 4ca07bfb6b14f..f33707ce8b6b0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/qp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/qp.c
@@ -132,7 +132,7 @@ void mlx5_rsc_event(struct mlx5_core_dev *dev, u32 rsn, int event_type)
 	if (!is_event_type_allowed((rsn >> MLX5_USER_INDEX_LEN), event_type)) {
 		mlx5_core_warn(dev, "event 0x%.2x is not allowed on resource 0x%.8x\n",
 			       event_type, rsn);
-		return;
+		goto out;
 	}
 
 	switch (common->res) {
@@ -150,7 +150,7 @@ void mlx5_rsc_event(struct mlx5_core_dev *dev, u32 rsn, int event_type)
 	default:
 		mlx5_core_warn(dev, "invalid resource type for 0x%x\n", rsn);
 	}
-
+out:
 	mlx5_core_put_rsc(common);
 }
 
-- 
2.20.1



