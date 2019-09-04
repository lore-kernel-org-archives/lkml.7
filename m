Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481D1C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232B62073F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbfIDQdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:33:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731520AbfIDQdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:33:20 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A280621E8953A5A2F875;
        Thu,  5 Sep 2019 00:33:15 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Sep 2019 00:33:06 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@hisilicon.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <olof@lixom.net>, <arnd@arndb.de>, <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at registration
Date:   Thu, 5 Sep 2019 00:30:33 +0800
Message-ID: <1567614633-210580-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the only LOGIC_PIO_INDIRECT host (hisi-lpc) now sets the accessors
ops prior to registration, enforce the check for these ops at registration
instead of in the IO port accessors, to simplify and marginally optimise
the code.

A slight misalignment is also tidied.

Also add myself as an author.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
I hope that the soc maintainers don't mind taking this patch through their
tree, as it is relevant to the HiSilicon LPC bus driver. Thanks

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index 905027574e5d..f511a99bb389 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017 HiSilicon Limited, All Rights Reserved.
  * Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
  * Author: Zhichang Yuan <yuanzhichang@hisilicon.com>
+ * Author: John Garry <john.garry@huawei.com>
  */
 
 #define pr_fmt(fmt)	"LOGIC PIO: " fmt
@@ -39,7 +40,8 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
 	resource_size_t iio_sz = MMIO_UPPER_LIMIT;
 	int ret = 0;
 
-	if (!new_range || !new_range->fwnode || !new_range->size)
+	if (!new_range || !new_range->fwnode || !new_range->size ||
+	    (new_range->flags == LOGIC_PIO_INDIRECT && !new_range->ops))
 		return -EINVAL;
 
 	start = new_range->hw_start;
@@ -237,7 +239,7 @@ type logic_in##bw(unsigned long addr)					\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) { \
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
-		if (entry && entry->ops)				\
+		if (entry)						\
 			ret = entry->ops->in(entry->hostdata,		\
 					addr, sizeof(type));		\
 		else							\
@@ -253,7 +255,7 @@ void logic_out##bw(type value, unsigned long addr)			\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
-		if (entry && entry->ops)				\
+		if (entry)						\
 			entry->ops->out(entry->hostdata,		\
 					addr, value, sizeof(type));	\
 		else							\
@@ -261,7 +263,7 @@ void logic_out##bw(type value, unsigned long addr)			\
 	}								\
 }									\
 									\
-void logic_ins##bw(unsigned long addr, void *buffer,		\
+void logic_ins##bw(unsigned long addr, void *buffer,			\
 		   unsigned int count)					\
 {									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
@@ -269,7 +271,7 @@ void logic_ins##bw(unsigned long addr, void *buffer,		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
-		if (entry && entry->ops)				\
+		if (entry)						\
 			entry->ops->ins(entry->hostdata,		\
 				addr, buffer, sizeof(type), count);	\
 		else							\
@@ -286,7 +288,7 @@ void logic_outs##bw(unsigned long addr, const void *buffer,		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
-		if (entry && entry->ops)				\
+		if (entry)						\
 			entry->ops->outs(entry->hostdata,		\
 				addr, buffer, sizeof(type), count);	\
 		else							\
-- 
2.17.1

