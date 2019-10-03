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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFC0C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6510D21A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tjbXHeyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfJCMZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:25:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39725 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbfJCMZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:25:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id v17so2141278wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 05:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lleiCD1v15l9Knq/O5s6uOY5ExpJMMfHSdvlMxr6Vcg=;
        b=tjbXHeyN83Cp9mfYg6tMmuCTa8iJlm2AtRkNUAUmvZfqMRXO5ErwNPiTFg4RqiSmNU
         yooE7YjhTsk6R+xdORaqzFj93gsbin6YREP/vTW3MYm3K6INWohS159Do2xjVpfAyZlS
         bIOr7lEJ0ctcpwpPkFVL1HrxJDl+QCATHH0it9BDav0K3QgoKkA+68bdBrS44aaW7IbG
         By5pWfvKjz9FRXc6r/bBROrmFb060ZG8E+/C+c0XXJZLjXHT6RgpLVPOmlJ+t6eeypD3
         YCiaUng9m7nfEPZVqSRVoYUOR65TQgBXgk+/NcLaCHaJp5bOb9uTiaFpuhW5VQUAvWmO
         AA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lleiCD1v15l9Knq/O5s6uOY5ExpJMMfHSdvlMxr6Vcg=;
        b=jLpJV1SuGHT2Cpo1/XIpZsTcN5007938ITYnksEbuWSazU5pkt8DwgFt1PrWw5FE6I
         w26Jofa0TI+cpNQGtMSplNfrJ7N9pLIu7LKzGnvey3nP0OUBCdHFu5YaMF07nks6Y0r8
         UC9rfa8+YMDVDp78ebeXcOoBvElFxe1jAPs7t2ykMuR988iJhb+/BNm9eNlqZWrAjYOH
         PUBflX0dc8h4oxOQ44wHwZvO9+6lVhyKvcyDbFUxMuxFklWLl8HPon67cn5KwyleLc8Z
         5uCaC4CBaZIMkJB45/i+yYH5A6R+enDokZEC/+bep0OZXeA4C0KHnnUKFq2JxtHO5KVa
         mCXg==
X-Gm-Message-State: APjAAAUB0MuhfohXTSF11/UBlZFsJQKYFDrx/F3TPj8v7xmpxs9hITh5
        T0dxe2NIEH68BB08nmRxvLk=
X-Google-Smtp-Source: APXvYqyEuPiddb/r4iV5RZ/2bLpIuHN1lQrx6jlHqD0XiQXyNIrRs+ECucgSNcu+GQPyJYAj6JwrOg==
X-Received: by 2002:a7b:c108:: with SMTP id w8mr6875006wmi.8.1570105537024;
        Thu, 03 Oct 2019 05:25:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id f17sm2699322wru.29.2019.10.03.05.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 05:25:36 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: rtl8188eu: cleanup comments in update_hw_ht_param
Date:   Thu,  3 Oct 2019 14:25:14 +0200
Message-Id: <20191003122514.1760-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003122514.1760-1-straube.linux@gmail.com>
References: <20191003122514.1760-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup comments in update_hw_ht_param to follow kernel coding style
and avoid line length over 80 characters.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 97cab71cef23..9aa44c921aca 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -567,20 +567,17 @@ static void update_hw_ht_param(struct adapter *padapter)
 
 	DBG_88E("%s\n", __func__);
 
-	/* handle A-MPDU parameter field */
-	/*
-		ampdu_params_info [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
-		ampdu_params_info [4:2]:Min MPDU Start Spacing
-	*/
+	/* handle A-MPDU parameter field
+	 * ampdu_params_info [1:0]:Max AMPDU Len => 0:8k , 1:16k, 2:32k, 3:64k
+	 * ampdu_params_info [4:2]:Min MPDU Start Spacing
+	 */
 	max_ampdu_len = pmlmeinfo->HT_caps.ampdu_params_info & 0x03;
 	min_mpdu_spacing = (pmlmeinfo->HT_caps.ampdu_params_info & 0x1c) >> 2;
 
 	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_MIN_SPACE, &min_mpdu_spacing);
 	rtw_hal_set_hwreg(padapter, HW_VAR_AMPDU_FACTOR, &max_ampdu_len);
 
-	/*  */
-	/*  Config SM Power Save setting */
-	/*  */
+	/* Config SM Power Save setting */
 	pmlmeinfo->SM_PS = (le16_to_cpu(pmlmeinfo->HT_caps.cap_info) & 0x0C) >> 2;
 	if (pmlmeinfo->SM_PS == WLAN_HT_CAP_SM_PS_STATIC)
 		DBG_88E("%s(): WLAN_HT_CAP_SM_PS_STATIC\n", __func__);
-- 
2.23.0

