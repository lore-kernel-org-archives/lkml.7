Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12418C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C5D218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bu1C08H+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbfGZSFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:05:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36112 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbfGZSFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:05:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id g67so44286332wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 11:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=enVHRv1hzuB9DJdnWqCR0Hba3g3fFl7T7q4qjet7quA=;
        b=Bu1C08H+O89Gvqnc4MHs/dvqLDwOEJNxd6PUlhpPQ0/MtUyUKJALlsF6V0/OJoTpy3
         HexvSPG2yUEyBOdTLuDe4PNpvHWY/tkhtLPMkuxBSRRB3jww9NFWkZt+j++TkHLGhvsi
         88MNZFZGpB5XgLwL3F0Kd6+ibWUztbZbJf4wgv+FLKgYLQKasIgu2h1MMnazBkDZGIkv
         kMqcQ5F+zH5URiax79p3LvX7ivpFhgn1ygoYSkVt7GjwblZVmyICM75PrOg1Dl+L9/jo
         AQ8O519KEHDHZwHdNwnu0VXz5Ko1Mu74bfWwnpb46t36/6SLTCAC+UmT/xu+MIsqVd9H
         hEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=enVHRv1hzuB9DJdnWqCR0Hba3g3fFl7T7q4qjet7quA=;
        b=FrdT9kXagSZkwRpBZJfMnyRQpcZW4dJdj2IH1N/c2X+PE3+NhUVkKgaoC8H0Bz+8NR
         vJcfuEqNckX6yMs2EgbkFTLR3ZEmu01rqM0D0S6Rh1z7/SDDFdN+qxLhxE2uJ41BnDdR
         /DbLv3W0Ek1cwWKuKhecmBB4kJ8uNCLOaz+mEnZRaYYHUzVQ7QE0kt0jPVbg5l1Nt1qq
         y+NHI5+4sDIW/bqaADIGY8QGY4nE503gtfczW6DjPKZAYf24GXPAoDHawh4Ad4FTeNTF
         asdj2aJi2P9VjhSjmVZQ2WWrG19ZWAmpMQkSd3q/BuuBKaX7wfPRWJQLLg2teqxOCszc
         EUJg==
X-Gm-Message-State: APjAAAXjZugud6jBxVpuBDc2QmIiyO+h8Ma2UK3ps0TIPyCB63CPl1KG
        CbPSfpmNreYFMrzFcphiRfg=
X-Google-Smtp-Source: APXvYqwAjH34PdGkB7r0hZnVFL3ktfFsk6yV6XpbWZqQ2po4BATrPac2HREJBiM9pPGXA/uWD2Lz2g==
X-Received: by 2002:a1c:a909:: with SMTP id s9mr85344396wme.20.1564164303895;
        Fri, 26 Jul 2019 11:05:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id p14sm43535931wrx.17.2019.07.26.11.05.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 11:05:03 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/6] staging: rtl8188eu: add spaces around '-' and '*' in usb_halinit.c
Date:   Fri, 26 Jul 2019 20:04:47 +0200
Message-Id: <20190726180448.2290-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726180448.2290-1-straube.linux@gmail.com>
References: <20190726180448.2290-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '-' and '*' to improve readability and follow kernel
coding style. Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/usb_halinit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/usb_halinit.c b/drivers/staging/rtl8188eu/hal/usb_halinit.c
index 40162f111195..0f54fde2f47b 100644
--- a/drivers/staging/rtl8188eu/hal/usb_halinit.c
+++ b/drivers/staging/rtl8188eu/hal/usb_halinit.c
@@ -190,7 +190,7 @@ static void _InitPageBoundary(struct adapter *Adapter)
 {
 	/*  RX Page Boundary */
 	/*  */
-	u16 rxff_bndy = MAX_RX_DMA_BUFFER_SIZE_88E-1;
+	u16 rxff_bndy = MAX_RX_DMA_BUFFER_SIZE_88E - 1;
 
 	usb_write16(Adapter, (REG_TRXFF_BNDY + 2), rxff_bndy);
 }
@@ -1298,7 +1298,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 			struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
 			struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
-			tsf = pmlmeext->TSFValue - do_div(pmlmeext->TSFValue, (pmlmeinfo->bcn_interval*1024)) - 1024; /* us */
+			tsf = pmlmeext->TSFValue - do_div(pmlmeext->TSFValue, (pmlmeinfo->bcn_interval * 1024)) - 1024; /* us */
 
 			if (((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE))
 				StopTxBeacon(Adapter);
@@ -1484,7 +1484,7 @@ void rtw_hal_set_hwreg(struct adapter *Adapter, u8 variable, u8 *val)
 				else
 					ulContent = 0;
 				/*  polling bit, and No Write enable, and address */
-				ulCommand = CAM_CONTENT_COUNT*ucIndex + i;
+				ulCommand = CAM_CONTENT_COUNT * ucIndex + i;
 				ulCommand = ulCommand | CAM_POLLINIG |
 					    CAM_WRITE;
 				/*  write content 0 is equall to mark invalid */
-- 
2.22.0

