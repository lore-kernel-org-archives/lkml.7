Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB5AC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF6421955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 05:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMh1rXdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfGVF5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 01:57:04 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:38318 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfGVF5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 01:57:02 -0400
Received: by mail-ed1-f47.google.com with SMTP id r12so4686992edo.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 22:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=V0NauvuKcIG8OsEXlRR/U4pgQmro8nJ1gsHE95WvQnI=;
        b=NMh1rXdkfWbuWDt+z3yLdkH/Y3Ouh+MzrzHaN3CeC/8ltQHQSE6EGFxxH/BDFynb01
         1ZVuNU0zwSR+XjqzhCJOUbVvmP/unkNMf52OSqhfkjAfHp6QeEqWuNd5j2blDRPgDolT
         GA1zL+pryQepcxHDTFH5RAjThr3ky8HcL/HqE0W+f0+Hl5Vn69QH/854SL+CcgibT7pq
         Emr4BgMusm690fBWxx8lvWeFX7UUve1x+F58dX8Wuyyai6smP9BAOKBjzxWcR22VY8SZ
         7i3rCiy/wYQLtgP0dvxLAuGjZ+A2vQHls8QLiK7rrdT+QumCXd4V0sPa6zSXZk2Kilwj
         H2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=V0NauvuKcIG8OsEXlRR/U4pgQmro8nJ1gsHE95WvQnI=;
        b=rOGEZPgxyXa3CorOBhhzEp3HauCuEJFt5nhemjQoO0vvMQvdJR0YuTAYdH3z72V9hl
         P561RoND4itcpBl7J//F+JjT/FM2PLLUf8YFb8/nxBc9pZSSd+1XAtL9NkFQcnkbnOie
         4mf3AYnhnn2NnR6qHrpWTexMsItp51J3k53RRlOusvgY8ks/TgtE4lOs0xPty4Ti2aFf
         uZyNEfxUdJug1DzkiR4XvuflyJWQtYigHO16H2k1VYSCXPJI4TdfKaKtU+LcsJAaFJHI
         O1ySZk3SsZuxHrE7okfrdTHmVHqyuRB54HJcXcEMu0gWYdnzg9shxgajKop/U74VP406
         3j8g==
X-Gm-Message-State: APjAAAVz+7nB0GwdB55V1oj6f4WKgxB1o3I1ZHBwFdpYTx/CJL4b9QG1
        g5KlFTJHDGtP/AdiX7xax04=
X-Google-Smtp-Source: APXvYqzalEzwxMf39q5qKDrV92KYncql/CQqlOTzgBM0FoITMmwp3crIM1iaLnWdTd/EYvyTCCPPEQ==
X-Received: by 2002:a05:6402:609:: with SMTP id n9mr58825921edv.159.1563775020497;
        Sun, 21 Jul 2019 22:57:00 -0700 (PDT)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id a6sm10351725eds.19.2019.07.21.22.56.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 22:57:00 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Shivamurthy Shastri <sshivamurthy@micron.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeff Kletsky <git-commits@allycomm.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: [PATCH 1/8] mtd: nand: move ONFI related functions to onfi.h
Date:   Mon, 22 Jul 2019 07:56:14 +0200
Message-Id: <20190722055621.23526-2-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722055621.23526-1-sshivamurthy@micron.com>
References: <20190722055621.23526-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

These functions will be used by both raw NAND and SPI NAND, which
supports ONFI like standards.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/raw/internals.h | 1 -
 include/linux/mtd/onfi.h         | 9 +++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
index cba6fe7dd8c4..ed323087d884 100644
--- a/drivers/mtd/nand/raw/internals.h
+++ b/drivers/mtd/nand/raw/internals.h
@@ -140,7 +140,6 @@ void nand_legacy_adjust_cmdfunc(struct nand_chip *chip);
 int nand_legacy_check_hooks(struct nand_chip *chip);
 
 /* ONFI functions */
-u16 onfi_crc16(u16 crc, u8 const *p, size_t len);
 int nand_onfi_detect(struct nand_chip *chip);
 
 /* JEDEC functions */
diff --git a/include/linux/mtd/onfi.h b/include/linux/mtd/onfi.h
index 339ac798568e..2c8a05a02bb0 100644
--- a/include/linux/mtd/onfi.h
+++ b/include/linux/mtd/onfi.h
@@ -10,6 +10,7 @@
 #ifndef __LINUX_MTD_ONFI_H
 #define __LINUX_MTD_ONFI_H
 
+#include <linux/mtd/nand.h>
 #include <linux/types.h>
 
 /* ONFI version bits */
@@ -175,4 +176,12 @@ struct onfi_params {
 	u8 vendor[88];
 };
 
+/* ONFI functions */
+u16 onfi_crc16(u16 crc, u8 const *p, size_t len);
+void nand_bit_wise_majority(const void **srcbufs,
+			    unsigned int nsrcbufs,
+			    void *dstbuf,
+			    unsigned int bufsize);
+void sanitize_string(u8 *s, size_t len);
+
 #endif /* __LINUX_MTD_ONFI_H */
-- 
2.17.1

