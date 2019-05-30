Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572EAC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F241261A8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWK/3wgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfE3VEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 17:04:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32938 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfE3VEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 17:04:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id g21so3062816plq.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 14:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vD2fLJXRnpmLTWPk2IUY5InLkt9+iHncke1FSW91ZcY=;
        b=jWK/3wgh433k10BhILFQBTdumpwnYdXDkD3FhqlmmVNdsJIG/dKvMgJpGL3M5xPYi0
         87zUTgJLmiAuoTQi9YF9NKp/rOaRx/dGgIGl0lUm4xLJ6dBEToGNQh5M0FD066HSrV/u
         OiTMgWJXMnaW33dUwAbRPH/hj1ITdza/urLkma1FzLLPILc59J4nWJ4lqXbWjQPoK4+B
         oc6ODDecHMrbtGBMYvFrJ59tU6Pq2uoptldobP7Y0zx2qigT0h4u3aOgfze/ZhJGGAZx
         HvNYK7QOEpbDHQtpeIziEu9vtjieTD6ftBqaUqXF5I4TpBfDpNmfS58dMx+UAf/EHl1z
         lOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vD2fLJXRnpmLTWPk2IUY5InLkt9+iHncke1FSW91ZcY=;
        b=QpypA5GKu/rgL2oA9Md/5wvKd391ozfrbbKPeIdr+sY4peMXgm6GfcRaJaFBgeqtp1
         DaHEf4TjFC6FMkhfU503Mgs/rxKx4qp1MfCNuou0oBwBG7fgAHG8t5LgxuP7DCldYNow
         JSTMzd4VRmyvHKqc6nl+aUg/SVY2bTYqGGf7K7tOMVRKE0Z3wqdjsgIicrbKHY7orICM
         8sDZrrEEJS5rA/3nYZ1MepPEaAeA7D29RPMmHOneQOrlSnsDegBwcs0bqbj/L634uU9W
         IBh/s930ooI86SiX+aj/hdB2riqyvrnWky6glUG7x2sW780oPqk9gI7dtfDceja5FX0j
         7HIQ==
X-Gm-Message-State: APjAAAUKbPhUB9o9HVQN2hEdEe8SBOIwqM/PWp0caLYraPzZIwvdCzBr
        rdTyqdaXmoobyoakTZ+Pivk=
X-Google-Smtp-Source: APXvYqzHUhgye+9GCfAT+RfQLdLAofvEeKT9byV5oZx65xPL7rX+qTDN8YVOH3Fe62GBHdeaq0/Xcg==
X-Received: by 2002:a17:902:4383:: with SMTP id j3mr5669710pld.320.1559250254813;
        Thu, 30 May 2019 14:04:14 -0700 (PDT)
Received: from localhost.localdomain ([47.15.209.13])
        by smtp.gmail.com with ESMTPSA id 63sm4507267pfu.95.2019.05.30.14.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 14:04:14 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, colin.king@canonical.com,
        straube.linux@gmail.com, yangx92@hotmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: rtl8712: ieee80211.c: Remove leading p from variable names
Date:   Fri, 31 May 2019 02:33:59 +0530
Message-Id: <20190530210359.30284-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove leading p from the names of the following pointer variables:
- pregistrypriv
- pdev_network
- pie
- pbuf.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8712/ieee80211.c | 50 ++++++++++++++---------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
index 4cca7390c8ef..fe94e5c15836 100644
--- a/drivers/staging/rtl8712/ieee80211.c
+++ b/drivers/staging/rtl8712/ieee80211.c
@@ -156,13 +156,13 @@ static uint r8712_get_rateset_len(u8 *rateset)
 	return i;
 }
 
-int r8712_generate_ie(struct registry_priv *pregistrypriv)
+int r8712_generate_ie(struct registry_priv *registrypriv)
 {
 	int rate_len;
 	uint sz = 0;
-	struct wlan_bssid_ex *pdev_network = &pregistrypriv->dev_network;
-	u8 *ie = pdev_network->IEs;
-	u16 beaconPeriod = (u16)pdev_network->Configuration.BeaconPeriod;
+	struct wlan_bssid_ex *dev_network = &registrypriv->dev_network;
+	u8 *ie = dev_network->IEs;
+	u16 beaconPeriod = (u16)dev_network->Configuration.BeaconPeriod;
 
 	/*timestamp will be inserted by hardware*/
 	sz += 8;
@@ -174,65 +174,65 @@ int r8712_generate_ie(struct registry_priv *pregistrypriv)
 	/*capability info*/
 	*(u16 *)ie = 0;
 	*(__le16 *)ie |= cpu_to_le16(cap_IBSS);
-	if (pregistrypriv->preamble == PREAMBLE_SHORT)
+	if (registrypriv->preamble == PREAMBLE_SHORT)
 		*(__le16 *)ie |= cpu_to_le16(cap_ShortPremble);
-	if (pdev_network->Privacy)
+	if (dev_network->Privacy)
 		*(__le16 *)ie |= cpu_to_le16(cap_Privacy);
 	sz += 2;
 	ie += 2;
 	/*SSID*/
-	ie = r8712_set_ie(ie, _SSID_IE_, pdev_network->Ssid.SsidLength,
-			  pdev_network->Ssid.Ssid, &sz);
+	ie = r8712_set_ie(ie, _SSID_IE_, dev_network->Ssid.SsidLength,
+			  dev_network->Ssid.Ssid, &sz);
 	/*supported rates*/
-	set_supported_rate(pdev_network->rates, pregistrypriv->wireless_mode);
-	rate_len = r8712_get_rateset_len(pdev_network->rates);
+	set_supported_rate(dev_network->rates, registrypriv->wireless_mode);
+	rate_len = r8712_get_rateset_len(dev_network->rates);
 	if (rate_len > 8) {
 		ie = r8712_set_ie(ie, _SUPPORTEDRATES_IE_, 8,
-				  pdev_network->rates, &sz);
+				  dev_network->rates, &sz);
 		ie = r8712_set_ie(ie, _EXT_SUPPORTEDRATES_IE_, (rate_len - 8),
-				  (pdev_network->rates + 8), &sz);
+				  (dev_network->rates + 8), &sz);
 	} else {
 		ie = r8712_set_ie(ie, _SUPPORTEDRATES_IE_,
-				  rate_len, pdev_network->rates, &sz);
+				  rate_len, dev_network->rates, &sz);
 	}
 	/*DS parameter set*/
 	ie = r8712_set_ie(ie, _DSSET_IE_, 1,
-			  (u8 *)&pdev_network->Configuration.DSConfig, &sz);
+			  (u8 *)&dev_network->Configuration.DSConfig, &sz);
 	/*IBSS Parameter Set*/
 	ie = r8712_set_ie(ie, _IBSS_PARA_IE_, 2,
-			  (u8 *)&pdev_network->Configuration.ATIMWindow, &sz);
+			  (u8 *)&dev_network->Configuration.ATIMWindow, &sz);
 	return sz;
 }
 
-unsigned char *r8712_get_wpa_ie(unsigned char *pie, uint *wpa_ie_len, int limit)
+unsigned char *r8712_get_wpa_ie(unsigned char *ie, uint *wpa_ie_len, int limit)
 {
 	u32 len;
 	u16 val16;
 	unsigned char wpa_oui_type[] = {0x00, 0x50, 0xf2, 0x01};
-	u8 *pbuf = pie;
+	u8 *buf = ie;
 
 	while (1) {
-		pbuf = r8712_get_ie(pbuf, _WPA_IE_ID_, &len, limit);
-		if (pbuf) {
+		buf = r8712_get_ie(buf, _WPA_IE_ID_, &len, limit);
+		if (buf) {
 			/*check if oui matches...*/
-			if (memcmp((pbuf + 2), wpa_oui_type,
+			if (memcmp((buf + 2), wpa_oui_type,
 				   sizeof(wpa_oui_type)))
 				goto check_next_ie;
 			/*check version...*/
-			memcpy((u8 *)&val16, (pbuf + 6), sizeof(val16));
+			memcpy((u8 *)&val16, (buf + 6), sizeof(val16));
 			le16_to_cpus(&val16);
 			if (val16 != 0x0001)
 				goto check_next_ie;
-			*wpa_ie_len = *(pbuf + 1);
-			return pbuf;
+			*wpa_ie_len = *(buf + 1);
+			return buf;
 		}
 		*wpa_ie_len = 0;
 		return NULL;
 check_next_ie:
-		limit = limit - (pbuf - pie) - 2 - len;
+		limit = limit - (buf - ie) - 2 - len;
 		if (limit <= 0)
 			break;
-		pbuf += (2 + len);
+		buf += (2 + len);
 	}
 	*wpa_ie_len = 0;
 	return NULL;
-- 
2.19.1

