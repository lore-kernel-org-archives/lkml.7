Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D743C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF9520843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918971;
	bh=FgOaEdWXWdI9Uio6JxtBlVsp/ME4wbq9iRoBd2VUNTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g7pd33bpbYuUwKbkF21nVNKbqsVqi3spKBjIBtG5cxUPQjD2YowvwRVU7SYsrjOYq
	 Z8sO4P4rsKm+wMUanDstD75Bd1Vi80DhZZaotd0h92Jfgzmay0EyC1OBPlNWDx54MO
	 l02+cf2xEzFqSO9+iiSa6NZsCWPrqHmIKidz7OwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfEOLQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:16:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730424AbfEOLQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:16:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F96A20843;
        Wed, 15 May 2019 11:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918966;
        bh=FgOaEdWXWdI9Uio6JxtBlVsp/ME4wbq9iRoBd2VUNTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T2CJP5npm9+FImBEs4AoI1iZDMXLBV0cZWMl2wTENvMKd6vBPM2M9jJL6tjxijE5j
         0i3Q/yGSADbfUNnh1Y40hftCeGarx9rHMu+ubhJByA8vF3vpv/cENnkqI/xpWxHA/2
         RJiyES1S7M2mco71l6vba5g3vMO7rPJC7s8C9pOg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sunil Dutt <usdutt@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 017/115] nl80211: Add NL80211_FLAG_CLEAR_SKB flag for other NL commands
Date:   Wed, 15 May 2019 12:54:57 +0200
Message-Id: <20190515090700.546516764@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090659.123121100@linuxfoundation.org>
References: <20190515090659.123121100@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d6db02a88a4aaa1cd7105137c67ddec7f3bdbc05 ]

This commit adds NL80211_FLAG_CLEAR_SKB flag to other NL commands
that carry key data to ensure they do not stick around on heap
after the SKB is freed.

Also introduced this flag for NL80211_CMD_VENDOR as there are sub
commands which configure the keys.

Signed-off-by: Sunil Dutt <usdutt@codeaurora.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 46e9812d13c02..c1a2ad050e617 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12761,7 +12761,8 @@ static const struct genl_ops nl80211_ops[] = {
 		.policy = nl80211_policy,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+				  NL80211_FLAG_NEED_RTNL |
+				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
 		.cmd = NL80211_CMD_DEAUTHENTICATE,
@@ -12812,7 +12813,8 @@ static const struct genl_ops nl80211_ops[] = {
 		.policy = nl80211_policy,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+				  NL80211_FLAG_NEED_RTNL |
+				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
 		.cmd = NL80211_CMD_UPDATE_CONNECT_PARAMS,
@@ -12820,7 +12822,8 @@ static const struct genl_ops nl80211_ops[] = {
 		.policy = nl80211_policy,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+				  NL80211_FLAG_NEED_RTNL |
+				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
 		.cmd = NL80211_CMD_DISCONNECT,
@@ -12849,7 +12852,8 @@ static const struct genl_ops nl80211_ops[] = {
 		.policy = nl80211_policy,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+				  NL80211_FLAG_NEED_RTNL |
+				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
 		.cmd = NL80211_CMD_DEL_PMKSA,
@@ -13201,7 +13205,8 @@ static const struct genl_ops nl80211_ops[] = {
 		.policy = nl80211_policy,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WIPHY |
-				  NL80211_FLAG_NEED_RTNL,
+				  NL80211_FLAG_NEED_RTNL |
+				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
 		.cmd = NL80211_CMD_SET_QOS_MAP,
@@ -13256,7 +13261,8 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_set_pmk,
 		.policy = nl80211_policy,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+				  NL80211_FLAG_NEED_RTNL |
+				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
 		.cmd = NL80211_CMD_DEL_PMK,
-- 
2.20.1



