Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BD5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1859920850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Az37lDhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfCTRVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:21:48 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:37880 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbfCTRVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:21:48 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id D9745C12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 17:21:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o_nHo2TH7ABy for <linux-kernel@vger.kernel.org>;
        Wed, 20 Mar 2019 12:21:47 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 8ED4D9A4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:21:47 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id 190so12681itv.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=T4ZmLPh0p4UVdC62UX26zhVQG0RynV4YeYN9/wnMJ/M=;
        b=Az37lDhyygLwAc0uJgr76zOJnIBL66V/geGM1Z782mh6LuPo9Dhpy9KoJuQwFPgQZq
         5ze/llyxwL73CkMMgUdpcj2pvn/e2tLOXQ+Vu56TRSMSHwFi61/dYZVjLFJYwCWWcmzV
         jBKR2YH19NHY2kEECriSKBICZC9STdFqgKOQrVLQm8YlugJIE2Lb6zLwdrwKRyJQI7KW
         RwYkZDmAIe1EKoe2rxwwmBIN/cbpWG09afUihimC5oHKg7+BiHjJisXIceMk8d6wBqTs
         opEEtgMrWRwc2KASpktvaCkhZWQ8spVLiSkYW2k1h/xRQxCf8soHTwcnqeFE6oLjkA3C
         ZprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T4ZmLPh0p4UVdC62UX26zhVQG0RynV4YeYN9/wnMJ/M=;
        b=FxdNL/2eNzYkfz8ERxfaFPpe8Kmt/64j4umuJIyAK/6dezTRrTgR/365GJ+HMmxS7S
         6q/lukSHJWTfiK8UwrOR0x59rgt0KcuQpgaJyyWe42MlCG9qe9KVFXicrhyUVN1Zsuqf
         UJMBse+Bp9P3t4o5fCQpqBP9E3Lz/J2fP+7iTZWd6xZsBxC5lEzRj7F1hg9M6t+U6RAs
         6wyHTk86MzXbJgQINXp0d3ohI4ztd5dxL/PBKmgtagZ2nl2tDndHLrrM9x51IWUIijhW
         E2QbvUfdBBu58Et6V/NN57hbJMUDIAP7/sSQG7nBm9NwiCdT5QntRVeUHeEB5dDbGDKv
         V1VA==
X-Gm-Message-State: APjAAAWVq06hqkCTMrUINUP4dQsJ8qZrnZzWtoerMtBrlu7TX5iKUb0/
        ir/WA6wlSVHWwt27Xi1MCmVgj0eM1fKdqMka2R0mZbLxJkakKwQ7hKVUd7BTkdhhphMUIeOBmkJ
        wb7B45Pjd+m65FAn0W66sc7yqCP/x
X-Received: by 2002:a24:4d15:: with SMTP id l21mr5892455itb.64.1553102507172;
        Wed, 20 Mar 2019 10:21:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqza6oD+opNr8FUm9MOm/r3qa3Mbah+zX/aPWQ4r26YMUSrJjR8GhddCE/jkbTrqIqH8M8SuMA==
X-Received: by 2002:a24:4d15:: with SMTP id l21mr5892440itb.64.1553102506926;
        Wed, 20 Mar 2019 10:21:46 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id t74sm1556725itt.29.2019.03.20.10.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 10:21:46 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: rtl8188eu: Fix potential NULL pointer dereference of kcalloc
Date:   Wed, 20 Mar 2019 12:21:35 -0500
Message-Id: <20190320172142.1305-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hwxmits is allocated via kcalloc and not checked for failure before its
dereference. The patch fixes this problem by returning error upstream
in rtl8723bs, rtl8188eu.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v2: Move signed off above version change log.
v1: Return error and remove print in case of failure, per Greg
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c    |  9 +++++++--
 drivers/staging/rtl8188eu/include/rtw_xmit.h |  2 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c    | 14 +++++++-------
 drivers/staging/rtl8723bs/include/rtw_xmit.h |  2 +-
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 1723a47a96b4..952f2ab51347 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -174,7 +174,9 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
 
-	rtw_alloc_hwxmits(padapter);
+	res = rtw_alloc_hwxmits(padapter);
+	if (res == _FAIL)
+		goto exit;
 	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 
 	for (i = 0; i < 4; i++)
@@ -1503,7 +1505,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	return res;
 }
 
-void rtw_alloc_hwxmits(struct adapter *padapter)
+s32 rtw_alloc_hwxmits(struct adapter *padapter)
 {
 	struct hw_xmit *hwxmits;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
@@ -1512,6 +1514,8 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
 
 	pxmitpriv->hwxmits = kcalloc(pxmitpriv->hwxmit_entry,
 				     sizeof(struct hw_xmit), GFP_KERNEL);
+	if (!pxmitpriv->hwxmits)
+		return _FAIL;
 
 	hwxmits = pxmitpriv->hwxmits;
 
@@ -1519,6 +1523,7 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
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

