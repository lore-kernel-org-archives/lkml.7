Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA32C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887132175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="jigknBpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfCSVII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:08:08 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:55122 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfCSVIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:08:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id E5536CE6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 21:08:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s6XPKWkUFnmx for <linux-kernel@vger.kernel.org>;
        Tue, 19 Mar 2019 16:08:05 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id B4136C46
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 16:08:05 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id y13so77684iol.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 14:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BuPokA0O7bpxjK8BLQRD7Qf9MChQElRdsem85SDXvS4=;
        b=jigknBpS59jCVJZlsj8kfrt5gSZWkw0jraOBuUWR5dLZbYXrazCq5YE+J5r56FoF2M
         ydSHzCUw25BMWAm3TOBKuFcqbFPggoRc3enjTu5Jqv1Wdtiz4UjL/YMrZWOX5yO8eczM
         gItNurG5DfcTa6k2mKZNkO4EprEC1OhYbd6DCIpkOlYim+EvUMfexH6DRcp3B1lVMT4H
         rd3bCprLCVIhoXpWu65phmh4GaT5qzDh9ipRm6KctdpyQ7V2Z1RYLuEcB3Fy7CMDMjsv
         42jTwQuIwoiVB1rgjN9eL5u69P/Q2hoz0FVrvCXb33FfywSfO2sjNnzswzOew5vAxfO0
         lL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BuPokA0O7bpxjK8BLQRD7Qf9MChQElRdsem85SDXvS4=;
        b=r0z9U9Xn9GyrM7a69v08nR+oN6JNF4C54YZbok+LOvCkTv2ZXu4Iows8aW8Jp5JQqR
         wyMs5luesBtVbrhTY78ojxLeX/YYXHUrFXSYieh8TvKHY26TZuCNRlFvFRnFvZhi/Lsc
         fFvhWyVs1eT3iolAEKpB5C04yAYwW0zXlEvkJTSNo+mC777rdepPvdcbOoba8mVdFqIk
         J+sleiRUbIXJlGavPhrCDjtXZdqNsfkDWO8+L9Px/bS5z5gY2S8kwznisM5Own42Ud7a
         0kBoTnTm/cQwutgMBvt/WBzK1AJkQy3x07fRqNqVZbfmXYnHlcM/5aTaCf2Ei7rp2N1y
         Eaqg==
X-Gm-Message-State: APjAAAX5Ynhfus+TJnAg9onIaxqp1aUa9J1E0IY1OOjthkt792Ul6BUM
        GGc8lAVKym+5mY6UG5822blkHvYCEVDk3NYTGvIlEoq5BUeSxNjazCBlKSj7OWgWso3x4GT4PTJ
        rZJ5dxDPv3o/uTNY/adYG7z/Ix21C
X-Received: by 2002:a6b:b258:: with SMTP id b85mr3250256iof.122.1553029685391;
        Tue, 19 Mar 2019 14:08:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwrTLeycVewjMp8y6+qXpiU1IWFPbqkySzewLJBZ6c+6kgsqC+B+FnMwWRE1ZqH/r1GVirrfw==
X-Received: by 2002:a6b:b258:: with SMTP id b85mr3250245iof.122.1553029685165;
        Tue, 19 Mar 2019 14:08:05 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id g194sm191428itc.31.2019.03.19.14.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 14:08:04 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8188eu: Fix potential NULL pointer dereference
Date:   Tue, 19 Mar 2019 16:07:54 -0500
Message-Id: <20190319210801.19074-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hwxmits is allocated via kcalloc and not checked for failure before its
dereference. The patch fixes this problem by returning an error in
rtl8723bs.

---
v1: Return error and remove print in case of failure, per Greg
Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c    | 10 ++++++++--
 drivers/staging/rtl8188eu/include/rtw_xmit.h |  2 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c    | 14 +++++++-------
 drivers/staging/rtl8723bs/include/rtw_xmit.h |  2 +-
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 1723a47a96b4..b70a87bda6f8 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -174,7 +174,10 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
 
-	rtw_alloc_hwxmits(padapter);
+	res = rtw_alloc_hwxmits(padapter);
+	if (res == _FAIL)
+		goto exit;
+
 	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 
 	for (i = 0; i < 4; i++)
@@ -1503,7 +1506,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	return res;
 }
 
-void rtw_alloc_hwxmits(struct adapter *padapter)
+s32 rtw_alloc_hwxmits(struct adapter *padapter)
 {
 	struct hw_xmit *hwxmits;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
@@ -1512,6 +1515,8 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
 
 	pxmitpriv->hwxmits = kcalloc(pxmitpriv->hwxmit_entry,
 				     sizeof(struct hw_xmit), GFP_KERNEL);
+	if (!pxmitpriv->hwxmits)
+		return _FAIL;
 
 	hwxmits = pxmitpriv->hwxmits;
 
@@ -1519,6 +1524,7 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
 	hwxmits[1] .sta_queue = &pxmitpriv->vi_pending;
 	hwxmits[2] .sta_queue = &pxmitpriv->be_pending;
 	hwxmits[3] .sta_queue = &pxmitpriv->bk_pending;
+	return _SUCCESS;
 }
 
 void rtw_free_hwxmits(struct adapter *padapter)
diff --git a/drivers/staging/rtl8188eu/include/rtw_xmit.h b/drivers/staging/rtl8188eu/include/rtw_xmit.h
index 788f59c74ea1..ba7e15fbde72 100644
--- a/drivers/staging/rtl8188eu/include/rtw_xmit.h
+++ b/drivers/staging/rtl8188eu/include/rtw_xmit.h
@@ -336,7 +336,7 @@ s32 rtw_txframes_sta_ac_pending(struct adapter *padapter,
 void rtw_init_hwxmits(struct hw_xmit *phwxmit, int entry);
 s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter);
 void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv);
-void rtw_alloc_hwxmits(struct adapter *padapter);
+s32 rtw_alloc_hwxmits(struct adapter *padapter);
 void rtw_free_hwxmits(struct adapter *padapter);
 s32 rtw_xmit(struct adapter *padapter, struct sk_buff **pkt);
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 094d61bcb469..b87f13a0b563 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -260,7 +260,9 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		}
 	}
 
-	rtw_alloc_hwxmits(padapter);
+	res = rtw_alloc_hwxmits(padapter);
+	if (res == _FAIL)
+		goto exit;
 	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 
 	for (i = 0; i < 4; i++) {
@@ -2144,7 +2146,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	return res;
 }
 
-void rtw_alloc_hwxmits(struct adapter *padapter)
+s32 rtw_alloc_hwxmits(struct adapter *padapter)
 {
 	struct hw_xmit *hwxmits;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
@@ -2155,10 +2157,8 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
 
 	pxmitpriv->hwxmits = rtw_zmalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry);
 
-	if (pxmitpriv->hwxmits == NULL) {
-		DBG_871X("alloc hwxmits fail!...\n");
-		return;
-	}
+	if (!pxmitpriv->hwxmits)
+		return _FAIL;
 
 	hwxmits = pxmitpriv->hwxmits;
 
@@ -2204,7 +2204,7 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
 
 	}
 
-
+	return _SUCCESS;
 }
 
 void rtw_free_hwxmits(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/include/rtw_xmit.h b/drivers/staging/rtl8723bs/include/rtw_xmit.h
index 1b38b9182b31..37f42b2f22f1 100644
--- a/drivers/staging/rtl8723bs/include/rtw_xmit.h
+++ b/drivers/staging/rtl8723bs/include/rtw_xmit.h
@@ -487,7 +487,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter);
 void _rtw_free_xmit_priv (struct xmit_priv *pxmitpriv);
 
 
-void rtw_alloc_hwxmits(struct adapter *padapter);
+s32 rtw_alloc_hwxmits(struct adapter *padapter);
 void rtw_free_hwxmits(struct adapter *padapter);
 
 
-- 
2.17.1

