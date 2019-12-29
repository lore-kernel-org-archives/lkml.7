Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DACC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5638B208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642111;
	bh=gRyWsqrK71xHotZYDJA8TKrJmsE0Yb04kA73Yr/Lrb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u7TpeD4Nrqb9zMtMMJvVR3lJwytLZZLEHK3AkaN/lbQuFQ0FLert5cYQ7ii48CVXd
	 YfSNODqm4N/ShYKzLi411gJxf0ycnGI3dfVs5w8p0PCuDzc0VnuzmEvF3Kk2PjK/6+
	 Sp4y+GYMKsS48JMV6oyL3W9H0hYk//gCz5ljO87M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbfL2RzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:43600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732839AbfL2RzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:55:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C230B206A4;
        Sun, 29 Dec 2019 17:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642108;
        bh=gRyWsqrK71xHotZYDJA8TKrJmsE0Yb04kA73Yr/Lrb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Af+EBFP+zbwz+hvTDWGZBXz0XG+VX1TM9AgZiv+iZoh13Nf6aOZkwsRv0SS67OSA+
         ENuZuqsgmAHt28hnc421MkvsvA9yBimXygbkqPeYAXJxAvp+3NrxoQOYPN6O/o88jL
         6nxW9A16E38LxoX8IAy6ckep7prB69fUlF6k9RqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Pedersen <thomas@adapt-ip.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 345/434] mac80211: consider QoS Null frames for STA_NULLFUNC_ACKED
Date:   Sun, 29 Dec 2019 18:26:38 +0100
Message-Id: <20191229172724.886995384@linuxfoundation.org>
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

From: Thomas Pedersen <thomas@adapt-ip.com>

[ Upstream commit 08a5bdde3812993cb8eb7aa9124703df0de28e4b ]

Commit 7b6ddeaf27ec ("mac80211: use QoS NDP for AP probing")
let STAs send QoS Null frames as PS triggers if the AP was
a QoS STA.  However, the mac80211 PS stack relies on an
interface flag IEEE80211_STA_NULLFUNC_ACKED for
determining trigger frame ACK, which was not being set for
acked non-QoS Null frames. The effect is an inability to
trigger hardware sleep via IEEE80211_CONF_PS since the QoS
Null frame was seemingly never acked.

This bug only applies to drivers which set both
IEEE80211_HW_REPORTS_TX_ACK_STATUS and
IEEE80211_HW_PS_NULLFUNC_STACK.

Detect the acked QoS Null frame to restore STA power save.

Fixes: 7b6ddeaf27ec ("mac80211: use QoS NDP for AP probing")
Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
Link: https://lore.kernel.org/r/20191119053538.25979-4-thomas@adapt-ip.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/status.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index ab8ba5835ca0..5a3d645fe1bc 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1030,7 +1030,8 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 			I802_DEBUG_INC(local->dot11FailedCount);
 	}
 
-	if (ieee80211_is_nullfunc(fc) && ieee80211_has_pm(fc) &&
+	if ((ieee80211_is_nullfunc(fc) || ieee80211_is_qos_nullfunc(fc)) &&
+	    ieee80211_has_pm(fc) &&
 	    ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS) &&
 	    !(info->flags & IEEE80211_TX_CTL_INJECTED) &&
 	    local->ps_sdata && !(local->scanning)) {
-- 
2.20.1



