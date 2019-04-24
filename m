Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5ADC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72502218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127391;
	bh=RAsi0xcUbYMzYVmmXaYs+1U34RsRM6sFAVk1c2qMrl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e+zL556vmXv2HzWhFTqxQZwSesLcLswkRpnEMP8K8pG6ymSlGRLgRh7iYmRY1RojH
	 Z/CpMmIrq9m2582MNcT9OQUuNHqm3hODnTGCLMKRG+VEiuRboQGfK7zsgOBJNQ83Lq
	 YeVeqL+HwsMlmaLxjw0XS0ZdhXQeFmckqdCyISio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391722AbfDXRga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:36:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403873AbfDXRg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:36:27 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65354218B0;
        Wed, 24 Apr 2019 17:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127386;
        bh=RAsi0xcUbYMzYVmmXaYs+1U34RsRM6sFAVk1c2qMrl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bCuaL3WteYRVcg+0UOXnue4j5sG/v8nAH5xrV3X0sCplsI+uqfrwAnjgLUxPMgLUw
         YhhfGDlWw2QzdJDyVADDo1D03rYOM8/UkPa8mEC60eEkU9FRepXSiXPMRZvv+GuMUk
         nFKxWon6AX/30kqA2boEHDFCYqXgWHwkGFIiEH1A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmytro Linkin <dmitrolin@mellanox.com>,
        Eli Britstein <elibr@mellanox.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.0 028/115] net/mlx5e: Protect against non-uplink representor for encap
Date:   Wed, 24 Apr 2019 19:09:24 +0200
Message-Id: <20190424170926.685771205@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmytro Linkin <dmitrolin@mellanox.com>

[ Upstream commit 5e0060b1491b299b1706414e61ede0b02265680e ]

TC encap offload is supported only for the physical uplink
representor. Fail for non uplink representor.

Fixes: 3e621b19b0bb ("net/mlx5e: Support TC encapsulation offloads with upper devices")
Signed-off-by: Dmytro Linkin <dmitrolin@mellanox.com>
Reviewed-by: Eli Britstein <elibr@mellanox.com>
Reviewed-by: Vlad Buslov <vladbu@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -39,6 +39,10 @@ static int get_route_and_out_devs(struct
 			return -EOPNOTSUPP;
 	}
 
+	if (!(mlx5e_eswitch_rep(*out_dev) &&
+	      mlx5e_is_uplink_rep(netdev_priv(*out_dev))))
+		return -EOPNOTSUPP;
+
 	return 0;
 }
 


