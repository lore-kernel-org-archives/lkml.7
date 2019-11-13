Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EDEC17441
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7217F214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611113;
	bh=6ae5gLZHT9rVDPo0bjsJcFqpzYZgUkjFH0R3EQ7FAyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1s8ffIS0YN9jx7My2kJrCJJ4AbbbCZuaTzLZhK+HIWBHIHVyfb9/YHjm4xlzhAPFE
	 81OsqVbjDqdAqB1Wvw1XDl9K7DsiNPr+D9H9CvspBjC7N1lI81lIHRdtp5WKJtsjZM
	 2Idj9lp9ec7b+7PE8lhPPg5IapIVha9VVoReIiIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbfKMB6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:58:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbfKMB63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:58:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED37A22470;
        Wed, 13 Nov 2019 01:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610308;
        bh=6ae5gLZHT9rVDPo0bjsJcFqpzYZgUkjFH0R3EQ7FAyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F+Rypyseu/60HdfoG4rak7/KimabtHrdYaGRy/ppqhDLu2jVy4pu/NUc4Z1f2Qlfw
         j1JcBXthYRv8gpIHpiDC3szKVXEfqET0osNSUxZnR8rwfZjq9N0XlHr98y09CidzQD
         4ZMiJxxXyinQNwQPjkWm6h3Wyo6Ea/n6OmUnBj4o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li RongQing <lirongqing@baidu.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 077/115] xfrm: use correct size to initialise sp->ovec
Date:   Tue, 12 Nov 2019 20:55:44 -0500
Message-Id: <20191113015622.11592-77-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit f1193e915748291fb205a908db33bd3debece6e2 ]

This place should want to initialize array, not a element,
so it should be sizeof(array) instead of sizeof(element)

but now this array only has one element, so no error in
this condition that XFRM_MAX_OFFLOAD_DEPTH is 1

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 06dec32503bd6..fc0a9ce1be18f 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -130,7 +130,7 @@ struct sec_path *secpath_dup(struct sec_path *src)
 	sp->len = 0;
 	sp->olen = 0;
 
-	memset(sp->ovec, 0, sizeof(sp->ovec[XFRM_MAX_OFFLOAD_DEPTH]));
+	memset(sp->ovec, 0, sizeof(sp->ovec));
 
 	if (src) {
 		int i;
-- 
2.20.1

