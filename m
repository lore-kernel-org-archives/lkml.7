Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EB4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A347D2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 19:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QP1vEQtQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfDJT7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:59:10 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37172 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfDJT7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 15:59:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id v13so3297697ljk.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xF0+W7srIQfbgQ7tlGxBCjWOJ+vLDr6qxPO28weJN5Y=;
        b=QP1vEQtQhoJSrpZ76JBL1JAYV+zoZbWvYwB5G5p18VhhzHZBR2lMnGBoqbyRvNr0pq
         4OoUGdDwPBl3J8a4UO97fGmytDlID6KzSlRdoVCzR3SNnR+r4tTM1lV6ujfQlIlVagXK
         uO0tXtmSG5ptGpp7laRSeweAc9bxB01JqHArPISzXsGzTE4q+K5w/eqPKfGwWb69zOaX
         gDiMvuM1FKmmxSFyuvDUJ47R9sz05HNBltF4LNg8ZXPHCwcPF901ylscKJ4LzBbV2AAe
         q8vM9cBtGjbBPp/OCI9smkda/UjqT+FOWvKWjwnr2WlqKbtk9PLFzuACWKnaqjXY94Kz
         wKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xF0+W7srIQfbgQ7tlGxBCjWOJ+vLDr6qxPO28weJN5Y=;
        b=pnTyfmjW+MfW0YuADltG5D99usrXUe36hz2FrD8qUzTTQ3v5Go6C3FCKcqlRcfu3rs
         /w7IUq58M4WVYe/t49DAnUxSvhjEdSA7xXS/8mhTePrdaTuT6xZsDzqi7Z4S1/L3wmt3
         yFrG8hFDbKyAzaQmqzqofzb4KImqJvydURcs7c7IdnTzWJDdi3hkGorPv0Nuk+J6GSHR
         uYEvR39/Xcih9ot4eMuZhP4/N8aThcEQHvhpAZuKRC+NBwkDIwu0l53FDYjlFN00qYZy
         Nh7PZtgx7MdrvSom9iTwWlYk2ySe7JO9xlH/1ZETqtteUvoHP9HGcMyC+QgOm4/zdVWp
         q5dg==
X-Gm-Message-State: APjAAAVkj87ssKV4xMyD74k+x2zCG3ATrbKJMfFsVJJwGi9CTPTXlpX4
        fx4iKxORd1eAlUcHXC022gppyQ==
X-Google-Smtp-Source: APXvYqxt6FgSVLw9nqPk30okfUzZKtd0kyDRdWsGL7tCt+Tr0Rj6/diNn62XiSBXkkf/SDfYKilkmg==
X-Received: by 2002:a2e:968c:: with SMTP id q12mr23873796lji.36.1554926346965;
        Wed, 10 Apr 2019 12:59:06 -0700 (PDT)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id q5sm7150752lfm.16.2019.04.10.12.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 12:59:06 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, marek.vasut@gmail.com, richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/2] mtd: nand: raw: fix build dependency
Date:   Wed, 10 Apr 2019 21:58:52 +0200
Message-Id: <20190410195852.4066-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410195852.4066-1-anders.roxell@linaro.org>
References: <20190410195852.4066-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enable CONFIG_MTD_NAND_ECC_SW_BCH as a module, the
MTD_NAND_ECC_SW_BCH depends on MTD_NAND, but the module controlled by
MTD_NAND links against the module controlled by MTD_NAND_ECC_SW_BCH.
This leads to the following link failure.

aarch64-linux-gnu-ld: drivers/mtd/nand/raw/nand_base.o: in function `nand_cleanup':
../drivers/mtd/nand/raw/nand_base.c:5886: undefined reference to `nand_bch_free'
aarch64-linux-gnu-ld: ../drivers/mtd/nand/raw/nand_base.c:5886:(.text+0x9928): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `nand_bch_free'
aarch64-linux-gnu-ld: drivers/mtd/nand/raw/nand_base.o: in function `nand_set_ecc_soft_ops':
../drivers/mtd/nand/raw/nand_base.c:5093: undefined reference to `nand_bch_calculate_ecc'
aarch64-linux-gnu-ld: ../drivers/mtd/nand/raw/nand_base.c:5093:(.text+0xe914): relocation truncated to fit: R_AARCH64_ADR_PREL_PG_HI21 against undefined symbol `nand_bch_calculate_ecc'
aarch64-linux-gnu-ld: ../drivers/mtd/nand/raw/nand_base.c:5093: undefined reference to `nand_bch_calculate_ecc'
aarch64-linux-gnu-ld: ../drivers/mtd/nand/raw/nand_base.c:5094: undefined reference to `nand_bch_correct_data'
aarch64-linux-gnu-ld: ../drivers/mtd/nand/raw/nand_base.c:5094:(.text+0xe934): relocation truncated to fit: R_AARCH64_ADR_PREL_PG_HI21 against undefined symbol `nand_bch_correct_data'
aarch64-linux-gnu-ld: ../drivers/mtd/nand/raw/nand_base.c:5094: undefined reference to `nand_bch_correct_data'
aarch64-linux-gnu-ld: ../drivers/mtd/nand/raw/nand_base.c:5148: undefined reference to `nand_bch_init'
aarch64-linux-gnu-ld: ../drivers/mtd/nand/raw/nand_base.c:5148:(.text+0xebbc): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `nand_bch_init'

Rework CONFIG_MTD_NAND_ECC_SW_BCH from tristate to bool,
and then link the nand_bch.o file into nand.ko if its enabled.

Fixes: 51ef1d0b2095 ("mtd: nand: Clarify Kconfig entry for software BCH ECC algorithm")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/mtd/nand/raw/Kconfig  | 2 +-
 drivers/mtd/nand/raw/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 615d738be411..0500c42f31cb 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -22,7 +22,7 @@ menuconfig MTD_RAW_NAND
 if MTD_RAW_NAND
 
 config MTD_NAND_ECC_SW_BCH
-	tristate "Support software BCH ECC"
+	bool "Support software BCH ECC"
 	select BCH
 	default n
 	help
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 8bc6faaa3bc7..efaf5cd25edc 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -2,7 +2,7 @@
 
 obj-$(CONFIG_MTD_RAW_NAND)		+= nand.o
 obj-$(CONFIG_MTD_NAND_ECC_SW_HAMMING)	+= nand_ecc.o
-obj-$(CONFIG_MTD_NAND_ECC_SW_BCH)	+= nand_bch.o
+nand-$(CONFIG_MTD_NAND_ECC_SW_BCH)	+= nand_bch.o
 obj-$(CONFIG_MTD_SM_COMMON) 		+= sm_common.o
 
 obj-$(CONFIG_MTD_NAND_CAFE)		+= cafe_nand.o
-- 
2.20.1

