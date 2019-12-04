Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78829C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F43F20833
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482730;
	bh=2fVdgC/fjirU6vo9EcK3UR87dC/f+jTse9YxNMAOxKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lcE8gbV1D3JPxYsdoDMHtcjiTmoARTsZD+QgN2vVsWXxAT66P1HMmElOBnDNBb+hE
	 R7pbW/YkNps+43JJBFF1Crp6LaA9zWFD/LCGZjqoHaUGUn7+LI2ixyIUFalvohE5NQ
	 P5ZhCauSd5qePhfIwYIIjtj/F7jIxhMrHAHzBjK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfLDSF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:05:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:51950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729347AbfLDSFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:05:23 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 634F420659;
        Wed,  4 Dec 2019 18:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482722;
        bh=2fVdgC/fjirU6vo9EcK3UR87dC/f+jTse9YxNMAOxKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mj0jOfP87S98KaTy2D2NsWI8I6rlf1vmG0mr8cCi0naaU2r+TO2179xnmXlH6AsCH
         Ycd/AoQj8BnGlWmIj5kYS6qIL19qyui4vub34RNoP5ismqyIl2O6ZtGosnuTFK3Xno
         l49FWAuUOMhXgdM5f0OPpDRAktPL+g3STpRgM3i0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 110/209] net/net_namespace: Check the return value of register_pernet_subsys()
Date:   Wed,  4 Dec 2019 18:55:22 +0100
Message-Id: <20191204175329.569679172@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit 0eb987c874dc93f9c9d85a6465dbde20fdd3884c ]

In net_ns_init(), register_pernet_subsys() could fail while registering
network namespace subsystems. The fix checks the return value and
sends a panic() on failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/net_namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 60b88718b1d48..1af25d53f63ca 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -854,7 +854,8 @@ static int __init net_ns_init(void)
 
 	mutex_unlock(&net_mutex);
 
-	register_pernet_subsys(&net_ns_ops);
+	if (register_pernet_subsys(&net_ns_ops))
+		panic("Could not register network namespace subsystems");
 
 	rtnl_register(PF_UNSPEC, RTM_NEWNSID, rtnl_net_newid, NULL,
 		      RTNL_FLAG_DOIT_UNLOCKED);
-- 
2.20.1



