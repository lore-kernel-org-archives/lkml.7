Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD47C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B699321855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbfJAQHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:07:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44524 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733280AbfJAQHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:07:48 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6C6B5E5304A984C54688;
        Wed,  2 Oct 2019 00:07:45 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Wed, 2 Oct 2019 00:07:15 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <bhelgaas@google.com>, <olof@lixom.net>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/3] logic_pio: Define PIO_INDIRECT_SIZE for !CONFIG_INDIRECT_PIO
Date:   Wed, 2 Oct 2019 00:04:26 +0800
Message-ID: <1569945867-82243-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1569945867-82243-1-git-send-email-john.garry@huawei.com>
References: <1569945867-82243-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the goal of expanding the test coverage of the HiSi LPC driver to
!ARM64, define a dummy PIO_INDIRECT_SIZE for !CONFIG_INDIRECT_PIO, which
is required by the named driver.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 include/linux/logic_pio.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
index 88e1e6304a71..54945aa824b4 100644
--- a/include/linux/logic_pio.h
+++ b/include/linux/logic_pio.h
@@ -108,10 +108,10 @@ void logic_outsl(unsigned long addr, const void *buffer, unsigned int count);
  * area by redefining the macro below.
  */
 #define PIO_INDIRECT_SIZE 0x4000
-#define MMIO_UPPER_LIMIT (IO_SPACE_LIMIT - PIO_INDIRECT_SIZE)
 #else
-#define MMIO_UPPER_LIMIT IO_SPACE_LIMIT
+#define PIO_INDIRECT_SIZE 0
 #endif /* CONFIG_INDIRECT_PIO */
+#define MMIO_UPPER_LIMIT (IO_SPACE_LIMIT - PIO_INDIRECT_SIZE)
 
 struct logic_pio_hwaddr *find_io_range_by_fwnode(struct fwnode_handle *fwnode);
 unsigned long logic_pio_trans_hwaddr(struct fwnode_handle *fwnode,
-- 
2.17.1

