Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2402C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6B62068E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402446;
	bh=2fVdgC/fjirU6vo9EcK3UR87dC/f+jTse9YxNMAOxKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1EU27wwXWKUlMmPOxULHV9OFCmJP5R8XV5H8TQeZqbHZCl8GT864i6qLU8g3hgfsF
	 H4M4HSFTTuAoh5BE/+DEceFT/yNHVAdJ4ZGMgnXxVIA++HpMZps3RxJlsr0lqTSpw8
	 S+3rCo9ZX3G8OZlevY23gvjixKnZ5BgkGqnD7Sfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfKVF53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:57:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:35576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728314AbfKVF5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:57:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD47B207FA;
        Fri, 22 Nov 2019 05:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402237;
        bh=2fVdgC/fjirU6vo9EcK3UR87dC/f+jTse9YxNMAOxKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KfkF0P9VeLPAD2Q+U/vPSu2FqYBhInIkBtnq8WGvxkniUiwWTpqT2Qr6flFfgnnfz
         Uoi+ZZ5g8g+r1x4hElkh7OKiYGUDslj8U0R1pg+cl6dGluoyvap/Oq+L1gbVyYU4wH
         daFbHmVaipz9tDcE4MK5ibbLc+F/y4Jo+7EEVhII=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 082/127] net/net_namespace: Check the return value of register_pernet_subsys()
Date:   Fri, 22 Nov 2019 00:55:00 -0500
Message-Id: <20191122055544.3299-81-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
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

