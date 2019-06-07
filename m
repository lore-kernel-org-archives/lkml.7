Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A707C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCABD208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeqpyBH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfFGHLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:11:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42822 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfFGHLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 03:11:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id go2so457150plb.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 00:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Do1Qo6V2JFR310gLCbSRbPWz/dTlopxTv15lvqi6FEQ=;
        b=WeqpyBH41NwApLNKLsD2BZh26hbc4NBURMixCvyihP1LzD8qb98gJNGMxNDGVIbaF5
         B5zdf3V/HdWrPQWXBqyfRAa/VmNb4Y4NZ2cz7Oq6gql6FGb4TiRbms64BQZfWu3btCmZ
         b2g7AhuIV2Ar/t0/8IuGbAc7OmZAP6H0DBohHvo6hSkb1iR5tqoNtdldU/g9ErB2xQ5E
         yBF8OhF4XuT8qwZh+SvjUNjefjESjR6o9UAwT/lVEb2WgR6THJAqskDeydSASGXg/l99
         E4TJNyFyMMzYm7vMFN3YRlU+UCdHBoZBFtR1GHq9tuczY68/53xM0yBNAkiskL+RYgfT
         edCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Do1Qo6V2JFR310gLCbSRbPWz/dTlopxTv15lvqi6FEQ=;
        b=Nf8+AF1pIF0KYbhXHY2RIsHabAtmXuhsko9eKy+vkizP7EvAL8mQVFX1FmMZLsj1QJ
         Z5Bhi/HoGkpQVgaMH5Eh+y3iS6xEK2q08MrmD7NcsJJ91/7TTfDbUcG6Km4SeAqWw4BY
         pUKSzWOytQKhtYoIIDpfz20OulfW+sgxeyq/c7CWu3zz0IWAKKMIuz7x2b8+9XFnRNSz
         3GS14bDS2dvjOsiSeskvy5xN+7+uqJBfh1S9nQrGcLJOYlB7wyP0SPRyKq24J7bADDRR
         KhQ+H70gLltdO2tuWD24NDLgB7999FsjGEqvQuKm63GSjHbR+5d/t+YyCQRfaOAjWxl8
         wwrQ==
X-Gm-Message-State: APjAAAWhGEV4vmXFRtzbsMnA13/1X0lWy1IjyNX116QYTjjV1KcCILk5
        aCjq0VSEeOEMC3pWtpR/ewjj0/bb
X-Google-Smtp-Source: APXvYqxby4r+nDLbndZ7yeDA+uIOOjaJUNlZ1yew/Iy0Q9YLzfjds/0YrgrCF+z21xRpwPaYFnZSeg==
X-Received: by 2002:a17:902:a5ca:: with SMTP id t10mr50447160plq.98.1559891496143;
        Fri, 07 Jun 2019 00:11:36 -0700 (PDT)
Received: from localhost.localdomain ([110.227.95.145])
        by smtp.gmail.com with ESMTPSA id i5sm1299667pfk.49.2019.06.07.00.11.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 00:11:35 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, straube.linux@gmail.com,
        benniciemanuel78@gmail.com, hardiksingh.k@gmail.com
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: core: rtw_mlme_ext.c: Remove unused variables
Date:   Fri,  7 Jun 2019 12:41:23 +0530
Message-Id: <20190607071123.28193-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variables that are declared and assigned values but not otherwise
used.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 65e8cba7feba..5f0b20038a28 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -6771,10 +6771,6 @@ int rtw_get_ch_setting_union(struct adapter *adapter, u8 *ch, u8 *bw, u8 *offset
 {
 	struct dvobj_priv *dvobj = adapter_to_dvobj(adapter);
 	struct adapter *iface;
-	struct mlme_ext_priv *mlmeext;
-	u8 ch_ret = 0;
-	u8 bw_ret = CHANNEL_WIDTH_20;
-	u8 offset_ret = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 
 	if (ch)
 		*ch = 0;
@@ -6784,15 +6780,10 @@ int rtw_get_ch_setting_union(struct adapter *adapter, u8 *ch, u8 *bw, u8 *offset
 		*offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 
 	iface = dvobj->padapters;
-	mlmeext = &iface->mlmeextpriv;
 
 	if (!check_fwstate(&iface->mlmepriv, _FW_LINKED|_FW_UNDER_LINKING))
 		return 0;
 
-	ch_ret = mlmeext->cur_channel;
-	bw_ret = mlmeext->cur_bwmode;
-	offset_ret = mlmeext->cur_ch_offset;
-
 	return 1;
 }
 
-- 
2.19.1

