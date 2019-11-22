Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76137C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417F22070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421018;
	bh=JQi6aKOLE0wwtWtTLw0u7djK2iBnPGoeA7mPz4NJIYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AX4NiTjma0loxlp39Ffc/s+aS4ZqixyhdLFkt9Thzqj/4zLon+k4+Xrcjfv+qr2ff
	 ow4MGvjPZVuHDI6ATFFKq3/UwTZT0jdk5WmXolk1ziReKR6ZuojKm61CLanAq/bzM3
	 wtdhRcMAQB4LtNUzqiFm9OOxLeOh9xLYRyjKMf1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbfKVLKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:10:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731002AbfKVLC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:02:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A59E02073F;
        Fri, 22 Nov 2019 11:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420546;
        bh=JQi6aKOLE0wwtWtTLw0u7djK2iBnPGoeA7mPz4NJIYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gImQgi0vnfxfVtiQGo6oZxLSYJg5Lz9lvddK0G9fONjLeeyPKoXtJ1LiQeOckfj0v
         QgT6DCeEPECiCVARzxo7F3RD1lkfjYfkWRPewcKGZ96LmZag4p9cosCnQrWzaOcPoI
         xIhN/sH9XO4sUqmerjFSgpFWWf1t4zQR28bKhMdg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 143/220] xfrm: use correct size to initialise sp->ovec
Date:   Fri, 22 Nov 2019 11:28:28 +0100
Message-Id: <20191122100923.060117962@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



