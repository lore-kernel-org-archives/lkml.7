Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAE0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B612077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127244;
	bh=iKz0t0l64LPCVHN4IdpvZL3AGcCsEeQalcZSsJq48n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qRpDYJ3qRHba4jC/1qWubz5wzJ0g1XUAXUoMutGXHxU86/dIvzH/d2d4FZYVrvF9p
	 9CGJs/862Tk8XN3Q47b5otYMLwZFlDPhg9wGcEZi1UBXBVuFWHTwb7OmRYw+OxiHgw
	 lRDaI7FDcik6FcxUQv1mP+3XgduITKNMW0RxawcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391630AbfDXReD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:32878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391619AbfDXReA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:34:00 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D2922077C;
        Wed, 24 Apr 2019 17:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127240;
        bh=iKz0t0l64LPCVHN4IdpvZL3AGcCsEeQalcZSsJq48n0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ita/fyg3H2krmxR9ZK3E/JJU7ruT9oxbmnDpIqY+OjoLVE6egTSSE9zm0t2hxWqxr
         YWbeCJRmSzSKn403jbcOgHuimzR2+riDAN2WucvM7SEYM50ckZIa0cWGlJWSiCote9
         8JX4mRUp2zs/jB2tdpKR3mLUd2FkHhsAkdQbVqD0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Alexander Petrovskiy <alexpe@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 019/115] mlxsw: spectrum_router: Do not check VRF MAC address
Date:   Wed, 24 Apr 2019 19:09:15 +0200
Message-Id: <20190424170926.171518548@linuxfoundation.org>
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

[ Upstream commit 972fae683cbad5cf348268e76abc6d55cfb3ba87 ]

Commit 74bc99397438 ("mlxsw: spectrum_router: Veto unsupported RIF MAC
addresses") enabled the driver to veto router interface (RIF) MAC
addresses that it cannot support.

This check should only be performed for interfaces for which the driver
actually configures a RIF. A VRF upper is not one of them, so ignore it.

Without this patch it is not possible to set an IP address on the VRF
device and use it as a loopback.

Fixes: 74bc99397438 ("mlxsw: spectrum_router: Veto unsupported RIF MAC addresses")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Alexander Petrovskiy <alexpe@mellanox.com>
Tested-by: Alexander Petrovskiy <alexpe@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -6745,7 +6745,7 @@ static int mlxsw_sp_router_port_check_ri
 	/* A RIF is not created for macvlan netdevs. Their MAC is used to
 	 * populate the FDB
 	 */
-	if (netif_is_macvlan(dev))
+	if (netif_is_macvlan(dev) || netif_is_l3_master(dev))
 		return 0;
 
 	for (i = 0; i < MLXSW_CORE_RES_GET(mlxsw_sp->core, MAX_RIFS); i++) {


