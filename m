Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455B1C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B002084C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rojfL0Gu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfGSIaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 04:30:09 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55692 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfGSIaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 04:30:09 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6J8THUc065533;
        Fri, 19 Jul 2019 03:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563524957;
        bh=9c1Ulz4kYZoRGREkkMV4r8fhTvR5MYnlpJnGO/Okjkw=;
        h=From:To:CC:Subject:Date;
        b=rojfL0Guo6r6xoQLKN/dOOkhDUdR7wzXZFLufz0UojzpKIyEwvT725r9OzGcSaA9H
         yYHu0O6BhH8ba+ICNdF417kRWLvDie6c0kLyhTUamslq4syLOsLpoS2qpCJ9HVTg/7
         wvvI1ktmUMoe10CXb2wN4qww6fR7y/XgtIDC3YS4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6J8THq6029681
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Jul 2019 03:29:17 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 19
 Jul 2019 03:29:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 19 Jul 2019 03:29:16 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6J8TENc076829;
        Fri, 19 Jul 2019 03:29:14 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Mao Wenan <maowenan@huawei.com>
Subject: [PATCH] mtd: hyperbus: Kconfig: Fix HBMC_AM654 dependencies
Date:   Fri, 19 Jul 2019 13:59:12 +0530
Message-ID: <20190719082912.10316-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_64, when CONFIG_OF is not disabled:

WARNING: unmet direct dependencies detected for MUX_MMIO
  Depends on [n]: MULTIPLEXER [=y] && (OF [=n] || COMPILE_TEST [=n])
  Selected by [y]:
  - HBMC_AM654 [=y] && MTD [=y] && MTD_HYPERBUS [=y]

due to
config HBMC_AM654
	tristate "HyperBus controller driver for AM65x SoC"
	select MULTIPLEXER
	select MUX_MMIO

Fix this by making HBMC_AM654 imply MUX_MMIO instead of select so
that dependencies are taken care of. MUX_MMIO is optional for
functioning of driver.

Fixes: b07079f1642c ("mtd: hyperbus: Add driver for TI's HyperBus memory controller")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/mtd/hyperbus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/hyperbus/Kconfig b/drivers/mtd/hyperbus/Kconfig
index cff6bbd226f5..1c691df8eff7 100644
--- a/drivers/mtd/hyperbus/Kconfig
+++ b/drivers/mtd/hyperbus/Kconfig
@@ -15,7 +15,7 @@ if MTD_HYPERBUS
 config HBMC_AM654
 	tristate "HyperBus controller driver for AM65x SoC"
 	select MULTIPLEXER
-	select MUX_MMIO
+	imply MUX_MMIO
 	help
 	 This is the driver for HyperBus controller on TI's AM65x and
 	 other SoCs
-- 
2.22.0

