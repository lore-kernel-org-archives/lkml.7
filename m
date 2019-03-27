Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD2FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18F02087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g05lmg4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfC0VuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:50:11 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40483 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfC0VuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:50:10 -0400
Received: by mail-yw1-f66.google.com with SMTP id p64so13700037ywg.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 14:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fICWx0ErCM6/Fx2r5x+3YPyWqOwId1qZK4pdKQcCoWM=;
        b=g05lmg4YAF/eejBIajxWhp/fNmx+/lYxnDFGXTB2UaTP+AwGkaSC6K8p7zlnpduSsM
         wcz4wuqocQkfH5FOlSMC6ryN3qlpmjPH+8p/OdtnlZ+RdWOjTaUoOP7iDtTvajp8DQNn
         eq35ygfUTYS0YTjw8gVBGLVrdau1J8RNcbcTtJoTsXrUEzpC/nr92JYyHolpSRI297bH
         zGv4PZm4Pe4Lto1PUYVLHMKmTOCEhzmsPBJzqKEusA/CyelMc0AeGsR2tVPekLZ2pC+b
         A2aqmM5iAnrkvIObx4mLRXqoLmy7NTQyZW1JH/91R9gxFOZaYySaLR2mUDiBaN7MGobb
         y8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fICWx0ErCM6/Fx2r5x+3YPyWqOwId1qZK4pdKQcCoWM=;
        b=H5n1fH3d1uBJ0SQJpEWPkKiEXHuPNdHAbMwh7fknDOaM/w1lp8H1AAl6b/TCmuPGQ2
         ZfvhvVtJL8KnXF0FbcnK9IlrT2ndSPqS45rg8mftPVWkRzLu5HMVCmbkeb40dwV3yL/c
         ymJwGT6/V3VkL0Ol9s9azHoaQ/808uDSI7rrNJgRqO66okrieXwFRnCZ289pioQTza/z
         cT18joezOsGXGeJ4A1He+c61EvJPMw+N2uNCl6JEfdUZWjJMi1S7AgR8ZUuGcsXuXuYX
         +LOABxK0vUIh0PCavmEN6g1+BUodG4nAJnt61d5TWvmMY/dLDn1ZJUgPWPAkJRkpkmkD
         jxJw==
X-Gm-Message-State: APjAAAW6Bmc7FXriNOcZv6ifWyN3ymMN3OgwZ+In5MVDHIVXsTzCB3GC
        dm4lbW0w0aoO/y0cuSZB+uc=
X-Google-Smtp-Source: APXvYqyOtIVTusB0x05J4a1cHlyD+MdMXpx6+EQDet4cRlMJfdDYoyxy6Y4VKtDjIVie/Q/18Hw7AQ==
X-Received: by 2002:a25:d1d7:: with SMTP id i206mr3667933ybg.345.1553723409837;
        Wed, 27 Mar 2019 14:50:09 -0700 (PDT)
Received: from gmail.com ([2001:420:302:1320:1b22:a248:17b5:1f0b])
        by smtp.gmail.com with ESMTPSA id d81sm891784ywd.90.2019.03.27.14.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 14:50:09 -0700 (PDT)
Date:   Wed, 27 Mar 2019 14:53:35 -0700
From:   Julius Hemanth Pitti <juliushemanth@gmail.com>
To:     gregkh@linuxfoundation.org, johnfwhitmore@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        juliushemanth@gmail.com
Subject: [PATCH] staging: rtl8192u: ieee80211: ieee80211_wx: add space before
 open brace
Message-ID: <20190327215327.GA2802@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch error "ERROR: that open brace { should be on
the previous line" in ieee80211_wx.c.

Signed-off-by: Julius Hemanth Pitti <juliushemanth@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
index fa59c71..ebcc642 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -195,7 +195,7 @@ static inline char *rtl819x_translate_scan(struct ieee80211_device *ieee,
 	if (iwe.u.data.length)
 	    start = iwe_stream_add_point(info, start, stop, &iwe, custom);
 
-	if (ieee->wpa_enabled && network->wpa_ie_len){
+	if (ieee->wpa_enabled && network->wpa_ie_len) {
 		char buf[MAX_WPA_IE_LEN * 2 + 30];
 	//	printk("WPA IE\n");
 		u8 *p = buf;
@@ -210,7 +210,7 @@ static inline char *rtl819x_translate_scan(struct ieee80211_device *ieee,
 		start = iwe_stream_add_point(info, start, stop, &iwe, buf);
 	}
 
-	if (ieee->wpa_enabled && network->rsn_ie_len){
+	if (ieee->wpa_enabled && network->rsn_ie_len) {
 		char buf[MAX_WPA_IE_LEN * 2 + 30];
 
 		u8 *p = buf;
@@ -766,15 +766,13 @@ int ieee80211_wx_set_auth(struct ieee80211_device *ieee,
 	case IW_AUTH_80211_AUTH_ALG:
 		//printk("======>%s():data->value is %d\n",__func__,data->value);
 	//	ieee->open_wep = (data->value&IW_AUTH_ALG_OPEN_SYSTEM)?1:0;
-		if(data->value & IW_AUTH_ALG_SHARED_KEY){
+		if (data->value & IW_AUTH_ALG_SHARED_KEY) {
 			ieee->open_wep = 0;
 			ieee->auth_mode = 1;
-		}
-		else if(data->value & IW_AUTH_ALG_OPEN_SYSTEM){
+		} else if (data->value & IW_AUTH_ALG_OPEN_SYSTEM) {
 			ieee->open_wep = 1;
 			ieee->auth_mode = 0;
-		}
-		else if(data->value & IW_AUTH_ALG_LEAP){
+		} else if (data->value & IW_AUTH_ALG_LEAP) {
 			ieee->open_wep = 1;
 			ieee->auth_mode = 2;
 		}
-- 
2.7.4

