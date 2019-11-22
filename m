Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F136BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17C020707
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418993;
	bh=eOU3hIZ/nTfjPK4jdXxifgdMXaDFD9gZboYjupgngJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ps2G2hO9cKDr165+4HEmvkgS885mO/5si5exPz7OLeWKh9Q5AlMnPqRmcmAa3O0H4
	 oWRardASlPNqybcrkgP1yaP0aHVk9DCazHGORqLrT5T81OVo0rsXhhLxGt3wgspOnl
	 z/j9gr9b3s/EEt8DVhcGMcLneJw3g4EYvHcg9wXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfKVKgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:36:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbfKVKg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:36:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EED520708;
        Fri, 22 Nov 2019 10:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418988;
        bh=eOU3hIZ/nTfjPK4jdXxifgdMXaDFD9gZboYjupgngJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kSFln8aT/ii9B3BY5f1/nmlVlCOfq3dpnFwsr4vzlNUYEX0V3TjP+fPXgL/xO1GRy
         xjJThDSM5lSfALZoKupASw8/ArgfEfWFO31IjFZEsHRYSErOEGmFurms4YR+L4znYP
         BHM7MGSjAtRKJwD1xom/HpeovD1T9fcOePhsbEe4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrew Zaborowski <andrew.zaborowski@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 118/159] nl80211: Fix a GET_KEY reply attribute
Date:   Fri, 22 Nov 2019 11:28:29 +0100
Message-Id: <20191122100830.768543658@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
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
index 4de66dbd5bb60..fd0bf278067ef 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2879,7 +2879,7 @@ static void get_key_callback(void *c, struct key_params *params)
 			 params->cipher)))
 		goto nla_put_failure;
 
-	if (nla_put_u8(cookie->msg, NL80211_ATTR_KEY_IDX, cookie->idx))
+	if (nla_put_u8(cookie->msg, NL80211_KEY_IDX, cookie->idx))
 		goto nla_put_failure;
 
 	nla_nest_end(cookie->msg, key);
-- 
2.20.1



