Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B5BC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E98214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvY+F1VY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfJJVk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 17:40:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39368 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfJJVk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:40:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so9598307wrj.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 14:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XMJglR3k39oo4lFzmZ/NkXw1yJ/6wrmxZJcm2kMQjmw=;
        b=PvY+F1VYaxQrnqBlJD58hDny3N9yiiWe+m/OLkz52Dmkwp5x9bKGbWo0COyLmAXNwu
         Vw17CkjrhVHj9qHYpXLbNitEatrskyN0M9svUZmmG77ZkxteamJ4ZTMPIW9ek8kBg9Cu
         gTuSE4F41QCNgIjLvR6kV/lgqi1zWbNk9FGlugi3LsN/5Wgx8I96n9+vObBmMVdBK9IM
         pRiF1C0BlurG4Hd2v0cArtcJS/Z4z1v4+VNAwWWv+pzYYE8Nl7QhFwdQ9Gul+31cvVXL
         T5D2Qm5OgNzFsJOG9zMBE39pcAci0Xl0FzvUMvvsfYy5O+5IcUS8WKKy5ETL6PcBrXpU
         0+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XMJglR3k39oo4lFzmZ/NkXw1yJ/6wrmxZJcm2kMQjmw=;
        b=OWu0OqAyNWTAT6wuRvFTz141gl9WerRhKm1iguysCq/8grW4f2WZso1Sd1ckbFHSfS
         f50GkmYgPVDB+H0SgCsvrxXW1NSxhvcz+VjohR3O5w3j+3KaipOnkKYTSnJett3/T8/z
         Hn9o1pSvHW+ITf08Ses3f2WzSCoz4U7dVXhfLtxsLjuW2cUT0D48Ev+p/BA+Vy3hykk5
         3hOJxql9uAo6aalF4GqflxF51tEI1juFEVjf3YU/XywkbkSdpoPcU8Rfkc5V+76Bmqci
         753Qh4rMKjVrD3jpQhAhx13W2zO9PaLCBz+ZYpQQp7ICur++08zZOuTrTXUIwYKMnyFm
         ly6g==
X-Gm-Message-State: APjAAAXuyiM6gY5Ku5V4Fv1/4GIUMEvqMyAT3GKI71faSycAmezorTm0
        s3z3DPpHGtixQc+1SiQ9ZQ==
X-Google-Smtp-Source: APXvYqxp2X3mij+XJLhkVV3NDsw60mdBlZJn0aM+SQHG1O3YkTmaxKgFsb23/vDICVVFykPdMmu+zA==
X-Received: by 2002:adf:9c81:: with SMTP id d1mr9781941wre.238.1570743624401;
        Thu, 10 Oct 2019 14:40:24 -0700 (PDT)
Received: from ninjahub.lan (host-2-102-13-201.as13285.net. [2.102.13.201])
        by smtp.googlemail.com with ESMTPSA id h63sm11455423wmf.15.2019.10.10.14.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 14:40:24 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, Jules Irenge <jbi.octave@gmail.com>
Subject: [RESEND PATCH v1 3/5] staging: qlge: Fix multiple assignments warning by replacing integer variables to bool
Date:   Thu, 10 Oct 2019 22:40:04 +0100
Message-Id: <20191010214006.23677-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010214006.23677-1-jbi.octave@gmail.com>
References: <20191010214006.23677-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix multiple assignments warning " check
 issue detected by checkpatch tool:
"CHECK: multiple assignments should be avoided".

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/qlge/qlge_dbg.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
index 27aa8de3b5ff..b8ff9eccc472 100644
--- a/drivers/staging/qlge/qlge_dbg.c
+++ b/drivers/staging/qlge/qlge_dbg.c
@@ -112,7 +112,7 @@ static int ql_read_serdes_reg(struct ql_adapter *qdev, u32 reg, u32 *data)
 
 static void ql_get_both_serdes(struct ql_adapter *qdev, u32 addr,
 			       u32 *direct_ptr, u32 *indirect_ptr,
-			unsigned int direct_valid, unsigned int indirect_valid)
+			       bool direct_valid, bool indirect_valid)
 {
 	unsigned int status;
 
@@ -136,13 +136,12 @@ static int ql_get_serdes_regs(struct ql_adapter *qdev,
 			      struct ql_mpi_coredump *mpi_coredump)
 {
 	int status;
-	unsigned int xfi_direct_valid, xfi_indirect_valid, xaui_direct_valid;
-	unsigned int xaui_indirect_valid, i;
+	bool xfi_direct_valid = false, xfi_indirect_valid = false;
+	bool xaui_direct_valid = true, xaui_indirect_valid = true;
+	unsigned int i;
 	u32 *direct_ptr, temp;
 	u32 *indirect_ptr;
 
-	xfi_direct_valid = xfi_indirect_valid = 0;
-	xaui_direct_valid = xaui_indirect_valid = 1;
 
 	/* The XAUI needs to be read out per port */
 	status = ql_read_other_func_serdes_reg(qdev,
@@ -152,7 +151,7 @@ static int ql_get_serdes_regs(struct ql_adapter *qdev,
 
 	if ((temp & XG_SERDES_ADDR_XAUI_PWR_DOWN) ==
 				XG_SERDES_ADDR_XAUI_PWR_DOWN)
-		xaui_indirect_valid = 0;
+		xaui_indirect_valid = false;
 
 	status = ql_read_serdes_reg(qdev, XG_SERDES_XAUI_HSS_PCS_START, &temp);
 
@@ -161,7 +160,7 @@ static int ql_get_serdes_regs(struct ql_adapter *qdev,
 
 	if ((temp & XG_SERDES_ADDR_XAUI_PWR_DOWN) ==
 				XG_SERDES_ADDR_XAUI_PWR_DOWN)
-		xaui_direct_valid = 0;
+		xaui_direct_valid = false;
 
 	/*
 	 * XFI register is shared so only need to read one
@@ -176,18 +175,18 @@ static int ql_get_serdes_regs(struct ql_adapter *qdev,
 		/* now see if i'm NIC 1 or NIC 2 */
 		if (qdev->func & 1)
 			/* I'm NIC 2, so the indirect (NIC1) xfi is up. */
-			xfi_indirect_valid = 1;
+			xfi_indirect_valid = true;
 		else
-			xfi_direct_valid = 1;
+			xfi_direct_valid = true;
 	}
 	if ((temp & XG_SERDES_ADDR_XFI2_PWR_UP) ==
 					XG_SERDES_ADDR_XFI2_PWR_UP) {
 		/* now see if i'm NIC 1 or NIC 2 */
 		if (qdev->func & 1)
 			/* I'm NIC 2, so the indirect (NIC1) xfi is up. */
-			xfi_direct_valid = 1;
+			xfi_direct_valid = true;
 		else
-			xfi_indirect_valid = 1;
+			xfi_indirect_valid = true;
 	}
 
 	/* Get XAUI_AN register block. */
-- 
2.21.0

