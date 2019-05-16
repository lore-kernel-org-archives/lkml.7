Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4B8C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD11720848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558007358;
	bh=aH3b+fP/Z15xzrMBVGTSSwC9pPVL1Nox/juMJfQ2Y/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=onfZ4B+27yhCYzOsavR1N5mAje+TJinVj16KyFt7ohCVWwN+Vxsx6PIn3GGZJuH2u
	 FKAmpRcXA3Ku0OvuISnKo7G5oGpjQ0ykZeMXwHOHSVMqkuUlNGl4qXtH0RfmVW8+3y
	 PNJV8iznx5zxqQ/d6H7yjh40iBr5rU9Rj2VyKIa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfEPLjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfEPLjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:39:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E40CE20862;
        Thu, 16 May 2019 11:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558006776;
        bh=aH3b+fP/Z15xzrMBVGTSSwC9pPVL1Nox/juMJfQ2Y/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2vdnTLTTAo2Gok8pnvCW2tLL+fD0/bD0zxpJSguzZigceUbiD0SrTm9kt113vgtQd
         ylVMG+HyvUwws+GuvcqPRpu48z17rXRwt2Su/K4e8boQnjaDSyJXC/LWZUjhBsnwb9
         iBezt8adttMyqcTupgrR5upJzqI9ST113USmF5oA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Su Yanjun <suyj.fnst@cn.fujitsu.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 03/34] xfrm6_tunnel: Fix potential panic when unloading xfrm6_tunnel module
Date:   Thu, 16 May 2019 07:39:00 -0400
Message-Id: <20190516113932.8348-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516113932.8348-1-sashal@kernel.org>
References: <20190516113932.8348-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Su Yanjun <suyj.fnst@cn.fujitsu.com>

[ Upstream commit 6ee02a54ef990a71bf542b6f0a4e3321de9d9c66 ]

When unloading xfrm6_tunnel module, xfrm6_tunnel_fini directly
frees the xfrm6_tunnel_spi_kmem. Maybe someone has gotten the
xfrm6_tunnel_spi, so need to wait it.

Fixes: 91cc3bb0b04ff("xfrm6_tunnel: RCU conversion")
Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/xfrm6_tunnel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
index bc65db782bfb1..12cb3aa990af4 100644
--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -402,6 +402,10 @@ static void __exit xfrm6_tunnel_fini(void)
 	xfrm6_tunnel_deregister(&xfrm6_tunnel_handler, AF_INET6);
 	xfrm_unregister_type(&xfrm6_tunnel_type, AF_INET6);
 	unregister_pernet_subsys(&xfrm6_tunnel_net_ops);
+	/* Someone maybe has gotten the xfrm6_tunnel_spi.
+	 * So need to wait it.
+	 */
+	rcu_barrier();
 	kmem_cache_destroy(xfrm6_tunnel_spi_kmem);
 }
 
-- 
2.20.1

