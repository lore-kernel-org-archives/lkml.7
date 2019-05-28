Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70984C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B4F2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfE1Jb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:31:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56958 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbfE1Jb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:31:28 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E76218F3DB2F0A7C23DB;
        Tue, 28 May 2019 17:31:25 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 28 May 2019
 17:31:15 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dvhart@infradead.org>, <andy@infradead.org>, <lkundrak@v3.sk>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next 2/2] Platform: OLPC: Add INPUT dependencies
Date:   Tue, 28 May 2019 17:28:06 +0800
Message-ID: <20190528092806.20080-3-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190528092806.20080-1-yuehaibing@huawei.com>
References: <20190528092806.20080-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with CONFIG_INPUT set to m:

drivers/platform/olpc/olpc-xo175-ec.o: In function `olpc_xo175_ec_complete':
olpc-xo175-ec.c:(.text+0x75d): undefined reference to `input_event'
olpc-xo175-ec.c:(.text+0x76f): undefined reference to `input_event'
olpc-xo175-ec.c:(.text+0x787): undefined reference to `input_event'
olpc-xo175-ec.c:(.text+0x799): undefined reference to `input_event'
drivers/platform/olpc/olpc-xo175-ec.o: In function `olpc_xo175_ec_probe':
olpc-xo175-ec.c:(.text+0x8d5): undefined reference to `devm_input_allocate_device'
olpc-xo175-ec.c:(.text+0x910): undefined reference to `input_set_capability'
olpc-xo175-ec.c:(.text+0x91c): undefined reference to `input_register_device'

This patch add INPUT dependencies to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 0c3d931b3ab9 ("Platform: OLPC: Add XO-1.75 EC driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/platform/olpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/olpc/Kconfig b/drivers/platform/olpc/Kconfig
index 1d3244a..1fa676c 100644
--- a/drivers/platform/olpc/Kconfig
+++ b/drivers/platform/olpc/Kconfig
@@ -6,6 +6,7 @@ config OLPC_XO175_EC
 	tristate "OLPC XO 1.75 Embedded Controller"
 	depends on ARCH_MMP || COMPILE_TEST
 	depends on SPI_SLAVE
+	depends on INPUT
 	select OLPC_EC
 	help
 	  Include support for the OLPC XO Embedded Controller (EC). The EC
-- 
2.7.4


