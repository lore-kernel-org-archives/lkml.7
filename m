Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FD4ECE587
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 13:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B6D2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 13:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZDBbs0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfJMNNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 09:13:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38817 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbfJMNNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 09:13:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id l21so12505928edr.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 06:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q3DHhCXZ5LZWC7YrZHGmthdMiagzy1Un1WDuV8hFC1o=;
        b=SZDBbs0+U5Vq0bQdeUqWpklPXjXrmcOZ0Op8PTA4Ps2UjueO1XaRO9v7MUj4Fxl1Up
         iiLrGN/LWxETJmhP1+d6kwPWVTaiu/Z1VQsznD8Kf7S8ILGUXDGsjxReoOQfo+Rh/8tH
         N7nY6e003EElly9SsweqOGkoAbkfoUr/jAGkHL1w4BMwgnL7C1dCgYv/ZvrsVVTz2O9V
         cz1qcHDQBu7G1p35P2wjDxyv13BBHBbJdqWNgdXjbhaX1WHZmg37wK08CGC8YMffHukP
         8TtCn7aQSFnxpgxCvKxZnhHP0fbKsLHKfxLGWUuyum5kEdWp8onxFAhj331jjLKPljv2
         z4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q3DHhCXZ5LZWC7YrZHGmthdMiagzy1Un1WDuV8hFC1o=;
        b=dbKcGfbRFWpsyfAtxhzr1v88h/muelf/Iphwp7u3SUaiVIODTtJe/jThisCNMzHBQo
         IIgEqLiYMVNys1nO+ePOXdSzUme1PyC6fPcgjUiViIbVHj9vRjhk/LVNbdANN6W74rQa
         Le/+NnbI5raNUqPYgElDRFXVkI+9RgEOl3FpLfzQ2DMdbaPIOE44RoaSfFb2ncKQ16g/
         z7KFbf2jOYwPcgD66n1fSjSaAqGlUberlzdfihyXyM/+tT8qX/lhWmt8QR4a/M4UQZLc
         /03dHdlwvIgT5LiBKVx16opf5/jx6hmgFRElqr74absNUtryinsCsy9EVuvu0GeAvCj/
         675g==
X-Gm-Message-State: APjAAAUfwLa3ywibLtz0NefIlms0W003CVJKTX+Nnzk9qaKIiBf2QyQA
        t0MpY9kPQWMDbGzD1wspXbs=
X-Google-Smtp-Source: APXvYqzCZuJOnesmkEcff2g1L/U5WN8n3Ouu9PQgbyeDUhpMBss2bhbwd5ALOKxdhbDVXI1woErWOw==
X-Received: by 2002:a17:906:3415:: with SMTP id c21mr24738862ejb.190.1570972387311;
        Sun, 13 Oct 2019 06:13:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id u30sm2580520edd.18.2019.10.13.06.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 06:13:06 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8188eu: remove unnecessary conversion to bool
Date:   Sun, 13 Oct 2019 15:12:49 +0200
Message-Id: <20191013131249.34422-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191013131249.34422-1-straube.linux@gmail.com>
References: <20191013131249.34422-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comparsions evaluate to bool, explicit conversion with ternary
operator is overly verbose and unnecessary, so remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
index 7b16632048b7..03dc7e5fcc38 100644
--- a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
@@ -514,7 +514,7 @@ void rtw_init_pwrctrl_priv(struct adapter *padapter)
 		pwrctrlpriv->power_mgnt = PS_MODE_ACTIVE;
 	else
 		pwrctrlpriv->power_mgnt = padapter->registrypriv.power_mgnt;/*  PS_MODE_MIN; */
-	pwrctrlpriv->bLeisurePs = (pwrctrlpriv->power_mgnt != PS_MODE_ACTIVE) ? true : false;
+	pwrctrlpriv->bLeisurePs = (pwrctrlpriv->power_mgnt != PS_MODE_ACTIVE);
 
 	pwrctrlpriv->bFwCurrentInPSMode = false;
 
@@ -621,7 +621,7 @@ int rtw_pm_set_lps(struct adapter *padapter, u8 mode)
 			else
 				pwrctrlpriv->LpsIdleCount = 2;
 			pwrctrlpriv->power_mgnt = mode;
-			pwrctrlpriv->bLeisurePs = (pwrctrlpriv->power_mgnt != PS_MODE_ACTIVE) ? true : false;
+			pwrctrlpriv->bLeisurePs = (pwrctrlpriv->power_mgnt != PS_MODE_ACTIVE);
 		}
 	} else {
 		ret = -EINVAL;
-- 
2.23.0

