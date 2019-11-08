Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A451C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCF22085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214961;
	bh=1trDmOUYVi/h8TeA1Jy2TYemlFI7NDFW1aOIVk9jWwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mfg1J/WDGGBSplSw95NdWGxYDi3BvMW97Wz7zp/kMoTrSh1WIO7K/Xu5UEHfF7YWJ
	 DrSw/YmAZBWrPgGGzlKImP0aS073i10vkp6/IffO2VxHtm8riBZ1BoGpzPwIkyF1wB
	 xYrGjpl8fmkrlBtvMkbylBgdCcJTUXz1Sdtu8coI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391937AbfKHMJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:09:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388436AbfKHLkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:40:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98F99222C6;
        Fri,  8 Nov 2019 11:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213209;
        bh=1trDmOUYVi/h8TeA1Jy2TYemlFI7NDFW1aOIVk9jWwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CjpKEg3Vyw1y9ZsRn9sou3pmHUi595QPkjEd/YXlTg7OwXNQ+YjdXm8m7gt6F489A
         Tpr5Pj3KM7aWB0s1s7FKqQ3YlokGX1ZpLpHyVrAKEHN0ZyAVFujdnoN2mZqmTNawIA
         8pgKxjtNOF2E3Y5qZ+6AYhTUSWn+6cGf/l7rTBfQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Brauner <christian@brauner.io>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 090/205] rtnetlink: move type calculation out of loop
Date:   Fri,  8 Nov 2019 06:35:57 -0500
Message-Id: <20191108113752.12502-90-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 3932eed379a40..a199bd85085da 100644
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

