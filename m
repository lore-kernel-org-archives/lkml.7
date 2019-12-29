Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6107C2D0DA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D16207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577643054;
	bh=A1LewtAlpHu+W79XW+bX0foSjME/CcIXv3gHlAKGOaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uM9gI7xzr3evPlgCZ9Jks6eKfsiArMBd0hOFmc1a3SPcwdWZYJmg2K4bD5W4wPoXg
	 a/fOZC9h2pGa5f334Pcs9LMY+tBo2MeSCykp16gG2PtL1m+yDk/2RXSiasCuZ4UPyR
	 vw9q6D4ZP4GgMFCzzAA6H9dCgcnS5GyQa++1J81g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfL2Rnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:43:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:51566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbfL2Rnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:43:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01A2120718;
        Sun, 29 Dec 2019 17:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641430;
        bh=A1LewtAlpHu+W79XW+bX0foSjME/CcIXv3gHlAKGOaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gWHvkVeLLwSZ4yqVazK4fa4DlpAwqJDBN0sZ63enoarzBTo3+bJJaRKfNn27/2jHf
         7qP8ISEL2HlDTVJqJaKiHBp1sqIi67wDETeS4EG+wZukdGiHqHemTZswuJjhCugcgp
         eeeOmdvHvGiZXsN0nattSpq1cMdzjmi2XTematAI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 023/434] mlxsw: spectrum_router: Remove unlikely user-triggerable warning
Date:   Sun, 29 Dec 2019 18:21:16 +0100
Message-Id: <20191229172703.659811008@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 62201c00c4679ad8f0730d6d925a5d23651dfad2 ]

In case the driver vetoes the addition of an IPv6 multipath route, the
IPv6 stack will emit delete notifications for the sibling routes that
were already added to the FIB trie. Since these siblings are not present
in hardware, a warning will be generated.

Have the driver ignore notifications for routes it does not have.

Fixes: ebee3cad835f ("ipv6: Add IPv6 multipath notifications for add / replace")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -5637,8 +5637,13 @@ static void mlxsw_sp_router_fib6_del(str
 	if (mlxsw_sp_fib6_rt_should_ignore(rt))
 		return;
 
+	/* Multipath routes are first added to the FIB trie and only then
+	 * notified. If we vetoed the addition, we will get a delete
+	 * notification for a route we do not have. Therefore, do not warn if
+	 * route was not found.
+	 */
 	fib6_entry = mlxsw_sp_fib6_entry_lookup(mlxsw_sp, rt);
-	if (WARN_ON(!fib6_entry))
+	if (!fib6_entry)
 		return;
 
 	/* If not all the nexthops are deleted, then only reduce the nexthop


