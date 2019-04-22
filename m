Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B870C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B78E2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963927;
	bh=TFEbNgOnjZdp+OrAKel34HlM7HEacZoMLPhNOvdElzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qYbajgcLve9wmZIFgnaRs+PPsY/XxI5v6a0pPJT45fJHa5Al6NuWW7Qa4v4usg6Iv
	 Es9TyHiM0LzkfsVbz9iBGV14IutwUBWJzjsyd+VqdEccfm7LtJNl0Ug3puqdyoNxjl
	 qFB1r67ZukmRaPzVkjpyVEmvO4xflD5yv4gZLXKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732661AbfDVUMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbfDVTmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:42:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2361B2177B;
        Mon, 22 Apr 2019 19:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962130;
        bh=TFEbNgOnjZdp+OrAKel34HlM7HEacZoMLPhNOvdElzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AIy/9lWJ9uxBpwWbQrIEOLoZLxgrerHNdn9FaStDiklAnw1DUP5wrt7hfibyTcdFu
         C9NK1Joz/sAG19XRu6wV9kqAj9/E2lP5MF+QgsUdvsdzam4jZ6DLDrDPvlkqZ2quve
         nMaZmhV+EpjTotyaYkibuYyDnVT3RVqpvb5wcs3E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 05/98] mt76: mt76x2: fix external LNA gain settings
Date:   Mon, 22 Apr 2019 15:40:32 -0400
Message-Id: <20190422194205.10404-5-sashal@kernel.org>
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

[ Upstream commit 45a042e3026824a7e910db7a4dd38fef0540b902 ]

Devices with external LNA need different values for AGC registers 8 and 9

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x2/phy.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
index c9634a774705..11167b7af668 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
@@ -260,10 +260,15 @@ mt76x2_phy_set_gain_val(struct mt76x02_dev *dev)
 	gain_val[0] = dev->cal.agc_gain_cur[0] - dev->cal.agc_gain_adjust;
 	gain_val[1] = dev->cal.agc_gain_cur[1] - dev->cal.agc_gain_adjust;
 
-	if (dev->mt76.chandef.width >= NL80211_CHAN_WIDTH_40)
+	val = 0x1836 << 16;
+	if (!mt76x2_has_ext_lna(dev) &&
+	    dev->mt76.chandef.width >= NL80211_CHAN_WIDTH_40)
 		val = 0x1e42 << 16;
-	else
-		val = 0x1836 << 16;
+
+	if (mt76x2_has_ext_lna(dev) &&
+	    dev->mt76.chandef.chan->band == NL80211_BAND_2GHZ &&
+	    dev->mt76.chandef.width < NL80211_CHAN_WIDTH_40)
+		val = 0x0f36 << 16;
 
 	val |= 0xf8;
 
-- 
2.19.1

