Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A740CC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734D3222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611677;
	bh=JQi6aKOLE0wwtWtTLw0u7djK2iBnPGoeA7mPz4NJIYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Krpl5AJU8jhRO0bxy3aMgzOFDrNcsxJfB0WOGdMFUtM6WIwzzCZq9xR5/suR602bg
	 kbUdevoZsxl6WiScR33AyUB5flYxvI+MaSb/nAD6RvvdkiuvITwH9y26LSiOG3lBUr
	 nNXv0tL8NcBXTxrg4ob6cZGtiOaA4br+5ZaGaXG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfKMCVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:21:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728738AbfKMByC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:54:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7731C20674;
        Wed, 13 Nov 2019 01:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610042;
        bh=JQi6aKOLE0wwtWtTLw0u7djK2iBnPGoeA7mPz4NJIYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nx9kMdO4pDxJQAXtLHN3OAEZUCe7BDgCLelRI5G0rb5QpJHvJryvdfvih7ws6NNum
         XyUAc5gJdgDnAY5ImRhwwMzRMSli+Eylp2KuROLT2dx/jIG46MdKe3l9po8KgzNOU7
         9jBcyhDXxBzSz3tGLexP7/2HfeiSciGGpBmaH+IY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Li RongQing <lirongqing@baidu.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 132/209] xfrm: use correct size to initialise sp->ovec
Date:   Tue, 12 Nov 2019 20:49:08 -0500
Message-Id: <20191113015025.9685-132-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
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
index 790b514f86b62..d5635908587f4 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -131,7 +131,7 @@ struct sec_path *secpath_dup(struct sec_path *src)
 	sp->len = 0;
 	sp->olen = 0;
 
-	memset(sp->ovec, 0, sizeof(sp->ovec[XFRM_MAX_OFFLOAD_DEPTH]));
+	memset(sp->ovec, 0, sizeof(sp->ovec));
 
 	if (src) {
 		int i;
-- 
2.20.1

