Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E697C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDA52083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561725180;
	bh=gKaLS/QRjLKZmAawt2igdWZkMBOMTVFA6wDCM++04kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BK2CBnQiYuiRJIMzFMThg27ZCyYCDUX21vmp/Lw8L++6OqhkLPEmVrAK9sE4bxYJa
	 YsScwOasdAzqXTaKj44EsfTK+7Sf6mg3DZA+IOM25KyiZ/VFiVu+M7TxFp3/UIt0w/
	 VgTQT1aT9rrdAyBfognuaiOKAtKK2KOUFjiJu5L0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfF1Mc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:32:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39246 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfF1Mak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pnoOoNqvP9lmhsaftnP+6RshP9sKpNpxCGCfC6q8bcM=; b=TnE3sHN0v11shtZZiH/buLE4MU
        Uu/JRUcxc6txUIltVAeBEY67hQS1OJ7yZwN1Ase47osfgI1U7vPKX0lyJKnTrhcspZOXFapmwwo/O
        hN5TezEeoKfegTe1O4NzPoiVM0It2wEsM/k39lOhPm8c8NCTRmtoeqkMqf94TK6ig0pdKiwObPUFV
        ds2BGtpFoFSxonIMIMuyQ2mR2dUAcfcV19hIyvFxIEhLnKiN6Y/MqbFiYCKIPWk7hzvCPK1Twd0KA
        anM8T9Fq3X/9DKnoPPB2dGlvIfISHDBQVKcGUr606mVxxkbbvl8UkVHT/tbkyBqZQecnW/B/nu3wH
        tOHngZeQ==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-00054y-3a; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005RO-3O; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 06/39] docs: mtd: move it to the driver-api book
Date:   Fri, 28 Jun 2019 09:29:59 -0300
Message-Id: <5153e27b3729e097e3069f206fb6143ca6457c62.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While I was tempted to move it to admin-guide, as some docs
there are more userspace-faced, there are some very technical
discussions about memory error correction code from the Kernel
implementer's PoV. So, let's place it inside the driver-api
book.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/driver-api/index.rst               | 1 +
 Documentation/{ => driver-api}/mtd/index.rst     | 2 --
 Documentation/{ => driver-api}/mtd/intel-spi.rst | 0
 Documentation/{ => driver-api}/mtd/nand_ecc.rst  | 0
 Documentation/{ => driver-api}/mtd/spi-nor.rst   | 0
 drivers/mtd/nand/raw/nand_ecc.c                  | 2 +-
 6 files changed, 2 insertions(+), 3 deletions(-)
 rename Documentation/{ => driver-api}/mtd/index.rst (94%)
 rename Documentation/{ => driver-api}/mtd/intel-spi.rst (100%)
 rename Documentation/{ => driver-api}/mtd/nand_ecc.rst (100%)
 rename Documentation/{ => driver-api}/mtd/spi-nor.rst (100%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 41f5ce7dc34c..488c0347fa98 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -43,6 +43,7 @@ available subsections can be seen below.
    mtdnand
    miscellaneous
    mei/index
+   mtd/index
    nvdimm/index
    w1
    rapidio/index
diff --git a/Documentation/mtd/index.rst b/Documentation/driver-api/mtd/index.rst
similarity index 94%
rename from Documentation/mtd/index.rst
rename to Documentation/driver-api/mtd/index.rst
index 4fdae418ac97..2e0e7cc4055e 100644
--- a/Documentation/mtd/index.rst
+++ b/Documentation/driver-api/mtd/index.rst
@@ -1,5 +1,3 @@
-:orphan:
-
 ==============================
 Memory Technology Device (MTD)
 ==============================
diff --git a/Documentation/mtd/intel-spi.rst b/Documentation/driver-api/mtd/intel-spi.rst
similarity index 100%
rename from Documentation/mtd/intel-spi.rst
rename to Documentation/driver-api/mtd/intel-spi.rst
diff --git a/Documentation/mtd/nand_ecc.rst b/Documentation/driver-api/mtd/nand_ecc.rst
similarity index 100%
rename from Documentation/mtd/nand_ecc.rst
rename to Documentation/driver-api/mtd/nand_ecc.rst
diff --git a/Documentation/mtd/spi-nor.rst b/Documentation/driver-api/mtd/spi-nor.rst
similarity index 100%
rename from Documentation/mtd/spi-nor.rst
rename to Documentation/driver-api/mtd/spi-nor.rst
diff --git a/drivers/mtd/nand/raw/nand_ecc.c b/drivers/mtd/nand/raw/nand_ecc.c
index f6a7808db818..09fdced659f5 100644
--- a/drivers/mtd/nand/raw/nand_ecc.c
+++ b/drivers/mtd/nand/raw/nand_ecc.c
@@ -11,7 +11,7 @@
  *   Thomas Gleixner (tglx@linutronix.de)
  *
  * Information on how this algorithm works and how it was developed
- * can be found in Documentation/mtd/nand_ecc.rst
+ * can be found in Documentation/driver-api/mtd/nand_ecc.rst
  */
 
 #include <linux/types.h>
-- 
2.21.0

