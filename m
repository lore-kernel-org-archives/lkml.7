Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B14AC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475B52183F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0lQMHQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfGBH7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:59:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42648 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfGBH7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:59:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so3917331pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ElTcQKvctdzE95ivmztIczQQu4NRuAdLp1VqKYU0Y9M=;
        b=Y0lQMHQHABpq2pOxaJ5e4qsfAnNDAnMvGR+KVBItMjLnRGVOj2he3KQKY63Q0tBTnU
         k38Knyri1gzmXffSIB1OzKhmEFHQ1FNKZYr9FXDyB4vEKN5k6FRItNQG02FdekcozNhg
         fXmsXxVxi1paDlxV0/+CfAL47U4dQu6LsWBBjo9tg6fMHxN7CjskTnQBbjtqYm59bYa1
         D3UzzvesJDnRG55NhqYvSGI+5lxnoxShSGHE+1eLyge0SEDKF0gk80B6q/sdaV2a9+mX
         if/Tm5jJQ7rTNk8ILD8wyqYO/wFLrFYBlhc24LkmIpY/oj2s1kLa9Jc/v3CG803HJmTH
         x/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ElTcQKvctdzE95ivmztIczQQu4NRuAdLp1VqKYU0Y9M=;
        b=eUvdev8Uz63eqQY9Ms5P9Vs3ynS/Lk9+bs1r9Hy7mFeeVM8lG7Ht6dq23rlgpjDMj2
         Yyx5falDLmqJMb7Cu2KphAXq4gE38Xmrqhf2MH7qthxBKZCmrEQ5slcpu5addum5ixnk
         QpEj4+HBJHq+Gm3nay3BYLd+8wugbImXhvVi3Kt9/V+B3Wh8Hhe6Kj1y4ADQVZ0QZkvg
         9O5+mmMrZUtbwtiO6ZxictVZ+RC33BpM3VL2Pd1/v49Xa+IrBIpkEibSxyN8aVN1fcA1
         aKW2YuQObio2VZgHp5/FPK3Xzu3YUMYdN2cWP5j/tcirR/2dLM/QHvfXwEh6H/uRCW1a
         nTDA==
X-Gm-Message-State: APjAAAVcIv+HzqysAxtRituu3T76cuCiK2zW/EWw/5HY9AUdMa3LSmoD
        l6ZBAj/EMHD03pCpa/vJUZNM271t6Gc=
X-Google-Smtp-Source: APXvYqwojUUl4UszX2SvZdsi7J/M4tYf+I70/dI7y0ClbE452E5/uj8Bf7aMTNQTZW2BHlzLPlpqdw==
X-Received: by 2002:a63:f1c:: with SMTP id e28mr28845438pgl.147.1562054354986;
        Tue, 02 Jul 2019 00:59:14 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id i124sm11379658pfe.61.2019.07.02.00.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:59:14 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 19/27] staging: rtl8*: use zeroing allocator rather than allocator followed with memset 0
Date:   Tue,  2 Jul 2019 15:59:08 +0800
Message-Id: <20190702075908.24399-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use zeroing allocator rather than allocator followed with memset 0.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Resend

 drivers/staging/rtl8188eu/os_dep/mlme_linux.c     |  3 +--
 drivers/staging/rtl8712/rtl871x_io.c              |  4 +---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  8 ++------
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    | 12 +++---------
 4 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
index 9db11b16cb93..250acb01d1a9 100644
--- a/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/mlme_linux.c
@@ -98,10 +98,9 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 	if (authmode == _WPA_IE_ID_) {
 		RT_TRACE(_module_mlme_osdep_c_, _drv_info_,
 			 ("rtw_report_sec_ie, authmode=%d\n", authmode));
-		buff = rtw_malloc(IW_CUSTOM_MAX);
+		buff = rtw_zmalloc(IW_CUSTOM_MAX);
 		if (!buff)
 			return;
-		memset(buff, 0, IW_CUSTOM_MAX);
 		p = buff;
 		p += sprintf(p, "ASSOCINFO(ReqIEs =");
 		len = sec_ie[1] + 2;
diff --git a/drivers/staging/rtl8712/rtl871x_io.c b/drivers/staging/rtl8712/rtl871x_io.c
index 17dafeffd6f4..87024d6a465e 100644
--- a/drivers/staging/rtl8712/rtl871x_io.c
+++ b/drivers/staging/rtl8712/rtl871x_io.c
@@ -107,13 +107,11 @@ uint r8712_alloc_io_queue(struct _adapter *adapter)
 	INIT_LIST_HEAD(&pio_queue->processing);
 	INIT_LIST_HEAD(&pio_queue->pending);
 	spin_lock_init(&pio_queue->lock);
-	pio_queue->pallocated_free_ioreqs_buf = kmalloc(NUM_IOREQ *
+	pio_queue->pallocated_free_ioreqs_buf = kzalloc(NUM_IOREQ *
 						(sizeof(struct io_req)) + 4,
 						GFP_ATOMIC);
 	if ((pio_queue->pallocated_free_ioreqs_buf) == NULL)
 		goto alloc_io_queue_fail;
-	memset(pio_queue->pallocated_free_ioreqs_buf, 0,
-			(NUM_IOREQ * (sizeof(struct io_req)) + 4));
 	pio_queue->free_ioreqs_buf = pio_queue->pallocated_free_ioreqs_buf + 4
 			- ((addr_t)(pio_queue->pallocated_free_ioreqs_buf)
 			& 3);
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index db553f2e4c0b..f8e0723f5d1f 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1078,12 +1078,10 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
 	DBG_871X("pairwise =%d\n", pairwise);
 
 	param_len = sizeof(struct ieee_param) + params->key_len;
-	param = rtw_malloc(param_len);
+	param = rtw_zmalloc(param_len);
 	if (param == NULL)
 		return -1;
 
-	memset(param, 0, param_len);
-
 	param->cmd = IEEE_CMD_SET_ENCRYPTION;
 	memset(param->sta_addr, 0xff, ETH_ALEN);
 
@@ -2167,15 +2165,13 @@ static int cfg80211_rtw_connect(struct wiphy *wiphy, struct net_device *ndev,
 		{
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
-			pwep = rtw_malloc(wep_total_len);
+			pwep = rtw_zmalloc(wep_total_len);
 			if (pwep == NULL) {
 				DBG_871X(" wpa_set_encryption: pwep allocate fail !!!\n");
 				ret = -ENOMEM;
 				goto exit;
 			}
 
-			memset(pwep, 0, wep_total_len);
-
 			pwep->KeyLength = wep_key_len;
 			pwep->Length = wep_total_len;
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index e3d356952875..1491d420929c 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -478,14 +478,12 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
-			pwep = rtw_malloc(wep_total_len);
+			pwep = rtw_zmalloc(wep_total_len);
 			if (pwep == NULL) {
 				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, (" wpa_set_encryption: pwep allocate fail !!!\n"));
 				goto exit;
 			}
 
-			memset(pwep, 0, wep_total_len);
-
 			pwep->KeyLength = wep_key_len;
 			pwep->Length = wep_total_len;
 
@@ -2144,12 +2142,10 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
 	int ret = 0;
 
 	param_len = sizeof(struct ieee_param) + pext->key_len;
-	param = rtw_malloc(param_len);
+	param = rtw_zmalloc(param_len);
 	if (param == NULL)
 		return -1;
 
-	memset(param, 0, param_len);
-
 	param->cmd = IEEE_CMD_SET_ENCRYPTION;
 	memset(param->sta_addr, 0xff, ETH_ALEN);
 
@@ -3522,14 +3518,12 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 		if (wep_key_len > 0) {
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
-			pwep = rtw_malloc(wep_total_len);
+			pwep = rtw_zmalloc(wep_total_len);
 			if (pwep == NULL) {
 				DBG_871X(" r871x_set_encryption: pwep allocate fail !!!\n");
 				goto exit;
 			}
 
-			memset(pwep, 0, wep_total_len);
-
 			pwep->KeyLength = wep_key_len;
 			pwep->Length = wep_total_len;
 
-- 
2.11.0

