Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CF7C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF9920866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZgMNuII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfFNCzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 22:55:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42608 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbfFNCzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:55:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so462544pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 19:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SwSZeh81DBlOnvWVgHdXN91MkGQB7AkIc/s+fZav48I=;
        b=mZgMNuIICMJ535dfwlrSQzVmNFBy9rpWsCv0yaKH6iq4Xu5Bf8q89rii/7rBR/k/UP
         etYiSsEg72LzqI/pmcOInN6jpurv8Hl3O47tnPKU9n7bIYux4r9sXziHKCG4kGCR+/yi
         qSpquCRxpm6A7gSAdmv+tO+O3hcEX7vwILUwq0tcff6BDR7sG1TbEYM3Qw0iXXnhdJD7
         koP9HhsTWD8ZVFEEZvBo7vN5pf14q10DNGp4B1g/QYepd/OCWqRpqOXdcYzs/ZSr56Zh
         58R98oqe2j5peb2me25tz2bxoEUptrgHrZhYnr5zl8R4m0CZyuiEMd4pc8vdj48HwQ6S
         uvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SwSZeh81DBlOnvWVgHdXN91MkGQB7AkIc/s+fZav48I=;
        b=quy7jYpi4y2PpYwtkKua2mbPZGTXgQrk5lwo1Yzz2F9qKodadIUuT5jFh1lQ62qWIj
         2mgMy4+zu+7tEQRrJcTvUNvxGn/ejO3p1de08f9+2Q+RuPU49UQagOjU5/Hnos0FGovF
         9KyXBj0AouCa+BPRFRSThcZyJ1si10EgH/hfQ4uGqlDrQcmfToUGlRf3QqwB9sfWVB4F
         TksykrRHIuH/WLgYIv0HGnyWdDrgr7oPD+/SvMyWZ3nPX0irMDAsIQKgBVWJ8dJRlYNP
         6tMhJ3iLz5cOTbQMOO4UN7Tm6u1pppDbijyFz7O+zFgrq9e4VXsxO4XjP+WNrP148xU2
         L/kQ==
X-Gm-Message-State: APjAAAVe92/PUhlkbmJ2YgXy78NAkdMFWk8SAwzE2lc3lP0oDhJFWSos
        L7beIDf6QxBMBR0An3f7kaU=
X-Google-Smtp-Source: APXvYqyeoz280H99Rzxd6MfOi9jtrF/1mnTPz4N8u9/1DhOIFjeclmoJh5RkhXKyeL22ggZMfoJhlA==
X-Received: by 2002:a63:d458:: with SMTP id i24mr24164947pgj.171.1560480923027;
        Thu, 13 Jun 2019 19:55:23 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id j2sm1033788pfb.157.2019.06.13.19.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 19:55:22 -0700 (PDT)
Date:   Fri, 14 Jun 2019 08:25:19 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [Patch v2 3/3] staging: rtl8723bs: hal: sdio_halinit: fix Comparison
 to NULL
Message-ID: <20190614025519.GA3459@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below issue reported by checkpatch

CHECK: Comparison to NULL could be written "psta"
CHECK: Comparison to NULL could be written "psta"

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
-----
changes in v2: Send proper patch with out corruption
----
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 5c7cff0..6f10349 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1558,7 +1558,7 @@ static void SetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val)
 			DBG_871X_LEVEL(_drv_always_, "WOWLAN_DISABLE\n");
 
 			psta = rtw_get_stainfo(&padapter->stapriv, get_bssid(pmlmepriv));
-			if (psta != NULL)
+			if (psta)
 				rtl8723b_set_FwMediaStatusRpt_cmd(padapter, RT_MEDIA_DISCONNECT, psta->mac_id);
 			else
 				DBG_871X("psta is null\n");
@@ -1673,7 +1673,7 @@ static void SetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val)
 				(pwrctl->wowlan_wake_reason != Rx_DeAuth)
 			) {
 				rtl8723b_set_FwJoinBssRpt_cmd(padapter, RT_MEDIA_CONNECT);
-				if (psta != NULL)
+				if (psta)
 					rtl8723b_set_FwMediaStatusRpt_cmd(padapter, RT_MEDIA_CONNECT, psta->mac_id);
 			}
 #ifdef CONFIG_PNO_SUPPORT
-- 
2.7.4

