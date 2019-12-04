Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A778DC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A87205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575484006;
	bh=5PDxv2/YHr0FuhBfzhJ5z8m8H8XgdsUBLgg/TREY904=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u7lDAfu3rYWiHinPaoig9+Vdl1sDvOfjPD9uu3Kx7fMaJhWxdDN1UckQ2TATG8v3K
	 WRAMbhdvZiUEQvZwtfQQTkKqKxZl7cLy6XgkDiWHpoUtWA6dWOU4hgmAYt9+cRNTQH
	 PxreHW0fyBL9Wn1f8+/ggF8s+DQLIwFrRcdXMTo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfLDS0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:26:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:35288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729054AbfLDR7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:59:13 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E173F2081B;
        Wed,  4 Dec 2019 17:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482353;
        bh=5PDxv2/YHr0FuhBfzhJ5z8m8H8XgdsUBLgg/TREY904=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KU2+0clrtJO89CxL08NHR/JETP6taS4kUKnbjIRophGiFi1HSkMJzv3WmNAZ7UHFp
         ljf/sdgh/SKy8s3j3VeoMYPbuGaeWWFcXwZA2BvEzFMPYuI4KlVS/N/AxjG1CeEske
         HlwkA48krzJCKj0/HVl9uEDjqGdnt8+TKanz21/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 54/92] net/net_namespace: Check the return value of register_pernet_subsys()
Date:   Wed,  4 Dec 2019 18:49:54 +0100
Message-Id: <20191204174333.689045762@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
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
index 087ce1598b746..01bfe28b20a19 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -778,7 +778,8 @@ static int __init net_ns_init(void)
 
 	mutex_unlock(&net_mutex);
 
-	register_pernet_subsys(&net_ns_ops);
+	if (register_pernet_subsys(&net_ns_ops))
+		panic("Could not register network namespace subsystems");
 
 	rtnl_register(PF_UNSPEC, RTM_NEWNSID, rtnl_net_newid, NULL, NULL);
 	rtnl_register(PF_UNSPEC, RTM_GETNSID, rtnl_net_getid, rtnl_net_dumpid,
-- 
2.20.1



