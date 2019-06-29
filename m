Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1B6C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0051214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSiTJ0VH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfF2KTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 06:19:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39364 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfF2KTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 06:19:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so4646565pls.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 03:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=66nQjAJxmJvEqdK76xbS0v4Awl8Ld4jHNoG2MYlrSPc=;
        b=hSiTJ0VH2LR8cD4eJvD9GFiE8771rr/Wd0rwQVye9hTyXBYynhUsJK21v3cZ5R4HbD
         cQAgS3qiSbsEu5XjEtG47z6H0i2gfSO914VH4Us4NOFg8x9yQudP+BHtgVnNt7rBJXFU
         ZUZB+0hWO3/OwM6iOax3YNg6AZBp1su1VZ7AJsI8EMSUK61be8ney6l2xXtpKg86PnCR
         m+U0Xzexx3snRiAwQRrQX/JUqBQ8Eg8FBrj2IhZQu0gRO94f2yIkbehUlA0DShHmLWxz
         +pcUsvJw0GZIu+63MRRMc1twS/hJ6sOBL7ap2QLqQP2uxQ3egf0YfvmzdQBiVRjs8PDC
         sKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=66nQjAJxmJvEqdK76xbS0v4Awl8Ld4jHNoG2MYlrSPc=;
        b=CKkM+P3ZFM6xf2HvHD9a+8E6JZr1hMbxAsXoRBPZ6uJWD4IsyTxqGBwbbN5+OrOYoR
         U1HPVjIWOk/8mQo5/92SiGWghP58hRjGUxFzetdhsolruutPFnZtDNpnCc/vAaaTLwFg
         j1+dPsegeCV+WmSkQYfSELvtFYGL8I7sD9x36obLwmNrzoyxDt5fd+WNEszcjPDifSS/
         sx32FovQOdnKkELUBG4SoXRXGF5x2MDfePJDiECk8V029mdclNtoI3s1Is+xm9eu8KXX
         SN1HuW9iqjg8drmQH5U5SspiS/NN0UegX22bvNzVCYYSxEpVLCUVDrxzUmd01cfGXSBe
         /6vA==
X-Gm-Message-State: APjAAAXJ0XNyYv042FU+9jf5uOWEcX+r9vu6GzqiX4ZWfSx1bdTQFpDJ
        8ngAdAadKhicBgQ/SgTf06Q=
X-Google-Smtp-Source: APXvYqwfqiCBofp4EV/LyHS60DAP50fcMYoXiAq34ZMr1M4xaFUUCRyg0J/wRkSIB7P3M0mv4xA4uw==
X-Received: by 2002:a17:902:290b:: with SMTP id g11mr16690707plb.26.1561803554032;
        Sat, 29 Jun 2019 03:19:14 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id x26sm5907869pfq.69.2019.06.29.03.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 03:19:13 -0700 (PDT)
Date:   Sat, 29 Jun 2019 15:49:09 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] staging/rtl8723bs/hal: fix comparison to true/false is
 error prone
Message-ID: <20190629101909.GA14880@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issues reported by checkpatch

CHECK: Using comparison to false is error prone
CHECK: Using comparison to true is error prone

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 4a4d17b..b9d13e3 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -230,7 +230,7 @@ s32	rtw_hal_mgnt_xmit(struct adapter *padapter, struct xmit_frame *pmgntframe)
 	/* pwlanhdr = (struct rtw_ieee80211_hdr *)pframe; */
 	/* memcpy(pmgntframe->attrib.ra, pwlanhdr->addr1, ETH_ALEN); */
 
-	if (padapter->securitypriv.binstallBIPkey == true) {
+	if (padapter->securitypriv.binstallBIPkey) {
 		if (IS_MCAST(pmgntframe->attrib.ra)) {
 			pmgntframe->attrib.encrypt = _BIP_;
 			/* pmgntframe->attrib.bswenc = true; */
@@ -430,7 +430,7 @@ s32 rtw_hal_macid_sleep(struct adapter *padapter, u32 macid)
 
 	support = false;
 	rtw_hal_get_def_var(padapter, HAL_DEF_MACID_SLEEP, &support);
-	if (false == support)
+	if (!support)
 		return _FAIL;
 
 	rtw_hal_set_hwreg(padapter, HW_VAR_MACID_SLEEP, (u8 *)&macid);
@@ -445,7 +445,7 @@ s32 rtw_hal_macid_wakeup(struct adapter *padapter, u32 macid)
 
 	support = false;
 	rtw_hal_get_def_var(padapter, HAL_DEF_MACID_SLEEP, &support);
-	if (false == support)
+	if (!support)
 		return _FAIL;
 
 	rtw_hal_set_hwreg(padapter, HW_VAR_MACID_WAKEUP, (u8 *)&macid);
-- 
2.7.4

