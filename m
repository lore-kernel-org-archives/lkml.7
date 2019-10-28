Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26661CA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C5F2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388974AbfJ1MNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:13:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37054 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727763AbfJ1MNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:13:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DECEAB3B245FFE113604;
        Mon, 28 Oct 2019 20:13:14 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 28 Oct 2019 20:13:05 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <olof@lixom.net>, <bhelgaas@google.com>, <arnd@arndb.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 1/5] lib: logic_pio: Enforce LOGIC_PIO_INDIRECT region ops are set at registration
Date:   Mon, 28 Oct 2019 20:10:01 +0800
Message-ID: <1572264605-172363-2-git-send-email-john.garry@huawei.com>
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

Since the only LOGIC_PIO_INDIRECT host (hisi-lpc) now sets the ops prior
to registration, enforce this check for accessors ops at registration
instead of in the IO port accessors to simplify and marginally optimise
the code.

A slight misalignment is also tidied.

Also add myself as an author.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 lib/logic_pio.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

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

