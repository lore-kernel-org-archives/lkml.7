Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF48C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427F420685
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRiQ75S8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfDVJ6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:58:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39902 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDVJ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:58:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so13907354wmk.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 02:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ucwYonw5RQpt1gbYnvW2qWKBm2os7Wce+2pDRtOlAM=;
        b=VRiQ75S8Z2TdPdAlZBtp9B/Z3V2BIuYjijK3Y1DyAzE3jLXb1kIzzyF4e6hTXdYGiC
         vdUvNestPI5ltdF78LGzLZ2Toznp6dgs6xW+65SWrJ9otbe/wrRZi/7CXNRDZIpuKVkB
         kVG+fhyPbS2yIMVCcHomnH6TkUZOdAsH8oHrzAGMDQp/kZgZSe6U9mVIYw6vsqqeuKRI
         QzkkYWvjOUHEjkWiX+YwUJkXg3Ep1ENXtku1+Vijaew/VZ8tDd0lBXsuEGXpUoer69nJ
         rR0Y6pix0wUZ0hO7VPoFHA5yWbWqHzyeTNJ0VzSN/cisWE9U1xv7exIeHRK8EfTkgqoq
         lWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ucwYonw5RQpt1gbYnvW2qWKBm2os7Wce+2pDRtOlAM=;
        b=ZrVg7xtpZIkT39rrupMpU6OMmPufp/bYxvFKEpMmfXprapc/u7xVJ42p5x2Xvl8thQ
         iOL+9jfoCYkO599j8TcpwVFqfDPu/3O3LGcEsV1p9R0cAt6PWjRYxvpJZzKI9uYxZP5x
         5anIQjjq64dm24BtQDUYxOeA/0NR6XzsgxMDYYLd0wBmln4qAbCDfZUYTM+FfTPz5vVp
         CmqRqJG4gZk+VQHiFnCIhaq76gTyRftlMfdgV9YtSrRcQ+h303SiBkPaMUwjLRVfebf1
         rdDIMtKvsMZcLJN0Px9mSuGbNaECvLBXjCfok2mEFb+qM6Fd8ecNFsqLz9Zrm4dPLV8m
         HgYw==
X-Gm-Message-State: APjAAAUEMtrwEpPIzJR4rlN0fSPi/TfDv9a51gInR1mo2cgCgcz7hv+N
        Y9S9aIj4iYtWdNQEmWmct+o=
X-Google-Smtp-Source: APXvYqzkfdFm34bdn2fjoSwmEJ2RK7oSBKemKfa03VfFChQZs1DncjW8vSFNyeDcqzS+tBrkNy5JKQ==
X-Received: by 2002:a1c:9991:: with SMTP id b139mr12268305wme.53.1555927114238;
        Mon, 22 Apr 2019 02:58:34 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb88.dynamic.kabel-deutschland.de. [95.90.187.136])
        by smtp.gmail.com with ESMTPSA id i17sm12923181wrs.44.2019.04.22.02.58.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 02:58:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: rtl8188eu: add spaces around operators in rtw_ap.c
Date:   Mon, 22 Apr 2019 11:58:23 +0200
Message-Id: <20190422095826.3119-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '+', '-' and '|' to follow kernel coding style.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index c360856a86ec..9588ba2a16e4 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -922,7 +922,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 
 		pht_cap->mcs.rx_mask[0] = 0xff;
 		pht_cap->mcs.rx_mask[1] = 0x0;
-		memcpy(&pmlmepriv->htpriv.ht_cap, p+2, ie_len);
+		memcpy(&pmlmepriv->htpriv.ht_cap, p + 2, ie_len);
 	}
 
 	/* parsing HT_INFO_IE */
@@ -1122,9 +1122,11 @@ static void update_bcn_erpinfo_ie(struct adapter *padapter)
 		struct ndis_802_11_var_ie *pIE = (struct ndis_802_11_var_ie *)p;
 
 		if (pmlmepriv->num_sta_non_erp == 1)
-			pIE->data[0] |= RTW_ERP_INFO_NON_ERP_PRESENT|RTW_ERP_INFO_USE_PROTECTION;
+			pIE->data[0] |= RTW_ERP_INFO_NON_ERP_PRESENT |
+					RTW_ERP_INFO_USE_PROTECTION;
 		else
-			pIE->data[0] &= ~(RTW_ERP_INFO_NON_ERP_PRESENT|RTW_ERP_INFO_USE_PROTECTION);
+			pIE->data[0] &= ~(RTW_ERP_INFO_NON_ERP_PRESENT |
+					  RTW_ERP_INFO_USE_PROTECTION);
 
 		if (pmlmepriv->num_sta_no_short_preamble > 0)
 			pIE->data[0] |= RTW_ERP_INFO_BARKER_PREAMBLE_MODE;
@@ -1153,12 +1155,13 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	if (!pwps_ie_src)
 		return;
 
-	pwps_ie = rtw_get_wps_ie(ie+_FIXED_IE_LENGTH_, ielen-_FIXED_IE_LENGTH_, NULL, &wps_ielen);
+	pwps_ie = rtw_get_wps_ie(ie + _FIXED_IE_LENGTH_,
+				 ielen - _FIXED_IE_LENGTH_, NULL, &wps_ielen);
 
 	if (!pwps_ie || wps_ielen == 0)
 		return;
 
-	wps_offset = (uint)(pwps_ie-ie);
+	wps_offset = (uint)(pwps_ie - ie);
 
 	premainder_ie = pwps_ie + wps_ielen;
 
@@ -1171,15 +1174,15 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	}
 
 	wps_ielen = (uint)pwps_ie_src[1];/* to get ie data len */
-	if ((wps_offset+wps_ielen+2+remainder_ielen) <= MAX_IE_SZ) {
-		memcpy(pwps_ie, pwps_ie_src, wps_ielen+2);
-		pwps_ie += (wps_ielen+2);
+	if ((wps_offset + wps_ielen + 2 + remainder_ielen) <= MAX_IE_SZ) {
+		memcpy(pwps_ie, pwps_ie_src, wps_ielen + 2);
+		pwps_ie += (wps_ielen + 2);
 
 		if (pbackup_remainder_ie)
 			memcpy(pwps_ie, pbackup_remainder_ie, remainder_ielen);
 
 		/* update ie_length */
-		pnetwork->ie_length = wps_offset + (wps_ielen+2) + remainder_ielen;
+		pnetwork->ie_length = wps_offset + (wps_ielen + 2) + remainder_ielen;
 	}
 
 	kfree(pbackup_remainder_ie);
-- 
2.21.0

