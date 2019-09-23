Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17595C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E993520835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406041AbfIWIak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:30:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405022AbfIWIaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:30:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3FDF8308FBA6;
        Mon, 23 Sep 2019 08:30:39 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-214.pek2.redhat.com [10.72.12.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 601E21001B07;
        Mon, 23 Sep 2019 08:30:37 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     tj@kernel.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH] memcg: Only record foreign writebacks with dirty pages when memcg is not disabled
Date:   Mon, 23 Sep 2019 16:30:30 +0800
Message-Id: <20190923083030.6442-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 23 Sep 2019 08:30:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kdump kernel, memcg usually is disabled with 'cgroup_disable=memory'
for saving memory. Now kdump kernel will always panic when dump vmcore
to local disk:

BUG: kernel NULL pointer dereference, address: 0000000000000ab8
PGD 5fcab067 P4D 5fcab067 PUD 5ff73067 PMD 0
Oops: 0000 [#1] SMP NOPTI
CPU: 0 PID: 598 Comm: makedumpfile Not tainted 5.3.0+ #26
Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 10/02/2018
RIP: 0010:mem_cgroup_track_foreign_dirty_slowpath+0x38/0x140
Code: 55 48 8b 2d 6a bd 12 01 53 4c 8b 67 38 0f 1f 44 00 00 49 8b 06 48 89 e9 31 db be ff ff ff ff 48 8b 38 49 8d 84 24 d0 0a 00 00 <48> 39 78 e8 74 5a 48 8b 50 f8 48 39 ca 79 0e 44 8b 00 41 83 f8 01
RSP: 0018:ffffbc9300817bd0 EFLAGS: 00010046
RAX: 0000000000000ad0 RBX: 0000000000000000 RCX: 00000000fffba227
RDX: fffffffffffffff8 RSI: 00000000ffffffff RDI: 0000000000000004
RBP: 00000000fffba227 R08: 0000000000030340 R09: ffffbc9300817d10
R10: 0000000000000000 R11: 0000000000001000 R12: 0000000000000000
R13: ffff999c1fa2bcf0 R14: ffff999c1f7bcc78 R15: ffffe51fc177a8c0
FS:  00007f84f14c2b80(0000) GS:ffff999c22200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000ab8 CR3: 000000005f564000 CR4: 00000000003406b0
Call Trace:
 __set_page_dirty+0x52/0xc0
 iomap_set_page_dirty+0x50/0x90
 iomap_write_end+0x6e/0x270
 iomap_write_actor+0xce/0x170
 ? iomap_write_end+0x270/0x270
 iomap_apply+0xba/0x11e
 ? iomap_write_end+0x270/0x270
 iomap_file_buffered_write+0x62/0x90
 ? iomap_write_end+0x270/0x270
 xfs_file_buffered_aio_write+0xca/0x320 [xfs]
 new_sync_write+0x12d/0x1d0
 vfs_write+0xa5/0x1a0
 ksys_write+0x59/0xd0
 do_syscall_64+0x59/0x1e0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f84f1093ab5

And this will corrupt the 1st kernel too with 'cgroup_disable=memory'.

From the trace and with debugging, it is pointing to commit 97b27821b485
("writeback, memcg: Implement foreign dirty flushing") which introduced
this regression. Disabling memcg causes the null pointer dereference at
uninitialized data in function mem_cgroup_track_foreign_dirty_slowpath().

Fix it by returning directly if memcg is disabled, but not trying to
record the foreign writebacks with dirty pages.

Fixed: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/memcontrol.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ad8f1a397ae4..fa53f9d51205 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1261,7 +1261,8 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
 static inline void mem_cgroup_track_foreign_dirty(struct page *page,
 						  struct bdi_writeback *wb)
 {
-	if (unlikely(&page->mem_cgroup->css != wb->memcg_css))
+	if (unlikely(&page->mem_cgroup->css != wb->memcg_css)
+		&& !mem_cgroup_disabled())
 		mem_cgroup_track_foreign_dirty_slowpath(page, wb);
 }
 
-- 
2.17.2

