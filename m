Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1131FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE8320818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919447;
	bh=z1DY0QMRuBq/BmTsAMZFu6BRozpB8OSNs9uPgTFFqWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZBMu+Dxt+E2HaQi3EjQt2dCLZNZCIG46xrVJClXEvXcL+ItHrQi2tgVdp68n9qwWq
	 zq2XDNILKJr09XioWGi0o8OUpJdDUV9DPwOMHvQdj2y+fEML3Z1l5CytaHQ90JUdk0
	 9LWK5y6XG8KwVTmKg9OA86QyO0pz2+dUAJ2Fr1c8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbfEOLYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727636AbfEOLX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:23:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEE9E20818;
        Wed, 15 May 2019 11:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919438;
        bh=z1DY0QMRuBq/BmTsAMZFu6BRozpB8OSNs9uPgTFFqWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LJN8gOJHHLTVMf0b/l+sKjdfqTgEiX75+isB3u4nMcqwdLsNPMKhSejYs6f+s105r
         TKhpazPCuSaXVStNQmYydAyBh6/PK8hl/t9wg7EJkWe6645UW9oEY2FLei5fnlRT9Q
         8y9jP4TfoKy9vX7Gay9xMZcK4ENg1C6qCN2Bkg3E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.19 074/113] mlxsw: core: Do not use WQ_MEM_RECLAIM for EMAD workqueue
Date:   Wed, 15 May 2019 12:56:05 +0200
Message-Id: <20190515090659.157653104@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090652.640988966@linuxfoundation.org>
References: <20190515090652.640988966@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a8c133b06183c529c51cd0d54eb57d6b7078370c ]

The EMAD workqueue is used to handle retransmission of EMAD packets that
contain configuration data for the device's firmware.

Given the workers need to allocate these packets and that the code is
not called as part of memory reclaim path, remove the WQ_MEM_RECLAIM
flag.

Fixes: d965465b60ba ("mlxsw: core: Fix possible deadlock")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index f7154f358f276..426aea8ad72c4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -568,7 +568,7 @@ static int mlxsw_emad_init(struct mlxsw_core *mlxsw_core)
 	if (!(mlxsw_core->bus->features & MLXSW_BUS_F_TXRX))
 		return 0;
 
-	emad_wq = alloc_workqueue("mlxsw_core_emad", WQ_MEM_RECLAIM, 0);
+	emad_wq = alloc_workqueue("mlxsw_core_emad", 0, 0);
 	if (!emad_wq)
 		return -ENOMEM;
 	mlxsw_core->emad_wq = emad_wq;
-- 
2.20.1



