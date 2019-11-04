Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB987CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6AF2080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfKDRZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:25:43 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6145 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728321AbfKDRZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:25:35 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 808AC1CF5697FE0F6D55;
        Tue,  5 Nov 2019 01:25:31 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 01:25:22 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <olof@lixom.net>, <bhelgaas@google.com>, <arnd@arndb.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 2/5] logic_pio: Define PIO_INDIRECT_SIZE for !CONFIG_INDIRECT_PIO
Date:   Tue, 5 Nov 2019 01:22:16 +0800
Message-ID: <1572888139-47298-3-git-send-email-john.garry@huawei.com>
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

