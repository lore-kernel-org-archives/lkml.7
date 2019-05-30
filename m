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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1BCC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733F026199
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 21:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1e9vPO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfE3VCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 17:02:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32809 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3VB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 17:01:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id g21so3060849plq.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 14:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Rn97JUHpPdwbaTRS8tnudORzMA93pypME0DorT8PkU=;
        b=s1e9vPO0dPnKr5tdgPBRSA/qnQqXa1DW92dSBMji9f3tCWJgXJSxnznuxExoZcKnDX
         w+1+YQBiafAqRcil8a1d4G5emjeVAnM5i75yj2alJ/rP32bfhW8ZwMe2PR9w1tkcp93w
         eyQXqBcc3lKktB/2hvpwPzKxoB8M5iSlIkPGcl3IkMRlaBYieyLs+2hNxbW3FCgx0D1x
         5npfgpnPozJg4aSYUzfkYLXbtTRRqc6geqXLN5iG7q7JN7euMr1BiP//JJ6Zp87NxTFK
         v+d53/EL3wwdthCd4xVNS6ZHCvDf0myst+ZiRbzEpWeNoV1DaTkcGZqlxOKxcq46lApF
         /CGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Rn97JUHpPdwbaTRS8tnudORzMA93pypME0DorT8PkU=;
        b=g86qzXZm04SWi/wrL7QqsXYYornn0f0aVhUUzm0jhFXH8za4j1BOPzPMq50rrPen+r
         T0lPgOGl0gcX+JNGJg42eCx7CXy86GAaJWjA7CqsRHy33LY0VCz1ZBy3XYWOvcdDuKCV
         /5cH/95jN4dq3nIXALrPl4bF8Xg/JA70vIkk1qxZux0oG/CRmkkBzRNY9XF7QEQ2O3IJ
         /3nhybKsKc8Nwar2RTKm7bNcrnPVXx7/XfGvfZvKjzC6Scijlz32bDQ+bMEgQ4zBWDxd
         HcXZkddz4I7q/klWVtvX8Wr/x2jHoXHkAHz5ukjCbjkTPIfvFVGL3fFwcZKuv2hNZ2kM
         fMOQ==
X-Gm-Message-State: APjAAAWXAGeOl8WCsQVGCZDo5WFGB/qn57NF7eVESrboG5bL7mRtbBfe
        6NdjrD7LEXitdjk6OKrwoKw=
X-Google-Smtp-Source: APXvYqze68sDz+9fHQdmX4fZfLlak8YACBHqxghtnA6yXVdJFsh7XE1rOnmJBthbr6hYsYY7VVyzhw==
X-Received: by 2002:a17:902:b18c:: with SMTP id s12mr5312637plr.181.1559250119189;
        Thu, 30 May 2019 14:01:59 -0700 (PDT)
Received: from localhost.localdomain ([47.15.209.13])
        by smtp.gmail.com with ESMTPSA id p21sm3790104pfn.129.2019.05.30.14.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 14:01:58 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, himadri18.07@gmail.com,
        colin.king@canonical.com, straube.linux@gmail.com,
        yangx92@hotmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: rtl8712: Remove function alloc_network
Date:   Fri, 31 May 2019 02:31:41 +0530
Message-Id: <20190530210141.30221-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function alloc_network as it does nothing except call
_r8712_alloc_network. Further, to maintain consistency with
the names of other functions, rename _r8712_alloc_network as
r8712_alloc_network.
Also change the corresponding calls to either function
accordingly.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_cmd.c  | 2 +-
 drivers/staging/rtl8712/rtl871x_mlme.c | 9 ++-------
 drivers/staging/rtl8712/rtl871x_mlme.h | 2 +-
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
index 05a78ac24987..7c437ee9e022 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.c
+++ b/drivers/staging/rtl8712/rtl871x_cmd.c
@@ -880,7 +880,7 @@ void r8712_createbss_cmd_callback(struct _adapter *padapter,
 		}
 		r8712_indicate_connect(padapter);
 	} else {
-		pwlan = _r8712_alloc_network(pmlmepriv);
+		pwlan = r8712_alloc_network(pmlmepriv);
 		if (!pwlan) {
 			pwlan = r8712_get_oldest_wlan_network(
 				&pmlmepriv->scanned_queue);
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index f6ba3e865a30..3b6846c43d72 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -70,7 +70,7 @@ int r8712_init_mlme_priv(struct _adapter *padapter)
 	return _SUCCESS;
 }
 
-struct wlan_network *_r8712_alloc_network(struct mlme_priv *pmlmepriv)
+struct wlan_network *r8712_alloc_network(struct mlme_priv *pmlmepriv)
 {
 	unsigned long irqL;
 	struct wlan_network *pnetwork;
@@ -210,11 +210,6 @@ void r8712_free_mlme_priv(struct mlme_priv *pmlmepriv)
 	kfree(pmlmepriv->free_bss_buf);
 }
 
-static struct	wlan_network *alloc_network(struct mlme_priv *pmlmepriv)
-{
-	return _r8712_alloc_network(pmlmepriv);
-}
-
 /*
  * return the wlan_network with the matching addr
  * Shall be called under atomic context...
@@ -388,7 +383,7 @@ static void update_scanned_network(struct _adapter *adapter,
 		} else {
 			/* Otherwise just pull from the free list */
 			/* update scan_time */
-			pnetwork = alloc_network(pmlmepriv);
+			pnetwork = r8712_alloc_network(pmlmepriv);
 			if (!pnetwork)
 				return;
 			bssid_ex_sz = r8712_get_wlan_bssid_ex_sz(target);
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.h b/drivers/staging/rtl8712/rtl871x_mlme.h
index 8a54181f4816..3973a49dc32e 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.h
+++ b/drivers/staging/rtl8712/rtl871x_mlme.h
@@ -196,7 +196,7 @@ void _r8712_join_timeout_handler(struct _adapter *adapter);
 void r8712_scan_timeout_handler(struct _adapter *adapter);
 void _r8712_dhcp_timeout_handler(struct _adapter *adapter);
 void _r8712_wdg_timeout_handler(struct _adapter *adapter);
-struct wlan_network *_r8712_alloc_network(struct mlme_priv *pmlmepriv);
+struct wlan_network *r8712_alloc_network(struct mlme_priv *pmlmepriv);
 sint r8712_if_up(struct _adapter *padapter);
 void r8712_joinbss_reset(struct _adapter *padapter);
 unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
-- 
2.19.1

