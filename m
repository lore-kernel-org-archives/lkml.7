Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBCCC31E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0257A2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3MZmS+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfFRCjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 22:39:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39351 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRCjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 22:39:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so6720009pfe.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 19:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=D2ULf8qwvOBwy3f46dg2e3I/gGjBRzByDR6nlqf/Poo=;
        b=r3MZmS+Z+I1cKNS7BeGAWJUdN0PvL3JKwYaxcFev5JWsA8qVzMlBOBmGJXCEEdkPd7
         D91dibNWsZPlz7G+caLULqx8SCg5UsaP7EhoUrcJH6sDXGTdaT1m0kt2BxkEZkbcppMR
         q8llZ6m7wxB5W1wTHKTsYG99urZtrbmt6USA+lNx4b4sjBAkn2lyOrlQg2+BKokFjQNi
         z6HHRHW/eqdc0EzQGbasTEZSViAWTAHX3pwhp3ldLLIPMPMuDB5xSaqQ1CQniDLiawgF
         ordyt96nEKMyPzZfe7ktdJ8XecCBWiMGVKRsiUM6eWqpqAVW9G50+Rkolls3Rhl3KAdL
         H4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=D2ULf8qwvOBwy3f46dg2e3I/gGjBRzByDR6nlqf/Poo=;
        b=GnjQ9WWEcn1vy13V4vyCS+RolEvzKYC6vLsATKLi/WSVqgu/OjSnqW/OAHY64Wxfir
         Nd+kLzTdhenS4o8SaFc1fyTmSeTpywMZgrWB1z0TuR9pauGHJfDdhi+ImHvk4PPpI7Qo
         y6q9gPZCyl1VWtABF6l2bdrnVlje6arIEtJZXyO7BG5s9Zthm+FgQTGV4nDnRvIQyQVK
         IrZjqo1QM64xWWfCSmJ0QsNEp8Wyxo9tQrl0WXp06Fmx0vnbvZB0asnfhhiOTdx+BLYs
         N3B3l1JyjxmTg/KXNXlqdzNuH3z4uCswq3hCiQrWmQjYAlMqq35oN3AUw52Cdw6hfPUM
         +nUg==
X-Gm-Message-State: APjAAAVnED2aVW+CZPxU2O347cKrJCl/s6O3u9uQdz5iUhJiPXSq9mDd
        FxLzZ+oJTCyCmk1eBYG61BY=
X-Google-Smtp-Source: APXvYqzcIPqZDnf5snxqTSXapBqCegfFEqducV4HlYMAM8ZDlJ7T/MpiD8ZpFSxY5ih0Ezbbvqowpw==
X-Received: by 2002:a62:b503:: with SMTP id y3mr115834632pfe.4.1560825560519;
        Mon, 17 Jun 2019 19:39:20 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id o13sm16571452pgr.86.2019.06.17.19.39.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 19:39:19 -0700 (PDT)
Date:   Tue, 18 Jun 2019 08:09:14 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [Patch v3] staging: rtl8723bs: hal: odm_HWConfig: Unneeded variable:
 "result". Return "HAL_STATUS_SUCCESS"
Message-ID: <20190618023914.GA14730@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function ODM_ConfigMACWithHeaderFile as trace is not necessary
and as it is getting called only once and call direct function
"ODM_ReadAndConfig_MP_8723B_MAC_REG"

Issue identified by coccicheck

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
----
changes v2: fixed typo in commit message
changes v3: Remove function ODM_ConfigMACWithHeaderFile and replace
            with ODM_ReadAndConfig_MP_8723B_MAC_REG
---
---
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c    | 29 -------------------------
 drivers/staging/rtl8723bs/hal/odm_HWConfig.h    |  2 --
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c |  2 +-
 3 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
index d802a1f..22f7410 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
@@ -496,32 +496,3 @@ HAL_STATUS ODM_ConfigBBWithHeaderFile(
 	return HAL_STATUS_SUCCESS;
 }
 
-HAL_STATUS ODM_ConfigMACWithHeaderFile(PDM_ODM_T pDM_Odm)
-{
-	u8 result = HAL_STATUS_SUCCESS;
-
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_LOUD,
-		(
-			"===>ODM_ConfigMACWithHeaderFile (%s)\n",
-			(pDM_Odm->bIsMPChip) ? "MPChip" : "TestChip"
-		)
-	);
-	ODM_RT_TRACE(
-		pDM_Odm,
-		ODM_COMP_INIT,
-		ODM_DBG_LOUD,
-		(
-			"pDM_Odm->SupportPlatform: 0x%X, pDM_Odm->SupportInterface: 0x%X, pDM_Odm->BoardType: 0x%X\n",
-			pDM_Odm->SupportPlatform,
-			pDM_Odm->SupportInterface,
-			pDM_Odm->BoardType
-		)
-	);
-
-	READ_AND_CONFIG(8723B, _MAC_REG);
-
-	return result;
-}
diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.h b/drivers/staging/rtl8723bs/hal/odm_HWConfig.h
index d3af1ca..945366b 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.h
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.h
@@ -140,8 +140,6 @@ HAL_STATUS ODM_ConfigBBWithHeaderFile(
 	PDM_ODM_T pDM_Odm, ODM_BB_Config_Type ConfigType
 );
 
-HAL_STATUS ODM_ConfigMACWithHeaderFile(PDM_ODM_T pDM_Odm);
-
 HAL_STATUS ODM_ConfigFWWithHeaderFile(
 	PDM_ODM_T pDM_Odm,
 	ODM_FW_Config_Type ConfigType,
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index 6da7f8e..25c75b9 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -375,7 +375,7 @@ s32 PHY_MACConfig8723B(struct adapter *Adapter)
 	/*  */
 	rtStatus = phy_ConfigMACWithParaFile(Adapter, pszMACRegFile);
 	if (rtStatus == _FAIL) {
-		ODM_ConfigMACWithHeaderFile(&pHalData->odmpriv);
+		ODM_ReadAndConfig_MP_8723B_MAC_REG(&pHalData->odmpriv);
 		rtStatus = _SUCCESS;
 	}
 
-- 
2.7.4

