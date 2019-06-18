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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E56C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B742520861
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 01:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbHv0ugu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfFRBUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 21:20:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38785 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRBUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 21:20:12 -0400
Received: by mail-pl1-f195.google.com with SMTP id f97so4968266plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 18:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AuHccIdSxPbt86ZJkXZzP91IaZ8/7FsD2wmDGIVu61M=;
        b=gbHv0ugum9zXI3n7MsAdeKtL3MTfXanNJBbnNSGb+cUVrX9fJmnj2pKhTm1F2nsD9d
         a5EAtPuIZCywAG1YhzX/PBFeCqnKlbHe+e0cALtBivbUz3WO13WyEUv1Wxxy7hOb+5Z8
         m8CKot7KkocPxV5DaCPWnWGhlZo9FLGDSMpNO98qXEiOXMuWkPJq/GfWIDxourXzRjWE
         ETXRRAv/+E8m65I5r+eTblPVFJ/RbDY9F7xSPWVJj3/xjZ66G7N53NFLE1M/MkQz3fn+
         yYKNoazoG5Mh5DztKJXb5Ia02uaDQDHImDQlSFGvRW5TpFvvgCXAzCC60PrvqLS9d8SK
         eg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AuHccIdSxPbt86ZJkXZzP91IaZ8/7FsD2wmDGIVu61M=;
        b=loPZGAGeNPS4eqH+v7Pidr1sI39JwAyzpicjkPgitquYSjV55WrIz/meKpZvW6qIl/
         314LX4cqx39udyDlVpLWXVLX/t93atVXenDcicHggqnM2K239kvEvhIcBgd0RvaX+fxN
         /79lnIwRNMIjXIMmhF6jACDwToWcphVwo3E4g8ZXLKi343T6ejM9A1qDkPO0HCbxJS5E
         g0PFXnZIRPBZL9Hs4QcGpyAWfgsyV3P/fmfwlKulbAF2erIuynHqjPYlKUUrQpBvPrwO
         t5O6M+YA+XBWZ/ZGqy8pGPl/MOSX8z/9NDp2S8kBq5eOjopinDfKCethsp1Edcji3333
         RZNw==
X-Gm-Message-State: APjAAAVPMkKx4BrqpBCb6/OVgbAWQmpyDFNPv9tsjazJe+zpWpD4etPJ
        FkNG4rbVQXnyKOhkPzLjd24=
X-Google-Smtp-Source: APXvYqwyQ1urEoas4pLxiFnN/OcxePRhS51EIPNamFdJr3m1TCl0OnaXoJfEWuhuzFCUaOHkzluMmA==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34mr74671190pld.16.1560820811540;
        Mon, 17 Jun 2019 18:20:11 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id a3sm11674246pff.122.2019.06.17.18.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 18:20:11 -0700 (PDT)
Date:   Tue, 18 Jun 2019 06:50:07 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: hal: rtl8723b_rf6052: fix spaces
 preferred around unary operator
Message-ID: <20190618012007.GA7871@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: spaces required around that '<<' (ctx:VxV)

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
index aa45a84..c205345 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
@@ -114,12 +114,12 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 			break;
 		case RF_PATH_B:
 		case RF_PATH_D:
-			u4RegValue = PHY_QueryBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV<<16);
+			u4RegValue = PHY_QueryBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV << 16);
 			break;
 		}
 
 		/*----Set RF_ENV enable----*/
-		PHY_SetBBReg(Adapter, pPhyReg->rfintfe, bRFSI_RFENV<<16, 0x1);
+		PHY_SetBBReg(Adapter, pPhyReg->rfintfe, bRFSI_RFENV << 16, 0x1);
 		udelay(1);/* PlatformStallExecution(1); */
 
 		/*----Set RF_ENV output high----*/
@@ -163,7 +163,7 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 			break;
 		case RF_PATH_B:
 		case RF_PATH_D:
-			PHY_SetBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV<<16, u4RegValue);
+			PHY_SetBBReg(Adapter, pPhyReg->rfintfs, bRFSI_RFENV << 16, u4RegValue);
 			break;
 		}
 
-- 
2.7.4

