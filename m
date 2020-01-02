Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98433C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F32E20866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005232;
	bh=UEDvGixjMfM6/sPs/Vui0OLptROBGANMXxK5AkW3MM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PGSHG4TdllwD+6Uf6nIJqlWn83+hMkkqGfVsivxb48Pf9Tzp6UFuZ3kh3HLB1yJnn
	 FzdzpTe94Z/4MjsA8JM11xnFAfNzaWfVGKDYodTCqlfGUo8N/uIYR4IDNfVbPac05P
	 metEcUCXiJGHt+q8IHx6DiLYqS55H1ovUirC7szs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgABWrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:47:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:33146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730110AbgABW36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:29:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD8572253D;
        Thu,  2 Jan 2020 22:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004198;
        bh=UEDvGixjMfM6/sPs/Vui0OLptROBGANMXxK5AkW3MM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDYvXNe04XXsC/5/VP3BZUPeL0sFCXKpj1k5Db5DPQNQGzIBbsEPF4uEDmutNdc9h
         1tM5ZvMxxsQGFvF+LTUXM/jicVhrk3nPFi643h/TpJ5+TZ5KQH9euailOR0nGojx35
         aNd+97ReoX0ymRoK6fI17hbi5WKPmtaJUH4T2INI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 079/171] iwlwifi: check kasprintf() return value
Date:   Thu,  2 Jan 2020 23:06:50 +0100
Message-Id: <20200102220557.904934883@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
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
index 1bbd17ada974..20e16c423990 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/led.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/led.c
@@ -185,6 +185,9 @@ void iwl_leds_init(struct iwl_priv *priv)
 
 	priv->led.name = kasprintf(GFP_KERNEL, "%s-led",
 				   wiphy_name(priv->hw->wiphy));
+	if (!priv->led.name)
+		return;
+
 	priv->led.brightness_set = iwl_led_brightness_set;
 	priv->led.blink_set = iwl_led_blink_set;
 	priv->led.max_brightness = 1;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/led.c b/drivers/net/wireless/intel/iwlwifi/mvm/led.c
index 1e51fbe95f7c..73c351a64187 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/led.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/led.c
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



