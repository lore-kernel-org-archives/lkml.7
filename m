Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7674FC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527AF21734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgAFIB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:01:58 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42254 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725446AbgAFIB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:01:57 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E51A1A58AD1726910730;
        Mon,  6 Jan 2020 16:01:55 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Mon, 6 Jan 2020 16:01:47 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/4] f2fs: compress: fix panic in mkwrite
Date:   Mon, 6 Jan 2020 16:01:41 +0800
Message-ID: <20200106080144.52363-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ 1237.458208] invalid opcode: 0000 [#1] SMP PTI
[ 1237.458228] CPU: 9 PID: 6291 Comm: fsstress Tainted: G           OE     5.5.0-rc1 #36
[ 1237.458255] Hardware name: Xen HVM domU, BIOS 4.1.2_115-908.790. 06/05/2017
[ 1237.458299] RIP: 0010:f2fs_vm_page_mkwrite+0x1c6/0x630 [f2fs]
[ 1237.458321] Code: d6 fe ff ff 49 8b 75 20 48 89 df e8 24 0a 05 00 85 c0 41 89 c7 78 8e 0f 84 bd fe ff ff 45 31 f6 41 83 ff 02 0f 85 c3 fe ff ff <0f> 0b 45 84 f6 0f 84 e4 00 00 00 ba 01 00 00 00 be 05 00 00 00 48
[ 1237.458374] RSP: 0000:ffffaecdc0c1bd38 EFLAGS: 00010246
[ 1237.458395] RAX: 0000000000000002 RBX: ffff9241c5b5d8c0 RCX: 0000000000000000
[ 1237.458418] RDX: ffffeeb715d42407 RSI: ffff9242d8085168 RDI: 0000000000000000
[ 1237.458441] RBP: ffff9243f1c67000 R08: 0000000000017677 R09: 0000000000000004
[ 1237.458463] R10: 0000000000000000 R11: ffff9242d8085000 R12: ffffaecdc0c1bdf8
[ 1237.458488] R13: ffffeeb715d037c0 R14: 0000000000000000 R15: 0000000000000002
[ 1237.458512] FS:  00007f71f28ce700(0000) GS:ffff92443d840000(0000) knlGS:0000000000000000
[ 1237.458540] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1237.458561] CR2: 00007f71f28c9000 CR3: 00000007e0ba2003 CR4: 00000000001606e0
[ 1237.458586] Call Trace:
[ 1237.458611]  do_page_mkwrite+0x5a/0xc0
[ 1237.458630]  __handle_mm_fault+0xb81/0x12a0
[ 1237.458648]  ? do_mmap+0x4bd/0x640
[ 1237.458665]  handle_mm_fault+0xe3/0x1d0
[ 1237.458686]  __do_page_fault+0x288/0x500
[ 1237.458704]  do_page_fault+0x30/0x120
[ 1237.458725]  page_fault+0x3e/0x50

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9aeadf14413c..f18d1262b274 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -72,7 +72,10 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 			err = ret;
 			goto err;
 		} else if (ret) {
-			f2fs_bug_on(sbi, ret == CLUSTER_HAS_SPACE);
+			if (ret == CLUSTER_HAS_SPACE) {
+				err = -EAGAIN;
+				goto err;
+			}
 			need_alloc = false;
 		}
 	}
-- 
2.18.0.rc1

