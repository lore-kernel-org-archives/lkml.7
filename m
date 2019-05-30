Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4788C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAC025177
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189495;
	bh=m1S/o7bBWJfYKmlK40ba7fNUGV6C3viDPdMO7iZvriU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AdbotfH7+wSD6F40yZQIGGxJQRbbLDxDlxLiFkpeys2Rdd+hKU+NJh7jQpDEyZqDq
	 vVXmQM/ublp3v5b8cRlWihxwRXcbgQkWPHG2jUsyCcU5e9RZMVgBqERpppF0e3ejnV
	 fzS+AfwhSUfVA8IRsmZ6aADTXD00VTiRSNJo39fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbfE3ELa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729878AbfE3DQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:16:49 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F72324636;
        Thu, 30 May 2019 03:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186208;
        bh=m1S/o7bBWJfYKmlK40ba7fNUGV6C3viDPdMO7iZvriU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oCxRkyKqQiqDircj7LsyrjllqLBjif5t9BqxAUeGyu+EctIWr1Imvzdck56EzjNNM
         YMakhqw6RVI2XBJAlVbR2HUh/G4fCYnLn5nUTTWD5ampLLWjatotXmNFsXSmTfGnEb
         28huTibOkXUFxHXvsvmrhyrhaExHdmG5Przq3b8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 097/276] rsi: Fix NULL pointer dereference in kmalloc
Date:   Wed, 29 May 2019 20:04:15 -0700
Message-Id: <20190530030532.206413780@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d5414c2355b20ea8201156d2e874265f1cb0d775 ]

kmalloc can fail in rsi_register_rates_channels but memcpy still attempts
to write to channels. The patch replaces these calls with kmemdup and
passes the error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/rsi/rsi_91x_mac80211.c | 30 ++++++++++++---------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index 4e510cbe0a89f..be59d66585d6d 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -188,27 +188,27 @@ bool rsi_is_cipher_wep(struct rsi_common *common)
  * @adapter: Pointer to the adapter structure.
  * @band: Operating band to be set.
  *
- * Return: None.
+ * Return: int - 0 on success, negative error on failure.
  */
-static void rsi_register_rates_channels(struct rsi_hw *adapter, int band)
+static int rsi_register_rates_channels(struct rsi_hw *adapter, int band)
 {
 	struct ieee80211_supported_band *sbands = &adapter->sbands[band];
 	void *channels = NULL;
 
 	if (band == NL80211_BAND_2GHZ) {
-		channels = kmalloc(sizeof(rsi_2ghz_channels), GFP_KERNEL);
-		memcpy(channels,
-		       rsi_2ghz_channels,
-		       sizeof(rsi_2ghz_channels));
+		channels = kmemdup(rsi_2ghz_channels, sizeof(rsi_2ghz_channels),
+				   GFP_KERNEL);
+		if (!channels)
+			return -ENOMEM;
 		sbands->band = NL80211_BAND_2GHZ;
 		sbands->n_channels = ARRAY_SIZE(rsi_2ghz_channels);
 		sbands->bitrates = rsi_rates;
 		sbands->n_bitrates = ARRAY_SIZE(rsi_rates);
 	} else {
-		channels = kmalloc(sizeof(rsi_5ghz_channels), GFP_KERNEL);
-		memcpy(channels,
-		       rsi_5ghz_channels,
-		       sizeof(rsi_5ghz_channels));
+		channels = kmemdup(rsi_5ghz_channels, sizeof(rsi_5ghz_channels),
+				   GFP_KERNEL);
+		if (!channels)
+			return -ENOMEM;
 		sbands->band = NL80211_BAND_5GHZ;
 		sbands->n_channels = ARRAY_SIZE(rsi_5ghz_channels);
 		sbands->bitrates = &rsi_rates[4];
@@ -227,6 +227,7 @@ static void rsi_register_rates_channels(struct rsi_hw *adapter, int band)
 	sbands->ht_cap.mcs.rx_mask[0] = 0xff;
 	sbands->ht_cap.mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
 	/* sbands->ht_cap.mcs.rx_highest = 0x82; */
+	return 0;
 }
 
 /**
@@ -1985,11 +1986,16 @@ int rsi_mac80211_attach(struct rsi_common *common)
 	wiphy->available_antennas_rx = 1;
 	wiphy->available_antennas_tx = 1;
 
-	rsi_register_rates_channels(adapter, NL80211_BAND_2GHZ);
+	status = rsi_register_rates_channels(adapter, NL80211_BAND_2GHZ);
+	if (status)
+		return status;
 	wiphy->bands[NL80211_BAND_2GHZ] =
 		&adapter->sbands[NL80211_BAND_2GHZ];
 	if (common->num_supp_bands > 1) {
-		rsi_register_rates_channels(adapter, NL80211_BAND_5GHZ);
+		status = rsi_register_rates_channels(adapter,
+						     NL80211_BAND_5GHZ);
+		if (status)
+			return status;
 		wiphy->bands[NL80211_BAND_5GHZ] =
 			&adapter->sbands[NL80211_BAND_5GHZ];
 	}
-- 
2.20.1



