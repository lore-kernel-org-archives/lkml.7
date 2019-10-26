Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF79BCA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 12:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8537B222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 12:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4fyD/qW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfJZMLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 08:11:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39834 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfJZMLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 08:11:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id r141so4603056wme.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 05:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rbbDikhV/iQ9zXkIzvsic6LstX6D3lalONEPDHnSWr8=;
        b=W4fyD/qWXDqwQppYiL0BxiYgdSdAwq05QeodSBfoaenthp8KocNZ7L2h4Ch2NvUR7f
         htVC5eYt7oks7DSeN+iTGmxQfUeDhlD35NEvk/IwZTBUSlc1dQcXdn0/AcW0JAEITV0K
         2OD7tXO2ZL/tHUjnxKDX4bc1+E3jBIdIErVTz/309C4Loz8+1rIo7qCadVajUsMzQGnQ
         TpvbDr61HbClW2dygD6j+5gq5jcWMO9TjoKPaKktCgEprMyZ1NynvvRxroXS3FIhmX2G
         qW7bmwYtFDreu6a72seLsIVEI/5iatkJwpyAfjwRaYbHOWS7oT29EQnQHIlai13cD0yL
         ks5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rbbDikhV/iQ9zXkIzvsic6LstX6D3lalONEPDHnSWr8=;
        b=mQXjHQv/GEn+83X/YJLs8HlJCJ0iGfN564auee8ngZ/zdabt806dGcrHfGxQK1uypH
         hW8w78eNE8k8H25ZOSrviCYt+7xmwEb8TD96xKoqssnnFZhtflsNWqBVjNfeV2G4uCR4
         eVD7bDa5mldOgWjFxWEpEPjbAETLC5H0Kw658XdByPXfEuRMa3gZ8SSJSYaEQZq8Qqcd
         9r5hjDqQ0AxXgrzK5xfRgRS5XBI+p8F8Ci4rnWUNugTk6Lr3gzo5nHIm+lX1eoBeu+Ac
         fZNOwT9Bfi7jmkAkLZHjAFoA4Z/BbCNYRoM6H4h/bI+yjjY3ZWnFq8FZ1O0ro3OSkD1e
         F0HA==
X-Gm-Message-State: APjAAAWfcyaywuXzVz6Y/GthuaapFPOulk29OymR0ZL1z01eFgU8z2jf
        MpL/m31VXaJWjCFB5R0Iaq8=
X-Google-Smtp-Source: APXvYqywHKFI1oeQS7aN8FewIeIA/wdtx0lIXOuCYoo5rKee//+97NuHowuns8AqVnd9L8STGki3gw==
X-Received: by 2002:a1c:5609:: with SMTP id k9mr7524974wmb.103.1572091912679;
        Sat, 26 Oct 2019 05:11:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id v8sm5789906wra.79.2019.10.26.05.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 05:11:52 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/7] staging: rtl8188eu: convert unsigned char array to u8
Date:   Sat, 26 Oct 2019 14:11:30 +0200
Message-Id: <20191026121135.181897-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191026121135.181897-1-straube.linux@gmail.com>
References: <20191026121135.181897-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert array bcast_addr from unsigned char to u8.
Clears a line over 80 characters checkpatch warning.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index cbe970979eb0..394b887a8bde 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -450,7 +450,7 @@ u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
 {
 	struct sta_info *psta;
 	u32 res = _SUCCESS;
-	unsigned char bcast_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	u8 bcast_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
 	psta = rtw_alloc_stainfo(pstapriv, bcast_addr);
-- 
2.23.0

