Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88FAC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4BA21900
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139668;
	bh=9ho2BIPOAZ9w85tJgHiH9+fpSdRkJa5Jayxrw4tIlM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a21Xd7FKQJfElEVK4cjg1cd63ZPvvBFhMqXL2ymu60v06lzWlqwvI7RmkcIcn0uL6
	 JUwxfRfrVU2zN5RdcmumS4V/4E7C/SplPTs77/23up4lZmi6re/4zm4gYd4Oxjr9X4
	 /jk8vrp7yvNFArDpeaHkyVM3/KkYKrmO1bgyhKy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732703AbfDAR1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:27:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732252AbfDAR1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:27:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C07F2063F;
        Mon,  1 Apr 2019 17:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139661;
        bh=9ho2BIPOAZ9w85tJgHiH9+fpSdRkJa5Jayxrw4tIlM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkqNBZ6/awDYxM3MnSMmRa9Rwo2jYKcPixNCpaO9zUAXNncnHdaS4GjPeIt5AuXiG
         vX/h526XRo/xHRA8h0LPEsBfrK3EzFQpPH/mwq53N+eh4xjywju3ECyeJvX0y6oZbL
         Su2dlgUkrQxTPmkNZusOI0orSsSxAkgRyE0tmP4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 04/56] cfg80211: size various nl80211 messages correctly
Date:   Mon,  1 Apr 2019 19:02:20 +0200
Message-Id: <20190401170103.718175610@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

[ Upstream commit 4ef8c1c93f848e360754f10eb2e7134c872b6597 ]

Ilan reported that sometimes nl80211 messages weren't working if
the frames being transported got very large, which was really a
problem for userspace-to-kernel messages, but prompted me to look
at the code.

Upon review, I found various places where variable-length data is
transported in an nl80211 message but the message isn't allocated
taking that into account. This shouldn't cause any problems since
the frames aren't really that long, apart in one place where two
(possibly very long frames) might not fit.

Fix all the places (that I found) that get variable length data
from the driver and put it into a message to take the length of
the variable data into account. The 100 there is just a safe
constant for the remaining message overhead (it's usually around
50 for most messages.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/nl80211.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -12942,7 +12942,7 @@ static void nl80211_send_mlme_event(stru
 	struct sk_buff *msg;
 	void *hdr;
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	msg = nlmsg_new(100 + len, gfp);
 	if (!msg)
 		return;
 
@@ -13094,7 +13094,7 @@ void nl80211_send_connect_result(struct
 	struct sk_buff *msg;
 	void *hdr;
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	msg = nlmsg_new(100 + req_ie_len + resp_ie_len, gfp);
 	if (!msg)
 		return;
 
@@ -13136,7 +13136,7 @@ void nl80211_send_roamed(struct cfg80211
 	struct sk_buff *msg;
 	void *hdr;
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	msg = nlmsg_new(100 + req_ie_len + resp_ie_len, gfp);
 	if (!msg)
 		return;
 
@@ -13173,7 +13173,7 @@ void nl80211_send_disconnected(struct cf
 	struct sk_buff *msg;
 	void *hdr;
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	msg = nlmsg_new(100 + ie_len, GFP_KERNEL);
 	if (!msg)
 		return;
 
@@ -13249,7 +13249,7 @@ void cfg80211_notify_new_peer_candidate(
 
 	trace_cfg80211_notify_new_peer_candidate(dev, addr);
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	msg = nlmsg_new(100 + ie_len, gfp);
 	if (!msg)
 		return;
 
@@ -13620,7 +13620,7 @@ int nl80211_send_mgmt(struct cfg80211_re
 	struct sk_buff *msg;
 	void *hdr;
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	msg = nlmsg_new(100 + len, gfp);
 	if (!msg)
 		return -ENOMEM;
 
@@ -13664,7 +13664,7 @@ void cfg80211_mgmt_tx_status(struct wire
 
 	trace_cfg80211_mgmt_tx_status(wdev, cookie, ack);
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	msg = nlmsg_new(100 + len, gfp);
 	if (!msg)
 		return;
 
@@ -14473,7 +14473,7 @@ void cfg80211_ft_event(struct net_device
 	if (!ft_event->target_ap)
 		return;
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	msg = nlmsg_new(100 + ft_event->ric_ies_len, GFP_KERNEL);
 	if (!msg)
 		return;
 


