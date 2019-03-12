Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE34C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222AE2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHHcS5zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfCLOj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:39:57 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43540 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLOj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:39:57 -0400
Received: by mail-qt1-f194.google.com with SMTP id d16so2747859qtn.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RlEUwtoo2fzvf8uoWm5turOiMD9NMoC+/ATe1cHwutQ=;
        b=OHHcS5ziZtiFhzxZ/bnKX/q0vYd4JsxaV7IJkGTYX0NcsLupUMeym8hS/aYcnC5J09
         qGNRxe/qy3iP71sjeoq24YhZMc33RyJwtQQWMIS07gXnsPBwJp8J/2tZe6vn9rpfxgF1
         Vw5TRgk7ly5ow0KM0/StNNrdWVYbSkNdAJ2S4HhD3qKSSz4UqnZhXbdF/t8Ild4rVMtv
         HXWziMPQP5IGxQlHOcF5VIfjexQfN0mkuIxjvihiVF2bc1RddSXNKN/NFAz0m2nV1VgA
         W7Ifsku860mchwk9vIUXBjRIQyKIv8wDfnRdtmBNsEeqUg3E3SYYa63t3Q+DPSeZb3Vh
         km/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RlEUwtoo2fzvf8uoWm5turOiMD9NMoC+/ATe1cHwutQ=;
        b=fN/uv5UnD0feM0fMoTtZAPyq5uYEG18haUdPz6Yw09zqLgL/V9emiTTuS7ihTbhX06
         JDo0oPF9i7tTrzf+P6u1RJWXmIpkvgE8M8u2dyxSBI0a5oGsfXZJd23CvG11AerNMCeu
         hrh3h37Jyu+V43s3o6baKoP9LpihLaaIYZt878F3hRcyu3wTEP/La3ig5761DnDFhoce
         3O6ZdBopbs9iyZuE+8s8Obq9HaJeccXz7Y4xzpV9FdfcMIbs0eMWP0UL3Co/8eN7xzFG
         Rv6Gb7+JLe5pa01NNPH6Vao3tQSm8ls0zE/OMGTnGOZNfDYraljh2sKx6pFy6vLoIDHe
         MK7A==
X-Gm-Message-State: APjAAAWyzTmwOMG2rYpCrsH2JwM0WVBFn8oKkOxv59VhmV693RNKfYYq
        4K+ULn6mBb4SlfuWdDFMjPRu4GCP
X-Google-Smtp-Source: APXvYqzv/iPpY7dwwykDk8Qm//s2Gq+3vv4man8pnpAuIgpnVA9o1KEeWnwImvj6YsT/HiwZmv6kKw==
X-Received: by 2002:a0c:9e6b:: with SMTP id z43mr31175176qve.131.1552401595453;
        Tue, 12 Mar 2019 07:39:55 -0700 (PDT)
Received: from localhost.localdomain ([177.76.237.150])
        by smtp.gmail.com with ESMTPSA id m88sm4616344qte.68.2019.03.12.07.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 07:39:54 -0700 (PDT)
From:   Guilherme T Maeoka <gui.mspace@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Guilherme T Maeoka <gui.maeoka@gmail.com>
Subject: [PATCH 2/2] Staging: rtl8723bs: os_dep: Invert if selection statement
Date:   Tue, 12 Mar 2019 11:39:14 -0300
Message-Id: <20190312143914.4471-2-gui.mspace@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190312143914.4471-1-gui.mspace@gmail.com>
References: <20190312143914.4471-1-gui.mspace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guilherme T Maeoka <gui.maeoka@gmail.com>

Change 'if (a)' to 'if (!a)' and return. Otherwise, continue with
the previouly wrapped block of control. This reduces the indentation
level by 2 and 1.

I'm not if this commit contributes to the coding style.

Signed-off-by: Guilherme T Maeoka <gui.maeoka@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 73 +++++++++++---------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 86f1e090436e..54425ad28bfd 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -103,23 +103,27 @@ static void sdio_free_irq(struct dvobj_priv *dvobj)
 	struct sdio_func *func;
 	int err;
 
-	if (dvobj->irq_alloc) {
-		psdio_data = &dvobj->intf_data;
-		func = psdio_data->func;
-
-		if (func) {
-			sdio_claim_host(func);
-			err = sdio_release_irq(func);
-			if (err) {
-				dvobj->drv_dbg.dbg_sdio_free_irq_error_cnt++;
-				DBG_871X_LEVEL(_drv_err_, "%s: sdio_release_irq FAIL(%d)!\n", __func__, err);
-			} else {
-				dvobj->drv_dbg.dbg_sdio_free_irq_cnt++;
-			}
-			sdio_release_host(func);
-		}
-		dvobj->irq_alloc = 0;
+	if (!dvobj->irq_alloc)
+		return;
+
+	psdio_data = &dvobj->intf_data;
+	func = psdio_data->func;
+	dvobj->irq_alloc = 0;
+
+	if (!func)
+		return;
+
+	sdio_claim_host(func);
+	err = sdio_release_irq(func);
+	if (err) {
+		dvobj->drv_dbg.dbg_sdio_free_irq_error_cnt++;
+		DBG_871X_LEVEL(_drv_err_, "%s: sdio_release_irq FAIL(%d)!\n",
+			       __func__, err);
+	} else {
+		dvobj->drv_dbg.dbg_sdio_free_irq_cnt++;
 	}
+
+	sdio_release_host(func);
 }
 
 #ifdef CONFIG_GPIO_WAKEUP
@@ -219,26 +223,29 @@ static void sdio_deinit(struct dvobj_priv *dvobj)
 
 	func = dvobj->intf_data.func;
 
-	if (func) {
-		sdio_claim_host(func);
-		err = sdio_disable_func(func);
-		if (err) {
-			dvobj->drv_dbg.dbg_sdio_deinit_error_cnt++;
-			DBG_8192C(KERN_ERR "%s: sdio_disable_func(%d)\n", __func__, err);
-		}
+	if (!func)
+		return;
 
-		if (dvobj->irq_alloc) {
-			err = sdio_release_irq(func);
-			if (err) {
-				dvobj->drv_dbg.dbg_sdio_free_irq_error_cnt++;
-				DBG_8192C(KERN_ERR "%s: sdio_release_irq(%d)\n", __func__, err);
-			} else {
-				dvobj->drv_dbg.dbg_sdio_free_irq_cnt++;
-			}
-		}
+	sdio_claim_host(func);
+	err = sdio_disable_func(func);
+	if (err) {
+		dvobj->drv_dbg.dbg_sdio_deinit_error_cnt++;
+		DBG_8192C(KERN_ERR "%s: sdio_disable_func(%d)\n",
+			  __func__, err);
+	}
 
-		sdio_release_host(func);
+	if (dvobj->irq_alloc) {
+		err = sdio_release_irq(func);
+		if (err) {
+			dvobj->drv_dbg.dbg_sdio_free_irq_error_cnt++;
+			DBG_8192C(KERN_ERR "%s: sdio_release_irq(%d)\n",
+				  __func__, err);
+		} else {
+			dvobj->drv_dbg.dbg_sdio_free_irq_cnt++;
+		}
 	}
+
+	sdio_release_host(func);
 }
 
 static struct dvobj_priv *sdio_dvobj_init(struct sdio_func *func)
-- 
2.17.1

