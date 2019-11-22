Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D95DC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213C220708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421784;
	bh=mhHN88vt379iosWB8gbGNyPhtscPz6r7O0iId8KiFuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F4TBdCkbppvU53x8u9vHisMsE+dBoifjUP7K7ykv6dCMvnYnOh5RL/eyFsz3hV5Gf
	 OVthuKCgbGyZ2VnPTDdXKaGfWHgCspebxYFJHf3vh05gv8E5LWzV73q7z41xEoupkO
	 LXJmVVVT3FWgrX/zuCofC084XsYNkFOIpgSwdNcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfKVLXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:23:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728564AbfKVKmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:42:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DB9E20715;
        Fri, 22 Nov 2019 10:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419332;
        bh=mhHN88vt379iosWB8gbGNyPhtscPz6r7O0iId8KiFuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mZnSUznmaA4l6ttln231FYTVIqlNTWyphbISEfpRT9HczuK8QWXRSjnl+HD+SCT8q
         68b9DNeU8lxzfzUBIKKmwVw4WTrG6DrbCQL8G0OX367F5x0YLyBq/um/5yccLMuNW5
         urZbRlQDs8Gs3jgy5vFHLn3ZIQDsp1g7CxT3PAHg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rajeev Kumar Sirasanagandla <rsirasan@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 021/222] cfg80211: Avoid regulatory restore when COUNTRY_IE_IGNORE is set
Date:   Fri, 22 Nov 2019 11:26:01 +0100
Message-Id: <20191122100836.916233887@linuxfoundation.org>
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

From: Rajeev Kumar Sirasanagandla <rsirasan@codeaurora.org>

[ Upstream commit 7417844b63d4b0dc8ab23f88259bf95de7d09b57 ]

When REGULATORY_COUNTRY_IE_IGNORE is set,  __reg_process_hint_country_ie()
ignores the country code change request from __cfg80211_connect_result()
via regulatory_hint_country_ie().

After Disconnect, similar to above, country code should not be reset to
world when country IE ignore is set. But this is violated and restore of
regulatory settings is invoked by cfg80211_disconnect_work via
regulatory_hint_disconnect().

To address this, avoid regulatory restore from regulatory_hint_disconnect()
when COUNTRY_IE_IGNORE is set.

Note: Currently, restore_regulatory_settings() takes care of clearing
beacon hints. But in the proposed change, regulatory restore is avoided.
Therefore, explicitly clear beacon hints when DISABLE_BEACON_HINTS
is not set.

Signed-off-by: Rajeev Kumar Sirasanagandla <rsirasan@codeaurora.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/reg.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 44befe9f9ff08..dde741f298de7 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2616,8 +2616,54 @@ static void restore_regulatory_settings(bool reset_user)
 	schedule_work(&reg_work);
 }
 
+static bool is_wiphy_all_set_reg_flag(enum ieee80211_regulatory_flags flag)
+{
+	struct cfg80211_registered_device *rdev;
+	struct wireless_dev *wdev;
+
+	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
+		list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
+			wdev_lock(wdev);
+			if (!(wdev->wiphy->regulatory_flags & flag)) {
+				wdev_unlock(wdev);
+				return false;
+			}
+			wdev_unlock(wdev);
+		}
+	}
+
+	return true;
+}
+
 void regulatory_hint_disconnect(void)
 {
+	/* Restore of regulatory settings is not required when wiphy(s)
+	 * ignore IE from connected access point but clearance of beacon hints
+	 * is required when wiphy(s) supports beacon hints.
+	 */
+	if (is_wiphy_all_set_reg_flag(REGULATORY_COUNTRY_IE_IGNORE)) {
+		struct reg_beacon *reg_beacon, *btmp;
+
+		if (is_wiphy_all_set_reg_flag(REGULATORY_DISABLE_BEACON_HINTS))
+			return;
+
+		spin_lock_bh(&reg_pending_beacons_lock);
+		list_for_each_entry_safe(reg_beacon, btmp,
+					 &reg_pending_beacons, list) {
+			list_del(&reg_beacon->list);
+			kfree(reg_beacon);
+		}
+		spin_unlock_bh(&reg_pending_beacons_lock);
+
+		list_for_each_entry_safe(reg_beacon, btmp,
+					 &reg_beacon_list, list) {
+			list_del(&reg_beacon->list);
+			kfree(reg_beacon);
+		}
+
+		return;
+	}
+
 	pr_debug("All devices are disconnected, going to restore regulatory settings\n");
 	restore_regulatory_settings(false);
 }
-- 
2.20.1



