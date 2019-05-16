Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46922C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082962087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558006949;
	bh=TA6mDrVDLBcE6XkWLV//P2zFTEyWrak3ZTbcgZImXPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NIr50N6igF6G1DQjNJd6nQHR59L/Jd43T9EpPbDbj2Sj2WOaJms9ts6p3EUAEZ2LQ
	 McokEljH802iEOmqY2Z9O2RpU5VG0c2dmSpNzyQciAAtI7KVm8eoVQQ4McAmmht5fR
	 Zs9YWAAKp+jnuvE4ql2EeEDrWdX6cso09Yr1UVz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfEPLm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728446AbfEPLmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:42:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F9D52087E;
        Thu, 16 May 2019 11:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558006924;
        bh=TA6mDrVDLBcE6XkWLV//P2zFTEyWrak3ZTbcgZImXPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PDEMIRPcyKmCt5sh4BiMRvDyaXbKYkuQhoid8mCQuQcrYJ1SDu2Af/h3yTtHGkJNN
         o16+twX8mPGijsugotSNakXTaGde99/QOUfW8LHZdbb5kszNXswuXUtnAQ2L/qjgOl
         evmZDgVWQF3vvqKGXWdO7dSck0EyHCmJEhCwW/rI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jeremy Sowden <jeremy@azazel.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 3/6] vti4: ipip tunnel deregistration fixes.
Date:   Thu, 16 May 2019 07:41:56 -0400
Message-Id: <20190516114159.9382-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516114159.9382-1-sashal@kernel.org>
References: <20190516114159.9382-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Sowden <jeremy@azazel.net>

[ Upstream commit 5483844c3fc18474de29f5d6733003526e0a9f78 ]

If tunnel registration failed during module initialization, the module
would fail to deregister the IPPROTO_COMP protocol and would attempt to
deregister the tunnel.

The tunnel was not deregistered during module-exit.

Fixes: dd9ee3444014e ("vti4: Fix a ipip packet processing bug in 'IPCOMP' virtual tunnel")
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_vti.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index e224ca2ea1c06..ed6c6695912a2 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -618,9 +618,9 @@ static int __init vti_init(void)
 	return err;
 
 rtnl_link_failed:
-	xfrm4_protocol_deregister(&vti_ipcomp4_protocol, IPPROTO_COMP);
-xfrm_tunnel_failed:
 	xfrm4_tunnel_deregister(&ipip_handler, AF_INET);
+xfrm_tunnel_failed:
+	xfrm4_protocol_deregister(&vti_ipcomp4_protocol, IPPROTO_COMP);
 xfrm_proto_comp_failed:
 	xfrm4_protocol_deregister(&vti_ah4_protocol, IPPROTO_AH);
 xfrm_proto_ah_failed:
@@ -635,6 +635,7 @@ static int __init vti_init(void)
 static void __exit vti_fini(void)
 {
 	rtnl_link_unregister(&vti_link_ops);
+	xfrm4_tunnel_deregister(&ipip_handler, AF_INET);
 	xfrm4_protocol_deregister(&vti_ipcomp4_protocol, IPPROTO_COMP);
 	xfrm4_protocol_deregister(&vti_ah4_protocol, IPPROTO_AH);
 	xfrm4_protocol_deregister(&vti_esp4_protocol, IPPROTO_ESP);
-- 
2.20.1

