Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8892FC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57CC020692
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143767;
	bh=vOu5GY2HeiZhUlzomiwDu7QcOj43pllbfrYPDvOkyk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FKeWl3EvH9CelNNwQlEWh3HkDH5kv3wl/F3jrPBQCfFRMiE6tzM3rrtU2RItKCXne
	 NJ1V4zMsxjPEV163t2pZSuidC0f7bM7G0hw9FsXRndSNR16o+dtEXtd54BTLT4KUlO
	 3y0y9JXsBb1wHJLpFludetWGbKwaoQJYaNRux3eA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfKSF2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:28:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbfKSF2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:28:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D3AC21823;
        Tue, 19 Nov 2019 05:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141324;
        bh=vOu5GY2HeiZhUlzomiwDu7QcOj43pllbfrYPDvOkyk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=05QTRegZsMvxA00gDDfwaMD8611PPcA2mOG5XLyOm47bDcFbz5332kLHg3gfURic1
         lR6PEu+sKD/zTeg72PrznDh9qEruKY28xNYk98hOPa1+lVeHYMRF7ESU5/HBA/TPt4
         y/lNxezCyhdsbGZCda4YH9wkjqWp5Psk3eGlHe6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Brauner <christian@brauner.io>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 122/422] rtnetlink: move type calculation out of loop
Date:   Tue, 19 Nov 2019 06:15:19 +0100
Message-Id: <20191119051406.920820019@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian@brauner.io>

[ Upstream commit 87ccbb1f943625884b824c5560f635dcea8e4510 ]

I don't see how the type - which is one of
RTM_{GETADDR,GETROUTE,GETNETCONF} - can change. So do the message type
calculation once before entering the for loop.

Signed-off-by: Christian Brauner <christian@brauner.io>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/rtnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 95768a9fca06e..c0de73b125802 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3268,13 +3268,13 @@ static int rtnl_dump_all(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	int idx;
 	int s_idx = cb->family;
+	int type = cb->nlh->nlmsg_type - RTM_BASE;
 
 	if (s_idx == 0)
 		s_idx = 1;
 
 	for (idx = 1; idx <= RTNL_FAMILY_MAX; idx++) {
 		struct rtnl_link **tab;
-		int type = cb->nlh->nlmsg_type-RTM_BASE;
 		struct rtnl_link *link;
 		rtnl_dumpit_func dumpit;
 
-- 
2.20.1



