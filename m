Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44C4C2D0B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8909C2086D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482520;
	bh=a4knX04cxFaMOLeX/SVfP/CawM/MDe1uSfxDHJ+yGHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hHPEOkGL68lge8d3pKeqIzGSELOeuQHJfsAsjTd814yDuvs85kQ7JVXNPNc+M7s83
	 lUb+tuTAeztKOq2xKf/zSkANYhuYpD4cCU6AMiC4lyoY/IsRav7EUgwaJZSgNvitY3
	 +usYDjasQkQ8zbFvRfgZLDWtAsBP52r3uDGS75w4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfLDSB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:01:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729697AbfLDSB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:01:56 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 107C02073B;
        Wed,  4 Dec 2019 18:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482515;
        bh=a4knX04cxFaMOLeX/SVfP/CawM/MDe1uSfxDHJ+yGHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dvVkAUFAHohvreBqex/IXXm3eYxH+gbPiu3AN3vqS78m1yZ5+JK46VK9YR0O1W7C/
         kxUA6Isbcp6sIGm0WOgMc2O9r87QlR1dLPul4WC3gzmu9GKcMgMx7A/tvzU5+07LeW
         Yphaz7rv/RHtARM3xLh42hVIgosFOGsPaxW4OovY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ahmed Zaki <anzaki@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 027/209] mac80211: fix station inactive_time shortly after boot
Date:   Wed,  4 Dec 2019 18:53:59 +0100
Message-Id: <20191204175323.374986989@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmed Zaki <anzaki@gmail.com>

[ Upstream commit 285531f9e6774e3be71da6673d475ff1a088d675 ]

In the first 5 minutes after boot (time of INITIAL_JIFFIES),
ieee80211_sta_last_active() returns zero if last_ack is zero. This
leads to "inactive time" showing jiffies_to_msecs(jiffies).

 # iw wlan0 station get fc:ec:da:64:a6:dd
 Station fc:ec:da:64:a6:dd (on wlan0)
	inactive time:	4294894049 ms
	.
	.
	connected time:	70 seconds

Fix by returning last_rx if last_ack == 0.

Signed-off-by: Ahmed Zaki <anzaki@gmail.com>
Link: https://lore.kernel.org/r/20191031121243.27694-1-anzaki@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/sta_info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index f1b496222bda6..1a86974b02e39 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2313,7 +2313,8 @@ unsigned long ieee80211_sta_last_active(struct sta_info *sta)
 {
 	struct ieee80211_sta_rx_stats *stats = sta_get_last_rx_stats(sta);
 
-	if (time_after(stats->last_rx, sta->status_stats.last_ack))
+	if (!sta->status_stats.last_ack ||
+	    time_after(stats->last_rx, sta->status_stats.last_ack))
 		return stats->last_rx;
 	return sta->status_stats.last_ack;
 }
-- 
2.20.1



