Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4DFC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4B72084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3ec93JE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfDZImU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:42:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38877 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZImU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:42:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id f36so1218805plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 01:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9fBiel0Wv6n6EdQhWCqCtKNPm0ZxS5yjXqnbpCw5iaQ=;
        b=Y3ec93JEZiHoPq8u9xLowFYZTmHm+/zUMI0NIkEffn4vWeqg5XLKzhLBWfqXcq7AOt
         LW3fzstAI+Hy31Gf6seXmn3ygk/56LgbTS0MwcCzVU5b4PtaxQvv96Q1ZbOOJ7cw//DS
         xD391nwKCwfw9h+M5FozFyhYqYXb+zAy4Gp9QNjq/7HBQg85CkCYAPv/0CBciJ/JPXwd
         51xuoV1zZJOoR1et3twPhxBiwN8APjvkuPV1REZNHtnYMZTUjvBdSDCwmsVa38U7Vkfh
         CM68VH6IaObiaiiEFPv96nh2fZSb8wMsXpi0zkPd3zW8Ioah4NZy0nabUeIf4ePNFQZe
         B3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9fBiel0Wv6n6EdQhWCqCtKNPm0ZxS5yjXqnbpCw5iaQ=;
        b=Ae20JHj14bIYqeTlOmZK4dEK24HDGxlPjQolZzuTdaaT1KFV2vJmMJLBdD10D5Vu3u
         rvRb2MsfgUn/sQFr6pZvRuY2x7wz6f6DfNahxj3XF6/D5SI1EhYAxCN18G54BxJBK7Fi
         JNMmEyCl2m+OkDcvNjRLC1Jgk/b7DFu/g+7Z5fDRywsPBoxmPB5GEvcfAJfZSjJ73oiX
         UFIc5O5ganyv/ggNqU/qCA/yCJM/CsGpfcHceS9eleHGl/sjMwIV69L2sdl+DOSI34Mz
         7LXuTmBhIEm9a+DUqn9O7wH1I7rNiFYQyqEnkdSITceucsmHXGqIkcqau9ebzUVcHYFP
         FxyA==
X-Gm-Message-State: APjAAAUQiDNeTEcpZ5bByKoNueytKJGK7tzq0foGIhBLWX/ebUwybCYr
        WSJlAH8lCVOmdYSAYdJP9vE=
X-Google-Smtp-Source: APXvYqz7TDTyGeC7C1B2cbZOaR1kdSkB/nM7kllwWU0uXe64jlQqCMia9xb6DUbiObuANJlMtzO9IA==
X-Received: by 2002:a17:902:6a89:: with SMTP id n9mr36188529plk.76.1556268139569;
        Fri, 26 Apr 2019 01:42:19 -0700 (PDT)
Received: from localhost.localdomain ([103.87.57.142])
        by smtp.gmail.com with ESMTPSA id w10sm36635660pfi.126.2019.04.26.01.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 01:42:19 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Julia.Lawall@lip6.fr, Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH v2 1/2] staging: rtl8192u: ieee80211: Replace bit shifting with BIT macro
Date:   Fri, 26 Apr 2019 14:12:01 +0530
Message-Id: <20190426084201.30589-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change suggested by coccinelle.

Replace bit shifting on 1 with the BIT(x) macro.
Coccinelle script:

@@
expression c;
@@

-(1 << c)
+BIT(c)

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
Changes in v2:
-changed log message
-added space around '&' opreator and after 'if'
-added another patch to fix spelling mistake

 drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
index fa59c712c74b..2044ae27b973 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -86,7 +86,7 @@ static inline char *rtl819x_translate_scan(struct ieee80211_device *ieee,
 	/* Add the protocol name */
 	iwe.cmd = SIOCGIWNAME;
 	for(i=0; i<ARRAY_SIZE(ieee80211_modes); i++) {
-		if(network->mode&(1<<i)) {
+		if (network->mode & BIT(i)) {
 			sprintf(pname,ieee80211_modes[i].mode_string,ieee80211_modes[i].mode_size);
 			pname +=ieee80211_modes[i].mode_size;
 		}
@@ -394,7 +394,7 @@ int ieee80211_wx_set_encode(struct ieee80211_device *ieee,
 		sec.key_sizes[key] = len;
 		(*crypt)->ops->set_key(sec.keys[key], len, NULL,
 				       (*crypt)->priv);
-		sec.flags |= (1 << key);
+		sec.flags |= BIT(key);
 		/* This ensures a key will be activated if no key is
 		 * explicitely set */
 		if (key == sec.active_key)
@@ -415,7 +415,7 @@ int ieee80211_wx_set_encode(struct ieee80211_device *ieee,
 			(*crypt)->ops->set_key(sec.keys[key], 13, NULL,
 					       (*crypt)->priv);
 			sec.key_sizes[key] = 13;
-			sec.flags |= (1 << key);
+			sec.flags |= BIT(key);
 		}
 
 		/* No key data - just set the default TX key index */
@@ -636,7 +636,7 @@ int ieee80211_wx_set_encode_ext(struct ieee80211_device *ieee,
 	if (ext->alg != IW_ENCODE_ALG_NONE) {
 		//memcpy(sec.keys[idx], ext->key, ext->key_len);
 		sec.key_sizes[idx] = ext->key_len;
-		sec.flags |= (1 << idx);
+		sec.flags |= BIT(idx);
 		if (ext->alg == IW_ENCODE_ALG_WEP) {
 		      //  sec.encode_alg[idx] = SEC_ALG_WEP;
 			sec.flags |= SEC_LEVEL;
-- 
2.17.1

