Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77FBC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C22B21927
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468603;
	bh=9zTyihxQT4EJTdsTUMisudEX0jCUFmj216w9xmXXSmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TgGm63W8VpwXEy5s+i024Kg2jLa+ER/OKg9A28Yh3d/TDyLLvtVNnxzfsMyJXXFht
	 LTT+vipVv8k1frluLQoHoLLexpoCY7ZMech0owJJt3bRqOhPnbMjLdkCVpM+ov/r5z
	 +Dj+xpdgnkg9czpfShMKfUzYmHXKt4eFhORfCwa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfL0RnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:43:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728142AbfL0RnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:43:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DA072173E;
        Fri, 27 Dec 2019 17:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468593;
        bh=9zTyihxQT4EJTdsTUMisudEX0jCUFmj216w9xmXXSmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tMNA3qil3CToB4tQM/68dANSpQ99Sjr5X7upQS+dkvjgOdsOjgXoEEFxBjFWOSb9s
         50H+Pd5YbRXYPQKM1I1IEKhaTVXZU+lUJAM6ehxTy8B9EdoeD3goIZz3buTVa3kpo6
         Xe7wLsQiMssElfD3Rrvd2LXMigZHqnNwhyWlOPMU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Taehee Yoo <ap420073@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>,
        osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 115/187] gtp: avoid zero size hashtable
Date:   Fri, 27 Dec 2019 12:39:43 -0500
Message-Id: <20191227174055.4923-115-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 6a902c0f31993ab02e1b6ea7085002b9c9083b6a ]

GTP default hashtable size is 1024 and userspace could set specific
hashtable size with IFLA_GTP_PDP_HASHSIZE. If hashtable size is set to 0
from userspace,  hashtable will not work and panic will occur.

Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/gtp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 5450b1099c6d..e5b7d6d2286e 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -667,10 +667,13 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
 	if (err < 0)
 		return err;
 
-	if (!data[IFLA_GTP_PDP_HASHSIZE])
+	if (!data[IFLA_GTP_PDP_HASHSIZE]) {
 		hashsize = 1024;
-	else
+	} else {
 		hashsize = nla_get_u32(data[IFLA_GTP_PDP_HASHSIZE]);
+		if (!hashsize)
+			hashsize = 1024;
+	}
 
 	err = gtp_hashtable_new(gtp, hashsize);
 	if (err < 0)
-- 
2.20.1

