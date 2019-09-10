Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4207BC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 18:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE332082C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 18:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tek+1Zjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfIJSYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 14:24:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42280 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfIJSYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 14:24:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so10151777pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 11:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0I346vx91sUiAeUkNi54oztkGxRJ6TRG5+oqyFk02bY=;
        b=Tek+1ZjhvQoukKmunz9oWSi7ehimuA5KNE4USUlNH47zOHVd7hK0lshi8vdBQQkbft
         Y+iykjcmDFByvT0DrQj25tk3pbgmrZ1AcmvSU8+8z2lSWZLPwQWvSuVxWC21ApMyga2A
         yG+q1sDyeQ6DN+YIJUtFgFBoE3iV+h8EvN++Y3O+9vAiayxcmUZwiloMHp0ijIqcaF0r
         Hy1BK9ziX1IvLaq7/XZ5KN9NmyX+QBXkuIlC665PpUyuLLdIVS8LHHvCVe9DEuNUxJtE
         UuW59djanWpWgRWGAdhnyGGGyTKYYvRDzhuPP6gynSHQZGjd208Vs/hTeflWpKMNYWt/
         nv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0I346vx91sUiAeUkNi54oztkGxRJ6TRG5+oqyFk02bY=;
        b=IhKCtaBQdbOFQFkA0u6ZFep7VHeRyjZGx68FcRPbUDo4IHHQGKK3JdPrw6kUDVWcU5
         XLaDR9eDWueuQt4Z/eJ5jnkJ45PuJSdmdbkMRfCsIuj8N5vmwiRd46XK1KOPQfi1UAyi
         47bixa4cY1Sht+lzEAO7MWJZPT497EaeJuOAwtuxQHYVFR7r1FKrgQlx3ZMtjM9Ec6FT
         +vDBQ+SPzBnV0/mt4GOFHpnsSlUGUyVuWsoVdbICGz4HYjC7ZZ5xbBJYP9nfI3pjrMIc
         EXScZCqFc50FZO/eEteUucMepefSapJAKc5sBJoy4wyKi87w4ngnqETTVSd2i/ACZVWd
         9P3g==
X-Gm-Message-State: APjAAAUkxOhbQIyASGuxh9tLzS4Du2e2bNVts7EBMJ3SVpcXyGexhKCs
        NW+2C9+GZN51nqI9N8Ly3N1GF9X0LG493A==
X-Google-Smtp-Source: APXvYqxa8LiqtCxiVtBgng/u1HVtbAH6tYazztOwvGiOc/JeuqbxpUEnR4B5jfyPSEnwhlrgw3VhAw==
X-Received: by 2002:a17:90a:1c01:: with SMTP id s1mr930789pjs.76.1568139861681;
        Tue, 10 Sep 2019 11:24:21 -0700 (PDT)
Received: from SARKAR ([1.186.12.73])
        by smtp.gmail.com with ESMTPSA id u1sm14384025pgi.28.2019.09.10.11.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 11:24:21 -0700 (PDT)
Date:   Tue, 10 Sep 2019 23:54:15 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     gregkh@linuxfoundation.org, johnfwhitmore@gmail.com,
        devel@driverdev.osuosl.org
Cc:     rohitsarkar5398@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: ieee80211: Replace snprintf with scnprintf
Message-ID: <20190910182415.GA5768@SARKAR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the number of bytes to be printed exceeds the limit snprintf
returns the number of bytes that would have been printed (if there was
no truncation). This might cause issues, hence use scnprintf which
returns the actual number of bytes printed to buffer always.

Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c | 4 ++--
 drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index 0a3e478fccd6..b0a78508f378 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -1647,7 +1647,7 @@ int ieee80211_parse_info_param(struct ieee80211_device *ieee,
 			for (i = 0; i < network->rates_len; i++) {
 				network->rates[i] = info_element->data[i];
 #ifdef CONFIG_IEEE80211_DEBUG
-				p += snprintf(p, sizeof(rates_str) -
+				p += scnprintf(p, sizeof(rates_str) -
 					      (p - rates_str), "%02X ",
 					      network->rates[i]);
 #endif
@@ -1674,7 +1674,7 @@ int ieee80211_parse_info_param(struct ieee80211_device *ieee,
 			for (i = 0; i < network->rates_ex_len; i++) {
 				network->rates_ex[i] = info_element->data[i];
 #ifdef CONFIG_IEEE80211_DEBUG
-				p += snprintf(p, sizeof(rates_str) -
+				p += scnprintf(p, sizeof(rates_str) -
 					      (p - rates_str), "%02X ",
 					      network->rates_ex[i]);
 #endif
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
index be08cd1d37a7..8f378ba0e62a 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -109,7 +109,7 @@ static inline char *rtl819x_translate_scan(struct ieee80211_device *ieee,
 	/* Add basic and extended rates */
 	max_rate = 0;
 	p = custom;
-	p += snprintf(p, MAX_CUSTOM_LEN - (p - custom), " Rates (Mb/s): ");
+	p += scnprintf(p, MAX_CUSTOM_LEN - (p - custom), " Rates (Mb/s): ");
 	for (i = 0, j = 0; i < network->rates_len; ) {
 		if (j < network->rates_ex_len &&
 		    ((network->rates_ex[j] & 0x7F) <
@@ -119,12 +119,12 @@ static inline char *rtl819x_translate_scan(struct ieee80211_device *ieee,
 			rate = network->rates[i++] & 0x7F;
 		if (rate > max_rate)
 			max_rate = rate;
-		p += snprintf(p, MAX_CUSTOM_LEN - (p - custom),
+		p += scnprintf(p, MAX_CUSTOM_LEN - (p - custom),
 			      "%d%s ", rate >> 1, (rate & 1) ? ".5" : "");
 	}
 	for (; j < network->rates_ex_len; j++) {
 		rate = network->rates_ex[j] & 0x7F;
-		p += snprintf(p, MAX_CUSTOM_LEN - (p - custom),
+		p += scnprintf(p, MAX_CUSTOM_LEN - (p - custom),
 			      "%d%s ", rate >> 1, (rate & 1) ? ".5" : "");
 		if (rate > max_rate)
 			max_rate = rate;
@@ -215,7 +215,7 @@ static inline char *rtl819x_translate_scan(struct ieee80211_device *ieee,
 	 * for given network. */
 	iwe.cmd = IWEVCUSTOM;
 	p = custom;
-	p += snprintf(p, MAX_CUSTOM_LEN - (p - custom),
+	p += scnprintf(p, MAX_CUSTOM_LEN - (p - custom),
 		      " Last beacon: %lums ago", (jiffies - network->last_scanned) / (HZ / 100));
 	iwe.u.data.length = p - custom;
 	if (iwe.u.data.length)
-- 
2.17.1

