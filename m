Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7A7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72CA21D7E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642154;
	bh=Alhvg2+72tn+GgYizr728QgHtDo51MC5aDE2hkDjpc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gXMTKJEADGwPQ7NIpwLHK1WPKL430k9maCaNM85Ypf4KcnYqHpQ/ZfnDYWfIaQicS
	 3GH7XatMONTNSTQAIjmrWTE9RrolJeYCPMzEIDVqA6pwloFVByy/ZcxUzM6nWAArrN
	 m/QOvGow04KoLneMzyh7XwJTHUwl/lA/+Q//unxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733008AbfL2Rzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:55:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732361AbfL2Ryr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:54:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34C4C206DB;
        Sun, 29 Dec 2019 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642086;
        bh=Alhvg2+72tn+GgYizr728QgHtDo51MC5aDE2hkDjpc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HqE3p+nFVkOw4EYWqiThqUrLN+8/eAAdodw5RAg2Eqkg4gb86q96CmsoXvax8WcjM
         xZ5/HWr21AGV3lAcHHktiUiCtueAhMYE6L51m0IS6+nR1Ilcl+qBonFKcGSfX0R06Z
         KBLiOm3bT65BxMp5nZada4lJGR4yG7FGmFKwxlo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 337/434] iwlwifi: check kasprintf() return value
Date:   Sun, 29 Dec 2019 18:26:30 +0100
Message-Id: <20191229172724.354700068@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 drivers/net/wireless/intel/iwlwifi/dvm/led.c | 3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/led.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/led.c b/drivers/net/wireless/intel/iwlwifi/dvm/led.c
index dd387aba3317..e8a4d604b910 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/led.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/led.c
@@ -171,6 +171,9 @@ void iwl_leds_init(struct iwl_priv *priv)
 
 	priv->led.name = kasprintf(GFP_KERNEL, "%s-led",
 				   wiphy_name(priv->hw->wiphy));
+	if (!priv->led.name)
+		return;
+
 	priv->led.brightness_set = iwl_led_brightness_set;
 	priv->led.blink_set = iwl_led_blink_set;
 	priv->led.max_brightness = 1;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/led.c b/drivers/net/wireless/intel/iwlwifi/mvm/led.c
index d104da9170ca..72c4b2b8399d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/led.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/led.c
@@ -129,6 +129,9 @@ int iwl_mvm_leds_init(struct iwl_mvm *mvm)
 
 	mvm->led.name = kasprintf(GFP_KERNEL, "%s-led",
 				   wiphy_name(mvm->hw->wiphy));
+	if (!mvm->led.name)
+		return -ENOMEM;
+
 	mvm->led.brightness_set = iwl_led_brightness_set;
 	mvm->led.max_brightness = 1;
 
-- 
2.20.1



