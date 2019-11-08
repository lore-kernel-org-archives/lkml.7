Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FBDFC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE27C206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573215217;
	bh=xCW/lSW1U3Vl+AVPWZpivK93tjtE9RmQzvGRaO6XjAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d4d5XK0akkt5grbjV/muIWn7GzzWOeJAU9XVuM8o5XxtO/Y8EzFGsDbecBdinpZOZ
	 uk3/n778fYedFCyn6qsyZeuE3vQ72ok2oFd/JU+DYimEC0obGKvkxMznaqr+O7+ukD
	 cg8Fz6HrrkZLI8eDG+ajVDeX7midHbJ/nyZQTxIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbfKHLiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:38:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732378AbfKHLiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:38:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5DE720869;
        Fri,  8 Nov 2019 11:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213096;
        bh=xCW/lSW1U3Vl+AVPWZpivK93tjtE9RmQzvGRaO6XjAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qtRZig1KtoHepME2rcxOoBueBZik0izotpqd9cM0pV2q+z6FDX36cSQsw8+o/+Fii
         YHXX6gBxt1SOTlHELhn4KiAQu51A+2L3w8pvisN/nZzhMHs0Vs7aSLXXFFIJ+eewa8
         G8xI9xd0xPJwWRs6anQcZ+P1C4IYeDC5UfFeNjbA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rajeev Kumar Sirasanagandla <rsirasan@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 021/205] cfg80211: Avoid regulatory restore when COUNTRY_IE_IGNORE is set
Date:   Fri,  8 Nov 2019 06:34:48 -0500
Message-Id: <20191108113752.12502-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index cccbf845079c8..68ae97ef8bf0b 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -3225,8 +3225,54 @@ static void restore_regulatory_settings(bool reset_user)
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

