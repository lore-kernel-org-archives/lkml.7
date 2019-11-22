Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13378C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A35205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419682;
	bh=LH61V/qzUmWOj7rI6InJebjBB7kMjoSX9nWyR9/yzfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CguXiKWIpiPcH8gFw9dLgvbHDyE5xjfoHrdnW2Kt+8H7mSiy7406+e0Zl/Cx8RHzd
	 cA/TtxOSOuBBVEBGCsj+6/xNzNCLTl67ojQeNIfOe5v5q3VYnw++APZgyKbPEpVTkS
	 0s8rRjGBlrwoZDwyG1m08Y7Ux2Wu6htNrBUBOMuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfKVKsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:48:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729390AbfKVKry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:47:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C4320715;
        Fri, 22 Nov 2019 10:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419673;
        bh=LH61V/qzUmWOj7rI6InJebjBB7kMjoSX9nWyR9/yzfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MIglrufc9l8UZVTsm8snPqSQ8lnZDJfB16onXU3xt6tn9OwTK7fV0mgBgWlHXcEy9
         XUoVYxUsPlgYWYyyi3NJfXrcQuOTbZqz0LopElxkR3SI4NGUVZVQzrvvEWQ2dpqGvd
         ecT6TeOnZIppzcBq4VVmHXaQtplztjg3uwrWzMzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrew Zaborowski <andrew.zaborowski@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 166/222] nl80211: Fix a GET_KEY reply attribute
Date:   Fri, 22 Nov 2019 11:28:26 +0100
Message-Id: <20191122100914.560871101@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Zaborowski <andrew.zaborowski@intel.com>

[ Upstream commit efdfce7270de85a8706d1ea051bef3a7486809ff ]

Use the NL80211_KEY_IDX attribute inside the NL80211_ATTR_KEY in
NL80211_CMD_GET_KEY responses to comply with nl80211_key_policy.
This is unlikely to affect existing userspace.

Signed-off-by: Andrew Zaborowski <andrew.zaborowski@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 060bc0cc82526..bb19be78aed70 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3058,7 +3058,7 @@ static void get_key_callback(void *c, struct key_params *params)
 			 params->cipher)))
 		goto nla_put_failure;
 
-	if (nla_put_u8(cookie->msg, NL80211_ATTR_KEY_IDX, cookie->idx))
+	if (nla_put_u8(cookie->msg, NL80211_KEY_IDX, cookie->idx))
 		goto nla_put_failure;
 
 	nla_nest_end(cookie->msg, key);
-- 
2.20.1



