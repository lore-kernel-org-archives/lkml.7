Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70360C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CF6205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564155032;
	bh=8Or4AWLAlexKIw/bjsBgwyYHaKuQtxtf6ga710lI3V8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ynuAlUiKipZNfLOhJGBoqaS5h+AhmxycXUhlpEQyFMeaBdXcpwnyDrekWQMLxzapw
	 pi216Qf5mMA4xRiYSgb2W4qeouP3eRS0rL+brpBKcAtMyGSAtYkFj3BkLfie060H+r
	 s4TJoaIify8+61lkzmt9KwnQ3Hqt8h4o4q/vCP3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389094AbfGZPab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:30:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388303AbfGZPaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:30:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1140205F4;
        Fri, 26 Jul 2019 15:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564155024;
        bh=8Or4AWLAlexKIw/bjsBgwyYHaKuQtxtf6ga710lI3V8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tAnMyIFUZT61fRBSxzHY4h0Ek0PsARHI1L09EXlhJchujRUlw+t3C/jT9e49rK0kY
         +JDCSpK3fiQHzhnIjsxc6HVLfY0WSWH4+RRAN/xU8qec1Jmap5AwOH3Fu21Eliyifz
         6zOS2fBNloYRLceelDy5GCZbsOiUGChbZ3M2mVro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eli Britstein <elibr@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.1 39/62] net/mlx5e: Fix port tunnel GRE entropy control
Date:   Fri, 26 Jul 2019 17:24:51 +0200
Message-Id: <20190726152306.072675599@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.720139286@linuxfoundation.org>
References: <20190726152301.720139286@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eli Britstein <elibr@mellanox.com>

[ Upstream commit 914adbb1bcf89478ac138318d28b302704564d59 ]

GRE entropy calculation is a single bit per card, and not per port.
Force disable GRE entropy calculation upon the first GRE encap rule,
and release the force at the last GRE encap rule removal. This is done
per port.

Fixes: 97417f6182f8 ("net/mlx5e: Fix GRE key by controlling port tunnel entropy calculation")
Signed-off-by: Eli Britstein <elibr@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/port_tun.c |   23 ++---------------
 1 file changed, 4 insertions(+), 19 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/port_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/port_tun.c
@@ -100,27 +100,12 @@ static int mlx5_set_entropy(struct mlx5_
 	 */
 	if (entropy_flags.gre_calc_supported &&
 	    reformat_type == MLX5_REFORMAT_TYPE_L2_TO_NVGRE) {
-		/* Other applications may change the global FW entropy
-		 * calculations settings. Check that the current entropy value
-		 * is the negative of the updated value.
-		 */
-		if (entropy_flags.force_enabled &&
-		    enable == entropy_flags.gre_calc_enabled) {
-			mlx5_core_warn(tun_entropy->mdev,
-				       "Unexpected GRE entropy calc setting - expected %d",
-				       !entropy_flags.gre_calc_enabled);
-			return -EOPNOTSUPP;
-		}
-		err = mlx5_set_port_gre_tun_entropy_calc(tun_entropy->mdev, enable,
-							 entropy_flags.force_supported);
+		if (!entropy_flags.force_supported)
+			return 0;
+		err = mlx5_set_port_gre_tun_entropy_calc(tun_entropy->mdev,
+							 enable, !enable);
 		if (err)
 			return err;
-		/* if we turn on the entropy we don't need to force it anymore */
-		if (entropy_flags.force_supported && enable) {
-			err = mlx5_set_port_gre_tun_entropy_calc(tun_entropy->mdev, 1, 0);
-			if (err)
-				return err;
-		}
 	} else if (entropy_flags.calc_supported) {
 		/* Other applications may change the global FW entropy
 		 * calculations settings. Check that the current entropy value


