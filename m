Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3D1C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22C120665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999263;
	bh=YT/Ya2QuCV54Ta5zpV7aCETVkK9+itqi5z18Zxh8/2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FLMTvl+qkf0EVWT1HSwBhXwWGVX+4yDN6sZ4cMoHR+fYiEuEBMKgM/BoyqYlXAir0
	 fwQEehvR7H+Q+MJsZJjteS9EEiJ7bLVUBfK+v8dD2zUU2soDvSoXMNOOP/tug5kNGJ
	 cOnsidYFNxiqyBHbRYikqKYOj4/HaCV6DP8OetOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392339AbfGXUOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391937AbfGXTzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:55:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C472E20665;
        Wed, 24 Jul 2019 19:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998123;
        bh=YT/Ya2QuCV54Ta5zpV7aCETVkK9+itqi5z18Zxh8/2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XwiqL3uPB7HZ2cmxexelD+ja3R4sdLUTZYwnsd4rMpBZ1PrUkoeLnMDglcHjtsK9r
         T3xC/p7TNPYdBPuCklwYmdqff5t12HgqjZbdM7aMgn2smlhvuOVb/aUYPgWiK7/Ov3
         4DR+sw+65WxGhyARmwoupVMitsOyyqCEs1MfGDPc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 212/371] gtp: add missing gtp_encap_disable_sock() in gtp_encap_enable()
Date:   Wed, 24 Jul 2019 21:19:24 +0200
Message-Id: <20190724191740.529229336@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e30155fd23c9c141cbe7d99b786e10a83a328837 ]

If an invalid role is sent from user space, gtp_encap_enable() will fail.
Then, it should call gtp_encap_disable_sock() but current code doesn't.
It makes memory leak.

Fixes: 91ed81f9abc7 ("gtp: support SGSN-side tunnels")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/gtp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 7a145172d503..83488f2bf7a0 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -847,8 +847,13 @@ static int gtp_encap_enable(struct gtp_dev *gtp, struct nlattr *data[])
 
 	if (data[IFLA_GTP_ROLE]) {
 		role = nla_get_u32(data[IFLA_GTP_ROLE]);
-		if (role > GTP_ROLE_SGSN)
+		if (role > GTP_ROLE_SGSN) {
+			if (sk0)
+				gtp_encap_disable_sock(sk0);
+			if (sk1u)
+				gtp_encap_disable_sock(sk1u);
 			return -EINVAL;
+		}
 	}
 
 	gtp->sk0 = sk0;
-- 
2.20.1



