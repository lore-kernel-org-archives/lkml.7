Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDCBC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3923218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQyCXC4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfIRJ0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 05:26:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45853 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfIRJ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:26:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id u12so143758pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 02:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TP5u6Ukr8naGDCwUgGDGagSd1luSKaVAHPd6/hA2Lxc=;
        b=BQyCXC4uNCAIjoc6ev5sISLgargq7BoavxCTsf+ZXZA/3MRVJm6DE8cNuUu1er+7LE
         g/uRuoy5CYC0InQssHzLPQdsPpqdDOFBC2ETNyaiJgR5JIbtEzXrer/bfNK3fgtO74WY
         TWCHxcgI63IHQFZKGU5l3NNMYrBlSSndSIyO0hbjBMDFtrxbVBfNTD7F2Dfyu+CH6zN/
         uDEZC0HHw+uSO0meiDOucKi5DYimCHKvbUWFE/Ju886VeMe4GEXm1duuQ35P1cAvvs8F
         hbyvqDGWtmXdvz9KdsUQmA6EpSxpspLfxkObA8Ev5bFTbMN7Whp/NmFRDWXfvZDfArRq
         pXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TP5u6Ukr8naGDCwUgGDGagSd1luSKaVAHPd6/hA2Lxc=;
        b=XmoSaGH7iDABBLQzYeO2vAl9bwEp16qHLnmwlPBIi9BzGx0UT6Q/RTNf4O+2aJR31Y
         XwYoxayOgZDv3+r+SYb+obb1zSqLcS/BcE/io2PMOsDtlBGnu7GMg+hR0j0nLIFYXtjO
         Qcz3j9KMBn1kqJvEqHro542QMb8XQ3CPuBFRxnrRZRD9zuHhsiVwWZqvthFjPGeTxCg0
         Jlzk0awuiAfaJtswYkINugzVhZP/3M5iNo0uUheJZzeo0FSGvDVFk+hY0FaZWZAv89RX
         M8FF0kNWLMq6EO3sUcKIK7yD4CwkzHz5U4wqIR6HdHkJfSZLUXE/HLP1kh+XcV0sBIhe
         AF/g==
X-Gm-Message-State: APjAAAXJe3n6O8g6QGfHfS8MBEdZOCNsx2lxveYVMNDLpCyWze/ioGau
        a0TE6ncKAyp4LqbSy9ZcK00=
X-Google-Smtp-Source: APXvYqxxS5VPHg7voF/W/ZYyqfHN3XOErQ3eBbbKzxzjP8Q+m9zU5TQ5ykTgwHCm2au4U5JqDnIBsg==
X-Received: by 2002:a17:902:9698:: with SMTP id n24mr3268424plp.238.1568798775771;
        Wed, 18 Sep 2019 02:26:15 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1951:77d6:5858:909b:a968:2d14])
        by smtp.gmail.com with ESMTPSA id m12sm9270654pff.66.2019.09.18.02.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 02:26:14 -0700 (PDT)
From:   Aliasgar Surti <aliasgar.surti500@gmail.com>
X-Google-Original-From: Aliasgar Surti
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Aliasgar Surti <aliasgar.surti500@gmail.com>
Subject: [PATCH v2] drivers:staging:rtl8723bs: Removed unneeded variables
Date:   Wed, 18 Sep 2019 14:55:49 +0530
Message-Id: <1568798749-9855-1-git-send-email-aliasgar.surti500@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aliasgar Surti <aliasgar.surti500@gmail.com>

coccicheck reported warning for unneeded variable used.

This patch removes the unneeded variables.

Signed-off-by: Aliasgar Surti <aliasgar.surti500@gmail.com>
---
v2: removed unneeded functions and replaced them with NULL in function array.
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 54 +++-----------------------
 1 file changed, 5 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index d1b199e..55c6e45 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2425,13 +2425,6 @@ static  int rtw_drvext_hdl(struct net_device *dev, struct iw_request_info *info,
 	return 0;
 }
 
-static int rtw_mp_ioctl_hdl(struct net_device *dev, struct iw_request_info *info,
-						union iwreq_data *wrqu, char *extra)
-{
-	int ret = 0;
-	return ret;
-}
-
 static int rtw_get_ap_info(struct net_device *dev,
                                struct iw_request_info *info,
                                union iwreq_data *wrqu, char *extra)
@@ -4458,43 +4451,6 @@ static int rtw_pm_set(struct net_device *dev,
 	return ret;
 }
 
-static int rtw_mp_efuse_get(struct net_device *dev,
-			struct iw_request_info *info,
-			union iwreq_data *wdata, char *extra)
-{
-	int err = 0;
-	return err;
-}
-
-static int rtw_mp_efuse_set(struct net_device *dev,
-			struct iw_request_info *info,
-			union iwreq_data *wdata, char *extra)
-{
-	int err = 0;
-	return err;
-}
-
-static int rtw_tdls(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
-{
-	int ret = 0;
-	return ret;
-}
-
-
-static int rtw_tdls_get(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
-{
-	int ret = 0;
-	return ret;
-}
-
-
-
-
-
 static int rtw_test(
 	struct net_device *dev,
 	struct iw_request_info *info,
@@ -4744,7 +4700,7 @@ static iw_handler rtw_private_handler[] = {
 	rtw_wx_write32,					/* 0x00 */
 	rtw_wx_read32,					/* 0x01 */
 	rtw_drvext_hdl,					/* 0x02 */
-	rtw_mp_ioctl_hdl,				/* 0x03 */
+	NULL,						/* 0x03 */
 
 /*  for MM DTV platform */
 	rtw_get_ap_info,					/* 0x04 */
@@ -4771,15 +4727,15 @@ static iw_handler rtw_private_handler[] = {
 	NULL,							/* 0x12 */
 	rtw_p2p_get2,					/* 0x13 */
 
-	rtw_tdls,						/* 0x14 */
-	rtw_tdls_get,					/* 0x15 */
+	NULL,						/* 0x14 */
+	NULL,						/* 0x15 */
 
 	rtw_pm_set,						/* 0x16 */
 	rtw_wx_priv_null,				/* 0x17 */
 	rtw_rereg_nd_name,				/* 0x18 */
 	rtw_wx_priv_null,				/* 0x19 */
-	rtw_mp_efuse_set,				/* 0x1A */
-	rtw_mp_efuse_get,				/* 0x1B */
+	NULL,						/* 0x1A */
+	NULL,						/* 0x1B */
 	NULL,							/*  0x1C is reserved for hostapd */
 	rtw_test,						/*  0x1D */
 };
-- 
2.7.4

