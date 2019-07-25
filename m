Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5E4C76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C20522AED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 03:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2jb3A1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388860AbfGYDXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 23:23:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34878 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387761AbfGYDXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 23:23:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id u14so21977104pfn.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 20:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gWOX4S2cmsNDQd7ZgPQfa5ixwhND2vZIS2QHH9OWdfg=;
        b=l2jb3A1MO1XyzVUoqM5G7/WDQ1HMx8OR4zyPKsqa+mrfNPiB4YjbcjML1BJdqxUUhz
         70cmpS4K4Pal11bPy6q1Ba/0Edh4jQM5HQROUn8rqIqeh7WWDq5ceNoQ5ECzWTwAp+kZ
         is0cPH2PfG15KvabWvheJ5IWcqJj8Vn6Sw0OlwpHl+SZaH8fSdTzQz92ycuO56rJB+95
         6EMrZqG8H9VBigaybM2nrUVilIHZ11rt+B4y1zgKOKHrekF56bIpIYvqtad9SvlyKWZb
         OwJObY8xLdSY7T6mEU19ln6YH8BxuGY1U0wDMOYheHLt3zijqDUX0KvLfWeXQL7ahQ7/
         sosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gWOX4S2cmsNDQd7ZgPQfa5ixwhND2vZIS2QHH9OWdfg=;
        b=AxH4mQ5quoOz6c7NYIugcEFtQK2iKcNl50WSO8dhYC4vEXCAKF9oDp2nh01Ax1WEM8
         1FqWLBPyUC65h3lSgZPzyz71qNXJzu+YmwigAfPeug0tqc2XUTZi7DH2gaXx//umJngn
         KXax80Pd6vzf2BWfyV9tx3PW5CQ/0O5ldm47qceGUu6O4tbhLqqx2B891TGGZ5nfdVxf
         JU5eLx95QAaxWjRIESKlQrC3AJLh1u9OQK3u5HmgS+P7stYcDYdAO8Cx4D0kmDZJZhQb
         S8NyN62y3m/ZeRa3/FgEbCErU1shrq1IQJJGtBMZF4T53WjVPC7/llLzXoIjUgD0wjlZ
         iQnA==
X-Gm-Message-State: APjAAAU/DQO7s64Drh+RwvuaeHkN2fU8ecj52RDxvGKALH8XZa5dcWGG
        OwiJRiTKLI2MMOwPzcLbqxc=
X-Google-Smtp-Source: APXvYqwUocSs3pHrtnRJQ38nov8KlT7MAbFsSOEEWV4BKHnlkQjxwVfJBcf7ZoiL10AMlfczwbvdMA==
X-Received: by 2002:a63:6947:: with SMTP id e68mr48279889pgc.60.1564025012080;
        Wed, 24 Jul 2019 20:23:32 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id 143sm70254341pgc.6.2019.07.24.20.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 20:23:31 -0700 (PDT)
Date:   Thu, 25 Jul 2019 08:53:25 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: hal: Remove unneeded variable pU1Tmp
Message-ID: <20190725032325.GA16473@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both pu8 and pU1Tmp are of same data type u8. So replace pU1Tmp with u8.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_btcoex.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_btcoex.c b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
index 5257287..8987b5f 100644
--- a/drivers/staging/rtl8723bs/hal/hal_btcoex.c
+++ b/drivers/staging/rtl8723bs/hal/hal_btcoex.c
@@ -389,7 +389,6 @@ static u8 halbtcoutsrc_Get(void *pBtcContext, u8 getType, void *pOutBuf)
 	u8 *pu8;
 	s32 *pS4Tmp;
 	u32 *pU4Tmp;
-	u8 *pU1Tmp;
 	u8 ret;
 
 
@@ -403,7 +402,6 @@ static u8 halbtcoutsrc_Get(void *pBtcContext, u8 getType, void *pOutBuf)
 	pu8 = pOutBuf;
 	pS4Tmp = pOutBuf;
 	pU4Tmp = pOutBuf;
-	pU1Tmp = pOutBuf;
 	ret = true;
 
 	switch (getType) {
@@ -516,32 +514,32 @@ static u8 halbtcoutsrc_Get(void *pBtcContext, u8 getType, void *pOutBuf)
 		break;
 
 	case BTC_GET_U1_WIFI_DOT11_CHNL:
-		*pU1Tmp = padapter->mlmeextpriv.cur_channel;
+		*pu8 = padapter->mlmeextpriv.cur_channel;
 		break;
 
 	case BTC_GET_U1_WIFI_CENTRAL_CHNL:
-		*pU1Tmp = pHalData->CurrentChannel;
+		*pu8 = pHalData->CurrentChannel;
 		break;
 
 	case BTC_GET_U1_WIFI_HS_CHNL:
-		*pU1Tmp = 0;
+		*pu8 = 0;
 		ret = false;
 		break;
 
 	case BTC_GET_U1_MAC_PHY_MODE:
-		*pU1Tmp = BTC_SMSP;
+		*pu8 = BTC_SMSP;
 /* 			*pU1Tmp = BTC_DMSP; */
 /* 			*pU1Tmp = BTC_DMDP; */
 /* 			*pU1Tmp = BTC_MP_UNKNOWN; */
 		break;
 
 	case BTC_GET_U1_AP_NUM:
-		*pU1Tmp = halbtcoutsrc_GetWifiScanAPNum(padapter);
+		*pu8 = halbtcoutsrc_GetWifiScanAPNum(padapter);
 		break;
 
 	/* 1Ant =========== */
 	case BTC_GET_U1_LPS_MODE:
-		*pU1Tmp = padapter->dvobj->pwrctl_priv.pwr_mode;
+		*pu8 = padapter->dvobj->pwrctl_priv.pwr_mode;
 		break;
 
 	default:
-- 
2.7.4

