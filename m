Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F28C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB6B20665
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408587AbfITJsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 05:48:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43171 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405771AbfITJsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 05:48:10 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <connor.kuehl@canonical.com>)
        id 1iBFWL-0005Aq-0s
        for linux-kernel@vger.kernel.org; Fri, 20 Sep 2019 09:48:09 +0000
Received: by mail-wm1-f72.google.com with SMTP id g82so955965wmg.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 02:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B0gRBX2sU0Z6OKmHo7Z4yIU03olB4csImxHyIILBwAA=;
        b=JC/YpPNc7WOKKAV8XgOhJxswjxjIAgtPkJYkbRcKMSabGYPOPxPNhbIJizxFuQkv+K
         860kbqFYefiTuRZNdksbIP58N7WOL5o2bbKe/Z6ZvpU0CWAYucd2E8NAY+RWZ1Kgj5i/
         iLt3/DKdeq2E5qbkf6tOCUzueGTkXpHtBtthsTQXht1vDO7mNNaqQkNhYYGw3FZPkRuf
         WhWbLMXee7pykufUmnx2DBMGkaHOelgkiB0LnbiojoQVi8lxsoPNr/ASgnqdgS3yPNqO
         fi7FvKhohb+Wczm8t3diwgtpzty/x6MfyyNdznuOrRi5BN2X8nlVQJiX113m73kgdwAK
         OPcQ==
X-Gm-Message-State: APjAAAWysRPp1Z/0BMNFDeupgaJQeFGDLQTzzxRFfz48y+Vb/hOhogms
        Ir12kX6EFRE5cpGc377gwJON/bpYKGNgAVFBk4V1GQr0NHmGwwDFQw6nJogwcPBpyvshlq5GKiH
        4hJ0rKmjcZAz5UEdAMxE0iDDunwldkPeTvdz5YU+Shg==
X-Received: by 2002:a5d:430f:: with SMTP id h15mr11239560wrq.177.1568972888806;
        Fri, 20 Sep 2019 02:48:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxVRY04L0KSUugiU+ntxgo+Wvpl8BGaO0LusgrffrFde1j3tGSNP2BDAc7riJC99gqoaqgZaw==
X-Received: by 2002:a5d:430f:: with SMTP id h15mr11239545wrq.177.1568972888657;
        Fri, 20 Sep 2019 02:48:08 -0700 (PDT)
Received: from canonical.c.hoisthospitality.com (static-dcd-cqq-121001.business.bouyguestelecom.com. [212.194.121.1])
        by smtp.gmail.com with ESMTPSA id z9sm2104375wrp.26.2019.09.20.02.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 02:48:07 -0700 (PDT)
From:   Connor Kuehl <connor.kuehl@canonical.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: remove unnecessary self-assignment
Date:   Fri, 20 Sep 2019 11:48:07 +0200
Message-Id: <20190920094807.9217-1-connor.kuehl@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a self-assignment which is redundant. Fix this by removing the
self-assignment.

Addresses-Coverity: ("Self assignment")

Signed-off-by: Connor Kuehl <connor.kuehl@canonical.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
index 086f98d38cba..57ae0e83dd3e 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
@@ -552,7 +552,6 @@ void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter, u8 *PROMContent, bool
 			pHalData->AntDivCfg = 1; /*  0xC1[3] is ignored. */
 	} else {
 		pHalData->AntDivCfg = 0;
-		pHalData->TRxAntDivType = pHalData->TRxAntDivType; /*  The value in the driver setting of device manager. */
 	}
 	DBG_88E("EEPROM : AntDivCfg = %x, TRxAntDivType = %x\n", pHalData->AntDivCfg, pHalData->TRxAntDivType);
 }
-- 
2.17.1

