Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7492C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 19:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF4020836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 19:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCBTjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 14:39:37 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.33]:26022 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726529AbfCBTjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 14:39:37 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 078DC5A21
        for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2019 13:39:36 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 0ATvhmyXfYTGM0ATvh3EaV; Sat, 02 Mar 2019 13:39:36 -0600
X-Authority-Reason: nr=8
Received: from [189.250.88.58] (port=49436 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1h0ATv-003ZWz-54; Sat, 02 Mar 2019 13:39:35 -0600
Date:   Sat, 2 Mar 2019 13:39:33 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eli Britstein <elibr@mellanox.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] net/mlx5e: Remove redundant assignment
Message-ID: <20190302193933.GA13467@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.88.58
X-Source-L: No
X-Exim-ID: 1h0ATv-003ZWz-54
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.88.58]:49436
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant assignment to tun_entropy->enabled.

Addesses-Coverity-ID: 1477328 ("Unused value")
Fixes: 97417f6182f8 ("net/mlx5e: Fix GRE key by controlling port tunnel entropy calculation")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/port_tun.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/port_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/port_tun.c
index 40f4a19b1ce1..be69c1d7941a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/port_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/port_tun.c
@@ -80,10 +80,8 @@ void mlx5_init_port_tun_entropy(struct mlx5_tun_entropy *tun_entropy,
 	mlx5_query_port_tun_entropy(mdev, &entropy_flags);
 	tun_entropy->num_enabling_entries = 0;
 	tun_entropy->num_disabling_entries = 0;
-	tun_entropy->enabled = entropy_flags.calc_enabled;
-	tun_entropy->enabled =
-		(entropy_flags.calc_supported) ?
-		entropy_flags.calc_enabled : true;
+	tun_entropy->enabled = entropy_flags.calc_supported ?
+			       entropy_flags.calc_enabled : true;
 }
 
 static int mlx5_set_entropy(struct mlx5_tun_entropy *tun_entropy,
-- 
2.21.0

