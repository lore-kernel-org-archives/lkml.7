Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DEDC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2FD20637
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403799;
	bh=L7kOZ2DuuxrBOah1HpwY0bLme+c1Dzk3lN0xbxhInE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JTgVsZcSdfWCBCU5AypgAcPGijD1OGalWI5kWZ2d0WSeC8kfvhRA+i66u8lmaiGub
	 0ZvPVdAuuZH2fQkU+9yqLoPP8QKxd2qDZWawCXkBXI/MasVSjTKRs8xQHPrDjB3Ic8
	 FMUY4XUAeMyzrrh6tKhXgBWS+VWXGHuee0csnSaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfKVGXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:23:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfKVFvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:51:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0A0020840;
        Fri, 22 Nov 2019 05:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401907;
        bh=L7kOZ2DuuxrBOah1HpwY0bLme+c1Dzk3lN0xbxhInE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvgdHLDlEM56ZKNnAZ29/MmnsMW9I1Vxukv4gan0Y3gqQ6lRyGsVFX79FqnTWyLul
         yllQGyv39KqpO9zACx257UUrX/T7G+D1yQnafokLg/vuCiP8emScmrYNwufTWiIGrm
         55PQgtEBtnBk475fMK/rX9ol3jnSFzHswI/HKjqw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 138/219] net/netlink_compat: Fix a missing check of nla_parse_nested
Date:   Fri, 22 Nov 2019 00:47:50 -0500
Message-Id: <20191122054911.1750-131-sashal@kernel.org>
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

[ Upstream commit 89dfd0083751d00d5d7ead36f6d8b045bf89c5e1 ]

In tipc_nl_compat_sk_dump(), if nla_parse_nested() fails, it could return
an error. To be consistent with other invocations of the function call,
on error, the fix passes the return value upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tipc/netlink_compat.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index 318c541970ecd..6494d6b5e1b24 100644
--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -1030,8 +1030,11 @@ static int tipc_nl_compat_sk_dump(struct tipc_nl_compat_msg *msg,
 		u32 node;
 		struct nlattr *con[TIPC_NLA_CON_MAX + 1];
 
-		nla_parse_nested(con, TIPC_NLA_CON_MAX,
-				 sock[TIPC_NLA_SOCK_CON], NULL, NULL);
+		err = nla_parse_nested(con, TIPC_NLA_CON_MAX,
+				       sock[TIPC_NLA_SOCK_CON], NULL, NULL);
+
+		if (err)
+			return err;
 
 		node = nla_get_u32(con[TIPC_NLA_CON_NODE]);
 		tipc_tlv_sprintf(msg->rep, "  connected to <%u.%u.%u:%u>",
-- 
2.20.1

