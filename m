Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DD5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA0F20717
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572212061;
	bh=G8fdBiczYjP1dj+XAo4W0fgeejN6M3is5d/XqM9NW8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PUbwQ0mw9hGQZJMfzxXycaic8IEEQoyl2we9mK7EZJcVzPMA5OdaJkUOGWTvcQMHL
	 tT3B2GDPKyc03jhB2XXOWKBer6n/kMAH8fH/jNjqkBb5hibjxO1H4OD8txfk/JXtOf
	 VGyWW2MiHNBly/6pQgzDrm2UD9eoOEa8dvj5cDhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbfJ0VeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729848AbfJ0VLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:11:11 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D3AF21848;
        Sun, 27 Oct 2019 21:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210671;
        bh=G8fdBiczYjP1dj+XAo4W0fgeejN6M3is5d/XqM9NW8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rkg8Ctn/yfpSanX5+0UrZ6qI6KmSFCqSW5FpmootWeb03+dq1KS8GCjHfgOLG3UhT
         V0xYWs+F5URIUVmuYLKL7EITIF6r4aGv0oqjJyLUbx726wxtlwM4XbsvB3c0XofpH/
         P40rx7qeyuaH4Nh9mYctPy7wsa1svt2bqaOHjY7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nicolas Waisman <nico@semmle.com>,
        Will Deacon <will@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.14 094/119] cfg80211: wext: avoid copying malformed SSIDs
Date:   Sun, 27 Oct 2019 22:01:11 +0100
Message-Id: <20191027203348.587555174@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203259.948006506@linuxfoundation.org>
References: <20191027203259.948006506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

commit 4ac2813cc867ae563a1ba5a9414bfb554e5796fa upstream.

Ensure the SSID element is bounds-checked prior to invoking memcpy()
with its length field, when copying to userspace.

Cc: <stable@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Reported-by: Nicolas Waisman <nico@semmle.com>
Signed-off-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20191004095132.15777-2-will@kernel.org
[adjust commit log a bit]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/wext-sme.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/wireless/wext-sme.c
+++ b/net/wireless/wext-sme.c
@@ -202,6 +202,7 @@ int cfg80211_mgd_wext_giwessid(struct ne
 			       struct iw_point *data, char *ssid)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	int ret = 0;
 
 	/* call only for station! */
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION))
@@ -219,7 +220,10 @@ int cfg80211_mgd_wext_giwessid(struct ne
 		if (ie) {
 			data->flags = 1;
 			data->length = ie[1];
-			memcpy(ssid, ie + 2, data->length);
+			if (data->length > IW_ESSID_MAX_SIZE)
+				ret = -EINVAL;
+			else
+				memcpy(ssid, ie + 2, data->length);
 		}
 		rcu_read_unlock();
 	} else if (wdev->wext.connect.ssid && wdev->wext.connect.ssid_len) {
@@ -229,7 +233,7 @@ int cfg80211_mgd_wext_giwessid(struct ne
 	}
 	wdev_unlock(wdev);
 
-	return 0;
+	return ret;
 }
 
 int cfg80211_mgd_wext_siwap(struct net_device *dev,


