Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE86C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561D62070B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120845;
	bh=wf7xGimtbwbcr9/12xVRlNjFQE+Cb8YhVNAh45RSF8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tpgzYjjfBR5mDqBc4heJKlY+FFRYw05LO3NvM6P5cbMKzfQc/FR5CCiuwVuC0kTUV
	 zvOldGNtW9EelqBZfktazGHIXHRWv5YXjhzqIA1RzOT1blD7A6Hc+cIO1TsxP2BJ4O
	 17eimeQfjker+nHHJHvUDm/KT5v6Cw6hvPTDq0CM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404942AbfJCQko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403785AbfJCQki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:40:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82DE120830;
        Thu,  3 Oct 2019 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120838;
        bh=wf7xGimtbwbcr9/12xVRlNjFQE+Cb8YhVNAh45RSF8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pk429ugKos9D8FzTrymGtoDeMaW/ThxODZ0V9LT6Gh8DsHLhmmPK/HFmnxVNvo1MF
         5XrTstGB/BXINuJbbVyyYa0IZzLEySBt+GBKuZYAD5hX9U6vzY8EOhTYDaCCJl9I1b
         54HeZUY6PalWMU5mIZN7v8oga5+IEiXk2k97qCLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH 5.3 029/344] net/mlx5e: Fix traffic duplication in ethtool steering
Date:   Thu,  3 Oct 2019 17:49:54 +0200
Message-Id: <20191003154542.962362676@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saeed Mahameed <saeedm@mellanox.com>

[ Upstream commit d22fcc806b84b9818de08b32e494f3c05dd236c7 ]

Before this patch, when adding multiple ethtool steering rules with
identical classification, the driver used to append the new destination
to the already existing hw rule, which caused the hw to forward the
traffic to all destinations (rx queues).

Here we avoid this by setting the "no append" mlx5 fs core flag when
adding a new ethtool rule.

Fixes: 6dc6071cfcde ("net/mlx5e: Add ethtool flow steering support")
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
@@ -399,10 +399,10 @@ add_ethtool_flow_rule(struct mlx5e_priv
 		      struct mlx5_flow_table *ft,
 		      struct ethtool_rx_flow_spec *fs)
 {
+	struct mlx5_flow_act flow_act = { .flags = FLOW_ACT_NO_APPEND };
 	struct mlx5_flow_destination *dst = NULL;
-	struct mlx5_flow_act flow_act = {0};
-	struct mlx5_flow_spec *spec;
 	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_spec *spec;
 	int err = 0;
 
 	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);


