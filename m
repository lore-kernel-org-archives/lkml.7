Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693A8C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0D024A93
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186810;
	bh=figzrZJk28omJxNn3z3++baoDIH28NEjwx59Tq0jw9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IJvHOe1IINMJnIFLwiO9Qb9qp90mcSQVKQJzv5NIklgP3laGDwuE9uiLsLJ3DKhth
	 HqSjcJcVo3BS6WUnA7dpC2E0F/pg9UZOrr/HeR3GIan+TH876XcjnpEv+icslK7SZU
	 G0Ct6c4ID2wLXKFkKdvhkJkp2sAeZtDxQZd1RYd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387431AbfE3D0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:26:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730851AbfE3DTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:19:02 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EE2D24823;
        Thu, 30 May 2019 03:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186341;
        bh=figzrZJk28omJxNn3z3++baoDIH28NEjwx59Tq0jw9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0d/f40jBA6iORE4JnSknPixlNHrsea2YNwRZ3a6okET9aJ1OKVaGmVmxDOlilLZAe
         +Xnseb5/IbeGrX6ZujqhYluGRb0Tv/nytRn/ImAkxvrx36QwTaNsYOm0xpsJC9cZRt
         ELyIUDQOxEKT9QbBWWPaweUOLcmWY8Ugt1b8cG7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 067/193] mac80211/cfg80211: update bss channel on channel switch
Date:   Wed, 29 May 2019 20:05:21 -0700
Message-Id: <20190530030458.695246233@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030446.953835040@linuxfoundation.org>
References: <20190530030446.953835040@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5dc8cdce1d722c733f8c7af14c5fb595cfedbfa8 ]

FullMAC STAs have no way to update bss channel after CSA channel switch
completion. As a result, user-space tools may provide inconsistent
channel info. For instance, consider the following two commands:
$ sudo iw dev wlan0 link
$ sudo iw dev wlan0 info
The latter command gets channel info from the hardware, so most probably
its output will be correct. However the former command gets channel info
from scan cache, so its output will contain outdated channel info.
In fact, current bss channel info will not be updated until the
next [re-]connect.

Note that mac80211 STAs have a workaround for this, but it requires
access to internal cfg80211 data, see ieee80211_chswitch_work:

	/* XXX: shouldn't really modify cfg80211-owned data! */
	ifmgd->associated->channel = sdata->csa_chandef.chan;

This patch suggests to convert mac80211 workaround into cfg80211 behavior
and to update current bss channel in cfg80211_ch_switch_notify.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c    | 3 ---
 net/wireless/nl80211.c | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 4c59b5507e7ac..33bd6da00a1c5 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1071,9 +1071,6 @@ static void ieee80211_chswitch_work(struct work_struct *work)
 		goto out;
 	}
 
-	/* XXX: shouldn't really modify cfg80211-owned data! */
-	ifmgd->associated->channel = sdata->csa_chandef.chan;
-
 	ifmgd->csa_waiting_bcn = true;
 
 	ieee80211_sta_reset_beacon_monitor(sdata);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c1a2ad050e617..c672a790df1ce 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -14706,6 +14706,11 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 
 	wdev->chandef = *chandef;
 	wdev->preset_chandef = *chandef;
+
+	if (wdev->iftype == NL80211_IFTYPE_STATION &&
+	    !WARN_ON(!wdev->current_bss))
+		wdev->current_bss->pub.channel = chandef->chan;
+
 	nl80211_ch_switch_notify(rdev, dev, chandef, GFP_KERNEL,
 				 NL80211_CMD_CH_SWITCH_NOTIFY, 0);
 }
-- 
2.20.1



