Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C98EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33098222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782482;
	bh=2Gul6UmxNIbaUrQa/4TM8QjpPTFFBtqtqI+C6Bft56w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sboNbymj7zcEP6bDS/1MQSsahQHtiQ0t+W9KUQYTEB27Yqzvp3Go/53XUQxYnHHsz
	 dgZjUTHOsNGroplNc2LfgDxGziY0jbkgy6bDt/QrP4AXcebtjBcyZo7Scf5ihcVXUB
	 sjv248X/RaDt1urSxmKkMAaLUJBtiaWDvKvRtPaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfLSTIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:08:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728445AbfLSSmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:42:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A5D024679;
        Thu, 19 Dec 2019 18:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780950;
        bh=2Gul6UmxNIbaUrQa/4TM8QjpPTFFBtqtqI+C6Bft56w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMSEXXOPHqeyaHLSls62DantEmHxmU4AEdOjdMXn/+/Q5YGr2Hxe1+wnbTYMHwlno
         1DMXWolZYsKv6xkr4P3oYnEwI249JgICJDW3CRxqi7yKrGOGnesKD2kIthaG4wN7Td
         2PE0NawOScd4rKGcJAcz28wib3YDZYeid+ovoLec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moni Shoua <monis@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 021/199] net/mlx5: Release resource on error flow
Date:   Thu, 19 Dec 2019 19:31:43 +0100
Message-Id: <20191219183215.972964045@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
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
index 9346f3985edf3..354338c8a510e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/qp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/qp.c
@@ -125,7 +125,7 @@ void mlx5_rsc_event(struct mlx5_core_dev *dev, u32 rsn, int event_type)
 	if (!is_event_type_allowed((rsn >> MLX5_USER_INDEX_LEN), event_type)) {
 		mlx5_core_warn(dev, "event 0x%.2x is not allowed on resource 0x%.8x\n",
 			       event_type, rsn);
-		return;
+		goto out;
 	}
 
 	switch (common->res) {
@@ -139,7 +139,7 @@ void mlx5_rsc_event(struct mlx5_core_dev *dev, u32 rsn, int event_type)
 	default:
 		mlx5_core_warn(dev, "invalid resource type for 0x%x\n", rsn);
 	}
-
+out:
 	mlx5_core_put_rsc(common);
 }
 
-- 
2.20.1



