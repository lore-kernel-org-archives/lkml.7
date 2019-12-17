Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0F7C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B0824676
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576613466;
	bh=VZwyj9YuiCOt/nAtyjwSiG+a0CNd2vTooOmflEuVM6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=beKWMUP2rI4m8XyoGQ27Gp+iErMJd6OY+H2d4oHk12AwS+avTty5l9HAX4Xdn6Kbi
	 +xlbjYdkxRG40YW2BkjtFc1Sqohm//pKVSmJ29Hf5plV4Ai+AFoIPru5bnmwg1hIei
	 ahRxkMCpa2HRWl6yd4bHdwdSZ8hgzjiAD37eZIKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfLQULF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:11:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbfLQULC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:11:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58245206D7;
        Tue, 17 Dec 2019 20:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576613461;
        bh=VZwyj9YuiCOt/nAtyjwSiG+a0CNd2vTooOmflEuVM6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPzTEDYqnXYDJkW67As7+LmLs/M9uNfvr5+zCFOmdFelNJzjVSREakjLp0CtgbUHC
         FPwCbuRRA8bXgKP8WAAJIAEDP46IAYV67f+4QTQK9d1y8eWSacHk+aBv7z5pjlphxb
         JnGcSg8wasApTIBq1Aia7imIO6wXcGzbx5VP4rFA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roi Dayan <roid@mellanox.com>,
        Eli Britstein <elibr@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.4 30/37] net/mlx5e: Fix freeing flow with kfree() and not kvfree()
Date:   Tue, 17 Dec 2019 21:09:51 +0100
Message-Id: <20191217200732.961616439@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217200721.741054904@linuxfoundation.org>
References: <20191217200721.741054904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roi Dayan <roid@mellanox.com>

[ Upstream commit a23dae79fb6555c808528707c6389345d0b0c189 ]

Flows are allocated with kzalloc() so free with kfree().

Fixes: 04de7dda7394 ("net/mlx5e: Infrastructure for duplicated offloading of TC flows")
Signed-off-by: Roi Dayan <roid@mellanox.com>
Reviewed-by: Eli Britstein <elibr@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1616,7 +1616,7 @@ static void __mlx5e_tc_del_fdb_peer_flow
 	flow_flag_clear(flow, DUP);
 
 	mlx5e_tc_del_fdb_flow(flow->peer_flow->priv, flow->peer_flow);
-	kvfree(flow->peer_flow);
+	kfree(flow->peer_flow);
 	flow->peer_flow = NULL;
 }
 


