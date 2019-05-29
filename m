Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A05C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F6E21881
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKsyjAaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfE2NcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:32:13 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44178 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfE2NcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:32:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id c5so1067356pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 06:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cjrQ8YCtSkpAgdCS1Bxq9uio+64j2BPS+VlWEqnS1x4=;
        b=FKsyjAaZbhgsZt0VI/1vjpIfNTSoCjtAeNeLOXgQC3wpDG4RUNnX5zPZMPMZsuQaIo
         40NB7Y4wyRFLxptQJJ5yuTrKoqJaLVGi6M4CysGYv5qgkcxITCKEC7qmvme9RQ9e/c+z
         4vhiLjdGlsqKj0oZmtkxSfjR+BJT2RwjP9diFeZB80n+xsvo+oQH3Qcjs+4Na3uppCal
         Dt3F2whceB2r+qmDa4Aq+eSiBUabt7JlMv8xE4Ww5SGMB8yF/CIm5lTC3qHzm4P37qle
         NmDBqSvs+0Q/DYkTk1s1OInMZTP94gSLJOyOQkq6hkzQ3OCiL5h7jUd4CpU6og1UoHs+
         WteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cjrQ8YCtSkpAgdCS1Bxq9uio+64j2BPS+VlWEqnS1x4=;
        b=NQntyT6+nGc5TTdbdjQzLnIsGrMlrjHOEDK8okMbrxxc5GyYjBvaYpcyHHBUYJjf44
         sfLZc7VgxcJh+S3g+ecm0oCrxFd6Qaew0YY0yAShbPzKMxgA8+4OtCnCTaRJ/FMrzfJE
         Q1wnTJZLDN0G1Jx4WlIPXShRM+UmYwgWl4UOk5pTyBa/ls3vvF6TXf62nTkKso2Zw2Io
         vI7R5/ZrxDL15IfZTqWsW60ldCHGbUG3IeyLGY27gLoZC17OmJQ/Nhx7JfCRhakzoUTy
         hSF3PZSJd3CLZNeWpXnsWbz9zh7KUQnAAV73WQbZQCDWOjP5q89wDNkxQNh7SXDgBXv3
         5ipA==
X-Gm-Message-State: APjAAAXZNXT6oDt/uACfkQ1zlypy2BC8qoLo5q01ouKIVRw+qq11+dWI
        lcJWL3NK16FdQiJkJ0ay39U=
X-Google-Smtp-Source: APXvYqxAlISnkMtdxhX9AYkgEjmgN6zPwOOFdovx3E5sQRi3ga6aPxLv0Ylit+uesEHueVvIwACd6Q==
X-Received: by 2002:a17:902:3103:: with SMTP id w3mr63855663plb.187.1559136727724;
        Wed, 29 May 2019 06:32:07 -0700 (PDT)
Received: from localhost.localdomain ([122.163.67.155])
        by smtp.gmail.com with ESMTPSA id j22sm10763595pfh.71.2019.05.29.06.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 06:32:06 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        payal.s.kshirsagar.98@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH] staging: rtl8712: Remove initialisations
Date:   Wed, 29 May 2019 19:01:54 +0530
Message-Id: <20190529133154.6750-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove initialisations of multiple variables as these initial values are
never used.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_mp.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_mp.c b/drivers/staging/rtl8712/rtl871x_mp.c
index ba379506da3f..edd3da05fc06 100644
--- a/drivers/staging/rtl8712/rtl871x_mp.c
+++ b/drivers/staging/rtl8712/rtl871x_mp.c
@@ -709,20 +709,18 @@ static u32 GetPhyRxPktCounts(struct _adapter *pAdapter, u32 selbit)
 
 u32 r8712_GetPhyRxPktReceived(struct _adapter *pAdapter)
 {
-	u32 OFDM_cnt = 0, CCK_cnt = 0, HT_cnt = 0;
+	u32 OFDM_cnt = GetPhyRxPktCounts(pAdapter, OFDM_MPDU_OK_BIT);
+	u32 CCK_cnt  = GetPhyRxPktCounts(pAdapter, CCK_MPDU_OK_BIT);
+	u32 HT_cnt   = GetPhyRxPktCounts(pAdapter, HT_MPDU_OK_BIT);
 
-	OFDM_cnt = GetPhyRxPktCounts(pAdapter, OFDM_MPDU_OK_BIT);
-	CCK_cnt = GetPhyRxPktCounts(pAdapter, CCK_MPDU_OK_BIT);
-	HT_cnt = GetPhyRxPktCounts(pAdapter, HT_MPDU_OK_BIT);
 	return OFDM_cnt + CCK_cnt + HT_cnt;
 }
 
 u32 r8712_GetPhyRxPktCRC32Error(struct _adapter *pAdapter)
 {
-	u32 OFDM_cnt = 0, CCK_cnt = 0, HT_cnt = 0;
+	u32 OFDM_cnt = GetPhyRxPktCounts(pAdapter, OFDM_MPDU_FAIL_BIT);
+	u32 CCK_cnt  = GetPhyRxPktCounts(pAdapter, CCK_MPDU_FAIL_BIT);
+	u32 HT_cnt   = GetPhyRxPktCounts(pAdapter, HT_MPDU_FAIL_BIT);
 
-	OFDM_cnt = GetPhyRxPktCounts(pAdapter, OFDM_MPDU_FAIL_BIT);
-	CCK_cnt = GetPhyRxPktCounts(pAdapter, CCK_MPDU_FAIL_BIT);
-	HT_cnt = GetPhyRxPktCounts(pAdapter, HT_MPDU_FAIL_BIT);
 	return OFDM_cnt + CCK_cnt + HT_cnt;
 }
-- 
2.19.1

