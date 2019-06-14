Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1061C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9D4208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfFNMN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:13:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51550 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727531AbfFNMNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:13:25 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AA00B8BA90A42D58E026;
        Fri, 14 Jun 2019 20:13:23 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 14 Jun 2019
 20:13:15 +0800
From:   <chengzhihao1@huawei.com>
To:     <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
        <boris.brezillon@bootlin.com>, <david@sigma-star.at>,
        <artem.bityutskiy@linux.intel.com>, <yi.zhang@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: [PATCH mtd-utils] ubi-tests: mkvol test: Checks return value 'ENOSPC' for 'ubi_mkvol'
Date:   Fri, 14 Jun 2019 20:18:48 +0800
Message-ID: <1560514728-54932-1-git-send-email-chengzhihao1@huawei.com>
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

UBI tests try to create too many volumes in mkvol_bad and mkvol_basic.
Currently mtd-utils allows return value 'ENFILE' from 'ubi_mkvol', that
works fine in most situations. But what if the number of PEBs equals to
the maximum count of volumes? For example, mkvol_basic test will fail in
a 64MiB flash with 512KiB PEB size.
Following is the output of mkvol_basic test:

  ======================================================================
  ======================================================================
  ======================================================================
  Test on mtdram, fastmap enabled, VID header offset factor 1
  ======================================================================
  ======================================================================
  ======================================================================
  mtdram: 64MiB, PEB size 512KiB, fastmap enabled
  Running mkvol_basic /dev/ubi0
  [mkvol_basic] mkvol_multiple():182: function ubi_mkvol() failed with
  error 28 (No space left on device)
  [mkvol_basic] mkvol_multiple():183: vol_id 122
  Error: mkvol_basic failed
  FAILURE

The reason is that there is no available PEB to support a new volume. We
can see following verbose in dmesg:

  ubi0: attached mtd0 (name "mtdram test device", size 64 MiB)
  ubi0: user volume: 0, internal volumes: 1, max. volumes count: 128
  ubi0: available PEBs: 122, total reserved PEBs: 6, PEBs reserved for
  bad PEB handling: 0

The maximum count of volumes is 128, so we can create 128 volumes
theoretically. But there are 122 available PEBs becauese of existence of
reserved PEBs. In addition, a volume occupies at least one PEB. Actually,
we can only create 122 volumes, Therefore, 'ubi_mkvol' returns 'ENOSPC'
when mkvol_basic tries to create 123rd volume. And we can see
corresponding error message in dmesg:

  ubi0 error: ubi_create_volume [ubi]: not enough PEBs, only 0 available
  ubi0 error: ubi_create_volume [ubi]: cannot create volume 122, error -28

So, 'ENOSPC' can happen before 'ENFILE' in flash with a small amount of
PEBs. This patch checks return value 'ENOSPC' for 'ubi_mkvol' when mkvol
test is trying to create too many volumes.

----------------------------------------

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 tests/ubi-tests/mkvol_bad.c   | 2 +-
 tests/ubi-tests/mkvol_basic.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/ubi-tests/mkvol_bad.c b/tests/ubi-tests/mkvol_bad.c
index 7e46726..a5143e3 100644
--- a/tests/ubi-tests/mkvol_bad.c
+++ b/tests/ubi-tests/mkvol_bad.c
@@ -200,7 +200,7 @@ static int test_mkvol(void)
 			 * Note, because of gluebi we may be unable to create
 			 * dev_info.max_vol_count devices (MTD restrictions).
 			 */
-			if (errno == ENFILE)
+			if (errno == ENFILE || errno == ENOSPC)
 				break;
 			failed("ubi_mkvol");
 			errorm("vol_id %d", i);
diff --git a/tests/ubi-tests/mkvol_basic.c b/tests/ubi-tests/mkvol_basic.c
index c7c6984..cc3f7ba 100644
--- a/tests/ubi-tests/mkvol_basic.c
+++ b/tests/ubi-tests/mkvol_basic.c
@@ -178,7 +178,7 @@ static int mkvol_multiple(void)
 		req.name = nm;
 
 		if (ubi_mkvol(libubi, node, &req)) {
-			if (errno == ENFILE) {
+			if (errno == ENFILE || errno == ENOSPC) {
 				max = i;
 				break;
 			}
-- 
2.7.4

