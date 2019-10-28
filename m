Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66163CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4468E2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388984AbfJ1MNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:13:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37108 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727085AbfJ1MNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:13:18 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 236A86C4144E00DC386E;
        Mon, 28 Oct 2019 20:13:15 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 28 Oct 2019 20:13:06 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <olof@lixom.net>, <bhelgaas@google.com>, <arnd@arndb.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 4/5] bus: hisi_lpc: Expand build test coverage
Date:   Mon, 28 Oct 2019 20:10:04 +0800
Message-ID: <1572264605-172363-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1572264605-172363-1-git-send-email-john.garry@huawei.com>
References: <1572264605-172363-1-git-send-email-john.garry@huawei.com>
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

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/bus/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 6b331061d34b..44cb4b6bea18 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -41,8 +41,8 @@ config MOXTET
 
 config HISILICON_LPC
 	bool "Support for ISA I/O space on HiSilicon Hip06/7"
-	depends on ARM64 && (ARCH_HISI || COMPILE_TEST)
-	select INDIRECT_PIO
+	depends on (ARM64 && ARCH_HISI) || COMPILE_TEST
+	select INDIRECT_PIO if ARM64
 	help
 	  Driver to enable I/O access to devices attached to the Low Pin
 	  Count bus on the HiSilicon Hip06/7 SoC.
-- 
2.17.1

