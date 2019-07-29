Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5CAC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713A5205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564431181;
	bh=WlJ4yrxopqTT3+7UsmQK1o/hzQ+WKHc5DJDQr2AXGWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gsym+NlgszgH35t9iCoW50+FshZbfdFypiIPUxudcZg11FoaUhrPjwhpvGFyl3MSp
	 bTZVk7sgagd4+qj/tO6svfTlMeam59Kl2Z4d9b6jGcsGiLbtJs1SmGJzlZ+2MOgIIH
	 1yCjFEKP87UmvB9sBO5Kh8g8bYQPKt0rv84hF1ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfG2UNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729464AbfG2TbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:31:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63C30217F4;
        Mon, 29 Jul 2019 19:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428669;
        bh=WlJ4yrxopqTT3+7UsmQK1o/hzQ+WKHc5DJDQr2AXGWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uYYsFaS6xLwkEqOS7S69EISfh5nodjcLNdpjfNX/WEAiKrTBSkM3mBD4eDLh+sAXR
         VpFrR6Y/h687kUwzE+HVy6xUOaoU7rGpOXA+swyZczFkjKJJM7Zm9pevfdZn29gmG8
         Xwu2jIKLNaRBmVg+291zWz4a/fZTAj8EWaC8O2C4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 099/293] gtp: add missing gtp_encap_disable_sock() in gtp_encap_enable()
Date:   Mon, 29 Jul 2019 21:19:50 +0200
Message-Id: <20190729190832.220102907@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
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
index f38e32a7ec9c..dba3869b61be 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -845,8 +845,13 @@ static int gtp_encap_enable(struct gtp_dev *gtp, struct nlattr *data[])
 
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



