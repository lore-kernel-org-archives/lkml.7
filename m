Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C778C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194722070B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140281;
	bh=DE7BFBXdwc8kLsOo2gPx1/9Wfl0HiaSUcDV36wrhcsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R3S2LENMKpVZlZH/QopIZMw+zMTI8HSmrRMv1RMIzlZx8kGcms1VZgMDymXTYaSvF
	 5AsC2DODSp7nP0uXS5PA/dC64F8nmx8SN+20D5j4y0aODTpGi/qlvOuQ+nz6/mDST9
	 hbZhzPjrU9XLQTm6O9/9JJQ9IMae2ATlMhBGitq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388276AbfDARh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388252AbfDARh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:37:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73EB920896;
        Mon,  1 Apr 2019 17:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140275;
        bh=DE7BFBXdwc8kLsOo2gPx1/9Wfl0HiaSUcDV36wrhcsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYKL+6H74bc3HzIFlM4eZ6AS87o+FOddjv42lJHRnnxmmRN1VzCK2HkBX7gnU4CYr
         RLi2MLfTXGvGHm54Z1KhLhvwoPOZ4OYk1dDbp4lRoLZ5yc67HBa6CuW3VCN4YFslMK
         7Btvp107XE7bk/h54WyFJJpIwwTpV/WaeXQ/F6E0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 27/50] cfg80211: size various nl80211 messages correctly
Date:   Mon,  1 Apr 2019 19:03:10 +0200
Message-Id: <20190401170044.289549808@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
---
 net/wireless/nl80211.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2e1633ac93f7..800ef920b4f6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10586,7 +10586,7 @@ static void nl80211_send_mlme_event(struct cfg80211_registered_device *rdev,
 	struct sk_buff *msg;
 	void *hdr;
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	msg = nlmsg_new(100 + len, gfp);
 	if (!msg)
 		return;
 
@@ -10738,7 +10738,7 @@ void nl80211_send_connect_result(struct cfg80211_registered_device *rdev,
 	struct sk_buff *msg;
 	void *hdr;
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	msg = nlmsg_new(100 + req_ie_len + resp_ie_len, gfp);
 	if (!msg)
 		return;
 
@@ -10778,7 +10778,7 @@ void nl80211_send_roamed(struct cfg80211_registered_device *rdev,
 	struct sk_buff *msg;
 	void *hdr;
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	msg = nlmsg_new(100 + req_ie_len + resp_ie_len, gfp);
 	if (!msg)
 		return;
 
@@ -10816,7 +10816,7 @@ void nl80211_send_disconnected(struct cfg80211_registered_device *rdev,
 	struct sk_buff *msg;
 	void *hdr;
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	msg = nlmsg_new(100 + ie_len, GFP_KERNEL);
 	if (!msg)
 		return;
 
@@ -10893,7 +10893,7 @@ void cfg80211_notify_new_peer_candidate(struct net_device *dev, const u8 *addr,
 
 	trace_cfg80211_notify_new_peer_candidate(dev, addr);
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	msg = nlmsg_new(100 + ie_len, gfp);
 	if (!msg)
 		return;
 
@@ -11269,7 +11269,7 @@ int nl80211_send_mgmt(struct cfg80211_registered_device *rdev,
 	struct sk_buff *msg;
 	void *hdr;
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	msg = nlmsg_new(100 + len, gfp);
 	if (!msg)
 		return -ENOMEM;
 
@@ -11312,7 +11312,7 @@ void cfg80211_mgmt_tx_status(struct wireless_dev *wdev, u64 cookie,
 
 	trace_cfg80211_mgmt_tx_status(wdev, cookie, ack);
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	msg = nlmsg_new(100 + len, gfp);
 	if (!msg)
 		return;
 
@@ -12022,7 +12022,7 @@ void cfg80211_ft_event(struct net_device *netdev,
 	if (!ft_event->target_ap)
 		return;
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	msg = nlmsg_new(100 + ft_event->ric_ies_len, GFP_KERNEL);
 	if (!msg)
 		return;
 
-- 
2.19.1



