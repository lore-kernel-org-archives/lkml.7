Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8805C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83549206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc6RBG0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389455AbfFJKij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:38:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46835 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389217AbfFJKij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:38:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so5047361pfy.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 03:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mpPScSwEUvGCrfFSzsPIPCGbvFV9XPrrj9L5Mq7ES2o=;
        b=Tc6RBG0z7+LuK3uLgyEbinWPqfxyBMhm12dlPYzpTzHReHHdD3yLFL8h17hrzxueg7
         qig4UDVs9F89wrRD8QEbjMnF3K16yUHWMDQHf8lTMWVzkAH2EIbQkzTNG/01cADfYMU0
         8pjCY3miVG0yvYeljjpnEMrDD3nUzFno3PmZySlqzCh9E2FiK5blo+mREoPBF0EFUjX+
         0IEC9UeEZoSBnS5b+lrqPLaTGw/hMqLlF93mq2YG5dcrIU3lGfJHIWq38HZHDgfVwatY
         pY2KayHBUvlArMNcseVykmzuPqYiO/AnPT+bpjdaxXXvEANsbJ5KkD8UmAkEW28drvj/
         KgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mpPScSwEUvGCrfFSzsPIPCGbvFV9XPrrj9L5Mq7ES2o=;
        b=uNIzp4QWi9cirUjWaWiIZj77ppByKpHsCX72tTE3tzq0BP043mxVVHbhVVJ2jCPLKk
         Pcvu+laufVVoQRxj38B7gBv7cBYgPHKvo7lwf91To80oqSKCheNdwtdfT6hs1SlYxZsq
         Xc938L4n++2UPJa+fxTs1fBCL37Ltv1xEefhQf9YZ+WMhFxrk8lJYrJ29eIu3DzMkzDm
         s7J6KxiO0K95s1H4YKORI5Oc0iAHpu73v49tMXXwhvzVSnS5TWG7fVM1Re7hAw3L7fGC
         MboLvC87nQBi3HIN0ZrpG1G1ZL40jvAQaq1qCrBmA5NUUncI9wK/lVpyl+rNizKZsocx
         7g5A==
X-Gm-Message-State: APjAAAV9jUenlDSdLoAFm0hTR2UHeS/VhvI7JEVsm0c8yaqXw09JQlbE
        tPdLC69VsCwo7shjfmYqGs4=
X-Google-Smtp-Source: APXvYqwoF8NxU5GFTcruRD63cj7AzF075nfcFx3++9Qc63hWP7Czfbgxm7vJEkvKcIx/BeaKiESjNQ==
X-Received: by 2002:a17:90a:a593:: with SMTP id b19mr947374pjq.31.1560163118455;
        Mon, 10 Jun 2019 03:38:38 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:2747:12e9:74e9:432c:7ca9:f9ed])
        by smtp.gmail.com with ESMTPSA id q7sm9512883pfb.32.2019.06.10.03.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 03:38:38 -0700 (PDT)
From:   Merwin Trever Ferrao <merwintf@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Merwin Trever Ferrao <Merwintf@gmail.com>,
        Merwin Trever Ferrao <merwintf@gmail.com>
Subject: [PATCH 16/16] Staging: wlan-ng: cfg80211: fixed alignment issue with open parenthesis                      line ending with (
Date:   Mon, 10 Jun 2019 16:08:25 +0530
Message-Id: <20190610103825.19364-1-merwintf@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Merwin Trever Ferrao <Merwintf@gmail.com>

Fixed a coding style issue.

Signed-off-by: Merwin Trever Ferrao <merwintf@gmail.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 32 ++++++++++++++----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index eee1998c4b18..5424e2682911 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -324,8 +324,7 @@ static int prism2_scan(struct wiphy *wiphy,
 		(i < request->n_channels) && i < ARRAY_SIZE(prism2_channels);
 		i++)
 		msg1.channellist.data.data[i] =
-			ieee80211_frequency_to_channel(
-				request->channels[i]->center_freq);
+			ieee80211_frequency_to_channel(request->channels[i]->center_freq);
 	msg1.channellist.data.len = request->n_channels;
 
 	msg1.maxchanneltime.data = 250;
@@ -359,15 +358,15 @@ static int prism2_scan(struct wiphy *wiphy,
 		freq = ieee80211_channel_to_frequency(msg2.dschannel.data,
 						      NL80211_BAND_2GHZ);
 		bss = cfg80211_inform_bss(wiphy,
-			ieee80211_get_channel(wiphy, freq),
-			CFG80211_BSS_FTYPE_UNKNOWN,
-			(const u8 *)&msg2.bssid.data.data,
-			msg2.timestamp.data, msg2.capinfo.data,
-			msg2.beaconperiod.data,
-			ie_buf,
-			ie_len,
-			(msg2.signal.data - 65536) * 100, /* Conversion to signed type */
-			GFP_KERNEL
+					  ieee80211_get_channel(wiphy, freq),
+					  CFG80211_BSS_FTYPE_UNKNOWN,
+					  (const u8 *)&msg2.bssid.data.data,
+					  msg2.timestamp.data, msg2.capinfo.data,
+					  msg2.beaconperiod.data,
+					  ie_buf,
+					  ie_len,
+					  (msg2.signal.data - 65536) * 100, /* Conversion to signed type */
+					  GFP_KERNEL
 		);
 
 		if (!bss) {
@@ -475,14 +474,13 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
 			}
 
 			result = prism2_domibset_uint32(wlandev,
-				DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
-				sme->key_idx);
+							DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
+							sme->key_idx);
 			if (result)
 				goto exit;
 
 			/* send key to driver */
-			did = didmib_dot11smt_wepdefaultkeystable_key(
-					sme->key_idx + 1);
+			did = didmib_dot11smt_wepdefaultkeystable_key(sme->key_idx + 1);
 			result = prism2_domibset_pstr32(wlandev,
 							did, sme->key_len,
 							(u8 *)sme->key);
@@ -588,8 +586,8 @@ static int prism2_set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 		data = MBM_TO_DBM(mbm);
 
 	result = prism2_domibset_uint32(wlandev,
-		DIDMIB_DOT11PHY_TXPOWERTABLE_CURRENTTXPOWERLEVEL,
-		data);
+					DIDMIB_DOT11PHY_TXPOWERTABLE_CURRENTTXPOWERLEVEL,
+					data);
 
 	if (result) {
 		err = -EFAULT;
-- 
2.17.1

