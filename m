Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C515C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AE42054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127241;
	bh=Otwzvv2D8iNykGi25XCLUdEnCSt1exJxL5WROFmRgEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oU4gbrcm+Oqqn7KcxJtgYcbgn7t8dTKitMtWAMz2wzm6NjR9Mp8nWYUIaBKNsSRyA
	 Ok0eVzTAs+nhWn7HS+wNjl//WgLn3mPErFhWWiseZe8ozKHVctJJqiCnLG66z6giPN
	 J+0LBO6rYMyCrO03z8JFFDGdAl6lWQl99kMXNunU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391620AbfDXReA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:34:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:32840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391607AbfDXRd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:33:58 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 295BF2054F;
        Wed, 24 Apr 2019 17:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127237;
        bh=Otwzvv2D8iNykGi25XCLUdEnCSt1exJxL5WROFmRgEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KCKGRRpcwEDaYdUp53kUZS2pHov4brC8GT2fXHxrr3a/qRInyPUChWRYXL84ZxaCO
         j0F6e7wON9sSmRMLYijcWh2JGoxSWD177QYhY869cxApWyO7DcAqyHKrkuE+Nrt99w
         gfeVsXPdnnhsCm8ap/Koh+IbnrGPw3FkOlYSZ/W4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 018/115] mlxsw: core: Do not use WQ_MEM_RECLAIM for mlxsw workqueue
Date:   Wed, 24 Apr 2019 19:09:14 +0200
Message-Id: <20190424170926.117180031@linuxfoundation.org>
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

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit b442fed1b724af0de087912a5718ddde1b87acbb ]

The workqueue is used to periodically update the networking stack about
activity / statistics of various objects such as neighbours and TC
actions.

It should not be called as part of memory reclaim path, so remove the
WQ_MEM_RECLAIM flag.

Fixes: 3d5479e92087 ("mlxsw: core: Remove deprecated create_workqueue")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -1912,7 +1912,7 @@ static int __init mlxsw_core_module_init
 {
 	int err;
 
-	mlxsw_wq = alloc_workqueue(mlxsw_core_driver_name, WQ_MEM_RECLAIM, 0);
+	mlxsw_wq = alloc_workqueue(mlxsw_core_driver_name, 0, 0);
 	if (!mlxsw_wq)
 		return -ENOMEM;
 	mlxsw_owq = alloc_ordered_workqueue("%s_ordered", 0,


