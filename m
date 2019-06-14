Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A66C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4060921473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfFNMMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:12:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727572AbfFNMMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:12:55 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8DA29D3C080F3421CE99;
        Fri, 14 Jun 2019 20:12:53 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Fri, 14 Jun 2019
 20:12:44 +0800
From:   <chengzhihao1@huawei.com>
To:     <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
        <boris.brezillon@bootlin.com>, <david@sigma-star.at>,
        <artem.bityutskiy@linux.intel.com>, <yi.zhang@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: [PATCH mtd-utils] ubi-tests: io_read: Filter invalid offset value before 'lseek' in io_read test
Date:   Fri, 14 Jun 2019 20:18:16 +0800
Message-ID: <1560514696-54824-1-git-send-email-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhihao Cheng <chengzhihao1@huawei.com>

There are many different offset values passed in 'lseek' during io_read
testing of ubi test. The offset value maybe a negative number or a big
number that exceeds the volume data size, which can lead to ubi tests
failure by passing invalid offset value to 'lseek'. For example:

Example 1: The data size of volume is 39525 bytes, offset = (sz) -
MAX_NAND_PAGE_SIZE - 1, where MAX_NAND_PAGE_SIZE is 65536. Here, offset
is a negative value passed to 'lseek', which leads to fail in io_read.

  ======================================================================
  ======================================================================
  ======================================================================
  Test on mtdram, fastmap enabled, VID header offset factor 1
  ======================================================================
  ======================================================================
  ======================================================================
  mtdram: 16MiB, PEB size 16KiB, fastmap enabled
  Running mkvol_basic /dev/ubi0
  Running mkvol_bad /dev/ubi0
  Running mkvol_paral /dev/ubi0
  Running rsvol /dev/ubi0
  Running io_basic /dev/ubi0
  Running io_read /dev/ubi0
  [io_basic] test_read3():189: function seek() failed with error 22
  (Invalid argument)
  [io_basic] test_read3():190: len = 1
  [io_basic] test_read2():237: offset = -26012
  [io_basic] test_read1():303: length = 1
  [io_basic] test_read():362: alignment = 7905
  Error: io_read failed
  FAILURE

Example 2: The data size of volume is 79035 bytes, offset = 2 *
MAX_NAND_PAGE_SIZE, where MAX_NAND_PAGE_SIZE is 65536. Here, offset is a
value exceeds volume size, which leads to fail in io_read.

  ======================================================================
  ======================================================================
  ======================================================================
  Test on mtdram, fastmap enabled, VID header offset factor 1
  ======================================================================
  ======================================================================
  ======================================================================
  mtdram: 16MiB, PEB size 16KiB, fastmap enabled
  Running mkvol_basic /dev/ubi0
  Running mkvol_bad /dev/ubi0
  Running mkvol_paral /dev/ubi0
  Running rsvol /dev/ubi0
  Running io_basic /dev/ubi0
  Running io_read /dev/ubi0
  [io_basic] test_read3():185: function seek() failed with error 22
  (Invalid argument)
  [io_basic] test_read3():186: len = 1
  [io_basic] test_read2():233: offset = 131072
  [io_basic] test_read1():299: length = 1
  [io_basic] test_read():358: alignment = 3
  Error: io_read failed
  FAILURE

This patch checks offset value before executing 'lseek', invalid offset
values are filtered.

----------------------------------------

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 tests/ubi-tests/io_read.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/ubi-tests/io_read.c b/tests/ubi-tests/io_read.c
index 3100ef1..f944a86 100644
--- a/tests/ubi-tests/io_read.c
+++ b/tests/ubi-tests/io_read.c
@@ -228,6 +228,10 @@ static int test_read2(const struct ubi_vol_info *vol_info, int len)
 				  vol_info->data_bytes);
 
 	for (i = 0; i < sizeof(offsets)/sizeof(off_t); i++) {
+		/* Filter invalid offset value */
+		if (offsets[i] < 0 || offsets[i] > vol_info->data_bytes)
+			continue;
+
 		if (test_read3(vol_info, len, offsets[i])) {
 			errorm("offset = %d", offsets[i]);
 			return -1;
-- 
2.7.4

