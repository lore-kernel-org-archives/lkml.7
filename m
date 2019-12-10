Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4C2C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1C92077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576017285;
	bh=KVELWriR2M1QbPsog9zvcEmalOdJbCRZm84jFAznJBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yHOwpFGDMsAxObg37IYY5AUlaHz3htvVRXGsBmsrzzsX/96YRF0bSRrd+sjVft4aH
	 VeLZxenSSEvvFr3zWTXB0FoWU7bjHDuHYhrYeHMFs6BrynDtBjrCDw0Y2dQFBpW2xd
	 qqXG0pX8zSKNM5+DPqzIA7jaVX4Mw1B2LF7oyZ5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbfLJWen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:34:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730380AbfLJWed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:34:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2527820828;
        Tue, 10 Dec 2019 22:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576017272;
        bh=KVELWriR2M1QbPsog9zvcEmalOdJbCRZm84jFAznJBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0TIcZJN+cVE5+3j9ChNbBsg9P1oialFuC7PGFMwwn79T98eem/YAPox30Y/Kp13b5
         KROr0Ceo9TP0JvTadfd20CuwEvrkGDQeikLwgYr2I6TUArHesIiFvgLBkQCTPyTByo
         ofnGpMdur82v6lVd9G7zTu5+++YcAA6RyDQ1sY8o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 64/71] iwlwifi: check kasprintf() return value
Date:   Tue, 10 Dec 2019 17:33:09 -0500
Message-Id: <20191210223316.14988-64-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210223316.14988-1-sashal@kernel.org>
References: <20191210223316.14988-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 5974fbb5e10b018fdbe3c3b81cb4cc54e1105ab9 ]

kasprintf() can fail, we should check the return value.

Fixes: 5ed540aecc2a ("iwlwifi: use mac80211 throughput trigger")
Fixes: 8ca151b568b6 ("iwlwifi: add the MVM driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/iwlwifi/dvm/led.c | 3 +++
 drivers/net/wireless/iwlwifi/mvm/led.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/iwlwifi/dvm/led.c b/drivers/net/wireless/iwlwifi/dvm/led.c
index ca4d6692cc4eb..47e5fa70483d1 100644
--- a/drivers/net/wireless/iwlwifi/dvm/led.c
+++ b/drivers/net/wireless/iwlwifi/dvm/led.c
@@ -184,6 +184,9 @@ void iwl_leds_init(struct iwl_priv *priv)
 
 	priv->led.name = kasprintf(GFP_KERNEL, "%s-led",
 				   wiphy_name(priv->hw->wiphy));
+	if (!priv->led.name)
+		return;
+
 	priv->led.brightness_set = iwl_led_brightness_set;
 	priv->led.blink_set = iwl_led_blink_set;
 	priv->led.max_brightness = 1;
diff --git a/drivers/net/wireless/iwlwifi/mvm/led.c b/drivers/net/wireless/iwlwifi/mvm/led.c
index e3b3cf4dbd77a..948be43e4d266 100644
--- a/drivers/net/wireless/iwlwifi/mvm/led.c
+++ b/drivers/net/wireless/iwlwifi/mvm/led.c
@@ -109,6 +109,9 @@ int iwl_mvm_leds_init(struct iwl_mvm *mvm)
 
 	mvm->led.name = kasprintf(GFP_KERNEL, "%s-led",
 				   wiphy_name(mvm->hw->wiphy));
+	if (!mvm->led.name)
+		return -ENOMEM;
+
 	mvm->led.brightness_set = iwl_led_brightness_set;
 	mvm->led.max_brightness = 1;
 
-- 
2.20.1

