Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EEAC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2685D20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558641005;
	bh=xywE+GSgYA5Pfdjb6LBnSzVFaUGC8KB/hDWbOo3Es4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZcUyjAWRHNZxA5QKNF8c90F2Ex2wdaqGtz1/h2ytEpGJrmM+b1nTKWTsIVUiwTi+A
	 Qz6TFbnCxfE/ozcYHbIlJiBqYUIIE6f442kBDW1TM9zOlYSK8Qa+ctGbnUUzpM8grJ
	 oS9LOTjRZesT5iq52C8dekhyq9OK6Xt4sy8R7HWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbfEWTKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387743AbfEWTKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:10:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFD672133D;
        Thu, 23 May 2019 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638613;
        bh=xywE+GSgYA5Pfdjb6LBnSzVFaUGC8KB/hDWbOo3Es4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A1Yq5ySbuQhqeVOsKDQyfTJUxepdzZLpw1os5hjiQI6JhveTA/CuFuyLdZzsmCLQM
         zvzkW1Xp/L7XIuvafShhA5VHKxbVwTyOr8WEbVfcd5yfZ4JFM4bGW3LSSwj9zZQvOk
         yYuiynslrfYVwgGMtcZ7Vl0eal6PIK0AjaulNyJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeremy Sowden <jeremy@azazel.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 44/53] vti4: ipip tunnel deregistration fixes.
Date:   Thu, 23 May 2019 21:06:08 +0200
Message-Id: <20190523181717.950582899@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181710.981455400@linuxfoundation.org>
References: <20190523181710.981455400@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 270e79f4d40e6..4e39c935e057e 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -678,9 +678,9 @@ static int __init vti_init(void)
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
@@ -696,6 +696,7 @@ pernet_dev_failed:
 static void __exit vti_fini(void)
 {
 	rtnl_link_unregister(&vti_link_ops);
+	xfrm4_tunnel_deregister(&ipip_handler, AF_INET);
 	xfrm4_protocol_deregister(&vti_ipcomp4_protocol, IPPROTO_COMP);
 	xfrm4_protocol_deregister(&vti_ah4_protocol, IPPROTO_AH);
 	xfrm4_protocol_deregister(&vti_esp4_protocol, IPPROTO_ESP);
-- 
2.20.1



