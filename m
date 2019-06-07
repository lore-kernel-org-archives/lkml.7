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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41C3C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95B2208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nnwr/JXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfFGHU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:20:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46161 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfFGHUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 03:20:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id v9so668609pgr.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 00:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3s2Am2EXinIk1Cx3geFx3zyzkfhWkzc/aAXsSIIwy/4=;
        b=Nnwr/JXeTJIWPKjDDIY3rYwgxaUZr+W6/fvuDCn6Tpqm+ukyw2q216RHi9d4qF4UpQ
         fWu+QbfXKuo3xSPuUof/XqDURKl4WO97/XWFRwqPh6bGTbXXxr6v6RD2kdqrI0Rpmx3k
         ZkrasFu1neX7DISxTjaKQS9I+tuiaCWNlAXyL5mss6mLaNOlLGKFjtuWUmkuouF3hc3B
         gF75blTIvbgRB/LF33pbbXxl8ytOaLD/5HvTl2L7jf38jhwib226nN83t6sTPrncQXAl
         XywcMmtrqmN4EzupIK3zqk9UG2Qh2QBBTqTprQU0o2dZjnk1Y0cvZzNycSAaNrYoPvHE
         GCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3s2Am2EXinIk1Cx3geFx3zyzkfhWkzc/aAXsSIIwy/4=;
        b=sZo7BefvnaoG2AkrIyo17HdYCbpCy/KDshs0wF+0qeyJqdcRNx913uqFEzYOxVdlGD
         cArL82Gg4ysO//KeFiuRLXfZJowP4/H0RFHEcvx/gpsWhyme9QVuJqIhATFbCqjkNdu0
         wLhGJlJrP6WIsSWdRQyI18qzuNQRr8VgDXKhtruDA8ckaXPih/7dVwfFlSurdmvQgcUr
         svBK/saLE7F1wKt8mYqBXlju0pPduKi0RUq9HijnHxwHzZ/aUXdh9r7Q3xvva+xHrvX9
         vX446glyqEws1DciLj01htRQAgJB0aGKzrlX6757O7ZYiWxJIi1FhkT+NSc8lCU++GJ4
         zSCA==
X-Gm-Message-State: APjAAAVnBlXLF6QDNORpGbhtkqH3g83lwZnkZcqawydql+P3Zn4g8E19
        NnHm6MymjU8/g9mHYW0jwCs=
X-Google-Smtp-Source: APXvYqz4GA56O/vf+BShmfyDWKA++Cn5Rbi7jwTdvBjuCIhbipdUaQDpIT2JfB4Fiulm3lnYiGKjew==
X-Received: by 2002:a17:90a:21ac:: with SMTP id q41mr4029805pjc.31.1559892055103;
        Fri, 07 Jun 2019 00:20:55 -0700 (PDT)
Received: from localhost.localdomain ([110.227.95.145])
        by smtp.gmail.com with ESMTPSA id t24sm1178302pfh.113.2019.06.07.00.20.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 00:20:54 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, hardiksingh.k@gmail.com
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: hal: hal_btcoex.c: Remove variable
Date:   Fri,  7 Jun 2019 12:50:44 +0530
Message-Id: <20190607072044.28481-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable and use the values directly.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_btcoex.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index 6caddd7834a1..aebe8b8977ad 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -362,15 +362,9 @@ static u32 halbtcoutsrc_GetBtPatchVer(PBTC_COEXIST pBtCoexist)
 
 static s32 halbtcoutsrc_GetWifiRssi(struct adapter *padapter)
 {
-	struct hal_com_data *pHalData;
-	s32 UndecoratedSmoothedPWDB = 0;
-
-
-	pHalData = GET_HAL_DATA(padapter);
-
-	UndecoratedSmoothedPWDB = pHalData->dmpriv.EntryMinUndecoratedSmoothedPWDB;
+	struct hal_com_data *pHalData = GET_HAL_DATA(padapter);
 
-	return UndecoratedSmoothedPWDB;
+	return pHalData->dmpriv.EntryMinUndecoratedSmoothedPWDB;
 }
 
 static u8 halbtcoutsrc_GetWifiScanAPNum(struct adapter *padapter)
-- 
2.19.1

