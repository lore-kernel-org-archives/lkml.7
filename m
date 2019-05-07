Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73A9C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48E920578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207542;
	bh=jeJGDc8l4Oaneh2pqsP3PwJOVf5dFKG6BvceobaaJE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RWiMN7ZGXn+gdHLSx286JscvRwb5WMNq8+ZrTvurir12rC7oINM+1K46aUGOkgJjf
	 LNhxCJLPtvOa8wNgp5RKLXd+pc6ctr5u73NsqmRDqro2Y5km6XiGoj7EFX/P50nVwj
	 H7tnCUt+zaYWwwsCGYxXJRWrytNM8dgYHZwANhos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfEGFjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbfEGFiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:38:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3E0520675;
        Tue,  7 May 2019 05:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207534;
        bh=jeJGDc8l4Oaneh2pqsP3PwJOVf5dFKG6BvceobaaJE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHDXQHD+oSdL5AokBSwCZc/4W5+EyoAhlSp5QiA3UTtUmMriN3lni1ihyL/+noOoT
         GZ/rw3L+iCqfYCRV/NmP0zmJoiRVkq5MQMwgrsVH3rteG0AWgj8fszo8aYBq78RvtN
         eHJLeKIbj+wp4zKLvldFC/gwsR+1/J2dl7+Oesxc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 15/95] mISDN: Check address length before reading address family
Date:   Tue,  7 May 2019 01:37:04 -0400
Message-Id: <20190507053826.31622-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053826.31622-1-sashal@kernel.org>
References: <20190507053826.31622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 238ffdc49ef98b15819cfd5e3fb23194e3ea3d39 ]

KMSAN will complain if valid address length passed to bind() is shorter
than sizeof("struct sockaddr_mISDN"->family) bytes.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/isdn/mISDN/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/isdn/mISDN/socket.c b/drivers/isdn/mISDN/socket.c
index c5603d1a07d6..65cb4aac8dce 100644
--- a/drivers/isdn/mISDN/socket.c
+++ b/drivers/isdn/mISDN/socket.c
@@ -712,10 +712,10 @@ base_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	struct sock *sk = sock->sk;
 	int err = 0;
 
-	if (!maddr || maddr->family != AF_ISDN)
+	if (addr_len < sizeof(struct sockaddr_mISDN))
 		return -EINVAL;
 
-	if (addr_len < sizeof(struct sockaddr_mISDN))
+	if (!maddr || maddr->family != AF_ISDN)
 		return -EINVAL;
 
 	lock_sock(sk);
-- 
2.20.1

