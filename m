Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F13BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1994218FF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963918;
	bh=3B26sD+QFG5QwhJ3zwDVK4/nF9MxTgWcBoqtt7tkmOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1QTRvmAX2tePTvCfOSMfGHYeDX7deUNmWU1ukAr+Du7pSDWG+zoOx5lKZF7ccTaPV
	 R+VgLXNQBK1u6on6kCNEgUlTfaWKImozbDHHqc155ExGQsOJAYl3pA8Oy9N+Kmq6Ey
	 dOICZjuqM+OsewogxhXrzh1cGZH7QBCMDusHYcg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbfDVUL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:11:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728527AbfDVTmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:42:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0F152175B;
        Mon, 22 Apr 2019 19:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962131;
        bh=3B26sD+QFG5QwhJ3zwDVK4/nF9MxTgWcBoqtt7tkmOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cyoDCjaQPz5w0sJHvpOOZxQFyaxlRpajLtzn9891vaf9mwpS/SBaYe7P7KA0qm4Ll
         JSKriIwh9w+HG6ycRxcoFKjiS27VU5wjwxbc5RdiDUXEkO5YRD/t/N46ObLsAKjnGq
         EjN46uVu1hCw2jmtKHCvPxNPF52exSnAi5Kdis4c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 06/98] mt76: mt76x2: fix 2.4 GHz channel gain settings
Date:   Mon, 22 Apr 2019 15:40:33 -0400
Message-Id: <20190422194205.10404-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit b8cfd87ac24273e36fbd3ecda631f3ba6566d493 ]

AGC register 35, 37 override for the low gain setting should only be done
on 5 GHz. Also, 2.4 GHz needs a different value for register 35

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76x2/phy.c   | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
index 11167b7af668..2f618536ef2a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
@@ -285,6 +285,7 @@ void mt76x2_phy_update_channel_gain(struct mt76x02_dev *dev)
 {
 	u8 *gain = dev->cal.agc_gain_init;
 	u8 low_gain_delta, gain_delta;
+	u32 agc_35, agc_37;
 	bool gain_change;
 	int low_gain;
 	u32 val;
@@ -321,6 +322,16 @@ void mt76x2_phy_update_channel_gain(struct mt76x02_dev *dev)
 	else
 		low_gain_delta = 14;
 
+	agc_37 = 0x2121262c;
+	if (dev->mt76.chandef.chan->band == NL80211_BAND_2GHZ)
+		agc_35 = 0x11111516;
+	else if (low_gain == 2)
+		agc_35 = agc_37 = 0x08080808;
+	else if (dev->mt76.chandef.width == NL80211_CHAN_WIDTH_80)
+		agc_35 = 0x10101014;
+	else
+		agc_35 = 0x11111116;
+
 	if (low_gain == 2) {
 		mt76_wr(dev, MT_BBP(RXO, 18), 0xf000a990);
 		mt76_wr(dev, MT_BBP(AGC, 35), 0x08080808);
@@ -329,15 +340,13 @@ void mt76x2_phy_update_channel_gain(struct mt76x02_dev *dev)
 		dev->cal.agc_gain_adjust = 0;
 	} else {
 		mt76_wr(dev, MT_BBP(RXO, 18), 0xf000a991);
-		if (dev->mt76.chandef.width == NL80211_CHAN_WIDTH_80)
-			mt76_wr(dev, MT_BBP(AGC, 35), 0x10101014);
-		else
-			mt76_wr(dev, MT_BBP(AGC, 35), 0x11111116);
-		mt76_wr(dev, MT_BBP(AGC, 37), 0x2121262C);
 		gain_delta = 0;
 		dev->cal.agc_gain_adjust = low_gain_delta;
 	}
 
+	mt76_wr(dev, MT_BBP(AGC, 35), agc_35);
+	mt76_wr(dev, MT_BBP(AGC, 37), agc_37);
+
 	dev->cal.agc_gain_cur[0] = gain[0] - gain_delta;
 	dev->cal.agc_gain_cur[1] = gain[1] - gain_delta;
 	mt76x2_phy_set_gain_val(dev);
-- 
2.19.1

