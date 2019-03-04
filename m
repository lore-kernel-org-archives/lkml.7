Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C68C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8B920823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551689281;
	bh=OFnNu+23PGeHyNNLJyprflNtS3Asf+DKB7nivveaJHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SwEZuuxtovYFSqhaBQjgu+uUlX5WdQ7aomcw+SEYQKtIeLWkWwny5zlTrgtcPbg4G
	 aL2kQNpIuaFxFeVTMKEBdytWGqsaC8G/zJTNkekURkgMKazruW0L7+fnlkyL/XB3LX
	 V6KoBiHNDxbAubANCQUv7443Lr4KbB409zUjIJ7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfCDIXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:23:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfCDIXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:23:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B56AE208E4;
        Mon,  4 Mar 2019 08:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687801;
        bh=OFnNu+23PGeHyNNLJyprflNtS3Asf+DKB7nivveaJHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aKkMlS19b4jhe2JyXP0ej43w7Gr6YxaXu1q6vY76IHsoiIp+k75akNcbnBq/Xrmdh
         KKUFHDoQ8eUYNVNI9Aof07je9kT8EnM27rxRZcG6Uz3qjRkZDb9QK1OjmVSep8tBbW
         MSGT32Z6Fbz1UnBn0pBFFn3vNDIxd1x/L2EjZtbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Balaji Pothunoori <bpothuno@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 24/32] mac80211: dont initiate TDLS connection if station is not associated to AP
Date:   Mon,  4 Mar 2019 09:22:12 +0100
Message-Id: <20190304081604.051830003@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081602.307094059@linuxfoundation.org>
References: <20190304081602.307094059@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7ed5285396c257fd4070b1e29e7b2341aae2a1ce ]

Following call trace is observed while adding TDLS peer entry in driver
during TDLS setup.

Call Trace:
[<c1301476>] dump_stack+0x47/0x61
[<c10537d2>] __warn+0xe2/0x100
[<fa22415f>] ? sta_apply_parameters+0x49f/0x550 [mac80211]
[<c1053895>] warn_slowpath_null+0x25/0x30
[<fa22415f>] sta_apply_parameters+0x49f/0x550 [mac80211]
[<fa20ad42>] ? sta_info_alloc+0x1c2/0x450 [mac80211]
[<fa224623>] ieee80211_add_station+0xe3/0x160 [mac80211]
[<c1876fe3>] nl80211_new_station+0x273/0x420
[<c170f6d9>] genl_rcv_msg+0x219/0x3c0
[<c170f4c0>] ? genl_rcv+0x30/0x30
[<c170ee7e>] netlink_rcv_skb+0x8e/0xb0
[<c170f4ac>] genl_rcv+0x1c/0x30
[<c170e8aa>] netlink_unicast+0x13a/0x1d0
[<c170ec18>] netlink_sendmsg+0x2d8/0x390
[<c16c5acd>] sock_sendmsg+0x2d/0x40
[<c16c6369>] ___sys_sendmsg+0x1d9/0x1e0

Fixing this by allowing TDLS setup request only when we have completed
association.

Signed-off-by: Balaji Pothunoori <bpothuno@codeaurora.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 6ef9d32c34f1e..954315e1661df 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1425,6 +1425,10 @@ static int ieee80211_add_station(struct wiphy *wiphy, struct net_device *dev,
 	if (params->sta_flags_set & BIT(NL80211_STA_FLAG_TDLS_PEER))
 		sta->sta.tdls = true;
 
+	if (sta->sta.tdls && sdata->vif.type == NL80211_IFTYPE_STATION &&
+	    !sdata->u.mgd.associated)
+		return -EINVAL;
+
 	err = sta_apply_parameters(local, sta, params);
 	if (err) {
 		sta_info_free(local, sta);
-- 
2.19.1



