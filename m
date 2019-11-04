Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE75ECA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1ACF2080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfKDRZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:25:36 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728709AbfKDRZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:25:34 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7C74F61AA012ECC36D09;
        Tue,  5 Nov 2019 01:25:31 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 01:25:22 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <olof@lixom.net>, <bhelgaas@google.com>, <arnd@arndb.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 4/5] bus: hisi_lpc: Expand build test coverage
Date:   Tue, 5 Nov 2019 01:22:18 +0800
Message-ID: <1572888139-47298-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1572888139-47298-1-git-send-email-john.garry@huawei.com>
References: <1572888139-47298-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the driver will only ever be built for ARM64 because it selects
CONFIG_INDIRECT_PIO, which itself depends on ARM64.

Expand build test coverage for the driver to other architectures by only
selecting CONFIG_INDIRECT_PIO for ARM64, when we really want it.

We don't include ALPHA, C6X, HEXAGON, and PARISC architectures as they
don't define {read, write}sb.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/bus/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 6b331061d34b..70886abe008e 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -41,8 +41,9 @@ config MOXTET
 
 config HISILICON_LPC
 	bool "Support for ISA I/O space on HiSilicon Hip06/7"
-	depends on ARM64 && (ARCH_HISI || COMPILE_TEST)
-	select INDIRECT_PIO
+	depends on (ARM64 && ARCH_HISI) || (COMPILE_TEST && !ALPHA && !HEXAGON && !PARISC && !C6X)
+	depends on HAS_IOMEM
+	select INDIRECT_PIO if ARM64
 	help
 	  Driver to enable I/O access to devices attached to the Low Pin
 	  Count bus on the HiSilicon Hip06/7 SoC.
-- 
2.17.1

