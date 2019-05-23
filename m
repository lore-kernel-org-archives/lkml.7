Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31102C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32F52075E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640454;
	bh=laHD1jWBJrY0MXhlTLyPeumxAmw0dFaifheRZAZDSW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UgkR4lXNA/iNE+F+vYZKqEKz2JZRxvWAXqBND97Bq1ZTkQkHzzOrmVEadwsAP9ZIZ
	 757FrAqKcOSSCNC4vRtC/NU8M6OHzBgDoGnhenpn43U63VdrTG/tiRQ2ZcmGhw9eRB
	 gRkCmGhjNsNIP841L5Rig/6aBgYljYI70x3CjdTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390622AbfEWTkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389368AbfEWTUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:20:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41792217D9;
        Thu, 23 May 2019 19:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639247;
        bh=laHD1jWBJrY0MXhlTLyPeumxAmw0dFaifheRZAZDSW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=juCHr7b3jo12TvwAXk19CIP/y9VXTTHrg8shRFiXgOEQLYDaTR+xRXQvAo92O04WW
         Ol1MLhDbpC5cgvqtYoJW+fo2s0xSeh7aiJqs7je7a07Sqk7qugikR4Rnvjz2/WIfjT
         v7kxUvWHKNgzm+Wzo2+EXlpPRMi6sxhKFyeG/lXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmytro Linkin <dmitrolin@mellanox.com>,
        Roi Dayan <roid@mellanox.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.0 016/139] net/mlx5e: Additional check for flow destination comparison
Date:   Thu, 23 May 2019 21:05:04 +0200
Message-Id: <20190523181722.662968930@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmytro Linkin <dmitrolin@mellanox.com>

[ Upstream commit c979c445a88e1c9dd7d8f90838c10456ae4ecd09 ]

Flow destination comparison has an inaccuracy: code see no
difference between same vf ports, which belong to different pfs.

Example: If start ping from VF0 (PF1) to VF1 (PF1) and mirror
all traffic to VF0 (PF2), icmp reply to VF0 (PF1) and mirrored
flow to VF0 (PF2) would be determined as same destination. It lead
to creating flow handler with rule nodes, which not added to node
tree. When later driver try to delete this flow rules we got
kernel crash.

Add comparison of vhca_id field to avoid this.

Fixes: 1228e912c934 ("net/mlx5: Consider encapsulation properties when comparing destinations")
Signed-off-by: Dmytro Linkin <dmitrolin@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Reviewed-by: Vlad Buslov <vladbu@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1375,6 +1375,8 @@ static bool mlx5_flow_dests_cmp(struct m
 		if ((d1->type == MLX5_FLOW_DESTINATION_TYPE_VPORT &&
 		     d1->vport.num == d2->vport.num &&
 		     d1->vport.flags == d2->vport.flags &&
+		     ((d1->vport.flags & MLX5_FLOW_DEST_VPORT_VHCA_ID) ?
+		      (d1->vport.vhca_id == d2->vport.vhca_id) : true) &&
 		     ((d1->vport.flags & MLX5_FLOW_DEST_VPORT_REFORMAT_ID) ?
 		      (d1->vport.reformat_id == d2->vport.reformat_id) : true)) ||
 		    (d1->type == MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE &&


