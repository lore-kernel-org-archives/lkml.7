Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0099C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6C22082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzJHxb15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfC0Wgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:36:53 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34759 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbfC0Wgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:36:52 -0400
Received: by mail-yw1-f68.google.com with SMTP id x129so13036315ywc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 15:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cr3WWOrV5S7o4Bm/XNfbmt1waeaiOtrFxv/hwvHd7uI=;
        b=LzJHxb15U9ePHz6t87zy9gQU9YArrd3LjXciC6uv8KiQZ749Fltxbkub3KwSdo1sWN
         6urUZjV70RP0ra3wig2qIlRORQsyqdlUU1UtS5yC5bkmodwTkUDW/P9VnPcMWkiwwe4O
         KUwPwyl2giAumt3OC9iZwTf6joiOLtz3TBqEk46XWiD2kZpSYSpM3eqHWtPgxk8FjgV1
         fnpT05Kf/x6QJ6scMwxhzVUnnwNVg/IodSgYjTdQlkB2Ac5Pv34DgIxsE8hkuMnxSGXR
         dZkEJaL808qZ+NddlhNLn1adbwwL12k7CpKR22X667s+hZOzIR7Pw2G/hCon/IR1FpJS
         IiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cr3WWOrV5S7o4Bm/XNfbmt1waeaiOtrFxv/hwvHd7uI=;
        b=GfW+0LbByUD8YexYhrAZbj66sGcqhRkKpTPdMog7njcoYWkV1gjNtnw62vc7Dzwzu3
         On5QFbwTtEJGML3wV9oMBe8RKM5d+YUR2J9oo7IHabdcmX1u8yiupdUWNr/J77rKqSn+
         wwvZdRMEaJsE98E+wbnpEnmxCMHEbYjJMsEAA0e1l0ZCCFuapu7vZ7tNG7BrGDzVKQNK
         rU4DK/wNkJwyuXjt/vklZVHteIu2q2yoOBgZ1T518S0zsKvanzqtWcL8qgjyhbudSX6t
         1CfBenTHzA+J7kfJt1qEx+8qhByj0GlEJWJ5gERC1Tk1g86Ts/T1I1b+jdeevUTMia9/
         t4kg==
X-Gm-Message-State: APjAAAXsKAl6dsQ0BvQA7Fpn4fCpQVR9g4vPQNBkcaVB/5gwbmcdjYyV
        dyd+M2BAEV/GyOa15tZ7lrw=
X-Google-Smtp-Source: APXvYqwKIKb+1GdeJ8lYjoqRrIgRepDLIj00ePkW9AaNShHfsgjDaOyTHmB/QyhssMDAecROADIksA==
X-Received: by 2002:a81:9a0e:: with SMTP id r14mr14765446ywg.475.1553726211811;
        Wed, 27 Mar 2019 15:36:51 -0700 (PDT)
Received: from gmail.com ([2001:420:302:1320:1b22:a248:17b5:1f0b])
        by smtp.gmail.com with ESMTPSA id y70sm1278796ywy.86.2019.03.27.15.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 15:36:51 -0700 (PDT)
Date:   Wed, 27 Mar 2019 15:40:17 -0700
From:   Julius Hemanth Pitti <juliushemanth@gmail.com>
To:     gregkh@linuxfoundation.org, johnfwhitmore@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        juliushemanth@gmail.com
Subject: [PATCH v2] staging: rtl8192u: ieee80211: ieee80211_wx: add space
 before open brace
Message-ID: <20190327224014.GA5035@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch error "ERROR: space required before the open brace
'{'" in ieee80211_wx.c.

Signed-off-by: Julius Hemanth Pitti <juliushemanth@gmail.com>
---
Changes in v2:
 - Corrected commit message typo

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

