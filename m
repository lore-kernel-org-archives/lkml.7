Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF07C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEA8244DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5A9aY1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfFDIJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:09:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35098 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfFDIJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:09:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so12225258pfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BSMXN2q5QCRSNyxn1fdy+SG3cIkky7w3IsOPbnZEiDs=;
        b=o5A9aY1DvJ2eIYTMCsaaec9Zp6l2AcQ9/izs+xPY/XUAJNzccuGq7mBmNuAGJyqVC1
         TfogimNjJkThyZRldJK3BPgs0e3dIKM2yqbAPvqHVAyj+jZICS6n10IOpHM5dFR1Tv2K
         mkCf/keUAwMtbG5y7eqSrOXCT9ozkqMIrCUB61J93WvBgk9Tjh3nrPl+RaOwhJa/3bC3
         bLAdq25TkY0QvF9Htz5Ec2tQTew7SNL7p6o/zsuX0empew8KUZpdLhPr0EU8KwMU5CWO
         3IU83T5zry6kBGiHWQ64MvFu4bJXp7ns9pzp2t0X8wTOj4FAmmlS65sIcJNHr6yCdRDI
         BWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BSMXN2q5QCRSNyxn1fdy+SG3cIkky7w3IsOPbnZEiDs=;
        b=tYnQPSO3yTde85iA/BoJ4tOJcjljy2LL2HmAWdJjYjGjFFBC6wQOIdYZExs2OO2hBr
         7Hikzxk3nFT5VlFFonx24dlZooaURiXGGwR8/F6sNM7TR8iN5c+xSTolcjn0mHDDWfYn
         FP0CV2gtwM8fHJ9lpkvSw7D2URDnYVb91pLvw7cv4h2yoVXURZH7+5diXn9OD6+L8rWY
         6zD/4NPVPG4VNPIyXthG7pOUF6vejxG+6htML6FpL3yGqq5to8VXMaElZZRD4O8aWsz7
         WuzEUx3I8Q3fo01+0bQuDwqAbWRiX+s+dYEXj3CRGXWMw7cGVImSzLlw9ukFYPq/8Cx9
         9jwg==
X-Gm-Message-State: APjAAAXZ/aP93Qhl5nxB3wm9ya3loI2Ox5cdsMDCfmHnTyHtZPg8UM93
        Z57kzdhwoG66u0brLRPFfsJTDCJG
X-Google-Smtp-Source: APXvYqzGXzuWfZA2K9x27AWYsRbzCUBXZn0wf+Xv/ZL8ABxO0SIobJGnnWp49oDWfeT/pnjV1Pqldg==
X-Received: by 2002:a17:90a:1aa8:: with SMTP id p37mr35800295pjp.17.1559635763946;
        Tue, 04 Jun 2019 01:09:23 -0700 (PDT)
Received: from localhost.localdomain ([110.227.95.145])
        by smtp.gmail.com with ESMTPSA id d13sm28959489pfh.113.2019.06.04.01.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 01:09:23 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     larry.finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: core: Remove initialisation of return variable
Date:   Tue,  4 Jun 2019 13:39:10 +0530
Message-Id: <20190604080910.12599-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove initialisation of return variable as it is never used.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 8f28aefbe6f9..6f3c03201f64 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -5322,7 +5322,7 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
-	u8 res = _SUCCESS;
+	u8 res;
 	int len_diff = 0;
 
 	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
-- 
2.19.1

