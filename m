Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24941C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC13C2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czkRtXS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfFSCaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 22:30:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39553 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSCaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 22:30:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so6516515pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 19:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Hp7DHtibmJwvDlg9A4mEprONZytCRnxVVBzTxg8OHYo=;
        b=czkRtXS/k/PIDvk0gtpQpNB5VZxZherTZ9PRlTPnBwnjA/igg0LR2lOuUP5WT/rYgs
         Gp1so9Gfkp3mc6xC98nyHT6g4S+KnaR7bsDuxWN8+Y+rTzjObM+F9BgKArgSmZR13TGs
         uWGbx0LO/wo7UOWRlkSEaVcqH+1lKM7fG8tFV4gPNhPJJcpUbqzMQl0OxxSPfQOc7CbG
         rmrD0WP57rpXBIK62Gkq9J4Zc2r8rNgBuf/x9v93yHfJrFcNTCyxrcDzyidZa41Sa5n8
         nga8JQ9Pij0H46ixiXryHy8D2VI1/UK6brZpGaUe+ykruxDtpM0RGm+HhWkhVpVQqmkn
         ffmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Hp7DHtibmJwvDlg9A4mEprONZytCRnxVVBzTxg8OHYo=;
        b=ecdK21anaiySi7qvMpOPifLeFayUE71DY/AT7cLyN1RPZgfDAyCLMevlnJMzo8f6wG
         ZiD8As9m1DLYAMTebsoVlDsaEcHUY1Ka5woKfF11aRFGvilj6YdNaGP/KJf0A1nHYGdw
         rvmPX9M5vpuSZUh2Jk1SFRk9IRAXzcPKaDOw/A7FBrrKUQwPk8N6SWNZyl/6AcjCITTD
         bS+iTBgL2+1414vLEOVEIr9LW9rTurPsL22Y6u0uiy44XVGinDEcYxCk/KPtaAeBD02v
         lO2saZvNXpe0hhOagjn5FGyxVaWnG87V4YqI2wcLwp3mHfwD4zSM6kTLDWnW7wzjqVKI
         II1A==
X-Gm-Message-State: APjAAAVkFi2ZZoGvH443/hT52myXnIqxZV5yXdzzCOjHuDyYQyEbRSvc
        yGKNxd1wbND1dxDqYZPxzMYQP5d0
X-Google-Smtp-Source: APXvYqyHuCR/eXIW2UITGM18yxwMTR+iDtanNqySjG6vDTWCzZqFLXXb4U4Pay9MxueOrk3QofwtBg==
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10mr41544490pls.134.1560911415555;
        Tue, 18 Jun 2019 19:30:15 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id f186sm21041254pfb.5.2019.06.18.19.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 19:30:14 -0700 (PDT)
Date:   Wed, 19 Jun 2019 08:00:10 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: hal: odm_RegConfig8723B: fix Lines
 should not end with a '('
Message-ID: <20190619023010.GA21587@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch fixes below issue reported by checkpatch.pl

CHECK: Lines should not end with a '('
CHECK: Lines should not end with a '('

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h | 61 ++++++++++------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h b/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h
index 12dfc58..07b5859 100644
--- a/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h
+++ b/drivers/staging/rtl8723bs/hal/odm_RegConfig8723B.h
@@ -7,51 +7,46 @@
 #ifndef __INC_ODM_REGCONFIG_H_8723B
 #define __INC_ODM_REGCONFIG_H_8723B
 
-void odm_ConfigRFReg_8723B(
-	PDM_ODM_T pDM_Odm,
-	u32 Addr,
-	u32 Data,
-	ODM_RF_RADIO_PATH_E RF_PATH,
-	u32 RegAddr
+void odm_ConfigRFReg_8723B(PDM_ODM_T pDM_Odm,
+			   u32 Addr,
+			   u32 Data,
+			   ODM_RF_RADIO_PATH_E RF_PATH,
+			   u32 RegAddr
 );
 
 void odm_ConfigRF_RadioA_8723B(PDM_ODM_T pDM_Odm, u32 Addr, u32 Data);
 
 void odm_ConfigMAC_8723B(PDM_ODM_T pDM_Odm, u32 Addr, u8 Data);
 
-void odm_ConfigBB_AGC_8723B(
-	PDM_ODM_T pDM_Odm,
-	u32 Addr,
-	u32 Bitmask,
-	u32 Data
+void odm_ConfigBB_AGC_8723B(PDM_ODM_T pDM_Odm,
+			    u32 Addr,
+			    u32 Bitmask,
+			    u32 Data
 );
 
-void odm_ConfigBB_PHY_REG_PG_8723B(
-	PDM_ODM_T pDM_Odm,
-	u32 Band,
-	u32 RfPath,
-	u32 TxNum,
-	u32 Addr,
-	u32 Bitmask,
-	u32 Data
+void odm_ConfigBB_PHY_REG_PG_8723B(PDM_ODM_T pDM_Odm,
+				   u32 Band,
+				   u32 RfPath,
+				   u32 TxNum,
+				   u32 Addr,
+				   u32 Bitmask,
+				   u32 Data
 );
 
-void odm_ConfigBB_PHY_8723B(
-	PDM_ODM_T pDM_Odm,
-	u32 Addr,
-	u32 Bitmask,
-	u32 Data
+void odm_ConfigBB_PHY_8723B(PDM_ODM_T pDM_Odm,
+			    u32 Addr,
+			    u32 Bitmask,
+			    u32 Data
 );
 
-void odm_ConfigBB_TXPWR_LMT_8723B(
-	PDM_ODM_T pDM_Odm,
-	u8 *Regulation,
-	u8 *Band,
-	u8 *Bandwidth,
-	u8 *RateSection,
-	u8 *RfPath,
-	u8 *Channel,
-	u8 *PowerLimit
+void odm_ConfigBB_TXPWR_LMT_8723B(PDM_ODM_T pDM_Odm,
+				  u8 *Regulation,
+				  u8 *Band,
+				  u8 *Bandwidth,
+				  u8 *RateSection,
+				  u8 *RfPath,
+				  u8 *Channel,
+				  u8 *PowerLimit
 );
 
 #endif
-- 
2.7.4

