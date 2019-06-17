Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEE0C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63342084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfFQLLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:11:40 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:51055 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfFQLLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:11:40 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MvrVJ-1iRlfZ1c0t-00suZC; Mon, 17 Jun 2019 13:11:14 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: ingenic: fix ingenic_ecc dependency
Date:   Mon, 17 Jun 2019 13:10:48 +0200
Message-Id: <20190617111110.2103786-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3d5kPLvVE+Mc9VocHJ5QL+VG4ICGCL+ttTF1bO5RPZrywWViORJ
 J4UEAky7/1X2kY+6uHvrmIHQ7XjrD2blLBlde7aWejVbivUNHuxVqJ64iuGvyWcy6MGyobe
 b3z31TVpq0hJMmVqt1VT9ov4znfRlngYBsN+8AmkjxP/RiF758Gygi5TAFP2MyREaWJ05bQ
 zaAhuK21CjxYLMTKfVXOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zmaDm1J/3pY=:C/lRGG3LiVMmI+mYfDDOhB
 yTIvj0o/OjngHQQTEqmUTTGy/WInYst1DqPO24w3furPv5tYb26El1BOBWOPeZcgMNUMXh9nP
 SkHTyj/K0Udn6oU5dU28acZP8LsYqiQURxAnoNAYAHnq9psTFySd1DQNudIt7kncrP/o/bQpG
 6dd1RBjadw1Am0ex7q0lqYsllDzQEtiQXlCNr25WC9WmnDeahuGsTc6AD8lwt7GIa03V0ds1n
 rMZM9f7KjIvyupa+BPGfEF+AXatKuAczzwXi1jYmrCFS+TZY4s7UBDB2j0Yfv32nk7PwPbMzN
 Ucvh0jNCSah3wJuJOy+o3JllX5vvpGNeQgWmXBSH2Z+lQor5CJ8XF78/lcSm4uQ3hnj+K5xmJ
 ozSVZjZdwOSweZSH+p88q/aibNg1VQhd94eYaYc+Q1hf+7tyrEukvrZG6bkhmYMMYy+jVNwaw
 xlN48l+Ck8xJBOXy3eEtJ7hwz/h3pIqWuQjXcMDiz9Bjyp7JFFtJ8Cp5fT/aB5iu6c2Zc1DXO
 4Z3Ez8WGh17giu/cZzddQXnJs6nwnbhPd8JKnBxngvu/LdSr/uAq0P0YzVaIumJM6hOvd7lo5
 FEpB3XEjVjTIeBy12G49jsAw/6QIR16G1pK6grnUK4r25Ta9SlQ0uOhuYgk0ckCijuWDU7pbJ
 V2TjwiRJSNdfuapuKyl4QTBKADC8oh4Kfk6uyBYxtfxQGT02i+CV5IhjRiMyTvRz4HNTt3grF
 TNwW/xc9cuUgfKnro1uyx+qJRCAbvY3GuZN7lA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ecc code is called from the main ingenic_nand module, but the
Kconfig symbol gets selected by the dependent ones.

If the child drivers are loadable modules, this leads to a link
error:

drivers/mtd/nand/raw/ingenic/ingenic_nand.o: In function `ingenic_nand_remove':
ingenic_nand.c:(.text+0x1a1): undefined reference to `ingenic_ecc_release'
drivers/mtd/nand/raw/ingenic/ingenic_nand.o: In function `ingenic_nand_ecc_correct':
ingenic_nand.c:(.text+0x1fa): undefined reference to `ingenic_ecc_correct'
drivers/mtd/nand/raw/ingenic/ingenic_nand.o: In function `ingenic_nand_ecc_calculate':
ingenic_nand.c:(.text+0x255): undefined reference to `ingenic_ecc_calculate'
drivers/mtd/nand/raw/ingenic/ingenic_nand.o: In function `ingenic_nand_probe':
ingenic_nand.c:(.text+0x3ca): undefined reference to `of_ingenic_ecc_get'
ingenic_nand.c:(.text+0x685): undefined reference to `ingenic_ecc_release'

Rearrange this to have the ecc code linked the same way as the main
driver.

Fixes: 15de8c6efd0e ("mtd: rawnand: ingenic: Separate top-level and SoC specific code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/nand/raw/ingenic/Kconfig  | 2 +-
 drivers/mtd/nand/raw/ingenic/Makefile | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/ingenic/Kconfig b/drivers/mtd/nand/raw/ingenic/Kconfig
index 19a96ce515c1..66b7cffdb0c2 100644
--- a/drivers/mtd/nand/raw/ingenic/Kconfig
+++ b/drivers/mtd/nand/raw/ingenic/Kconfig
@@ -16,7 +16,7 @@ config MTD_NAND_JZ4780
 if MTD_NAND_JZ4780
 
 config MTD_NAND_INGENIC_ECC
-	tristate
+	bool
 
 config MTD_NAND_JZ4740_ECC
 	tristate "Hardware BCH support for JZ4740 SoC"
diff --git a/drivers/mtd/nand/raw/ingenic/Makefile b/drivers/mtd/nand/raw/ingenic/Makefile
index 1ac4f455baea..5a55efc5d9bb 100644
--- a/drivers/mtd/nand/raw/ingenic/Makefile
+++ b/drivers/mtd/nand/raw/ingenic/Makefile
@@ -2,7 +2,10 @@
 obj-$(CONFIG_MTD_NAND_JZ4740) += jz4740_nand.o
 obj-$(CONFIG_MTD_NAND_JZ4780) += ingenic_nand.o
 
-obj-$(CONFIG_MTD_NAND_INGENIC_ECC) += ingenic_ecc.o
+ifdef CONFIG_MTD_NAND_INGENIC_ECC
+obj-$(CONFIG_MTD_NAND_JZ4780) += ingenic_ecc.o
+endif
+
 obj-$(CONFIG_MTD_NAND_JZ4740_ECC) += jz4740_ecc.o
 obj-$(CONFIG_MTD_NAND_JZ4725B_BCH) += jz4725b_bch.o
 obj-$(CONFIG_MTD_NAND_JZ4780_BCH) += jz4780_bch.o
-- 
2.20.0

