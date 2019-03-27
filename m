Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF44C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF972054F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710369;
	bh=c80z3gNG3M1BowWhAEYg2Y3VdXlEI905S2AFjE8wJDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L2/3WAIyCM7vrN0Mnm71SUcBcRqnTztStYXTUy/Vu7Qltr7Z3Ha0GsORSmOD2Auka
	 j1Q+RpCx5LOm+9Bv9N817EqqkWJdCnLpQJXrmtnntVOimx5tldFqC4XyTuIplZg9E8
	 PNzHjsh8v024ttBJXoK8IB3Na3xgWXrI+JafFH5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389269AbfC0SMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389017AbfC0SMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:12:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD1D321738;
        Wed, 27 Mar 2019 18:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710363;
        bh=c80z3gNG3M1BowWhAEYg2Y3VdXlEI905S2AFjE8wJDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1u6PRgBV/QHlXriwuTCg+9nkuTxzEFUP2wajX1sq2kyFP7JqELLtyAQXpUNF3RvnE
         JHq6HfN6TUabarFZIln8Zpt/d198hz4glowZATmEU0IIpjGBauxGAJCXXiAEvW9dJH
         ROzlhf3jyKuFmkgR+tH+0I9PURZgN5kc/A/SUM8c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 081/192] mwifiex: don't advertise IBSS features without FW support
Date:   Wed, 27 Mar 2019 14:08:33 -0400
Message-Id: <20190327181025.13507-81-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Norris <briannorris@chromium.org>

[ Upstream commit 6f21ab30469d670de620f758330aca9f3433f693 ]

As it is, doing something like

  # iw phy phy0 interface add foobar type ibss

on a firmware that doesn't have ad-hoc support just yields failures of
HostCmd_CMD_SET_BSS_MODE, which happened to return a '-1' error code
(-EPERM? not really right...) and sometimes may even crash the firmware
along the way.

Let's parse the firmware capability flag while registering the wiphy, so
we don't allow attempting IBSS at all, and we get a proper -EOPNOTSUPP
from nl80211 instead.

Fixes: e267e71e68ae ("mwifiex: Disable adhoc feature based on firmware capability")
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index adc88433faa8..2d87ebbfa4da 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4282,11 +4282,13 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 	wiphy->mgmt_stypes = mwifiex_mgmt_stypes;
 	wiphy->max_remain_on_channel_duration = 5000;
 	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
-				 BIT(NL80211_IFTYPE_ADHOC) |
 				 BIT(NL80211_IFTYPE_P2P_CLIENT) |
 				 BIT(NL80211_IFTYPE_P2P_GO) |
 				 BIT(NL80211_IFTYPE_AP);
 
+	if (ISSUPP_ADHOC_ENABLED(adapter->fw_cap_info))
+		wiphy->interface_modes |= BIT(NL80211_IFTYPE_ADHOC);
+
 	wiphy->bands[NL80211_BAND_2GHZ] = &mwifiex_band_2ghz;
 	if (adapter->config_bands & BAND_A)
 		wiphy->bands[NL80211_BAND_5GHZ] = &mwifiex_band_5ghz;
@@ -4346,11 +4348,13 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 	wiphy->available_antennas_tx = BIT(adapter->number_of_antenna) - 1;
 	wiphy->available_antennas_rx = BIT(adapter->number_of_antenna) - 1;
 
-	wiphy->features |= NL80211_FEATURE_HT_IBSS |
-			   NL80211_FEATURE_INACTIVITY_TIMER |
+	wiphy->features |= NL80211_FEATURE_INACTIVITY_TIMER |
 			   NL80211_FEATURE_LOW_PRIORITY_SCAN |
 			   NL80211_FEATURE_NEED_OBSS_SCAN;
 
+	if (ISSUPP_ADHOC_ENABLED(adapter->fw_cap_info))
+		wiphy->features |= NL80211_FEATURE_HT_IBSS;
+
 	if (ISSUPP_RANDOM_MAC(adapter->fw_cap_info))
 		wiphy->features |= NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR |
 				   NL80211_FEATURE_SCHED_SCAN_RANDOM_MAC_ADDR |
-- 
2.19.1

