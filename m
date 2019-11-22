Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F95EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFCA20731
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402567;
	bh=AOTMLwBoPqJAtntlxmJ/XB13F96MU3zmgiI5dJWDJPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V6fnktUcWBv9eQ4aEB/acfbf6eD7xzbEUBcLr2qDOMgUUcdqmYamL4WjbuIYXZG/Z
	 A9kAT5A5sa1GylE99gGjbPZ0RR3Clk7H2kCvQ2KufprHswVBfjs2WiyKpgUvJxAtH0
	 o8Xzry5l3otH/99guDpxoTDh2gYGAYj/uOHWFRAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfKVGCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:02:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:41382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728656AbfKVGCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:02:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 733C020659;
        Fri, 22 Nov 2019 06:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402556;
        bh=AOTMLwBoPqJAtntlxmJ/XB13F96MU3zmgiI5dJWDJPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zQOHIR0mrSh8Tp5MAnI++EVT4nC/0jWwoD/EiW3LLatW9TacXYVVF/EAApU5aE0mo
         PJm3F9OBSMebLe/gIH+pvSZaScu3YaO+zedUu3P7GA6blObsHAAYY/YgeXlWG7MfjJ
         dVmy+yWIFH9SvweDc7qLReg91821AP6lHLvpN3lo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 61/91] net/net_namespace: Check the return value of register_pernet_subsys()
Date:   Fri, 22 Nov 2019 01:00:59 -0500
Message-Id: <20191122060129.4239-60-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122060129.4239-1-sashal@kernel.org>
References: <20191122060129.4239-1-sashal@kernel.org>
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
index 4509dec7bd1cd..7630fa80db92a 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -802,7 +802,8 @@ static int __init net_ns_init(void)
 
 	mutex_unlock(&net_mutex);
 
-	register_pernet_subsys(&net_ns_ops);
+	if (register_pernet_subsys(&net_ns_ops))
+		panic("Could not register network namespace subsystems");
 
 	rtnl_register(PF_UNSPEC, RTM_NEWNSID, rtnl_net_newid, NULL, NULL);
 	rtnl_register(PF_UNSPEC, RTM_GETNSID, rtnl_net_getid, rtnl_net_dumpid,
-- 
2.20.1

