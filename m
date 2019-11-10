Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D51C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A0F222C5
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354010;
	bh=dYIXRbexQq7+/HOd58pSYSn1iRSMJHiiIRGBrEXnUBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TZrpoaSqCdywhUBF/EvXIESfrUWEKUO41N9ZRHiLLhWcWsmvm3HKZZPEsdNVFbAyd
	 l7mVLIz7FM2p28sBT3LmCQ1BuUqkgAGXNP9WuXwLv7tAeeAyyTw6K59LinfJXAFjnJ
	 Ck6HtTVyJx3pfCj9PajFqEJ6yYyZKON8aty85zZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfKJCqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:46:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728422AbfKJCqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:46:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD5ED222C5;
        Sun, 10 Nov 2019 02:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354002;
        bh=dYIXRbexQq7+/HOd58pSYSn1iRSMJHiiIRGBrEXnUBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yo2763bkjZpEHcRPJrKBYQ3jJF9gcsxzH5Pb/KmvYgZpV8SZNFnVj4tG7oY1Gfycx
         RPDwqnGR9JiYeaMTignrDe/5znc9gd6JHyHdK9/mRHVKAeE7TPm/nBz5pcsJOOjRtc
         JpfytC3Da2K/Fi3w208IOcQxImSq2qpWs/KtslqI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Petr Machata <petrm@mellanox.com>, Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 029/109] mlxsw: spectrum: Init shaper for TCs 8..15
Date:   Sat,  9 Nov 2019 21:44:21 -0500
Message-Id: <20191110024541.31567-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024541.31567-1-sashal@kernel.org>
References: <20191110024541.31567-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Machata <petrm@mellanox.com>

[ Upstream commit a9f36656b519a9a21309793c306941a3cd0eeb8f ]

With introduction of MC-aware mode to mlxsw, it became necessary to
configure TCs above 7 as well. There is now code in mlxsw to disable ETS
for these higher classes, but disablement of max shaper was neglected.

By default, max shaper is currently disabled to begin with, so the
problem is just cosmetic. However, for symmetry, do like we do for ETS
configuration, and call mlxsw_sp_port_ets_maxrate_set() for both TC i
and i + 8.

Signed-off-by: Petr Machata <petrm@mellanox.com>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index a909aa315a92a..226187cba0e81 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2825,6 +2825,13 @@ static int mlxsw_sp_port_ets_init(struct mlxsw_sp_port *mlxsw_sp_port)
 						    MLXSW_REG_QEEC_MAS_DIS);
 		if (err)
 			return err;
+
+		err = mlxsw_sp_port_ets_maxrate_set(mlxsw_sp_port,
+						    MLXSW_REG_QEEC_HIERARCY_TC,
+						    i + 8, i,
+						    MLXSW_REG_QEEC_MAS_DIS);
+		if (err)
+			return err;
 	}
 
 	/* Map all priorities to traffic class 0. */
-- 
2.20.1

