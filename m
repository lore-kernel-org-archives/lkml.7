Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B5FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B352186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=azazel.net header.i=@azazel.net header.b="vDsXePYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfCOMNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:13:02 -0400
Received: from kadath.azazel.net ([81.187.231.250]:53158 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbfCOMNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 08:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=kFTLd4RyTSwtClBl1+B0bPl73WM+ngjjww8ws6rkj+U=; b=vDsXePYpnYwul4K51FJUThyRLE
        uCvn5zp47oYWjnHc4HvHP15VxWXgQ0XWAgZ2/l/pb5nyqss74RndlnR//c9A1kRT2cjTksR9uf2Zl
        98dD7Ndq92dl+IYd3Bw8m+jxTRmHg1NqsSgLbhnr+ZydF6UDFcwhKa/VfDGuRaYXDUF7gOMQ49h35
        LI7trruwc/QuzlgfEA+qZMoAt656QwsluGO0WPra04yt589Vph+voiv85eVtHoMId1tMfg+2hoynD
        YRwPCZkgFTiLOQoyEhotqWk/Qds/HIyw65NSaD+MNncJckqAfae/3hpDJhqUVU6BPH6qpfKq3CQna
        DzIYdy0w==;
Received: from ulthar.dreamlands ([192.168.96.2])
        by kadath.azazel.net with esmtp (Exim 4.89)
        (envelope-from <jeremy@azazel.net>)
        id 1h4lhs-0006ci-7a; Fri, 15 Mar 2019 12:13:00 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] vti4: removed duplicate log message.
Date:   Fri, 15 Mar 2019 12:13:00 +0000
Message-Id: <20190315121300.30007-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 192.168.96.2
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed info log-message if ipip tunnel registration fails during
module-initialization: it adds nothing to the error message that is
written on all failures.

Fixes: d9ee3444014e ("vti4: Fix a ipip packet processing bug in 'IPCOMP' virtual tunnel")
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 net/ipv4/ip_vti.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index b6235ca09fa5..35d8346742e2 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -646,10 +646,8 @@ static int __init vti_init(void)
 
 	msg = "ipip tunnel";
 	err = xfrm4_tunnel_register(&ipip_handler, AF_INET);
-	if (err < 0) {
-		pr_info("%s: cant't register tunnel\n",__func__);
+	if (err < 0)
 		goto xfrm_tunnel_failed;
-	}
 
 	msg = "netlink interface";
 	err = rtnl_link_register(&vti_link_ops);
-- 
2.20.1

