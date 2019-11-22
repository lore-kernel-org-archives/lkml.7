Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB68C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A80220637
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403763;
	bh=su1n9rIFco9QybKw4v3E7bYzZ5i2FUYnqUp43IBNZ6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dYJXJ+CgQUIyY+jg7WxhqbsmvjLEvagdjveKpChwpYEMJoD5ThmcJkrkiw4ymoLPy
	 AijzYIhJn/VkxxwTBfsUFIHmQ+OEDZZKRBsca+1LdVvavibizK83B+Nb0mIQ3i7zuP
	 ToSHLEYuz/EP0+UV1HCl8HDbI0s9E1PG1n8QBsRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbfKVFv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:51:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbfKVFvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:51:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF6792075B;
        Fri, 22 Nov 2019 05:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401908;
        bh=su1n9rIFco9QybKw4v3E7bYzZ5i2FUYnqUp43IBNZ6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A907qBrMLNG4Px02DPHe1UMehv1GYrNdEc/+96kM4BjgqxlLpPGbm4NFsHjY4cpkg
         cGv2vd2TGjFRAUTEhEPzgm1goslZWgxfqbI1dBA95BUPLE2wN/7OKmGJGcslQd1PAO
         RAkoDiGcuTly8Pd86FcGiURij9/glwLI0PMYEd1E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 139/219] net/net_namespace: Check the return value of register_pernet_subsys()
Date:   Fri, 22 Nov 2019 00:47:51 -0500
Message-Id: <20191122054911.1750-132-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 6dab186d4b8f6..c60123dff8039 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -913,7 +913,8 @@ static int __init net_ns_init(void)
 	init_net_initialized = true;
 	up_write(&pernet_ops_rwsem);
 
-	register_pernet_subsys(&net_ns_ops);
+	if (register_pernet_subsys(&net_ns_ops))
+		panic("Could not register network namespace subsystems");
 
 	rtnl_register(PF_UNSPEC, RTM_NEWNSID, rtnl_net_newid, NULL,
 		      RTNL_FLAG_DOIT_UNLOCKED);
-- 
2.20.1

