Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF3DC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C982C227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782799;
	bh=co4FlB8YcvY29kAYTpb3KhAoXm+CpBhbJFOc85kIum8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NlvT/Ec5/7Sxa35Q1aD2nveNjbm3UyqSWO6V8PMHoSCyhcn1rbXBBggPxzeYipTos
	 qY5zM/XIINQ6kB4NfrtycDiwkwme/dX4DaFgXdsr/9067NbzlKWhZz0Vd4guVD4zt1
	 v4N7XAYXQqc2GtsAHTwkB9lWp1SX0TQiwh3jAT4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfLSSfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:35:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbfLSSff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:35:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81F66222C2;
        Thu, 19 Dec 2019 18:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780535;
        bh=co4FlB8YcvY29kAYTpb3KhAoXm+CpBhbJFOc85kIum8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=py1ubhHqLLQS1Grr9gEFmgpzkviu138y00bUzceMIk9ybWypelTG/zHp73B+uxwlp
         aYK8+N9TtASG6RO3KVLUyNHCMns7HE4k0dizfkDa8G+jqedaxwKyQx7eogjNBYObMA
         r8/9c5/xDF3PWiqMGB3Mn5gep3iZ5FrrTwC6nDK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 014/162] iwlwifi: mvm: Send non offchannel traffic via AP sta
Date:   Thu, 19 Dec 2019 19:32:02 +0100
Message-Id: <20191219183204.822632301@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

[ Upstream commit dc1aca22f8f38b7e2ad7b118db87404d11e68771 ]

TDLS discovery response frame is a unicast direct frame to the peer.
Since we don't have a STA for this peer, this frame goes through
iwl_tx_skb_non_sta(). As the result aux_sta and some completely
arbitrary queue would be selected for this frame, resulting in a queue
hang.  Fix that by sending such frames through AP sta instead.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/iwlwifi/mvm/mac80211.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/iwlwifi/mvm/mac80211.c
index 7b2a7d848a56f..ca498b1f1f568 100644
--- a/drivers/net/wireless/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/iwlwifi/mvm/mac80211.c
@@ -741,6 +741,21 @@ static void iwl_mvm_mac_tx(struct ieee80211_hw *hw,
 		     !ieee80211_is_action(hdr->frame_control)))
 		sta = NULL;
 
+	/* If there is no sta, and it's not offchannel - send through AP */
+	if (info->control.vif->type == NL80211_IFTYPE_STATION &&
+	    info->hw_queue != IWL_MVM_OFFCHANNEL_QUEUE && !sta) {
+		struct iwl_mvm_vif *mvmvif =
+			iwl_mvm_vif_from_mac80211(info->control.vif);
+		u8 ap_sta_id = READ_ONCE(mvmvif->ap_sta_id);
+
+		if (ap_sta_id < IWL_MVM_STATION_COUNT) {
+			/* mac80211 holds rcu read lock */
+			sta = rcu_dereference(mvm->fw_id_to_mac_id[ap_sta_id]);
+			if (IS_ERR_OR_NULL(sta))
+				goto drop;
+		}
+	}
+
 	if (sta) {
 		if (iwl_mvm_defer_tx(mvm, sta, skb))
 			return;
-- 
2.20.1



