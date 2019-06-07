Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC8CC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED1020B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTn6I4Kj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfFGOKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:10:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43145 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbfFGOKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:10:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so1233287pgv.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WviGJBKgEpiJLqccK37TyqA/NvGYOeZQ8PBC4TwGa4M=;
        b=VTn6I4KjwL5gWYewleunXOkbS0NLQfMjEErXokyNJ/coXmNRgEa8xOQsD6gSWor8RV
         uder4DeV9PFezBtB8VwuL8dKxRSEG38yfm2maA4yyxeSEbPW0NSpj0l0FKCo76Fwd0rf
         uSPTsjWzka+Gxo8ee6+ewx/PI6uHCLBF0kgxBbi4nXaezPRhbMuQa3aCTQw2Fk5WfFg6
         EkpbxWI9yDUSOvTifCIbFQhQ9OjGNc7/OnlsXRGKMfmv539fYyUswNtgkfAr7JeuVzkd
         4Zy3+vvjyeRb7YT8bjC99PbolxrTNpCLkaMmfN+ZEQmFw8RAVFkHv3xXKr1fFN0HFUzs
         Z8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WviGJBKgEpiJLqccK37TyqA/NvGYOeZQ8PBC4TwGa4M=;
        b=NEzslSsTn+lYRUx8K3kTAWePprC0/eq/lsYBR80aSVGlVY7IsAFRvsUQFkKZaXEivP
         6w4II5G9f0JuoJjCs7YwOQxsv69Vuw4DrLNZCvd+nztdIUuX0ckAixiA6vu+Q8j8HGnJ
         ybCH8qAXxEHZ10otRzoImO1CNX/2L9oo+Ez6xy2hBve0BkEekIhJZiHyC4A5nKDcSxMh
         Ac60zaYrO3myWR/AuGHLOwEGD2/LNs0dSoyL3na/AkTKEhk4XRRmRjxRd8r+X15IBuVD
         mp3CQxSFBeyu9YkqakjPkjK5sdWlXvfczdglLibtLT05N7IZOdJ5bfw2rUeteX19VBdU
         M5EA==
X-Gm-Message-State: APjAAAXL7XziWcK2qICXRrXL4kKaawbMhvux6CWKPkF2R/7Sdv8Mul/S
        ANmhM6ds80pIXEHOwE0qloc=
X-Google-Smtp-Source: APXvYqwEekzVMmLl+SOJvzoI3Qwq5rO+7raqy2CKPQml0u9NmV8RXF94lZ0oCE6g1hDEhBYe3EaKWA==
X-Received: by 2002:a17:90a:9f90:: with SMTP id o16mr5730591pjp.72.1559916617409;
        Fri, 07 Jun 2019 07:10:17 -0700 (PDT)
Received: from localhost.localdomain ([110.227.95.145])
        by smtp.gmail.com with ESMTPSA id u20sm2526448pfm.145.2019.06.07.07.10.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 07:10:16 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, straube.linux@gmail.com,
        larry.finger@lwfinger.net, flbue@gmx.de
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH v2] staging: rtl8188eu: core: Replace function rtw_free_network_nolock()
Date:   Fri,  7 Jun 2019 19:40:03 +0530
Message-Id: <20190607141003.11998-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function rtw_free_network_nolock, as all it does is call
_rtw_free_network_nolock, and rename _rtw_free_network_nolock to
rtw_free_network_nolock.
Keep the new rtw_free_network_nolock a static function and remove the
old version from the header file.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme.c    | 9 ++-------
 drivers/staging/rtl8188eu/include/rtw_mlme.h | 3 ---
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 0abb2df32645..d2f7a88e992e 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -159,7 +159,8 @@ static void _rtw_free_network(struct mlme_priv *pmlmepriv, struct wlan_network *
 	spin_unlock_bh(&free_queue->lock);
 }
 
-void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwork)
+static void rtw_free_network_nolock(struct mlme_priv *pmlmepriv,
+				    struct wlan_network *pnetwork)
 {
 	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
 
@@ -276,12 +277,6 @@ static struct wlan_network *rtw_alloc_network(struct mlme_priv *pmlmepriv)
 	return _rtw_alloc_network(pmlmepriv);
 }
 
-static void rtw_free_network_nolock(struct mlme_priv *pmlmepriv,
-				    struct wlan_network *pnetwork)
-{
-	_rtw_free_network_nolock(pmlmepriv, pnetwork);
-}
-
 int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
 {
 	int ret = true;
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme.h b/drivers/staging/rtl8188eu/include/rtw_mlme.h
index bfef66525944..9abb7c320192 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme.h
@@ -335,9 +335,6 @@ void rtw_free_mlme_priv_ie_data(struct mlme_priv *pmlmepriv);
 
 struct wlan_network *_rtw_alloc_network(struct mlme_priv *pmlmepriv);
 
-void _rtw_free_network_nolock(struct mlme_priv *pmlmepriv,
-			      struct wlan_network *pnetwork);
-
 int rtw_if_up(struct adapter *padapter);
 
 u8 *rtw_get_capability_from_ie(u8 *ie);
-- 
2.19.1

