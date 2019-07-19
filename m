Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5885C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE2A2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfGSLcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 07:32:17 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:32889 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfGSLcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:32:17 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M7v18-1hkbMf1elO-0052h7; Fri, 19 Jul 2019 13:31:47 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] [v2] blkdev: always export SECTOR_SHIFT
Date:   Fri, 19 Jul 2019 13:31:18 +0200
Message-Id: <20190719113139.4005262-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Vmcxqz1+zEC4Gz6MD7qxPE6OvaMIZxoiZywAbPjeNNR5AZUtT2+
 +rfnevMk1EgxsXJurkbh8MjLDWrZ8gHLODetIapgvkq3WJuzsanCjfwpsdc6I7UAoPODYST
 e4CuWsI1cWg7chal0vqGKqISZAJxF4wt5wFpeZ2T83pN61CdvHkanJUFplVU/HEI+KiI6IL
 3NNUfLtBMCGVeMMdNsADw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rxjEIKNOxbo=:3knNSkYGwlgeMBNhwhifSm
 jilkYZ/AJkClQOMIzvdln5LqT6DE+j9D3SjGQd6LdxsaeX44E29Wp6QQS205jpY5o9F1bC8tk
 MG++tt4QoT1gwZPNgNI3o3PTeLwXLcNCvUS5F0+WHIyXdmtVLvQsToa/JUoAs02Pgczc6ngIv
 fBqqsV32a+DrgnIZBxz61S6Zs0LHkUXGduH1DFjyUOr/a0U+9BqsH1OHCSsFWpZsD5D/AcDs2
 6PwEAikML8CdlwNQ9MepTYknmmePDWpN/TDfwBgCvD/8aEZuRFz8cYY5GYdjCTAVHJK+CqeEz
 A8PLpSBllLsqSgLweMKVAZNjOA04yeJU3gluqToGzBSlMJ21AbXJAf6S7RF+C4sOGbzrqKwTu
 DZjA50LTI9Z9fH46VUmxt1i/f8cAA5PLz19z4q0bz0Zpb4CpgcdbR6ssbUec6MbejQ+vqqMZr
 dqRQOkuz4iue1VjiVISllaBCGnpm5XwPGyNeFUfWyiYkkUXRsFQqLn4JsvpeS/fgMOtMfuyTQ
 DhyGW+/7Ajtwe2ME/+vpZ3bHRZevJKX7V8+gcc0/sO7usX8qfXPaXq72ZITw1nxK/vYHqTdzX
 HzWORafEMdGaFzxV/iSnpntcsIIY04kjL62jZZ9WiDPqNwhkuBLEJWIhvbOrGZrao7NgdkmIt
 KY5OC4vJKHLDUIxPbXXg62JeiypBO+8VWpBdpbOCuXCxGKlR+cPYjAkZ8PByQUQthJAkcGL0I
 dNY3ATK0ZuCfuy3vpMw8aP2woWfopPmK8+jaJA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_BLOCK is disabled, SECTOR_SHIFT is unknown, and this leads
to a failure in the testing infrastructure added from commit c93a0368aaa2
("kbuild: do not create wrappers for header-test-y"):

In file included from <built-in>:3:
include/linux/iomap.h:76:48: error: use of undeclared identifier 'SECTOR_SHIFT'
        return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;

If we want to keep build testing all headers, the macro needs to
either be defined, or not used. Move it out of the #ifdef
section to ensure it is visible.

Fixes: db074436f421 ("iomap: move the direct IO code into a separate file")
Link: https://lore.kernel.org/lkml/20190718125509.775525-1-arnd@arndb.de/T/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The discussion about the build testing is still going on, but I promised
to send this version anyway for reference. I see no other header-test
failures in randconfig builds with this patch.
---
 include/linux/blkdev.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0ec4f975437e..9c22d8bc6bf9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -5,6 +5,19 @@
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
 
+/*
+ * The basic unit of block I/O is a sector. It is used in a number of contexts
+ * in Linux (blk, bio, genhd). The size of one sector is 512 = 2**9
+ * bytes. Variables of type sector_t represent an offset or size that is a
+ * multiple of 512 bytes. Hence these two constants.
+ */
+#ifndef SECTOR_SHIFT
+#define SECTOR_SHIFT 9
+#endif
+#ifndef SECTOR_SIZE
+#define SECTOR_SIZE (1 << SECTOR_SHIFT)
+#endif
+
 #ifdef CONFIG_BLOCK
 
 #include <linux/major.h>
@@ -889,19 +902,6 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 	return bdev->bd_disk->queue;	/* this is never NULL */
 }
 
-/*
- * The basic unit of block I/O is a sector. It is used in a number of contexts
- * in Linux (blk, bio, genhd). The size of one sector is 512 = 2**9
- * bytes. Variables of type sector_t represent an offset or size that is a
- * multiple of 512 bytes. Hence these two constants.
- */
-#ifndef SECTOR_SHIFT
-#define SECTOR_SHIFT 9
-#endif
-#ifndef SECTOR_SIZE
-#define SECTOR_SIZE (1 << SECTOR_SHIFT)
-#endif
-
 /*
  * blk_rq_pos()			: the current sector
  * blk_rq_bytes()		: bytes left in the entire request
-- 
2.20.0

