Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A92C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610B92080A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/sM1rUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfFRS1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:27:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36310 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfFRS1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:27:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id f21so8150783pgi.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 11:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mO472utuFQ+nV4A29aUiVfjK/XWRxLa6xDQ8sQgJqmI=;
        b=R/sM1rUxhjbZRW6SG/PJTnw0z5LYinOBGI/dRLlrIOlSjumvc0CKHCyD+SMw89XEH6
         O7uIcv+A5w/ApFurMpH4xh7R3mPPWYax8BkSssi4IrzM40/LE0nWs9C5qP0CBqnhw93d
         clouyVq+ZVdkUUfxHYdC0zSYpk71dNOtiQXtbtgazRGaEHxgXCbkPR/qnaWClOsp2shk
         D+KO0r0HepQKf8JCu2vxSMIVODaXsuBWxXTDpRPSXh7anxLjXJIfSKTzEYJtvT/HaDmw
         X0GDP/F88ssZTO1V5Z7TRVHRwMb15k96oMB4LUW3bOjZgodr58GmQanpz/1i7OrY0SuN
         htEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mO472utuFQ+nV4A29aUiVfjK/XWRxLa6xDQ8sQgJqmI=;
        b=MefftpFlmoYfYVkInNXO3Z0GXKAqzElgrV+TMOu0j+oIQTTOLIimEGRRBDb3Kcxu7L
         LKsrYno6ugPz/Hd+Fg7uIB18oWXmSOR0pL8r77TFvEeHo6ZmQDSJtEF3aWOoCYHEyKwe
         u3N0wdxnKHJQ8Od14bLGrlHiPQhbCrm28d0knA/L0y9Iw1M/N2RceQzvOQLiYGfnTaao
         V00lvEJJ8vRs2XhsvubtkSWLVf5+dIFGcEkZOoYebY2NYXWjq4QdZyf82qMBQeImus4C
         W/kYRPPdnZCzuPEx2fYrnb1pHbUUXQqojUB/M+F3cV5g5eSQOSEuVAhztYGyR5CDcSgn
         l34A==
X-Gm-Message-State: APjAAAW2sIKCPsglU9MNhUafE34Xs2ohJ4kBKNbd7msbLRS6RrW90ydx
        DdU08av1M2wBeO+Sp/R6JqM=
X-Google-Smtp-Source: APXvYqxTZ4eWDDY0GFYbRMxO2F8ZVnxImzZ5rLTeOMtXnl7NUQclELdAN0qKO+IgHFm8gnB56XWusg==
X-Received: by 2002:a17:90a:9905:: with SMTP id b5mr6758464pjp.70.1560882427917;
        Tue, 18 Jun 2019 11:27:07 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id k4sm6639480pfk.42.2019.06.18.11.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:27:07 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v4 1/2] mtd: Add flag to indicate panic_write
Date:   Tue, 18 Jun 2019 14:26:42 -0400
Message-Id: <1560882420-727-1-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a flag to indicate a panic_write so that low level drivers can
use it to take required action where applicable, to ensure oops data
gets written to assigned mtd device.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/mtdcore.c   | 3 +++
 include/linux/mtd/mtd.h | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 453242d..2e04627 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1124,6 +1124,9 @@ int mtd_panic_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
 		return -EROFS;
 	if (!len)
 		return 0;
+
+	mtd->panic_write_triggered = true;
+
 	return mtd->_panic_write(mtd, to, len, retlen, buf);
 }
 EXPORT_SYMBOL_GPL(mtd_panic_write);
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 936a3fd..02dce49 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -316,6 +316,12 @@ struct mtd_info {
 	int (*_get_device) (struct mtd_info *mtd);
 	void (*_put_device) (struct mtd_info *mtd);
 
+	/*
+	 * flag indicates a panic write, low level drivers can take appropriate
+	 * action if required to ensure writes go through
+	 */
+	bool panic_write_triggered;
+
 	struct notifier_block reboot_notifier;  /* default mode before reboot */
 
 	/* ECC status information */
-- 
1.9.0.138.g2de3478

