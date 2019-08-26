Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF95C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 05:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60C92080C
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 05:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdHGwU5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbfHZFUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 01:20:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42089 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfHZFUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 01:20:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id y1so9385753plp.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 22:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrkJNuUkgZRa9WqgJTpr+iClIcHwYAMNxN4El98MH8c=;
        b=WdHGwU5jJ9Luz0P67oqquA4qjczFDzuzvcS66PA1Rof+b8+VmQNBcUxNP3ET3zXBNM
         0gHssR4AJaaQISyj1+okpELnS4C3ngkt/GQ3hMVUq/Y/wr/Y4MuAhTFUGgBtjSTkLOo7
         PkOufDp+wVAUSumq0YA3rcynpkAITSZePwQog3KC7JAIrsfKz1J7gWT6Dj4ZJzo0JtoN
         j/4QZH1HFCpfMzM2IGmZ8t1DufebidQ+YTGZAQRNS/8tOJ3NCApdQnvtaHkWE56pMSE4
         QzAvSKgKqEWFXnp3ssy4XSyw3AAKEErrFGGnC1NrqUp9QYEbL6hAp+PIFA7CfBVO2+6j
         zR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrkJNuUkgZRa9WqgJTpr+iClIcHwYAMNxN4El98MH8c=;
        b=cVPRlFMO4R9wb7eHbSQdPiE+X0Bzntp0s/h645daSOOQWERIxNva+/SDtSzkSZj/pK
         JhojkgDlkcvQ7RDtIOfpVz2kLynj6Vcz/EFRNTU4lxnmirEfFce+B3l6W2nn0sQqj1YX
         Oo8xnxxPbm1YwnHeSZZU9rRRPqXfnowVp1MT5fCHzNOEMg7aprVA5IOztWp4p3zBMZm8
         be9DDudKS9DcF1UtGZfkTXw0UJGvAvbu8xU3usXUMYlSkqnWmfvkPtaL6Xex2v3dzpy1
         q15DZ+rnnYqX0YeqTpq2LTmXA9WNSVAU71nVE0e9nXG0zbodEki5VBipr5oDOU2rNvgA
         W8mw==
X-Gm-Message-State: APjAAAVzBQ+KOsTBw+OfbqtvT/t2h/U+eBjuAAm3jg32zcrvhPB0DDcY
        qpRdeGZlUelkwnzPFekwnpWR38r0TRAyRw==
X-Google-Smtp-Source: APXvYqwpKo0msETO1B3V2SRW7R9j2UAJvAjWnkPNOLo8sclbJrIrlSjEi6AhH05kSX2vWbu/FoTNsA==
X-Received: by 2002:a17:902:7b97:: with SMTP id w23mr3666860pll.283.1566796836919;
        Sun, 25 Aug 2019 22:20:36 -0700 (PDT)
Received: from localhost.localdomain (61-220-137-38.HINET-IP.hinet.net. [61.220.137.38])
        by smtp.gmail.com with ESMTPSA id c12sm13916626pfc.22.2019.08.25.22.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Aug 2019 22:20:36 -0700 (PDT)
From:   "Taihsiang Ho (tai271828)" <tai271828@gmail.com>
To:     straube.linux@gmail.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        "Taihsiang Ho (tai271828)" <tai271828@gmail.com>
Subject: [PATCH] staging: rtl8712: wifi: checkpatch style fix
Date:   Mon, 26 Aug 2019 13:20:18 +0800
Message-Id: <20190826052018.18649-1-tai271828@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove multiple blank lines.

Signed-off-by: Taihsiang Ho (tai271828) <tai271828@gmail.com>
---
 drivers/staging/rtl8712/wifi.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index 1a5b966a167e..be731f1a2209 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -300,7 +300,6 @@ static inline unsigned char *get_da(unsigned char *pframe)
 	return da;
 }
 
-
 static inline unsigned char *get_sa(unsigned char *pframe)
 {
 	unsigned char	*sa;
@@ -346,8 +345,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 	return sa;
 }
 
-
-
 /*-----------------------------------------------------------------------------
  *		Below is for the security related definition
  *-----------------------------------------------------------------------------
@@ -392,7 +389,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 
 #define	_RESERVED47_		47
 
-
 /* ---------------------------------------------------------------------------
  *			Below is the fixed elements...
  * ---------------------------------------------------------------------------
@@ -436,7 +432,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 #define _WMM_IE_Length_				7  /* for WMM STA */
 #define _WMM_Para_Element_Length_		24
 
-
 /*-----------------------------------------------------------------------------
  *			Below is the definition for 802.11n
  *------------------------------------------------------------------------------
@@ -456,7 +451,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 #define GetOrderBit(pbuf)	(((*(__le16 *)(pbuf)) & \
 				le16_to_cpu(_ORDER_)) != 0)
 
-
 /**
  * struct ieee80211_bar - HT Block Ack Request
  *
@@ -476,7 +470,6 @@ struct ieee80211_bar {
 #define IEEE80211_BAR_CTRL_ACK_POLICY_NORMAL     0x0000
 #define IEEE80211_BAR_CTRL_CBMTID_COMPRESSED_BA  0x0004
 
-
 /*
  * struct ieee80211_ht_cap - HT capabilities
  *
@@ -552,7 +545,6 @@ struct ieee80211_ht_addt_info {
  */
 #define IEEE80211_MIN_AMPDU_BUF 0x8
 
-
 /* Spatial Multiplexing Power Save Modes */
 #define WLAN_HT_CAP_SM_PS_STATIC		0
 #define WLAN_HT_CAP_SM_PS_DYNAMIC	1
-- 
2.23.0

