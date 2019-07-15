Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29552C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B662083D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199365;
	bh=9rnVUpRT6X/sVeEDWBhLqY50B2NpdW52Dny88IE/8F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VnHx8vTzZhHUZv+apNr/hxn89bsuaO0DrE4IJTW9H63h/tKR+yKr27kfxR89x+Djy
	 BpB1pL562aNlY2tKUDFhqUkbp9CJB3O6CiLo5dKPX743btyX7yv0ft1fuI98/oJTRh
	 3+hStUxC7WKxU41X2w/PwIe2dEOyGjtiZJ6Q8cPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbfGOOCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387661AbfGOOCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:02:34 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28C0120C01;
        Mon, 15 Jul 2019 14:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199353;
        bh=9rnVUpRT6X/sVeEDWBhLqY50B2NpdW52Dny88IE/8F4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TcE7SNIKGFYCFkeGPag5taVIlj9X32GTx3z/C0s05FSRlDQU69bWuwvzxgZkSUGQr
         DoXafL7YEDotO/n33cTt6xJsSSH47JGoVxDg4A4s7mX+gti9BvpDZf6vrQRVtPhI1g
         CPisawzpkDB234XcmvT5yKyx0hGIulCoISv5JsXE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Taehee Yoo <ap420073@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 242/249] gtp: add missing gtp_encap_disable_sock() in gtp_encap_enable()
Date:   Mon, 15 Jul 2019 09:46:47 -0400
Message-Id: <20190715134655.4076-242-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

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
index fc45b749db46..01fc51892e48 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -843,8 +843,13 @@ static int gtp_encap_enable(struct gtp_dev *gtp, struct nlattr *data[])
 
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

