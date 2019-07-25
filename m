Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE7FC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBCF22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3y7KyeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391018AbfGYRJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:09:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40440 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388559AbfGYRJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:09:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so51570592wrl.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 10:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ec8xBLIRJMB96z4CmSL5OwNWKBAlshAdxvW0h7AzbUM=;
        b=S3y7KyeYp3mLwmfxuf2K68/8o8WfH4ywasVTEy02uE1pjhWHzzu7V7t7YmGASUon1u
         EAsFFpV3kqnMrmSqmBGt9tMWCS0JC04sBVsH3JWDhIfpAk4UK3QCbfI5pKLaUWn9dn7S
         mqJyEEkPeRBAKtSyOTz+QAB31IZXoATamOBLvDAS3233Noms5NkRD7l5qIr38oFG29B6
         91IXIE6ULkI8LvABripYwAQURI+Qp+DPvk/BFfBHZkgd7F/cnhfX+ZZI9ahEv/tGcEHs
         hhIUpLi+MTBAUIVjyJDjL+Wxrv2GBiyP86/+YV9ORwZ3eaATIRv6SpSdjP/Pi4/I82tg
         m5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ec8xBLIRJMB96z4CmSL5OwNWKBAlshAdxvW0h7AzbUM=;
        b=niTitzossD23c+C9mqs1t4NSD2KJWonKXSM7dWDNvR4IlsUWBPO1hd81dtEOcOYWfj
         nMGlELCj335mQXn18xNuBAzB7j7M4/R2MKvticbSpLqycFXOs5OPRlYw7h11+uWC7ZMN
         knq1pOy7QWviQlUuTORVjB+xVaTHwY5O+bIo0Bua9+NiHVvSpHX0Ua+YEZzz0LGGJdmQ
         RuKIVgntM7GBlMzX0nkPWVyz05I9Xy1ut/Y08aVPy9mC13t14ECT4gb8GZXgquiznx90
         lCTuOC8EKEl15PLQc0gWK83znP75TgsQYvfoI9sQARXjIW1TKlL2rUPsfKA+vwB5c4QF
         Mh1A==
X-Gm-Message-State: APjAAAWIWSXFeV7tS5xYdqxK57RK20qyA6QuOy3cbcOJwI0jQNmOKYBB
        VQ1luRfPGA/VCDXRrig+Ows=
X-Google-Smtp-Source: APXvYqywFsQEc1QbUaQQXS0GyR+xSbYgUggabL+ep/LI0JjoGPt5AHn+YExhm9rCT3TsL1LnXwppRw==
X-Received: by 2002:a5d:618d:: with SMTP id j13mr94779237wru.195.1564074577933;
        Thu, 25 Jul 2019 10:09:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id u6sm51798911wml.9.2019.07.25.10.09.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 10:09:37 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: replace hal_EfusePgCheckAvailableAddr()
Date:   Thu, 25 Jul 2019 19:09:22 +0200
Message-Id: <20190725170922.16465-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function hal_EfusePgCheckAvailableAddr() contains just a single if
test. Remove the function and replace the call to it with the if test.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index 51c3dd6d7ffb..533ca1ddffb0 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -763,17 +763,6 @@ static bool hal_EfusePartialWriteCheck(struct adapter *pAdapter, u8 efuseType, u
 	return ret;
 }
 
-static bool
-hal_EfusePgCheckAvailableAddr(
-		struct adapter *pAdapter,
-		u8 efuseType
-	)
-{
-	if (Efuse_GetCurrentSize(pAdapter) >= EFUSE_MAP_LEN_88E)
-		return false;
-	return true;
-}
-
 static void hal_EfuseConstructPGPkt(u8 offset, u8 word_en, u8 *pData, struct pgpkt *pTargetPkt)
 {
 	memset((void *)pTargetPkt->data, 0xFF, sizeof(u8)*8);
@@ -789,7 +778,7 @@ bool Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8 word_en, u8 *pD
 	u16			startAddr = 0;
 	u8 efuseType = EFUSE_WIFI;
 
-	if (!hal_EfusePgCheckAvailableAddr(pAdapter, efuseType))
+	if (Efuse_GetCurrentSize(pAdapter) >= EFUSE_MAP_LEN_88E)
 		return false;
 
 	hal_EfuseConstructPGPkt(offset, word_en, pData, &targetPkt);
-- 
2.22.0

