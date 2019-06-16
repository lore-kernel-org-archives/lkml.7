Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5028FC31E49
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 05:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C9121473
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 05:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYu/+NVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfFPFc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 01:32:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45170 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfFPFc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 01:32:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id s21so3900408pga.12
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 22:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mzA6YGK114GVMFQzrNpNT//3gdsVz7F+WL+F5wNK5UE=;
        b=LYu/+NVwSLjv4s670OLSv8HTPOpogxzRVgy5uyO+17vtePiBW2qxQMesQnBnyviEEZ
         Zwsm/ia7xgwFCATgBvwxJmSzG6mBIt7xNSmpsbonMzv7MKtfOJc7R/a7ozuQYmURwwJB
         7dnG59e9eU5HbsSxqvuBy8Qn1T3c79ltpJe6DDIuBSQ+NnikKYaTC/6JMfOf9M9Jlm7+
         pU4eHv6W4jit1V21AZY3PF2V30N6F6rQI7eo0O7fso/BeqDFx4NkOwaLg8k8OLCp9Fbj
         rajP7MTDZWhY5KFup2ymhhvG1I2GKXMlXnQfJOlIFpeOMCtXIjuH82FeWK8Kao4I0uSY
         F9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mzA6YGK114GVMFQzrNpNT//3gdsVz7F+WL+F5wNK5UE=;
        b=iMLnwKD3Bmtl/Npxu9dksj6yI/rLjWAd9bX4x+HTwGgHqPPGaJ0EHeW21KxDpBOWw0
         eBgnmLbFWK+OmhKzj7mnBWTveKx7dEzQ/w1964TL8Ax6v4TbhGMd5EoQTyvuKVMFMggS
         RMpqXEGHf6AnaWPVhqOd4Hwn+Dtz7xbHc8I+YbtOta9XYOrIlUcGOZGa8xvzrqHo8DqC
         Nh/3iJP362ywSovuhYAkmARJApTwDmHdl36lcip4XG7p9wsPeOmqoNd6w7SoSI0W2onR
         jjb64GJ0DV0A1llPxB0Y4bNgoDOCZ2bkjWuODISFrfMgiIWOiyByj7w90Z4xL7mZlQ2n
         Nehw==
X-Gm-Message-State: APjAAAX6efJoyCS/XccSAmjrCeAi3IGEXZqfcGh9zEb6xKj3mjC5xu1w
        k28CPyDLOz81CRiuVf3zA0o=
X-Google-Smtp-Source: APXvYqy/qNZg1GQjR2zk1frJxNxSAejEDL/BNJ2/rkpno+AU9YJmzwyLbBAwXfhS0UxAcTt6WyQBHQ==
X-Received: by 2002:a63:dc56:: with SMTP id f22mr28014541pgj.305.1560663175751;
        Sat, 15 Jun 2019 22:32:55 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id c9sm8305651pfn.3.2019.06.15.22.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 22:32:55 -0700 (PDT)
Date:   Sun, 16 Jun 2019 11:02:50 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: os_dep: ioctl_linux:  Make use
 rtw_zmalloc
Message-ID: <20190616053250.GA16116@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_malloc with memset can be replace with rtw_zmalloc.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index fc3885d..c59e366 100644
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
 
@@ -3521,14 +3517,12 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
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
2.7.4

