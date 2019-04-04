Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6236C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5997205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370867;
	bh=ME5p1rp+NlcYdq046JAhJ4S+BtKiJHBvQYDamaJQpcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W0tKLNmAczMKWqRixk9gLx0ezGs8hgtU/RvZuzjUYNBjNXHtQ6aHbyx0jcFmlg4rt
	 umDlfywRu4TeydRUxYRlJ/ON3vOF6jJCFQ+yTFM6hcya8cgmOaRSRE4pwD+9jR+7ej
	 NNatoVvYbWtM3op+liN4OzHMA5Ef+FExFWnoQVPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbfDDJCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:02:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731165AbfDDJCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:02:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7AB42147C;
        Thu,  4 Apr 2019 09:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368552;
        bh=ME5p1rp+NlcYdq046JAhJ4S+BtKiJHBvQYDamaJQpcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekTQLhTFNVN706pqjpFHpd8Q5KrhtLppdA2rLnj+0IcmHgPDrIqWtMQetH8l6lTeg
         MX29XZqiDbqKivOeh9TlpSQD7U16trd6OPiYbS1TQHrN8FbZed1VMXCSJqBl9XVFDg
         BuuMHg048cAT1dJNay3U504V9r8kIPaodzCizi8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 081/187] mwifiex: dont advertise IBSS features without FW support
Date:   Thu,  4 Apr 2019 10:46:58 +0200
Message-Id: <20190404084606.856776008@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



