Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8B7C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7132B20830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okVxu1JD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfJCMZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:25:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35513 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbfJCMZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:25:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id v8so2723331wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 05:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ib/r61tbSexB1OnVkKNOt18FLUJy8O36CIIdkYoTSQw=;
        b=okVxu1JDlRGVgK8S/rV/IcDImZam46EkKetvnamhwBl7P3VaF5kAWPfnGQlY6ZBo3z
         aGzf0HjKxPd6nWvp3pX9U2ywm8VgI+I/BiU88M39jQ/OpS/ZLcPD8Nnd+HuK9NYRrXsq
         5BFHLpikIiPox8UFABtT9umwYXPjX8BmwvjAX3UOJoev0J4uPrjuJl23nvcbAgmGcGPg
         qTE7XYV810iQdT33+eAEy8w4MjTx5rqE+VdSBfdKrqEXfjYUb34B7unfe3M4Go97btSd
         A2U1nC1NBoTEDCeCNSa5QfgkuEMGfefaOzDXwz1ZgWDnx81MSF0nF6P5FTjeqkpDvJOK
         eQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ib/r61tbSexB1OnVkKNOt18FLUJy8O36CIIdkYoTSQw=;
        b=doEpL4vNEwusOSr49ThHjCtUkNsX9q52TqzI5Ghg/SMr4k/Hb7KcsjdPHkkqthgEnK
         LxuatqjsrAXEOts621Tmu4NS1GmAdjOlvgeqMnQMwsy0hwSaweoWBA3W2st4dqlwxfMd
         VCxTSnuHSopbUO4Or4+AH4X7W0griqxaHzVlecjoiDyb8UVoBWEymhjXy8p2ujdiEHBK
         7yavD2r1iM0mKDvquyBZ50fgAyZ3kE0H4ccR3WL6PTBY+nYUpbQJxKDuAzr2/Y/YOm1n
         +lnrXKD6HzLVIfnFIeajbzLR6kYTVitZv820/oHjkaZ1pOiqbsQPS4GxKPlfLELry6mP
         RlZA==
X-Gm-Message-State: APjAAAW1bMxwbVumgvgS9cwkvI0GG9Lajs7dZNdpZ2c4i7hxEWJTPbMf
        5yoC66fUWZl1xuUOc2qSlX8=
X-Google-Smtp-Source: APXvYqy+2M5QPIy6JWX+AH37obCYnWiGytvV3JKfeetDLFiW+zxNzmthvaujaJAOSFQteC+LJGbUAA==
X-Received: by 2002:adf:ee92:: with SMTP id b18mr6460803wro.217.1570105535287;
        Thu, 03 Oct 2019 05:25:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id f17sm2699322wru.29.2019.10.03.05.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 05:25:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: rtl8188eu: rename variables to avoid mixed case
Date:   Thu,  3 Oct 2019 14:25:12 +0200
Message-Id: <20191003122514.1760-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003122514.1760-1-straube.linux@gmail.com>
References: <20191003122514.1760-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the local varibles max_AMPDU_len and min_MPDU_spacing to avoid
mixed case.

max_AMPDU_len -> max_ampdu_len
min_MPDU_spacing -> min_mpdu_spacing

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 1e4461a74474..75c34e8f2335 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -560,8 +560,8 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 
 static void update_hw_ht_param(struct adapter *padapter)
 {
-	u8 max_AMPDU_len;
-	u8 min_MPDU_spacing;
+	u8 max_ampdu_len;
+	u8 min_mpdu_spacing;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
@@ -572,13 +572,13 @@ static void update_hw_ht_param(struct adapter *padapter)
 		ampdu_params_info [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
 		ampdu_params_info [4:2]:Min MPDU Start Spacing
 	*/
-	max_AMPDU_len = pmlmeinfo->HT_caps.ampdu_params_info & 0x03;
+	max_ampdu_len = pmlmeinfo->HT_caps.ampdu_params_info & 0x03;
 
-	min_MPDU_spacing = (pmlmeinfo->HT_caps.ampdu_params_info & 0x1c) >> 2;
+	min_mpdu_spacing = (pmlmeinfo->HT_caps.ampdu_params_info & 0x1c) >> 2;
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_MIN_SPACE, &min_MPDU_spacing);
+	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_MIN_SPACE, &min_mpdu_spacing);
 
-	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_FACTOR, &max_AMPDU_len);
+	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_FACTOR, &max_ampdu_len);
 
 	/*  */
 	/*  Config SM Power Save setting */
-- 
2.23.0

